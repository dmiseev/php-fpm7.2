################################
#                              #
#   Ubuntu - PHP 7.2 CLI+FPM   #
#                              #
################################

FROM ubuntu:xenial

MAINTAINER Aseev Dmitriy <dimaaseev.94@gmail.com>

LABEL Vendor="dmiseev"
LABEL Description="PHP-FPM v7.2"
LABEL Version="1.0.0"

ENV LYBERTEAM_TIME_ZONE Europe/Kiev

#RUN apt-get install -y python-software-properties

RUN apt-get update -yqq \
    && apt-get install -yqq \
	ca-certificates \
    git \
    gcc \
    make \
    wget \
    mc \
    curl \
    sendmail

RUN DEBIAN_FRONTEND=noninteractive apt-get -y dist-upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install python-software-properties
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install software-properties-common
RUN DEBIAN_FRONTEND=noninteractive LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php

## Install php7.2 extension
RUN apt-get update -yqq \
    && apt-get install -yqq \
    php7.2-pgsql \
	php7.2-mysql \
	php7.2-opcache \
	php7.2-common \
	php7.2-mbstring \
	php7.2-soap \
	php7.2-cli \
	php7.2-intl \
	php7.2-json \
	php7.2-xsl \
	php7.2-imap \
	php7.2-ldap \
	php7.2-curl \
	php7.2-gd  \
	php7.2-dev \
    php7.2-fpm \
    php7.2-bcmath \
    && apt-get install pkg-config \
    && pecl install mongodb \
    && echo "extension=mongodb.so" > /etc/php/7.2/cli/conf.d/ext-mongodb.ini \
    && echo "extension=mongodb.so" > /etc/php/7.2/fpm/conf.d/ext-mongodb.ini \
    && apt-get install -y -q --no-install-recommends \
       ssmtp

# Add default timezone
RUN echo $LYBERTEAM_TIME_ZONE > /etc/timezone
RUN echo "date.timezone=$LYBERTEAM_TIME_ZONE" > /etc/php/7.2/cli/conf.d/timezone.ini

## Install composer globally
RUN echo "Install composer globally"
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

# Copy our config files for php7.2 fpm and php7.2 cli
COPY php-conf/php.ini /etc/php/7.2/cli/php.ini
COPY php-conf/php-fpm.ini /etc/php/7.2/fpm/php.ini
COPY php-conf/php-fpm.conf /etc/php/7.2/fpm/php-fpm.conf
COPY php-conf/www.conf /etc/php/7.2/fpm/pool.d/www.conf

RUN usermod -aG www-data www-data
# Reconfigure system time
RUN  dpkg-reconfigure -f noninteractive tzdata

COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]

WORKDIR /var/www/dmiseev

EXPOSE 9000
