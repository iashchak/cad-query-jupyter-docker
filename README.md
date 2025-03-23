# Cad Query with Jupyter in docker

You can pick up that image if you:
- [X] Have docker installed
- [X] Have docker-compose installed
- [X] Tired of installing dependencies on your machine when you want to try something new
- [X] Want to use copilot to generate code for you
- [X] Want to have some kind of organization for your models and scripts
- [X] Want to use Jupyter to run your CadQuery scripts

## How to make changes to the image
1. Clone this repository
```bash
git clone https://github.com/iashchak/cad-query-jupyter-docker.git
```

2. Do whatever you want with the Dockerfile and docker-compose.yml

3. Start the container
```bash
docker-compose up
```

4. ???

5. Profit

## How to use the image
1. Pull the image
```bash
docker pull ghcr.io/iashchak/cad-query-jupyter-docker:latest
```

2. Run the container
```bash
docker run -p 8888:8888 ghcr.io/iashchak/cad-query-jupyter-docker:latest
```

3. [Open the link in your browser](http://localhost:8888)

## FAQ
- **Q**: Can i expose it to the internet?
- **A**: You can, but you shouldn't. Copilot config present as server plugin, so it will be exposed to the internet. But as for local development in secure networks when you can trust everyone around you - it's fine.

- **Q**: Can i use it for production?
- **A**: Nah. Only for local development.

