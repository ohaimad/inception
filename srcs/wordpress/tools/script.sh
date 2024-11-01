#!/bin/bash

cd /var/www/html

# Download WordPress core
wp core download --allow-root

# Create wp-config.php file
wp config create --allow-root \
    --dbname="$DB_NAME" \
    --dbuser="$DB_USER" \
    --dbpass="$DB_PASSWORD" \
    --dbhost="$DB_HOST"

# Install WordPress
wp core install --allow-root \
    --url="$WP_URL" \
    --title="$WP_TITLE" \
    --admin_user="$WP_ADMIN_USER" \
    --admin_password="$WP_ADMIN_PASSWORD" \
    --admin_email="$WP_ADMIN_EMAIL"

# Create a WordPress user
wp user create --allow-root \
    "$WP_USER" "$WP_USER_EMAIL" \
    --user_pass="$WP_USER_PASSWORD"

# Start PHP-FPM
exec php-fpm7.4 -F
