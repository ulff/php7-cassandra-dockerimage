FROM php:7.0.5-fpm

RUN apt-get update && \
    apt-get install -y git wget libssl-dev zlib1g-dev libicu-dev g++ make cmake libuv-dev libgmp-dev

# Install datastax php-driver fox cassandra
RUN	git clone https://github.com/datastax/php-driver.git /usr/src/datastax-php-driver && \
	cd /usr/src/datastax-php-driver && \
	git submodule update --init && \
	cd ext && \
	./install.sh && \
    echo -e "; DataStax PHP Driver\nextension=cassandra.so" >> `php --ini | grep "Loaded Configuration" | sed -e "s|.*:\s*||"`

# Install PHP extensions
RUN pecl install xdebug && \
    echo zend_extension=xdebug.so > /usr/local/etc/php/conf.d/xdebug.ini && \
    pecl install apcu && \
    echo extension=apcu.so > /usr/local/etc/php/conf.d/apcu.ini && \
    docker-php-ext-install zip mbstring intl

RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/bin/composer
