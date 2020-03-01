#!/bin/bash

NAME=flutterdocker
TAG=latest

docker run -it \
    -e "SHELL=$SHELL" \
    $NAME:$TAG
