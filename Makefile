default: build

BUILD_ARGS ?=
DOCKER_IMAGE ?= mesaguy/alpine-rsync
ALPINE_VERSION ?= 3.11
DOCKER_PLATFORMS = linux/amd64,linux/arm64,linux/arm/v7,linux/ppc64le,linux/s390x,linux/386
BUILD_DATE = `date --utc +%Y%m%d`

build:
	docker buildx create --use && \
	docker buildx build --pull --platform ${DOCKER_PLATFORMS} \
		--build-arg ALPINE_VERSION=${ALPINE_VERSION} \
		--build-arg SOURCE_COMMIT=`git rev-parse --short HEAD` \
		--tag ${DOCKER_IMAGE}:latest \
		--tag ${DOCKER_IMAGE}:${BUILD_DATE} \
		${DOCKER_BUILDX_ARGS} .

push:
	docker buildx create --use && \
	docker buildx build --pull --platform ${DOCKER_PLATFORMS} \
		--build-arg ALPINE_VERSION=${ALPINE_VERSION} \
		--build-arg SOURCE_COMMIT=`git rev-parse --short HEAD` \
		--tag ${DOCKER_IMAGE}:latest \
		--tag ${DOCKER_IMAGE}:${BUILD_DATE} \
		--push \
		${DOCKER_BUILDX_ARGS} .
