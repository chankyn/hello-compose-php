# NGINGX + PHP 
FROM nginx:alpine

RUN apk add php7-fpm
COPY index.php /usr/share/nginx/html
COPY default.conf /etc/nginx/conf.d/

RUN mkdir -p '/var/run/' && touch '/var/run/php7-fpm.sock'

#Cambia la configuración de php
RUN sed -i 's/listen = 127.0.0.1:9000$/listen = \/var\/run\/php7-fpm.sock/g' /etc/php7/php-fpm.d/www.conf \
    && sed -i 's/;listen\.owner = nobody$/listen.owner = nginx/g' /etc/php7/php-fpm.d/www.conf \
    && sed -i 's/;listen\.group = nobody$/listen.group = nginx/g' /etc/php7/php-fpm.d/www.conf

#Lanzamos ambos servicios
CMD /usr/sbin/php-fpm7 ; /usr/sbin/nginx -g 'daemon off;' 

