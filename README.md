# LFTP Docker image running on Alpine Linux

[![Docker Automated build](https://img.shields.io/docker/automated/maurosoft1973/alpine-lftp.svg?style=for-the-badge&logo=docker)](https://hub.docker.com/r/maurosoft1973/alpine-lftp/)
[![Docker Pulls](https://img.shields.io/docker/pulls/maurosoft1973/alpine-lftp.svg?style=for-the-badge&logo=docker)](https://hub.docker.com/r/maurosoft1973/alpine-lftp/)
[![Docker Stars](https://img.shields.io/docker/stars/maurosoft1973/alpine-lftp.svg?style=for-the-badge&logo=docker)](https://hub.docker.com/r/maurosoft1973/alpine-lftp/)

[![Alpine Version](https://img.shields.io/badge/Alpine%20version-v3.15.1-green.svg?style=for-the-badge)](https://alpinelinux.org/)

The Docker images [(maurosoft1973/alpine-lftp)](https://hub.docker.com/r/maurosoft1973/alpine-lftp/) is based on the minimal [Alpine Linux](https://alpinelinux.org/)  with [LFTP Version v4.9.2-r3](https://lftp.yar.ru/).

##### Alpine Version 3.15.1 (Released Mar 16 2022)
##### LFTP Version 4.9.2-r3 (Released 2021-10-16 06:04:30)

## Description

The LFTP is a sophisticated file transfer program supporting a number of network protocols (ftp, http, sftp, fish, torrent). Like BASH, it has job control and uses the readline library for input. It has bookmarks, a built-in mirror command, and can transfer several files in parallel. It was designed with reliability in mind. LFTP is free software, distributed under the GNU GPL license.
For more information [(lftp)](https://lftp.yar.ru/features.html)

LFTP includes the following features (some may be missed in this list):

* FTP and HTTP protocols support.
* FTP (e.g. TIS FWTK) proxy support.
* HTTP proxy support.
* FTP over HTTP proxy support (hftp and CONNECT method).
* HTTPS and FTPS protocols support using GNU TLS or OpenSSL library.
* Automatic OPIE/SKEY support in FTP protocol.
* FXP transfers support (between two FTP servers, bypassing client machine).
* FTP listings support: unix-style, NT, EPLF, OS/2, AS400, MacWebStar, MLSD.
* FTP implicit compression (MODE Z) support.
* Automatic reconnect and retry of an operation on retriable errors or timeout.
* IPv6 support in both FTP and HTTP.
* FISH protocol support. It uses ssh with no special program on server side.
* SFTP protocol v3-v6 support.
* HTTP/1.1 keep-alive support.
* HTTP basic and digest authentication.
* Partial WebDAV support.
* BitTorrent protocol support (including IPv6).
* BitTorrent extensions: Fast, DHT, PEX, Multi-tracker, Metadata, magnet.
* Experimental support for SRV DNS records.
* SOCKS support (configure option).
* Modification time preservation (if server can report it).
* reget and reput support.
* Built-in mirror and reverse mirror (mirror -R).
* Transfer rate throttling for each connection, for each host and for all connections in total.
* Limit for number of connections to the same site. Interruption of background transfer to do a foreground operation when the limit is reached.
* Socket options tuning: buffer size and maximum segment size.
* Job queueing.
* Job execution at specified time.
* Comprehensive scripting support.
* URL recognition in most operations.
* Readline library is used for input.
* Context sensitive completion.
* Bash-like prompt extensions.
* Launching of local shell commands.
* Suspend support.
* Bookmarks.
* Aliases.
* Saving of last directory on each site. `cd -' to go there.
* Copying of files (including mirror) between two servers over the client, automatic usage of FXP when possible to bypass the client.
* Numerous settings which can be associated with a specific server or a group.
* Paging of remote files using external program.
* zcat and zmore support.
* Help for commands.
* Command history saved in a file.
* Transfer status includes rate and ETA.
* File listing cache.
* Background jobs (bash-like).
* Job output redirection to a file or to a program via pipe.
* Conditional commands depending on exit status of previous one.
* Loading of binary modules at run time (configure option).
* pget to download a file using several connections. `pget' download can be continued as it saves a status file periodically.
* mirror can download several files in parallel (--parallel option) and a single file with `pget' (--use-pget-n option).
* Slots. Each slot is a separate session, switch using Meta-{1-9} or `slot' command. Refer to a slot site using pseudo URL slot:name.

## Architectures

* ```:aarch64``` - 64 bit ARM
* ```:armhf```   - 32 bit ARM v6
* ```:armv7```   - 32 bit ARM v7
* ```:ppc64le``` - 64 bit PowerPC
* ```:x86```     - 32 bit Intel/AMD
* ```:x86_64```  - 64 bit Intel/AMD (x86_64/amd64)

## Tags

* ```:latest```         latest branch based (Automatic Architecture Selection)
* ```:aarch64```        latest 64 bit ARM
* ```:armhf```          latest 32 bit ARM v6
* ```:armv7```          latest 32 bit ARM v7
* ```:ppc64le```        latest 64 bit PowerPC
* ```:x86```            latest 32 bit Intel/AMD
* ```:x86_64```         latest 64 bit Intel/AMD
* ```:test```           test branch based (Automatic Architecture Selection)
* ```:test-aarch64```   test 64 bit ARM
* ```:test-armhf```     test 32 bit ARM v6
* ```:test-armv7```     test 32 bit ARM v7
* ```:test-ppc64le```   test 64 bit PowerPC
* ```:test-x86```       test 32 bit Intel/AMD
* ```:test-x86_64```    test 64 bit Intel/AMD
* ```:3.15.1``` 3.15.1 branch based (Automatic Architecture Selection)
* ```:3.15.1-aarch64```   3.15.1 64 bit ARM
* ```:3.15.1-armhf```     3.15.1 32 bit ARM v6
* ```:3.15.1-armv7```     3.15.1 32 bit ARM v7
* ```:3.15.1-ppc64le```   3.15.1 64 bit PowerPC
* ```:3.15.1-x86```       3.15.1 32 bit Intel/AMD
* ```:3.15.1-x86_64```    3.15.1 64 bit Intel/AMD
* ```:3.15.1-4.9.2-r3``` 3.15.1-4.9.2-r3 branch based (Automatic Architecture Selection)
* ```:3.15.1-4.9.2-r3-aarch64```   3.15.1 64 bit ARM
* ```:3.15.1-4.9.2-r3-armhf```     3.15.1 32 bit ARM v6
* ```:3.15.1-4.9.2-r3-armv7```     3.15.1 32 bit ARM v7
* ```:3.15.1-4.9.2-r3-ppc64le```   3.15.1 64 bit PowerPC
* ```:3.15.1-4.9.2-r3-x86```       3.15.1 32 bit Intel/AMD
* ```:3.15.1-4.9.2-r3-x86_64```    3.15.1 64 bit Intel/AMD

## Layers & Sizes

| Version                                                                               | Size                                                                                                                 |
|---------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------|
| ![Version](https://img.shields.io/badge/version-amd64-blue.svg?style=for-the-badge)   | ![MicroBadger Size (tag)](https://img.shields.io/docker/image-size/maurosoft1973/alpine-lftp/latest?style=for-the-badge)  |
| ![Version](https://img.shields.io/badge/version-armv6-blue.svg?style=for-the-badge)   | ![MicroBadger Size (tag)](https://img.shields.io/docker/image-size/maurosoft1973/alpine-lftp/armhf?style=for-the-badge)   |
| ![Version](https://img.shields.io/badge/version-armv7-blue.svg?style=for-the-badge)   | ![MicroBadger Size (tag)](https://img.shields.io/docker/image-size/maurosoft1973/alpine-lftp/armv7?style=for-the-badge)   |
| ![Version](https://img.shields.io/badge/version-ppc64le-blue.svg?style=for-the-badge) | ![MicroBadger Size (tag)](https://img.shields.io/docker/image-size/maurosoft1973/alpine-lftp/ppc64le?style=for-the-badge) |
| ![Version](https://img.shields.io/badge/version-x86-blue.svg?style=for-the-badge)     | ![MicroBadger Size (tag)](https://img.shields.io/docker/image-size/maurosoft1973/alpine-lftp/x86?style=for-the-badge)     |

## Environment Variables:

### Main LFTP parameters:
* `LC_ALL`: default locale (en_GB.UTF-8)
* `TIMEZONE`: default timezone (Europe/Brussels)

## Sample Use with gitlab pipeline
The script below allows you to synchronize files on a remote server, excluding hidden files and folders (-X .* -X .*/)
The script restore_last_git_modified_time.sh sets the last modified date on the repository files before syncronized.

```yalm
stages:
    - deploy

deploy develop:
    stage: deploy
    image: maurosoft1973/alpine-lftp
    variables:
        FTP_SERVER: 'ftp server'
        FTP_PORT: '21'
        FTP_USERNAME: 'ftp username'
        FTP_PASSWORD: 'ftp password'
        FTP_LOCAL_FOLDER: 'local folder'
        FTP_REMOTE_FOLDER: 'remote folder'
    only:
        - develop
    script:
        - /restore_last_git_modified_time.sh
        - lftp -e "set ssl:verify-certificate no; set ftp:use-mdtm-overloaded true; open $FTP_SERVER; user $FTP_USERNAME $FTP_PASSWORD; mirror -X .* -X .*/ --reverse --verbose --delete $FTP_LOCAL_FOLDER $FTP_REMOTE_FOLDER; bye"

deploy prod:
    stage: deploy
    image: maurosoft1973/alpine-lftp
    variables:
        FTP_SERVER: 'ftp server'
        FTP_PORT: 'ftp port'
        FTP_USERNAME: 'ftp username'
        FTP_PASSWORD: 'ftp password'
        FTP_LOCAL_FOLDER: 'local folder'
        FTP_REMOTE_FOLDER: 'remote folder'
    only:
        - develop
    script:
        - /restore_last_git_modified_time.sh
        - lftp -e "set ssl:verify-certificate no; set sftp:auto-confirm yes; open sftp://$FTP_SERVER -p $FTP_PORT -u $FTP_USERNAME,$FTP_PASSWORD; mirror -X .* -X .*/ --reverse --verbose --delete $FTP_LOCAL_FOLDER $FTP_REMOTE_FOLDER; bye"
```

***
###### Last Update 15.04.2022 03:08:35
