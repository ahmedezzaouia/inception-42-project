#!/bin/bash

sleep 10

# Check if WordPress is already installed
if [ ! -e /var/www/html/wordpress/wp-config.php ]; then

    # Create wp-config.php file
    wp config create --allow-root \
        --dbname=${DB_NAME} \
        --dbuser=${DB_USER} \
        --dbpass=${DB_PASS} \
        --dbhost=${DB_HOST} \
        --path=/var/www/html/wordpress

    # Install WordPress
    wp core install --url=${WORDPRESS_DOMAIN} \
        --title=${WORDPRESS_SITE_TITLE} \
        --admin_user=${WORDPRESS_ADMIN_USER} \
        --admin_password=${WORDPRESS_ADMIN_PASSWORD} \
        --admin_email=${WORDPRESS_ADMIN_EMAIL} \
        --allow-root --path=/var/www/html/wordpress


    # Create additional user
    wp user create --allow-root --role=author \
        ${WORDPRESS_USER_LOGIN} ${WORDPRESS_USER_EMAIL} \
        --user_pass=${WORDPRESS_USER_PASS} \
        --path=/var/www/html/wordpress >> /log.txt

fi

# Start PHP-FPM to read and execute wordpress code 
/usr/sbin/php-fpm7.3 -F
