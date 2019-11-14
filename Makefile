default: build

DOCKER_IMAGE ?= mesaguy/alpine-rsync
ALPINE_VERSION ?= 3.10.3
DOCKER_PLATFORMS = linux/amd64,linux/arm64,linux/arm/v7,linux/ppc64le,linux/s390x,linux/386
BUILD_DATE = `date --utc +%Y%m%d`

build:
	docker buildx build --platform ${DOCKER_PLATFORMS} \
		--build-arg ALPINE_VERSION=${ALPINE_VERSION} \
		--build-arg VCS_REF=`git rev-parse --short HEAD` \
		--tag ${DOCKER_IMAGE}:latest \
		--tag ${DOCKER_IMAGE}:${BUILD_DATE} \
		.

push:
	docker buildx build --platform ${DOCKER_PLATFORMS} \
		--build-arg ALPINE_VERSION=${ALPINE_VERSION} \
		--build-arg VCS_REF=`git rev-parse --short HEAD` \
		--tag ${DOCKER_IMAGE}:latest \
		--tag ${DOCKER_IMAGE}:${BUILD_DATE} \
		--push \
		.
