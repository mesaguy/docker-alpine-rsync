ARG ALPINE_VERSION
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

FROM alpine:$ALPINE_VERSION

# Install rsync
RUN apk add --no-cache rsync

# Make a root directory to share by default
RUN mkdir -p /export

# Add a default configuration, this can be overwritten an runtime
# chroot isn't necessary as the daemon is run as 'nobody'
RUN printf 'use chroot = no\n\
read only = yes\n\
[mirror]\n\
    path = /export\n\
    read only = yes\n'\
    > /etc/rsyncd.conf

# Run unprivileged
USER nobody

# Expose port 8730 rather than default 873
EXPOSE 8730

# Run rsync in daemon mode
CMD ["rsync", "--daemon", "--no-detach", "--verbose", "--log-file=/dev/stdout", "--port=8730"]

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="Alpine Rsync server" \
      org.label-schema.description="Simple alpine based unprivileged rsync server" \
      org.label-schema.url="https://hub.docker.com/repository/docker/mesaguy/alpine-rsync/" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/mesaguy/docker-alpine-rsync" \
      org.label-schema.vendor="Mesaguy" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"
