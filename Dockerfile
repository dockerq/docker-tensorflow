FROM adolphlwq/docker-jupyter:base-notebook
MAINTAINER adolphlwq kenan3015@gmail.com

USER root

# down mesos
RUN echo "deb http://repos.mesosphere.io/ubuntu/ trusty main" > /etc/apt/sources.list.d/mesosphere.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF && \
    apt-get -y update && \
    apt-get --no-install-recommends -y --force-yes install mesos=0.28.1-2.0.20.ubuntu1404 \
    openjdk-7-jre-headless curl

# download tf 3.5
RUN pip --no-cache-dir install \
    https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.10.0-cp35-cp35m-linux_x86_64.whl

# install spark
RUN curl -fL http://archive.apache.org/dist/spark/spark-1.6.0/spark-1.6.0-bin-hadoop2.6.tgz | tar xzf - -C /usr/local

# install some sci packages
RUN pip --no-cache-dir install \
    pandas \
    scikit-learn \
    matplotlib \
    numpy \
    scipy && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Spark and Mesos config
ENV SPARK_HOME /usr/local/spark-1.6.0-bin-hadoop2.6
ENV PYTHONPATH=$SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.9-src.zip \
    MESOS_NATIVE_JAVA_LIBRARY=/usr/local/lib/libmesos.so

EXPOSE 6006
