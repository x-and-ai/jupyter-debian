# xandai/jupyter-debian

[Docker Hub Link](https://hub.docker.com/r/xandai/jupyter-debian)

[GitHub Link](https://github.com/x-and-ai/jupyter-debian)

## Description

This is a Docker image for using Jupyter Notebook on Debian.

## Tags and Versions

| tag        | jupyter    | python     | debian     |
|:----------:|:----------:|:----------:|:----------:|
| 1.0.0      | 1.0.0      | 3.5.3-1    | 9.8        |

## Usage

- Start Jupyter Notebook without token

``` sh
docker run --rm -it -p <localhostport>:8888 -v /absolute/path/to/notebook/dir:/home/jupyter/notebook xandai/jupyter-debian:1.0.0 jupyter notebook --NotebookApp.token=''
```

- Start Jupyter Notebook with token

``` sh
docker run --rm -it -p <localhostport>:8888 -v /absolute/path/to/notebook/dir:/home/jupyter/notebook xandai/jupyter-debian:1.0.0
```
