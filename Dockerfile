FROM debian:stable-slim

MAINTAINER Quinn Snyder <qsnyder@cisco.com>

EXPOSE 2055

RUN apt-get update && apt-get install -y \
    build-essential \
    libjansson4 \
    libjansson-dev \
    gcc \
    make \
    libstdc++6 \
    libssl-dev \
    libmariadb3 \
    libmariadbd-dev \
    librabbitmq-dev \
    librdkafka-dev \
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
    ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var --enable-rabbitmq --enable-ipv6 --enable-l2 --enable-debug --enable-plabel --enable-64bit --enable-threads --enable-jansson && \
    make && \
    make install

CMD pmacctd -f /etc/pmacct/pmacctd.conf