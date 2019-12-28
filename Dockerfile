ARG ALPINE_VERSION=latest
ARG SOURCE_COMMIT
ARG VERSION=latest

FROM alpine:$ALPINE_VERSION

# Install rsync
RUN apk add --no-cache rsync && \
# Make a root directory to share by default
mkdir -p /export

# Add a default configuration, this can be overwritten an runtime
# chroot isn't necessary as the daemon is run as 'nobody'
RUN printf 'use chroot = no\n\
read only = yes\n\
[mirror]\n\
    path = /export\n\
    read only = yes\n\
    reverse lookup = no\n'\
    > /etc/rsyncd.conf

# Run unprivileged
USER nobody

# Expose port 8730 rather than default 873
EXPOSE 8730

# Run rsync in daemon mode
CMD ["rsync", "--daemon", "--no-detach", "--verbose", "--log-file=/dev/stdout", "--port=8730"]

LABEL org.label-schema.name="Alpine rsync service" \
      org.label-schema.description="Simple alpine based unprivileged rsync service built for many architectures" \
      org.label-schema.url="https://hub.docker.com/repository/docker/mesaguy/alpine-rsync/" \
      org.label-schema.vcs-ref=$SOURCE_COMMIT \
      org.label-schema.vcs-url="https://github.com/mesaguy/docker-alpine-rsync" \
      org.label-schema.vendor="Mesaguy" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"
