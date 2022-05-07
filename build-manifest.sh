#!/bin/bash
# Description: Push image to repository
# Maintainer: Mauro Cardillo
DOCKER_IMAGE=maurosoft1973/alpine-lftp
RELEASE=TEST

# Loop through arguments and process them
for arg in "$@"
do
    case $arg in
        -di=*|--docker-image=*)
        DOCKER_IMAGE="${arg#*=}"
        shift # Remove
        ;;
        -du=*|--docker-hub-username=*)
        DOCKER_HUB_USERNAME="${arg#*=}"
        shift # Remove
        ;;
        -dp=*|--docker-hub-password=*)
        DOCKER_HUB_PASSWORD="${arg#*=}"
        shift # Remove
        ;;
        -av=*|--alpine-version=*)
        ALPINE_VERSION="${arg#*=}"
        shift # Remove
        ;;
        -lv=*|--lftp-version=*)
        LFTP_VERSION="${arg#*=}"
        shift # Remove
        ;;
        -r=*|--release=*)
        RELEASE="${arg#*=}"
        shift # Remove
        ;;
        -h|--help)
        echo -e "usage "
        echo -e "$0 "
        echo -e "  -di=|--docker-image         -> ${DOCKER_IMAGE:-""} (docker image name)"
        echo -e "  -du=|--docker-hub-username  -> ${DOCKER_HUB_USERNAME:-""} (docker hub username)"
        echo -e "  -dp=|--docker-hub-password  -> ${DOCKER_HUB_PASSWORD:-""} (docker hub password)"
        echo -e "  -av=|--alpine-version       -> ${ALPINE_VERSION:-""} (alpine version)"
        echo -e "  -mv=|--lftp-version         -> ${LFTP_VERSION:-""} (lftp version)"
        echo -e "  -r=|--release               -> ${RELEASE:-""} (release of image.Values: TEST, CURRENT, LATEST)"
        exit 0
        ;;
    esac
done

echo "# Docker Image              -> ${DOCKER_IMAGE}"
echo "# Docker Image Release      -> ${RELEASE}"
echo "# Alpine Version            -> ${ALPINE_VERSION}"
echo "# LFTP Version              -> ${LFTP_VERSION}"

ARGUMENT_ERROR=0

if [ "${DOCKER_IMAGE}" == "" ]; then
    echo "ERROR: The variable DOCKER_IMAGE is not set!"
    ARGUMENT_ERROR=1
fi

if [ "${DOCKER_HUB_USERNAME}" == "" ]; then
    echo "ERROR: The variable DOCKER_HUB_USERNAME is not set!"
    ARGUMENT_ERROR=1
fi

if [ "${DOCKER_HUB_PASSWORD}" == "" ]; then
    echo "ERROR: The variable DOCKER_HUB_PASSWORD is not set!"
    ARGUMENT_ERROR=1
fi

if [ "${ALPINE_VERSION}" == "" ]; then
    echo "ERROR: The variable ALPINE_VERSION is not set!"
    ARGUMENT_ERROR=1
fi

if [ "${LFTP_VERSION}" == "" ]; then
    echo "ERROR: The variable LFTP_VERSION is not set!"
    ARGUMENT_ERROR=1
fi

if [ ${ARGUMENT_ERROR} -ne 0 ]; then
    exit 1
fi

TOKEN=$(curl -s -H "Content-Type: application/json" -X POST -d '{"username": "'${DOCKER_HUB_USERNAME}'", "password": "'${DOCKER_HUB_PASSWORD}'"}' https://hub.docker.com/v2/users/login/ | jq -r .token)

if [ "$TOKEN" != "null" ]; then
    echo "Login Docker HUB"
    echo "$DOCKER_HUB_PASSWORD" | docker login -u "$DOCKER_HUB_USER" --password-stdin

    if [ "$RELEASE" == "TEST" ]; then
        echo "Push Manifest for $RELEASE"
        docker manifest create ${DOCKER_IMAGE}:test \
            --amend ${DOCKER_IMAGE}:test-aarch64 \
            --amend ${DOCKER_IMAGE}:test-armhf \
            --amend ${DOCKER_IMAGE}:test-armv7 \
            --amend ${DOCKER_IMAGE}:test-ppc64le \
            --amend ${DOCKER_IMAGE}:test-x86 \
            --amend ${DOCKER_IMAGE}:test-x86_64

        docker manifest push ${DOCKER_IMAGE}:test
    elif [ "$RELEASE" == "CURRENT" ]; then
        echo "Push Manifest for $RELEASE"
        docker manifest create ${DOCKER_IMAGE}:${ALPINE_VERSION} \
            --amend ${DOCKER_IMAGE}:${ALPINE_VERSION}-aarch64 \
            --amend ${DOCKER_IMAGE}:${ALPINE_VERSION}-armhf \
            --amend ${DOCKER_IMAGE}:${ALPINE_VERSION}-armv7 \
            --amend ${DOCKER_IMAGE}:${ALPINE_VERSION}-ppc64le \
            --amend ${DOCKER_IMAGE}:${ALPINE_VERSION}-x86 \
            --amend ${DOCKER_IMAGE}:${ALPINE_VERSION}-x86_64

        docker manifest push ${DOCKER_IMAGE}:${ALPINE_VERSION}

        docker manifest create ${DOCKER_IMAGE}:${ALPINE_VERSION}-${LFTP_VERSION} \
            --amend ${DOCKER_IMAGE}:${ALPINE_VERSION}-${LFTP_VERSION}-aarch64 \
            --amend ${DOCKER_IMAGE}:${ALPINE_VERSION}-${LFTP_VERSION}-armhf \
            --amend ${DOCKER_IMAGE}:${ALPINE_VERSION}-${LFTP_VERSION}-armv7 \
            --amend ${DOCKER_IMAGE}:${ALPINE_VERSION}-${LFTP_VERSION}-ppc64le \
            --amend ${DOCKER_IMAGE}:${ALPINE_VERSION}-${LFTP_VERSION}-x86 \
            --amend ${DOCKER_IMAGE}:${ALPINE_VERSION}-${LFTP_VERSION}-x86_64

        docker manifest push ${DOCKER_IMAGE}:${ALPINE_VERSION}-${LFTP_VERSION}
    else
        echo "Push Manifest for $RELEASE"
        docker manifest create ${DOCKER_IMAGE} \
            --amend ${DOCKER_IMAGE}:aarch64 \
            --amend ${DOCKER_IMAGE}:armhf \
            --amend ${DOCKER_IMAGE}:armv7 \
            --amend ${DOCKER_IMAGE}:ppc64le \
            --amend ${DOCKER_IMAGE}:x86 \
            --amend ${DOCKER_IMAGE}:x86_64

        docker manifest push ${DOCKER_IMAGE}

        docker manifest create ${DOCKER_IMAGE}:${LFTP_VERSION} \
            --amend ${DOCKER_IMAGE}:${LFTP_VERSION}-aarch64 \
            --amend ${DOCKER_IMAGE}:${LFTP_VERSION}-armhf \
            --amend ${DOCKER_IMAGE}:${LFTP_VERSION}-armv7 \
            --amend ${DOCKER_IMAGE}:${LFTP_VERSION}-ppc64le \
            --amend ${DOCKER_IMAGE}:${LFTP_VERSION}-x86 \
            --amend ${DOCKER_IMAGE}:${LFTP_VERSION}-x86_64

        docker manifest push ${DOCKER_IMAGE}:${LFTP_VERSION}
    fi
else 
    echo "Login to Docker Hub Failed, verify username and password"
    exit 1
fi
