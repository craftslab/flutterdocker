#!/bin/bash

NAME=craftslab/flutterdocker
TAG=latest

docker run -i -e "SHELL=$SHELL" --rm $NAME:$TAG pwd
