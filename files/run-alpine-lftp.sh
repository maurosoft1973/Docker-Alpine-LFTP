#!/bin/sh

source /scripts/init-alpine.sh

mkdir -p ~/.ssh && chmod 700 ~/.ssh
echo "Host *" >> ~/.ssh/config
echo "     StrictHostKeyChecking no" >> ~/.ssh/config
echo "     HostKeyAlgorithms=+ssh-dss" >> ~/.ssh/config

/bin/sh
