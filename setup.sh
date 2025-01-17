#!/bin/bash

apt update && sudo apt upgrade -y

. ./mysql_secure_installation.sh

apt install -y \
    mysql-server \
    apache2 \
    php \
    libapache2-mod-php \
    php-mysql \
    php-curl \
    php-xml \
    php-mbstring \
    php-zip \
    php-gd 

wget https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz

systemctl enable apache2 mysql
systemctl start apache2 mysql

if [ ! -f ./project/database.sql ]; then
    echo "Файл database.sql не найден!"
    exit 1
fi

mysql -u root -p < ./project/database.sql

mv wordpress /var/www/html/wordpress
chown -R www-data:www-data /var/www/html/wordpress
chmod -R 775 /var/www/html/wordpress