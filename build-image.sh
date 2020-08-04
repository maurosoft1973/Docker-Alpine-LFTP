#!/bin/bash
# Description: Build image and push to repository
# Maintainer: Mauro Cardillo
# DOCKER_HUB_USER and DOCKER_HUB_PASSWORD is user environment variable
IMAGE=maurosoft1973/alpine-lftp
BUILD_DATE=$(date +"%Y-%m-%d")
ENV=TEST

# Loop through arguments and process them
for arg in "$@"
do
    case $arg in
        -e=*|--env=*)
        ENV="${arg#*=}"
        shift # Remove
        ;;
        -h|--help)
        echo -e "usage "
        echo -e "$0 "
        echo -e "  -e=|--env=${ENV} -> environment (TEST or PROD)"
        exit 0
        ;;
    esac
done

echo "# Image               : ${IMAGE}"
echo "# Environment         : ${ENV}"
echo "# Build Date          : ${BUILD_DATE}"

if [ "${ENV}" == "TEST" ]; then
    echo "Remove image ${IMAGE}:test"
    docker rmi -f ${IMAGE}:test > /dev/null 2>&1

    echo "Build Image: ${IMAGE}:test"
    docker build --build-arg BUILD_DATE=$BUILD_DATE -t ${IMAGE}:test .
else 
    docker build --build-arg BUILD_DATE=$BUILD_DATE -t ${IMAGE} -t ${IMAGE}:amd64 -t ${IMAGE}:x86_64 .

    #echo "Login Docker HUB"
    echo "$DOCKER_HUB_PASSWORD" | docker login -u "$DOCKER_HUB_USER" --password-stdin

    #echo "Push Image"
    docker push ${IMAGE}:amd64
    docker push ${IMAGE}:x86_64
    docker push ${IMAGE}
fi
