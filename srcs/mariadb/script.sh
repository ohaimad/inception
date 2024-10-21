#!/bin/bash

# Update MariaDB configuration to allow external connections
sed -i -e "s/127.0.0.1/0.0.0.0/g" "/etc/mysql/mariadb.conf.d/50-server.cnf"

# Start MariaDB service
service mariadb start

# Create the database if it does not exist
mariadb -uroot -p"$MYSQL_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\`;"

# Create the user if it does not exist
mariadb -uroot -p"$MYSQL_ROOT_PASSWORD" -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"

# Grant all privileges to the user on the specified database
mariadb -uroot -p"$MYSQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON \`$MYSQL_DATABASE\`.* TO '$MYSQL_USER'@'%' WITH GRANT OPTION;"

# Reload privileges to apply the changes
mariadb -uroot -p"$MYSQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"

# Stop MariaDB service
service mariadb stop

# Restart MariaDB daemon
mariadbd
