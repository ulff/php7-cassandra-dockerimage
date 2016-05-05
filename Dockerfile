FROM php:7.0.6-fpm

RUN apt-get update && \
    apt-get install -y git wget libssl-dev zlib1g-dev libicu-dev g++ make cmake libuv-dev libgmp-dev uuid-dev

# Install datastax php-driver fox cassandra
RUN	git clone https://github.com/datastax/php-driver.git /usr/src/datastax-php-driver && \
    cd /usr/src/datastax-php-driver && \
    git submodule update --init && \
    cd ext && \
    ./install.sh && \
    echo extension=cassandra.so > /usr/local/etc/php/conf.d/cassandra.ini

# Install PHP extensions
RUN docker-php-ext-install zip mbstring intl opcache && \
    pecl install xdebug && \
    echo zend_extension=xdebug.so > /usr/local/etc/php/conf.d/xdebug.ini && \
    pecl install apcu-5.1.3 && \
    echo extension=apcu.so > /usr/local/etc/php/conf.d/apcu.ini && \
    pecl install uuid && \
    echo extension=uuid.so > /usr/local/etc/php/conf.d/uuid.ini
    
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/bin/composer
