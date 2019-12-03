server {
    listen 80;
    listen [::]:80;

    root /var/www/html/dockerapps/laravel-docker-boilerplate/public;
    index index.php index.html index.htm index.nginx-debian.html;

    server_name docker.manjurulhoque.com;

    location / {
        try_files $uri $uri/ /index.php$is_args$args;
    }

    location ~ \.php$ {
        try_files $uri /index.php =404;
        fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }

    location ~ /\.ht {
        deny all;
    }
}
