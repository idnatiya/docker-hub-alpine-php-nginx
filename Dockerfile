FROM alpine:latest

RUN apk update \
  && apk add --no-cache php81 php81-fpm \
    curl \
    php81-soap php81-openssl php81-gmp \
    php81-pdo_odbc php81-json php81-dom \
    php81-pdo php81-zip php81-mysqli \
    php81-apcu php81-pdo_pgsql \
    php81-bcmath php81-gd php81-odbc \
    php81-pdo_mysql php81-phar php81-session php81-redis \
    php81-tokenizer php81-mbstring php81-fileinfo \
    php81-gettext php81-xmlreader php81-xmlwriter php81-xml \
    php81-bz2 php81-iconv php81-pdo_dblib php81-curl php81-ctype php81-pecl-swoole php81-posix \
    nodejs npm nano sudo \
    supervisor

RUN ln -s /usr/bin/php81 /usr/bin/php

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

COPY supervisord.conf /etc/supervisord.conf

EXPOSE 80/tcp

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]