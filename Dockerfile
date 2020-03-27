FROM debian:stable-slim

MAINTAINER Quinn Snyder <qsnyder@cisco.com>

EXPOSE 179

RUN apt-get update && apt-get install -y \
    build-essential \
    libjansson4 \
    libjansson-dev \
    curl \
    unzip \
    libpcap-dev \
    libtool \
    autoconf \
    automake \
    bash \
    pkg-config 

WORKDIR /root

RUN curl -O -L https://github.com/pmacct/pmacct/archive/master.zip
RUN unzip master.zip

RUN mkdir /etc/pmacct

RUN cd pmacct-master && \
    ./autogen.sh && \
    ./configure --enable-jansson && \
    make && \
    make install

CMD pmacctd -f /etc/pmacct/pmacctd.conf