#!/bin/bash

cd /var/www/html

# Download WordPress core
wp core download --allow-root

# # Wait for a moment to ensure the download completes
# sleep 10

# Create wp-config.php file
wp config create --allow-root \
    --dbname="ll" \
    --dbuser="ohaimad" \
    --dbpass="0000" \
    --dbhost="$WORDPRESS_DB_HOST:3306"

# Install WordPress
wp core install --allow-root \
    --url="localhost" \
    --title="TITLE_WORDPRESS" \
    --admin_user="ADMIN_WORDPRESS" \
    --admin_password="ADMIN_PASSWORD_WORDPRESS" \
    --admin_email="abc@abc.com"

# Create a WordPress user
wp user create --allow-root \
    "WORDPRESS_USER" "abc@abc.com" \
    --user_pass="WORDPRESS_USER_PASSWORD"

# Start PHP-FPM
exec php-fpm7.4 -F
