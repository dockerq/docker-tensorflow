FROM ubuntu:14.04
MAINTAINER adolphlwq kenan3015@gmail.com

ENV FRESHED_AT 2017-02-17
RUN ln -f -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

USER root
RUN apt-get update && apt-get install -yq --no-install-recommends bzip2 ca-certificates sudo locales wget && \
    rm -rf /var/lib/apt/lists/* && apt-get clean && apt-get autoremove

# Install Tini
RUN wget --quiet https://github.com/krallin/tini/releases/download/v0.9.0/tini && \
    echo "faafbfb5b079303691a939a747d7f60591f2143164093727e870b289a44d9872 *tini" | sha256sum -c - && \
    mv tini /usr/local/bin/tini && \
    chmod +x /usr/local/bin/tini

# Configure environment
ENV CONDA_DIR='/opt/conda' \
    SHELL='/bin/bash' \
    NB_USER='geek' \
    NB_UID='1000' \
    TF_VERSION='1.0.0'

ENV PATH=$CONDA_DIR/bin:$PATH \
    HOME=/home/$NB_USER

# Create jovyan user with UID=1000 and in the 'users' group
RUN useradd -m -s /bin/bash -N -u $NB_UID $NB_USER && \
    mkdir -p $CONDA_DIR && \
    chown $NB_USER $CONDA_DIR

USER $NB_USER
RUN mkdir /home/$NB_USER/work && \
    mkdir /home/$NB_USER/.jupyter && \
    mkdir -p -m 700 /home/$NB_USER/.local/share/jupyter && \
    echo "cacert=/etc/ssl/certs/ca-certificates.crt" > /home/$NB_USER/.curlrc
# Install conda as geek
RUN cd /tmp && \
    mkdir -p $CONDA_DIR && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda3-3.19.0-Linux-x86_64.sh && \
    echo "9ea57c0fdf481acf89d816184f969b04bc44dea27b258c4e86b1e3a25ff26aa0 *Miniconda3-3.19.0-Linux-x86_64.sh" | sha256sum -c - && \
    /bin/bash Miniconda3-3.19.0-Linux-x86_64.sh -f -b -p $CONDA_DIR && \
    rm Miniconda3-3.19.0-Linux-x86_64.sh && \
    $CONDA_DIR/bin/conda install --quiet --yes conda==3.19.1 && \
    $CONDA_DIR/bin/conda config --system --add channels conda-forge && \
    conda clean -tipsy && \
    echo "jpeg 8*" >> /opt/conda/conda-meta/pinned && \ 
    #https://github.com/jupyter/docker-stacks/issues/210
    conda install --quiet --yes \
    'notebook=4.2*' \
    && conda clean -tipsy

USER root
WORKDIR /home/$NB_USER/work
ENTRYPOINT ["tini", "--"]
CMD ["start-notebook.sh"]
COPY files/start-notebook.sh /usr/local/bin/
COPY files/start-singleuser.sh /usr/local/bin/
COPY files/jupyter_notebook_config.py /home/$NB_USER/.jupyter/
RUN chown -R $NB_USER:users /home/$NB_USER/.jupyter && \
    chmod +x /usr/local/bin/*.sh

# download tf 3.5 v1.0.0
RUN pip install tensorflow==$TF_VERSION
# RUN pip --no-cache-dir install \
#     https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.10.0-cp35-cp35m-linux_x86_64.whl

# # install some sci packages
# RUN pip --no-cache-dir install \
#     pandas \
#     scikit-learn \
#     matplotlib \
#     numpy \
#     scipy && \
#     apt-get clean && \
#     rm -rf /var/lib/apt/lists/*

EXPOSE 6006 8888