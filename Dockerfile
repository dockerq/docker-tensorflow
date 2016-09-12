FROM adolphlwq/docker-jupyter:base-notebook
MAINTAINER adolphlwq kenan3015@gmail.com

# download tf 3.5
RUN pip --no-cache-dir install \
    https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.10.0-cp35-cp35m-linux_x86_64.whl
USER root
# install some sci packages
RUN pip --no-cache-dir install \
    pandas \
    scikit-learn \
    matplotlib \
    numpy \
    scipy && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 6006
