FROM condaforge/miniforge3:latest

SHELL ["/bin/bash", "-c"]

RUN apt-get update && apt-get install -y libgl1 && rm -rf /var/lib/apt/lists/*

RUN mamba install -n base -c conda-forge mamba -y && \
    conda create -y -n cq -c conda-forge cadquery jupyterlab nodejs ffmpeg pip && \
    echo "source activate cq" >> ~/.bashrc

WORKDIR /home/cq

RUN source activate cq && \
    pip install git+https://github.com/meadiode/cq_gears.git@main

RUN curl -fsSL https://code-server.dev/install.sh | sh && \
    code-server --install-extension GitHub.copilot

CMD ["/bin/bash", "-c", "\
    source /opt/conda/etc/profile.d/conda.sh && \
    conda activate cq && \
    trap 'kill $(jobs -p); wait' SIGINT SIGTERM && \
    jupyter lab --ip=0.0.0.0 --port=8888 \
        --no-browser --allow-root \
        --NotebookApp.disable_check_xsrf=True \
        --NotebookApp.allow_origin='*' \
        --NotebookApp.token='' & \
    code-server --bind-addr 0.0.0.0:8080 --auth none & \
    wait"]
