default: build

DOCKER_IMAGE ?= mesaguy/alpine-rsync
VERSION ?= 1.0.0
ALPINE_VERSION ?= 3.10.3
DOCKER_PLATFORMS = linux/amd64,linux/arm64,linux/arm/v7,linux/ppc64le,linux/s390x,linux/386

build:
	docker buildx build --platform ${DOCKER_PLATFORMS} \
		--build-arg ALPINE_VERSION=${ALPINE_VERSION} \
		--tag ${DOCKER_IMAGE}:latest \
		--tag ${DOCKER_IMAGE}:`date +%Y%m%d` \
		.

push:
	docker buildx build --platform ${DOCKER_PLATFORMS} \
		--build-arg ALPINE_VERSION=${ALPINE_VERSION} \
		--tag ${DOCKER_IMAGE}:latest \
		--tag ${DOCKER_IMAGE}:`date +%Y%m%d` \
		--push \
		.
