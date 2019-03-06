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
