FROM ubuntu:18.04

USER root
ARG DEBIAN_FRONTEND=noninteractive
ARG GID=1000
ARG UID=1000
ENV SHELL="/bin/bash"
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update -y > /dev/null && \
    apt install -y curl git gnupg lib32stdc++6 && \
    apt install -y openjdk-8-jdk openjdk-8-jdk-headless && \
    apt install -y openssh-client openssh-server && \
    apt install -y python3 python3-dev python3-pip && \
    apt install -y sudo unzip vim xz-utils zip
RUN apt autoremove --purge -y > /dev/null && \
    apt autoclean -y > /dev/null && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/log/* && \
    rm -rf /tmp/*
RUN echo "StrictHostKeyChecking no" | tee --append /etc/ssh/ssh_config && \
    echo "craftslab ALL=(ALL) NOPASSWD: ALL" | tee --append /etc/sudoers && \
    echo "dash dash/sh boolean false" | debconf-set-selections && \
    DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash && \
    groupadd -g $GID craftslab && \
    useradd -d /home/craftslab -ms /bin/bash -g craftslab -u $UID craftslab

USER craftslab
WORKDIR /home/craftslab
ARG ANDROID=/home/craftslab/opt/android
ARG FLUTTER=/home/craftslab/opt/flutter
ENV ANDROID_HOME=$ANDROID
ENV FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
ENV PATH=$ANDROID/tools/bin:$FLUTTER/bin:$FLUTTER/bin/cache/dart-sdk/bin:$PATH
ENV PUB_HOSTED_URL=https://pub.flutter-io.cn
RUN curl -L https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip -o sdk-tools.zip && \
    mkdir -p $ANDROID; unzip sdk-tools.zip -d $ANDROID > /dev/null && \
    rm -f sdk-tools.zip
RUN curl -L https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_1.22.4-stable.tar.xz -o flutter.tar.xz && \
    tar xf flutter.tar.xz -C $HOME/opt > /dev/null && \
    rm -f flutter.tar.xz
RUN mkdir $HOME/.android; echo "count=0" > $HOME/.android/repositories.cfg && \
    yes | sdkmanager "build-tools;30.0.2" > /dev/null && \
    yes | sdkmanager "extras;android;m2repository" > /dev/null && \
    yes | sdkmanager "extras;google;m2repository" > /dev/null && \
    yes | sdkmanager "platforms;android-30" > /dev/null && \
    yes | sdkmanager "platform-tools" > /dev/null && \
    yes | sdkmanager "tools" > /dev/null && \
    yes | sdkmanager --licenses > /dev/null && \
    flutter doctor -v
