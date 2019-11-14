# Alpine based rsync service

[![DockerHub Badge](http://dockeri.co/image/mesaguy/alpine-rsync)](https://hub.docker.com/r/mesaguy/alpine-rsync)

## Introduction

Simple unprivileged rsync service built for many architectures.

rsync runs on tcp/8730 as the user 'nobody', logs are send to stdout.

## Usage

Data should be mounted to or under /export

The /etc/rsyncd.conf configuration file may be overwritten as needed

## Usage examples

Run basic service on tcp/830 (the default rsync service port)
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
