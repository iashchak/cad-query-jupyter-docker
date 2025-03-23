# Используем базовый образ Miniforge
FROM condaforge/miniforge3:latest

# Чтобы не писать всякий раз /bin/bash -c
SHELL ["/bin/bash", "-c"]

# Устанавливаем базовые системные зависимости (libgl1 для OpenGL)
RUN apt-get update && apt-get install -y libgl1 && rm -rf /var/lib/apt/lists/*

# Создаём окружение cq и ставим всё нужное из conda-forge
# Обратите внимание, что nodejs и ffmpeg тоже берём из conda-forge
RUN mamba install -n base -c conda-forge mamba -y && \
    conda create -y -n cq -c conda-forge cadquery jupyterlab nodejs ffmpeg pip && \
    # Обновляем .bashrc, чтобы при входе в контейнер окружение cq активировалось командой `source ~/.bashrc`
    echo "source activate cq" >> ~/.bashrc

# Переключаемся в рабочую директорию
WORKDIR /home/cq

# Ставим дополнительные Python-пакеты, требующиеся для проекта
# (jupyter_copilot + cadquery-gears с GitHub)
RUN source activate cq && \
    pip install jupyter_copilot git+https://github.com/meadiode/cq_gears.git@main

# Запуск Jupyter Lab
CMD source activate cq && \
    jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root --NotebookApp.disable_check_xsrf=True --NotebookApp.allow_origin='*' --NotebookApp.token=''
