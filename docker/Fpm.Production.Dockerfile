FROM php:7.2-fpm

RUN apt-get update && apt-get install -y curl nano && docker-php-ext-install pdo pdo_mysql
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
COPY ./docker/sites/docker.com /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/docker.com /etc/nginx/sites-enabled/

WORKDIR /var/www/html/lara-app

COPY . /var/www/html/lara-app

RUN chown -R www-data:www-data \
        /var/www/html/lara-app/storage \
        /var/www/html/lara-app/bootstrap/cache

RUN mv .env.production .env

RUN nginx -t
RUN service nginx restart

# RUN php artisan optimize

CMD ["php-fpm"]
