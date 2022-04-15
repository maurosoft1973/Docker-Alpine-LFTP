#!/bin/bash
# Description: Build image
# Maintainer: Mauro Cardillo
BUILD_DATE=$(date +"%Y-%m-%d")
DOCKER_IMAGE=maurosoft1973/alpine-lftp
ALPINE_ARCHITECTURE=x86_64

# Loop through arguments and process them
for arg in "$@"
do
    case $arg in
        -di=*|--docker-image=*)
        DOCKER_IMAGE="${arg#*=}"
        shift # Remove
        ;;
        -aa=*|--alpine-architecture=*)
        ALPINE_ARCHITECTURE="${arg#*=}"
        shift # Remove
        ;;
        -ar=*|--alpine-release=*)
        export ALPINE_RELEASE="${arg#*=}"
        shift # Remove
        ;;
        -av=*|--alpine-version=*)
        ALPINE_VERSION="${arg#*=}"
        shift # Remove
        ;;
        -ad=*|--alpine-version-date=*)
        ALPINE_VERSION_DATE="${arg#*=}"
        shift # Remove
        ;;
        -lv=*|--lftp-version=*)
        LFTP_VERSION="${arg#*=}"
        shift # Remove
        ;;
        -ld=*|--lftp-version-date=*)
        LFTP_VERSION_DATE="${arg#*=}"
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
        echo -e "  -aa=|--alpine-architecture  -> ${ALPINE_ARCHITECTURE:-""} (alpine architecture)"
        echo -e "  -ar=|--alpine-release       -> ${ALPINE_RELEASE:-""} (alpine release)"
        echo -e "  -av=|--alpine-version       -> ${ALPINE_VERSION:-""} (alpine version)"
        echo -e "  -ad=|--alpine-version-date  -> ${ALPINE_VERSION_DATE:-""} (alpine version date)"
        echo -e "  -lv=|--lftp-version         -> ${LFTP_VERSION:-""} (lftp version)"
        echo -e "  -ld=|--lftp-version-date    -> ${LFTP_VERSION_DATE:-""} (lftp version date)"
        echo -e "  -r=|--release               -> ${RELEASE:-""} (release of image.Values: TEST, CURRENT, LATEST)"
        exit 0
        ;;
    esac
done

echo "# Build Date                -> ${BUILD_DATE}"
echo "# Docker Image              -> ${DOCKER_IMAGE}"
echo "# Docker Image Release      -> ${RELEASE}"
echo "# Alpine Architecture       -> ${ALPINE_ARCHITECTURE}"
echo "# Alpine Release            -> ${ALPINE_RELEASE}"
echo "# Alpine Version            -> ${ALPINE_VERSION}"
echo "# Alpine Version Date       -> ${ALPINE_VERSION_DATE}"
echo "# LFTP Version              -> ${LFTP_VERSION}"
echo "# LFTP Version Date         -> ${LFTP_VERSION_DATE}"

ARGUMENT_ERROR=0

if [ "${DOCKER_IMAGE}" == "" ]; then
    echo "ERROR: The variable DOCKER_IMAGE is not set!"
    ARGUMENT_ERROR=1
fi

if [ "${ALPINE_ARCHITECTURE}" == "" ]; then
    echo "ERROR: The variable ALPINE_ARCHITECTURE is not set!"
    ARGUMENT_ERROR=1
fi

if [ "${ALPINE_RELEASE}" == "" ]; then
    echo "ERROR: The variable ALPINE_RELEASE is not set!"
    ARGUMENT_ERROR=1
fi

if [ "${ALPINE_VERSION}" == "" ]; then
    echo "ERROR: The variable ALPINE_VERSION is not set!"
    ARGUMENT_ERROR=1
fi

if [ "${ALPINE_VERSION_DATE}" == "" ]; then
    echo "ERROR: The variable ALPINE_VERSION_DATE is not set!"
    ARGUMENT_ERROR=1
fi

if [ "${LFTP_VERSION}" == "" ]; then
    echo "ERROR: The variable LFTP_VERSION is not set!"
    ARGUMENT_ERROR=1
fi

if [ "${LFTP_VERSION_DATE}" == "" ]; then
    echo "ERROR: The variable LFTP_VERSION_DATE is not set!"
    ARGUMENT_ERROR=1
fi

if [ ${ARGUMENT_ERROR} -ne 0 ]; then
    exit 1
fi

#linux/amd64, linux/386, linux/arm64, linux/riscv64, linux/ppc64le, linux/s390x, linux/arm/v7, linux/arm/v6
PLATFORM="linux/amd64"
if [ "${ALPINE_ARCHITECTURE}" == "aarch64" ]; then
    PLATFORM="linux/arm64"
elif [ "${ALPINE_ARCHITECTURE}" == "armhf" ]; then
    PLATFORM="linux/arm/v6"
elif [ "${ALPINE_ARCHITECTURE}" == "armv7" ]; then
    PLATFORM="linux/arm/v7"
elif [ "${ALPINE_ARCHITECTURE}" == "ppc64le" ]; then
    PLATFORM="linux/ppc64le"
