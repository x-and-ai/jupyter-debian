# xandai/jupyter-debian

[Docker Hub Link](https://hub.docker.com/r/xandai/jupyter-debian)

[GitHub Link](https://github.com/x-and-ai/jupyter-debian)

## Description

This is a Docker image for using Jupyter Lab on Debian.

## Tags and Versions

| tag        | jupyter    | python     | debian     |
|:----------:|:----------:|:----------:|:----------:|
| 1.0.0      | 1.0.0      | 3.5.3-1    | 9.8        |

| tag        | jupyterlab | python     | debian     |
|:----------:|:----------:|:----------:|:----------:|
| 1.1.0      | 3.0.16     | 3.7.3      | 10.9       |
| 1.1.1      | 3.0.16     | 3.7.3      | 10.9       |

## Usage

- Start Jupyter Lab without token

``` sh
docker run --rm -it -p <localhostport>:8888 -v /absolute/path/to/workdir:/home/jupyter/workdir xandai/jupyter-debian:1.1.1 jupyter lab --NotebookApp.token=''
```

- Start Jupyter Lab with token

``` sh
docker run --rm -it -p <localhostport>:8888 -v /absolute/path/to/workdir:/home/jupyter/workdir xandai/jupyter-debian:1.1.1
```
