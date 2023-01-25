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

        "14.04"|"16.04"|"18.04"|"20.04"|"22.04"|"22.10"|"23.04")
        UBUNTU_VERSION=$1
        echo "Selected Ubuntu Version: $UBUNTU_VERSION"
        ;;

        *)
        echo "Ubuntu version unsupported by Docker natively. (maybe a mistype? ex.:18.04)"
        exit 0
    esac
fi

############ RUN DOCKER ############# 

docker build -t teamscript --build-arg VERSION=$UBUNTU_VERSION $PWD

#Not using -d so you're able to see the compilation progress
docker run --rm -it --volume=$PWD/bahiart:/bahiart --volume=/$PWD/libsetplay:/libsetplay --name teamscript teamscript

#Build container using DEPS.env in case of extensive dependencies 
#docker build -t builder --build-arg VERSION=$UBUNTU_VERSION --build-arg DEPS="$(< DEPS.env)" $PWD

#Terminal Manual Commands
#docker build -t builder --build-arg VERSION=18.04 --build-arg DEPS="$(< DEPS.env)" .
#docker run --rm -it -d --volume=$PWD/bahiart:/bahiart --volume=/$PWD/libsetplay:/libsetplay --name builder builder