elif [ "${ALPINE_ARCHITECTURE}" == "x86" ]; then
    PLATFORM="linux/386"
elif [ "${ALPINE_ARCHITECTURE}" == "x86_64" ]; then
    PLATFORM="linux/amd64"
fi

if [ "$RELEASE" == "TEST" ]; then
    echo "Remove image ${DOCKER_IMAGE}:test-${ALPINE_ARCHITECTURE}"
    docker rmi -f ${DOCKER_IMAGE}:test-${ALPINE_ARCHITECTURE} > /dev/null 2>&1

    echo "Build Image: ${DOCKER_IMAGE} -> $RELEASE"
    docker buildx build --platform ${PLATFORM} \
            --build-arg DOCKER_ALPINE_VERSION=${ALPINE_VERSION} \
            --build-arg BUILD_DATE=${BUILD_DATE} \
            --build-arg ALPINE_ARCHITECTURE=${ALPINE_ARCHITECTURE} \
            --build-arg ALPINE_RELEASE=${ALPINE_RELEASE} \
            --build-arg ALPINE_VERSION=${ALPINE_VERSION} \
            --build-arg ALPINE_VERSION_DATE="${ALPINE_VERSION_DATE}" \
            --build-arg LFTP_VERSION=${LFTP_VERSION} \
            --build-arg LFTP_VERSION_DATE="${LFTP_VERSION_DATE}" \
            -t ${DOCKER_IMAGE}:test-${ALPINE_ARCHITECTURE} \
            -f ./Dockerfile .
elif [ "$RELEASE" == "CURRENT" ]; then
    echo "Remove image ${DOCKER_IMAGE}:${ALPINE_VERSION}-${ALPINE_ARCHITECTURE}"
    docker rmi -f ${DOCKER_IMAGE}:${ALPINE_VERSION}-${ALPINE_ARCHITECTURE}> /dev/null 2>&1

    echo "Remove image ${DOCKER_IMAGE}:${ALPINE_VERSION}-${LFTP_VERSION}-${ALPINE_ARCHITECTURE}"
    docker rmi -f ${DOCKER_IMAGE}:${ALPINE_VERSION}-${LFTP_VERSION}-${ALPINE_ARCHITECTURE}> /dev/null 2>&1

    echo "Build Image: ${DOCKER_IMAGE} -> $RELEASE"
    docker buildx build --platform ${PLATFORM} \
            --build-arg DOCKER_ALPINE_VERSION=${ALPINE_VERSION} \
            --build-arg BUILD_DATE=${BUILD_DATE} \
            --build-arg ALPINE_ARCHITECTURE=${ALPINE_ARCHITECTURE} \
            --build-arg ALPINE_RELEASE=${ALPINE_RELEASE} \
            --build-arg ALPINE_VERSION=${ALPINE_VERSION} \
            --build-arg ALPINE_VERSION_DATE="${ALPINE_VERSION_DATE}" \
            --build-arg LFTP_VERSION=${LFTP_VERSION} \
            --build-arg LFTP_VERSION_DATE="${LFTP_VERSION_DATE}" \
            -t ${DOCKER_IMAGE}:${ALPINE_VERSION}-${ALPINE_ARCHITECTURE} \
            -t ${DOCKER_IMAGE}:${ALPINE_VERSION}-${LFTP_VERSION}-${ALPINE_ARCHITECTURE} \
            -f ./Dockerfile .
else
    echo "Remove image ${DOCKER_IMAGE}:${ALPINE_ARCHITECTURE}"
    docker rmi -f ${DOCKER_IMAGE}:${ALPINE_ARCHITECTURE} > /dev/null 2>&1

    echo "Remove image ${DOCKER_IMAGE}:${LFTP_VERSION}-${ALPINE_ARCHITECTURE}"
    docker rmi -f ${DOCKER_IMAGE}:${LFTP_VERSION}-${ALPINE_ARCHITECTURE}> /dev/null 2>&1

    echo "Build Image: ${DOCKER_IMAGE} -> $RELEASE"
    docker buildx build --platform ${PLATFORM} \
            --build-arg DOCKER_ALPINE_VERSION=${ALPINE_VERSION} \
            --build-arg BUILD_DATE=${BUILD_DATE} \
            --build-arg ALPINE_ARCHITECTURE=${ALPINE_ARCHITECTURE} \
            --build-arg ALPINE_RELEASE=${ALPINE_RELEASE} \
            --build-arg ALPINE_VERSION=${ALPINE_VERSION} \
            --build-arg ALPINE_VERSION_DATE="${ALPINE_VERSION_DATE}" \
            --build-arg LFTP_VERSION=${LFTP_VERSION} \
            --build-arg LFTP_VERSION_DATE="${LFTP_VERSION_DATE}" \
            -t ${DOCKER_IMAGE}:${ALPINE_ARCHITECTURE} \
            -t ${DOCKER_IMAGE}:${LFTP_VERSION}-${ALPINE_ARCHITECTURE} \
            -f ./Dockerfile .
fi
