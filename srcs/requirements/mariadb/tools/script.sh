#!/bin/bash

# Update MariaDB configuration to allow external connections
sed -i -e "s/127.0.0.1/0.0.0.0/g" "/etc/mysql/mariadb.conf.d/50-server.cnf"

# Start MariaDB service
service mariadb start

sleep 4

# Create the database if it does not exist
mariadb -uroot -p"$DB_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS \`$DB_NAME\`;"

# Create the user if it does not exist
mariadb -uroot -p"$DB_ROOT_PASSWORD" -e "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';"

# Grant all privileges to the user on the specified database
mariadb -uroot -p"$DB_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON \`$DB_NAME\`.* TO '$DB_USER'@'%' WITH GRANT OPTION;"

# Reload privileges to apply the changes
mariadb -uroot -p"$DB_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"

# Stop MariaDB service
mariadb-admin -u root -p"$DB_ROOT_PASSWORD" shutdown

# Restart MariaDB daemon
mariadbd