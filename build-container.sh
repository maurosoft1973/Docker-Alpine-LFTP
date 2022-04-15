#!/bin/bash
# Description: Script for alpine container
# Maintainer: Mauro Cardillo
source ./.env

# Default values of arguments
DOCKER_IMAGE=maurosoft1973/alpine-lftp
DOCKER_IMAGE_TAG=latest
CONTAINER=alpine-lftp-${DOCKER_IMAGE_TAG}
LC_ALL=it_IT.UTF-8
TIMEZONE=Europe/Rome

# Loop through arguments and process them
for arg in "$@"
do
    case $arg in
        -it=*|--image-tag=*)
        DOCKER_IMAGE_TAG="${arg#*=}"
        shift # Remove
        ;;
        -cn=*|--container=*)
        CONTAINER="${arg#*=}"
        shift # Remove
        ;;
        -cl=*|--lc_all=*)
        LC_ALL="${arg#*=}"
        shift # Remove
        ;;
        -ct=*|--timezone=*)
        TIMEZONE="${arg#*=}"
        shift # Remove
        ;;
        -h|--help)
        echo -e "usage "
        echo -e "$0 "
        echo -e "  -it=|--image-tag -> ${DOCKER_IMAGE}:${DOCKER_IMAGE_TAG} (image with tag)"
        echo -e "  -cn=|--container -> ${CONTAINER} (container name)"
        echo -e "  -cl=|--lc_all -> ${LC_ALL} (container locale)"
        echo -e "  -ct=|--timezone -> ${TIMEZONE} (container timezone)"
        exit 0
        ;;
    esac
done

echo "# Docker Image            : ${DOCKER_IMAGE}:${DOCKER_IMAGE_TAG}"
echo "# Container Name          : ${CONTAINER}"
echo "# Container Locale        : ${LC_ALL}"
echo "# Container Timezone      : ${TIMEZONE}"

echo -e "Check if container ${CONTAINER} exist"
CHECK=$(docker container ps -a | grep ${CONTAINER} | wc -l)
if [ ${CHECK} == 1 ]; then
    echo -e "Stop Container -> ${CONTAINER}"
    docker stop ${CONTAINER} > /dev/null

    echo -e "Remove Container -> ${CONTAINER}"
    docker container rm ${CONTAINER} > /dev/null
else 
    echo -e "The container ${CONTAINER} not exist"
fi

echo -e "Create and run container"
docker run -dit --name ${CONTAINER} -e LC_ALL=${LC_ALL} -e TIMEZONE=${TIMEZONE} ${DOCKER_IMAGE}:${DOCKER_IMAGE_TAG}

echo -e ""
echo -e "Sleep 5 second"
sleep 5

IP=$(docker exec -it ${CONTAINER} /sbin/ip route | grep "src" | awk '{print $7}')
echo -e "IP Address is: $IP"

echo -e ""
echo -e "Environment variable"
docker exec -it ${CONTAINER} env

echo -e ""
echo -e "Test Locale (date)"
docker exec -it ${CONTAINER} date

echo -e ""
echo -e "Check Release Version"
CONTAINER_ALPINE_VERSION_RAW=$(docker exec -it ${CONTAINER} cat /etc/alpine-release)
CONTAINER_ALPINE_VERSION=`echo $CONTAINER_ALPINE_VERSION_RAW | sed 's/\\r//g'`

echo -e "Container Version -> ${CONTAINER_ALPINE_VERSION}"
echo -e "Expected Version  -> ${ALPINE_VERSION}"

if [ "${CONTAINER_ALPINE_VERSION}" == "${ALPINE_VERSION}" ]; then
    echo -e "OK"
else 
    echo -e "KO"
fi

echo -e ""
echo -e "Attach Containers"
docker attach ${CONTAINER}
