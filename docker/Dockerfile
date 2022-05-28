#source: https://github.com/msr-fiddle/DS-Analyzer/blob/main/docker/Dockerfile



## Build with command [from repo root directory]:
# docker build --tag fiddle-store . --file ./Dockerfile
##
## Run with command:
# nvidia-docker run -it --rm --mount type=bind,source=~/,target=/datadrive fiddlev3.azurecr.io/fiddle-store:latest /bin/bash
##

# Base image for pytorch
# https://ngc.nvidia.com/catalog/containers/nvidia:pytorch
# https://gitlab.com/nvidia/cuda
ARG FROM_IMAGE_NAME=nvcr.io/nvidia/pytorch:19.05-py3
FROM ${FROM_IMAGE_NAME}

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

RUN mkdir -p /home/app/ \
    && mkdir -p /datadrive/imagenet \
    && mkdir -p /datadrive/logs

WORKDIR /home/app
COPY . /home/app/

RUN wget https://s3.amazonaws.com/fast-ai-imageclas/imagenette2-320.tgz \
    && tar zxvf imagenette2-320.tgz \
    && rm -f imagenette2-320.tgz

RUN chmod -R 777 /home/app
RUN chmod -R 777 /datadrive

RUN apt-get update; echo Y | apt-get install sysstat; apt-get install dstat
RUN apt-get install sudo
RUN git clone https://github.com/brendangregg/perf-tools.git
RUN git clone https://github.com/NVIDIA/apex
RUN cd apex && git checkout  50338df6280fd47832039725ec5bdcc202591222 && pip install -v --no-cache-dir --global-option="--cpp_ext" --global-option="--cuda_ext" ./
RUN pip install --extra-index-url https://developer.download.nvidia.com/compute/redist nvidia-dali-cuda100
RUN git clone https://github.com/msr-fiddle/DS-Analyzer
WORKDIR ./DS-Analyzer
