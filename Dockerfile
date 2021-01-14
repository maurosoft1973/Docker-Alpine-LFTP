FROM maurosoft1973/alpine

ARG BUILD_DATE

LABEL \
    maintainer="Mauro Cardillo <mauro.cardillo@gmail.com>" \
    architecture="amd64/x86_64" \
    lftp-version="4.9.1" \
    alpine-version="3.12.3" \
    build="$BUILD_DATE" \
    org.opencontainers.image.title="alpine-lftp" \
    org.opencontainers.image.description="LFTP 4.9.1 Docker image running on Alpine Linux" \
    org.opencontainers.image.authors="Mauro Cardillo <mauro.cardillo@gmail.com>" \
    org.opencontainers.image.vendor="Mauro Cardillo" \
    org.opencontainers.image.version="v4.9.1" \
    org.opencontainers.image.url="https://hub.docker.com/r/maurosoft1973/alpine-lftp/" \
    org.opencontainers.image.source="https://github.com/maurosoft1973/alpine-lftp" \
    org.opencontainers.image.created=$BUILD_DATE

RUN \
    apk add --update --no-cache openssh-client git lftp && \
    rm -rf /tmp/* /var/cache/apk/*

# https://gist.githubusercontent.com/HackingGate/9e8169c7645b074b2f40c959ca20d738/raw/3ae3913f308d9cf34962ac3488b5973a2fbe1a95/restore_last_git_modified_time.sh
ADD files/restore_last_git_modified_time.sh /usr/local/sbin/git_restore_last_modified_time
RUN chmod +x /usr/local/sbin/git_restore_last_modified_time

ADD files/restore_last_git_modified_time.sh /restore_last_git_modified_time.sh
RUN chmod +x /restore_last_git_modified_time.sh

ADD files/run-alpine-lftp.sh /scripts/run-alpine-lftp.sh
RUN chmod +x /scripts/run-alpine-lftp.sh

ENTRYPOINT ["/scripts/run-alpine-lftp.sh"]
