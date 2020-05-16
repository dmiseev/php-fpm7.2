## PHP-FPM Image

[![Build Status](https://travis-ci.com/dmiseev/php-fpm7.2.svg?branch=master)](https://travis-ci.com/dmiseev/php-fpm7.2)

 **Helpful PHP-FPM image from official ubuntu:xenial**
 
 >
 > PHP-FPM version - 7.2.31
 >
 > DateTime - Europe/Kiev
 >
 > Composer installed globally

## Tags
 * dmiseev/php-fpm7.2:stable

### Extensions:

 * php7.2-pgsql
 * php7.2-mysql
 * php7.2-opcache
 * php7.2-common
 * php7.2-mbstring
 * php7.2-mcrypt
 * php7.2-soap
 * php7.2-cli
 * php7.2-intl
 * php7.2-json
 * php7.2-xsl
 * php7.2-imap
 * php7.2-ldap
 * php7.2-curl
 * php7.2-gd
 * php7.2-dev
 * php7.2-fpm
 * php7.2-redis
 * php7.2-memcached
 * php7.2-mongodb
 * php7.2-bcmath
 * php7.2-imagick (`new`)

### In addition

 * Composer (installed globally)
 
### Docker Compose yml

```yaml
version: "2"
services:
 php-fpm:
   image: dmiseev/php-fpm7.2
   volumes:
    - .:/usr/local/src/app
   working_dir: /usr/local/src/app
   extra_hosts:
    - "app:127.0.0.1"
```
