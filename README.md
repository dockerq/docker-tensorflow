# TensorFlow docker image
[![Docker Pulls](https://img.shields.io/docker/pulls/adolphlwq/docker-tensorflow.svg?maxAge=2592000)]()

A tensorflow docker image intergated jupyter

## Why yet another container for TensorFlow
[Official image](https://hub.docker.com/r/tensorflow/tensorflow/) just install python 2 of tensorflow series. So I build this image just install python 3.5 series of tensorflow.

## Usage
- start tensorflow container
```
docker run -p 8888:8888 -p 6006:6006 adolphlwq/docker-tensorflow:python3
```
- browser
browser `localhost:8888` or `your_host_ip:8888` to end jupyter online editor

## Custom: Docker Options
- set password to Jupyter Notebook
```
docker run -p 8888:8888 -p 6006:6006 -e PASSWORD="YOURPASS" adolphlwq/docker-tensorflow:python3
```
- gives the container user:jovyan passwordless sudo capability
```
docker run -p 8888:8888 -p 6006:6006 -e GRANT_SUDO=yes adolphlwq/docker-tensorflow:python3
```
- mount volume mapping from host to container
```
docker run -p 8888:8888 -p 6006:6006 -v pathto/host/folder:/home/jovyan/work adolphlwq/docker-tensorflow:python3
```
