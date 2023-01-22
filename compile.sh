#!/bin/bash


############ TAKE PARAMETERS ############
UBUNTU_VERSION="22.04"
TO_BE_COMPILED_DIR=$PWD

help(){
    echo "Usage: $0 [ubuntu-version] [compilation-dir]" 
}

if [ $# -lt 3 ]; then
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
if [ $# -gt 1 ]; then
    case $2 in
        '.')
        TO_BE_COMPILED_DIR=$PWD
        ;;
        *)
        TO_BE_COMPILED_DIR="$PWD/$2"
        ;;
    esac
fi
if [ $# -gt 2 ]; then
    case $3 in
        '.')
        BIN_DESTINATION=$PWD
        ;;
        *)
        BIN_DESTINATION="$PWD/$3"
        ;;
    esac
fi

echo Folder to be Compiled: $TO_BE_COMPILED_DIR
echo Destination Folder: $BIN_DESTINATION

###########################################

############### RUN DOCKER ################ 

docker build -t builder --build-arg VERSION=$UBUNTU_VERSION --build-arg DEPS="$(< DEPS.env)" $PWD

docker run --rm -it -d --volume=$TO_BE_COMPILED_DIR:/$2:rw --volume=$PWD --name builder builder

#terminal commands
#docker build -t builder --build-arg VERSION=18.04 --build-arg DEPS="$(< DEPS.env)" .
#docker run --rm -it -d --volume=/home/alan/robocup/brt/libsetplay:/libsetplay --name builder builder

#docker run --rm -it -d --volume=$PWD/bahiart:/bahiart --volume=/$PWD/libsetplay:/libsetplay --name builder builder
