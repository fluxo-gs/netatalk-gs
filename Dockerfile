FROM debian:jessie

ENV DEBIAN_FRONTEND=noninteractive
ENV NETATALK_VERSION 2.2.6

RUN apt-get update && apt-get install \
    --no-install-recommends \
    --fix-missing \
    --assume-yes \
    file \
    curl \
    build-essential \
    libdb-dev \
    && curl -SL -k "http://ufpr.dl.sourceforge.net/project/netatalk/netatalk/${NETATALK_VERSION}/netatalk-${NETATALK_VERSION}.tar.gz" | tar xvz

WORKDIR netatalk-${NETATALK_VERSION}

RUN ./configure \
	--prefix=/usr \
	--sysconfdir=/etc \
	--disable-quota \
	--disable-a2boot \
	--disable-ddp \
	--disable-debian \
	&& make && make install

COPY afpd.conf /etc/netatalk/afpd.conf
COPY etc/default/netatalk /etc/default/netatalk
COPY netatalk-gs /netatalk-gs

WORKDIR /
CMD ["/netatalk-gs"]

