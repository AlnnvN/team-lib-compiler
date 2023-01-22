ARG VERSION ''

FROM ubuntu:${VERSION}

ARG DEPS ''

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ${DEPS}\
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/include/locale.h /usr/include/xlocale.h

COPY commands.sh commands.sh

ENTRYPOINT ["/bin/sh", "-c" , "chmod 777 commands.sh && ./commands.sh"]
#ENTRYPOINT ["/bin/bash"]
