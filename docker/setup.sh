#!/bin/sh

docker pull nvcr.io/nvidia/pytorch:19.05-py3
cd docker
docker build --tag base_image . --file ./Dockerfile

