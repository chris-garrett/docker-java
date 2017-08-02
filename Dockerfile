FROM openjdk:8u131-jre-alpine
MAINTAINER Chris Garrett (https://github.com/chris-garrett/docker-java)
LABEL description="Java image 8u131"

ARG DOCKERIZE_VERSION=v0.5.0
COPY ./bash_aliases /home/sprout/.bashrc
COPY ./vimrc /home/sprout/.vimrc

RUN adduser -s /bin/bash -D sprout \
  && apk --no-cache add -U \
    ca-certificates \
    openssl \
  && update-ca-certificates \

  && apk --no-cache add -U \
    bash \
    vim \
    wget \
    curl \

  && wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
  && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
  && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \

  && chown sprout:sprout /home/sprout/.bashrc /home/sprout/.vimrc \
  && ln -sf /usr/bin/vim /usr/bin/vi \

  && rm -rf /var/cache/apk/*

  WORKDIR /work/app/src
  USER sprout
