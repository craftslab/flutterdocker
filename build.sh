#!/bin/bash

NAME=craftslab/flutterdocker
TAG=latest

docker build --no-cache -f Dockerfile -t $NAME:$TAG .
#sudo docker inspect $NAME:$TAG > Dockerobjects
