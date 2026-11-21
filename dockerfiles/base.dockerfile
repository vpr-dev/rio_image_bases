# Shared base for every image in this project. Built as the `base` compose
# service (each compose file tags it differently); the other dockerfiles start
# `FROM base`, which compose resolves via a named build context.
FROM ubuntu:24.04

SHELL ["/bin/bash", "-c"]

WORKDIR /rioapp

ENV TZ=America/Vancouver

RUN apt-get update \
    && apt-get install -y \
       vim \
       git \
       wget \
       # `net-tools` comes with `netstat`
       net-tools \
       tree \
       ssh \
       curl \
       zip \
       unzip \
       tzdata \
    && rm -rf /var/lib/apt/lists/* \
    # set up system timezone e.g. cron will trigger tasks based on /etc/localtime
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    # convention, /etc/timezone is just a text note
    && echo $TZ > /etc/timezone

RUN cd /root \
    # set up vi input mode in bash
    && echo "set -o vi" >> .bashrc

CMD [ "bash" ]
