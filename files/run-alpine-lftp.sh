#!/bin/sh

source /scripts/init-alpine.sh

mkdir -p ~/.ssh && chmod 700 ~/.ssh
echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config

/bin/sh
