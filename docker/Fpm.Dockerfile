FROM php:7.2-fpm

RUN apt-get update && apt-get install -y curl nano && docker-php-ext-install pdo pdo_mysql
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

CMD ["php-fpm"]