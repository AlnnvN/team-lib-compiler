#!/bin/bash

############ TAKE VERSION ############
UBUNTU_VERSION="22.04"

help(){
    echo "Usage: $0 [ubuntu-version]"
}

if [ $# -lt 1 ]; then
    help
    exit 0
fi

if [ $# -gt 0 ]; then
    case $1 in
        -h|--help)
        help
        exit 0
        ;;

        "14.04"|"18.04"|"20.04"|"22.04"|"22.10"|"23.04")
        UBUNTU_VERSION=$1
        echo "Selected Ubuntu Version: $UBUNTU_VERSION"
        ;;

        *)
        echo "Ubuntu version unsupported by Docker natively. (maybe a mistype? ex.:18.04)"
    esac
fi

############### RUN DOCKER ################ 

docker build -t builder --build-arg VERSION=$UBUNTU_VERSION --build-arg DEPS="$(< DEPS.env)" $PWD

docker run --rm -it -d --volume=$PWD/bahiart:/bahiart --volume=/$PWD/libsetplay:/libsetplay --name builder builder

#terminal commands
#docker build -t builder --build-arg VERSION=18.04 --build-arg DEPS="$(< DEPS.env)" .
#docker run --rm -it -d --volume=$PWD/bahiart:/bahiart --volume=/$PWD/libsetplay:/libsetplay --name builder builder