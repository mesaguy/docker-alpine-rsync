# Alpine based rsync server

[![DockerHub Badge](http://dockeri.co/image/mesaguy/alpine-rsync)](https://hub.docker.com/r/mesaguy/alpine-rsync)

## Introduction

Simple unprivileged rsync server built for many architectures.

rsync runs on tcp/8730 as the user 'nobody', logs are send to stdout.

## Usage

Data should be mounted to or under /export

The /etc/rsyncd.conf configuration file may be overwritten as needed

## Usage examples

Run basic server on tcp/830 (the default rsync server port)
``` script
docker run -p 873:8730 -v /mydata/:/export/ -it mesaguy/alpine-rsync
```

Use a custom rsyncd configuration and multiple mounts
``` script
docker run -p 873:8730 \
    -v /mydata/:/export/data/ \
    -v /my-www/:/export/www/ \
    -v $(pwd)/rsyncd.conf:/etc/rsyncd.conf \
    -it mesaguy/alpine-rsync
```
