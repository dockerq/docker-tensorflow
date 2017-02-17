# TensorFlow docker image
[![Docker Pulls](https://img.shields.io/docker/pulls/adolphlwq/docker-tensorflow.svg?maxAge=2592000)]()

A tensorflow docker image intergated jupyter

## Why yet another container for TensorFlow
[Official image](https://hub.docker.com/r/tensorflow/tensorflow/) just install python 2 of tensorflow series. So I build this image just install **only python 3.x** series of tensorflow.

## Features:
- support jupyter
- only python3
- tensorflow CPU only
- more tiny(by 2017-2-17):
```
adolphlwq/docker-tensorflow   latest                   29b48ea22cc8        2 hours ago         854.5 MB
tensorflow/tensorflow         latest                   ea40dcc45724        5 days ago          1.029 GB
```

## Usage
- choose image
    - `adolphlwq/docker-tensorflow:python3`: tensorflow 0.10.0 version on branch [0.10.0](https://github.com/dockerq/docker-tensorflow/tree/v0.10.0)
    - `adolphlwq/docker-tensorflow:v1.0.0`: tensorfloe 1.0.0 version on branch [1.0.0](https://github.com/dockerq/docker-tensorflow/tree/v1.0.0)
- start tensorflow container
```
docker run -p 8888:8888 -p 6006:6006 adolphlwq/docker-tensorflow:v1.0.0
```
- browser `localhost:8888` or `your_host_ip:8888` to see jupyter online editor

## Custom: Docker Options
- set password to Jupyter Notebook
```
docker run -p 8888:8888 -p 6006:6006 -e PASSWORD="YOURPASS" adolphlwq/docker-tensorflow:v1.0.0
```
- gives the container user:jovyan passwordless sudo capability
```
docker run -p 8888:8888 -p 6006:6006 -e GRANT_SUDO=yes adolphlwq/docker-tensorflow:v1.0.0
```
- mount volume mapping from host to container
```
docker run -p 8888:8888 -p 6006:6006 -v pathto/host/folder:/home/jovyan/work adolphlwq/docker-tensorflow:v1.0.0
```
