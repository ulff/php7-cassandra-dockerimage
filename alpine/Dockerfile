FROM tetsuobe/php7:v7.1.6

ENV INSTALL_DIR /usr/src/datastax-php-driver

ENV BUILD_DEPS \
                cmake \
                autoconf \
                g++ \
                gcc \
                make \
                pcre-dev \
                openssl-dev \
                libuv-dev \
                gmp-dev

RUN apk update && apk add --no-cache --virtual .build-deps $BUILD_DEPS \
    && apk add --no-cache git libuv gmp \
    && git clone https://github.com/datastax/php-driver.git $INSTALL_DIR \
    && cd $INSTALL_DIR \
    && git submodule update --init \
    && cd ext && ./install.sh \
    && docker-php-ext-enable cassandra \
    && apk del .build-deps \
    && rm -rf $INSTALL_DIR
