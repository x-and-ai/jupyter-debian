# ARG DEBIAN_VERSION=9.8

# FROM debian:${DEBIAN_VERSION}

# ARG PYTHON3_VERSION='3.5.3-1'

# ARG INSTALL_PACKAGES="python3=${PYTHON3_VERSION} python3-pip"

# RUN apt-get update &&\
#     apt-get install -y --no-install-recommends ${INSTALL_PACKAGES} &&\
#     rm -rf /var/lib/apt/lists/* &&\
#     ln -s /usr/bin/python3 /usr/bin/python &&\
#     ln -s /usr/bin/pip3 /usr/bin/pip &&\
#     python -m pip install --upgrade --no-cache-dir --disable-pip-version-check --user pip &&\
#     python -m pip install --no-cache-dir setuptools wheel


ARG PYTHON_DEBIAN_VERSION="1.0.0"

FROM xandai/python-debian:${PYTHON_DEBIAN_VERSION}

ARG JUPYTER_VERSION="1.0.0"
ARG JUPYTER_USER="jupyter"
ARG HOME_PATH="/home/${JUPYTER_USER}"
ARG NOTEBOOK_DIR="${HOME_PATH}/notebook"
ARG JUPYTER_CONFIG_DIR="${HOME_PATH}/.jupyter"
ARG JUPYTER_CONFIG_FILE="${JUPYTER_CONFIG_DIR}/jupyter_notebook_config.py"

USER root

RUN python -m pip install --no-cache-dir jupyter==${JUPYTER_VERSION} &&\
    adduser --disabled-password --gecos "" ${JUPYTER_USER}

USER ${JUPYTER_USER}

RUN mkdir -p ${NOTEBOOK_DIR} &&\
    mkdir -p ${JUPYTER_CONFIG_DIR} &&\
    echo "c.NotebookApp.ip = '0.0.0.0'" >> ${JUPYTER_CONFIG_FILE} &&\
    echo "c.NotebookApp.open_browser = False" >> ${JUPYTER_CONFIG_FILE} &&\
    echo "c.NotebookApp.notebook_dir = '${NOTEBOOK_DIR}'" >> ${JUPYTER_CONFIG_FILE}

EXPOSE 8888

WORKDIR ${NOTEBOOK_DIR}

CMD jupyter notebook

# RUN apk add --no-cache libzmq &&\
#     apk add --no-cache --virtual .build-deps gcc pkgconfig zeromq-dev libc-dev python3-dev &&\
#     pip install --no-cache-dir jupyter==${JUPYTER_VERSION} &&\
#     apk del .build-deps &&\
#     adduser -D -u 1000 ${JUPYTER_USER}

# USER jupyter

# RUN mkdir -p ${NOTEBOOK_DIR} &&\
#     mkdir -p ${JUPYTER_CONFIG_DIR} &&\
#     echo "c.NotebookApp.ip = '0.0.0.0'" >> ${JUPYTER_CONFIG_FILE} &&\
#     echo "c.NotebookApp.open_browser = False" >> ${JUPYTER_CONFIG_FILE} &&\
#     echo "c.NotebookApp.notebook_dir = '${NOTEBOOK_DIR}'" >> ${JUPYTER_CONFIG_FILE}

# EXPOSE 8888

# WORKDIR ${NOTEBOOK_DIR}

# CMD jupyter notebook
