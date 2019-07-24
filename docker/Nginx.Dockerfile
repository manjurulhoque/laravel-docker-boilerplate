FROM nginx

ADD ./docker/conf/nginx.conf /etc/nginx/conf.d/default.conf

WORKDIR /var/www/html/lara-app