ARG PYTHON_DEBIAN_VERSION="1.1.0"

FROM xandai/python-debian:${PYTHON_DEBIAN_VERSION}

ARG JUPYTERLAB_VERSION="3.0.16"
ARG JUPYTER_USER="jupyter"
ARG HOME_PATH="/home/${JUPYTER_USER}"
ARG NOTEBOOK_DIR="${HOME_PATH}/workdir"
ARG JUPYTER_CONFIG_DIR="${HOME_PATH}/.jupyter"
ARG JUPYTER_CONFIG_FILE="${JUPYTER_CONFIG_DIR}/jupyter_notebook_config.py"

USER root

RUN python -m pip install --no-cache-dir jupyterlab==${JUPYTERLAB_VERSION} \
    && groupadd -r ${JUPYTER_USER} \
    && useradd --no-log-init -m -r -g ${JUPYTER_USER} ${JUPYTER_USER}

USER ${JUPYTER_USER}

RUN mkdir -p ${NOTEBOOK_DIR} &&\
    mkdir -p ${JUPYTER_CONFIG_DIR} &&\
    echo "c.NotebookApp.ip = '0.0.0.0'" >> ${JUPYTER_CONFIG_FILE} &&\
    echo "c.NotebookApp.open_browser = False" >> ${JUPYTER_CONFIG_FILE} &&\
    echo "c.NotebookApp.notebook_dir = '${NOTEBOOK_DIR}'" >> ${JUPYTER_CONFIG_FILE}

EXPOSE 8888

WORKDIR ${NOTEBOOK_DIR}

CMD jupyter notebook
