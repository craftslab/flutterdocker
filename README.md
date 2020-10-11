# flutterdocker

[![Docker](https://img.shields.io/docker/pulls/craftslab/flutterdocker)](https://hub.docker.com/r/craftslab/flutterdocker)
[![License](https://img.shields.io/github/license/craftslab/flutterdocker.svg?color=brightgreen)](https://github.com/craftslab/flutterdocker/blob/master/LICENSE)
[![Tag](https://img.shields.io/github/tag/craftslab/flutterdocker.svg?color=brightgreen)](https://github.com/craftslab/flutterdocker/tags)



## Introduction

*Flutter Docker* is the Dockerfile for Android & Flutter SDK built on Ubuntu.



### Build

```bash
./build.sh
```



### Deploy

```bash
docker pull craftslab/flutterdocker:latest
```



### Run

```bash
./run.sh
```



### Reference

- **[Android Repo](https://dl.google.com/android/repository/repository2-1.xml)**

```bash
# repository2-1.xml
#
#<complete>
#       <size>154582459</size>
#       <checksum>8c7c28554a32318461802c1291d76fccfafde054</checksum>
#       <url>sdk-tools-linux-4333796.zip</url>
#</complete>
#<host-os>linux</host-os>
wget https://dl.google.com/android/repository/repository2-1.xml
wget https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
```



- **[Flutter Dev](https://flutter.dev/docs/get-started/)**
