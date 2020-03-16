#!/bin/bash

NAME=craftslab/flutterdocker
TAG=latest

docker run --rm $NAME:$TAG -e "SHELL=$SHELL" -i ./sample.sh release
