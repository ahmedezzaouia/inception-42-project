#!/bin/bash

sleep 10

cd /var/www/html/wordpress

# Downloading and extracting Wordpress core files to the current directory
wp core download --allow-root

# Creating the wp-config.php file using this command.
wp core config --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASS --dbhost=$DB_HOST --allow-root

# Installing Wordpress using the given environment variables to avoid showing the Wordpress installation page every time we run the container
wp core install --url=$WORDPRESS_DOMAIN --title=$WORDPRESS_SITE_TITLE --admin_user=$WORDPRESS_ADMIN_USER --admin_password=$WORDPRESS_ADMIN_PASSWORD --admin_email=$WORDPRESS_ADMIN_EMAIL --allow-root

# Create another user
wp user create $WORDPRESS_USER_LOGIN $WORDPRESS_USER_MAIL --role=author --user_pass=$WORDPRESS_USER_PASS --allow-root


# Start PHP-FPM to read and execute wordpress code 
/usr/sbin/php-fpm7.3 -F
