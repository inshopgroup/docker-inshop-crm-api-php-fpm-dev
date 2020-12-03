FROM inshopgroup/docker-inshop-crm-api-php-fpm-prod:latest

# install xdebug
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug

RUN echo "xdebug.mode=debug" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.max_nesting_level=10000" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.discover_client_host=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.start_with_request=yes" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.idekey=PHPSTORM" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.client_port=9001" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# disable opcache
RUN echo "opcache.enable=0" >> /usr/local/etc/php/conf.d/docker-php-custom.ini
RUN echo "opcache.enable_cli=0" >> /usr/local/etc/php/conf.d/docker-php-custom.ini
RUN echo "opcache.validate_timestamps=1" >> /usr/local/etc/php/conf.d/docker-php-custom.ini

RUN echo "memory_limit = 4096M" >> /usr/local/etc/php/conf.d/docker-php-custom.ini

# code sniffer
RUN curl -OL https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar && \
    cp phpcs.phar /usr/local/bin/phpcs && \
    chmod +x /usr/local/bin/phpcs

#clean
RUN apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*
