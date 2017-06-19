FROM tetsuobe/php7:v7.1.6

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
    && apk add --no-cache git libuv gmp

# Install datastax php-driver fox cassandra
RUN git clone https://github.com/datastax/php-driver.git /usr/src/datastax-php-driver \
    && cd /usr/src/datastax-php-driver \
    && git submodule update --init \
    && cd ext && ./install.sh \
    && docker-php-ext-enable cassandra

RUN apk del .build-deps $BUILD_DEPS
