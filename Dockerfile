ARG PYTHON_DEBIAN_VERSION="1.1.1"

FROM xandai/python-debian:${PYTHON_DEBIAN_VERSION}

ARG NUMPY_VERSION="1.20.3"
ARG MATPLOTLIB_VERSION="3.4.2"
ARG JUPYTERLAB_VERSION="3.0.16"
ARG PIP_PACKAGES="numpy==${NUMPY_VERSION} matplotlib==${MATPLOTLIB_VERSION} jupyterlab==${JUPYTERLAB_VERSION}"

ARG JUPYTER_USER="jupyter"
ARG HOME_PATH="/home/${JUPYTER_USER}"
ARG NOTEBOOK_DIR="${HOME_PATH}/workdir"
ARG JUPYTER_CONFIG_DIR="${HOME_PATH}/.jupyter"
ARG JUPYTER_CONFIG_FILE="${JUPYTER_CONFIG_DIR}/jupyter_notebook_config.py"

USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends curl \
    && curl -fsSL https://deb.nodesource.com/setup_14.x | bash - \
    && apt-get update \
    && apt-get install -y --no-install-recommends nodejs \
    && rm -rf /var/lib/apt/lists/* \
    && python3 -m pip install --no-cache-dir ${PIP_PACKAGES} \
    && groupadd -r ${JUPYTER_USER} \
    && useradd --no-log-init -m -r -g ${JUPYTER_USER} ${JUPYTER_USER}

USER ${JUPYTER_USER}

RUN mkdir -p ${NOTEBOOK_DIR} &&\
    mkdir -p ${JUPYTER_CONFIG_DIR} &&\
    echo "c.ServerApp.ip = '0.0.0.0'" >> ${JUPYTER_CONFIG_FILE} &&\
    echo "c.ServerApp.open_browser = False" >> ${JUPYTER_CONFIG_FILE} &&\
    echo "c.ServerApp.root_dir = '${NOTEBOOK_DIR}'" >> ${JUPYTER_CONFIG_FILE}

EXPOSE 8888

WORKDIR ${NOTEBOOK_DIR}

CMD jupyter lab
