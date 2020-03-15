FROM ubuntu:18.04

USER root
ARG DEBIAN_FRONTEND=noninteractive
ARG GID=1000
ARG UID=1000
ENV SHELL="/bin/bash"
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update -y > /dev/null && \
    apt install --no-install-recommends -y curl git gnupg lib32stdc++6 && \
    apt install --no-install-recommends -y openjdk-8-jdk openjdk-8-jdk-headless && \
    apt install --no-install-recommends -y openssh-client openssh-server && \
    apt install --no-install-recommends -y python3 python3-dev python3-pip && \
    apt install --no-install-recommends -y sudo unzip vim wget xz-utils zip
RUN apt autoremove --purge -y > /dev/null && \
    apt autoclean -y > /dev/null && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/log/* && \
    rm -rf /tmp/*
RUN echo "StrictHostKeyChecking no" | tee --append /etc/ssh/ssh_config && \
    echo "craftslab ALL=(ALL) NOPASSWD: ALL" | tee --append /etc/sudoers && \
    ln -fs /bin/bash /bin/sh && \
    groupadd -g $GID craftslab && \
    useradd -d /home/craftslab -ms /bin/bash -g craftslab -u $UID craftslab

USER craftslab
WORKDIR /home/craftslab
ARG ANDROID=/home/craftslab/opt/android
ARG FLUTTER=/home/craftslab/opt/flutter
ENV ANDROID_HOME=$ANDROID
ENV PATH=$ANDROID/tools/bin:$FLUTTER/bin:$FLUTTER/bin/cache/dart-sdk/bin:$PATH
RUN wget https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip && \
    mkdir -p $ANDROID; unzip sdk-tools-linux-4333796.zip -d $ANDROID > /dev/null && \
    rm -f sdk-tools-linux-4333796.zip
RUN wget https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_v1.12.13+hotfix.8-stable.tar.xz && \
    tar xf flutter_linux_v1.12.13+hotfix.8-stable.tar.xz -C $HOME/opt > /dev/null && \
    rm -f flutter_linux_v1.12.13+hotfix.8-stable.tar.xz
RUN mkdir $HOME/.android; echo "count=0" > $HOME/.android/repositories.cfg && \
    yes | sdkmanager --licenses > /dev/null && \
    yes | sdkmanager "tools" "build-tools;29.0.0" "platforms;android-29" "platform-tools" > /dev/null && \
    yes | sdkmanager --licenses > /dev/null && \
    flutter doctor -v
