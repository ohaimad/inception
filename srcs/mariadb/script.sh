#!/bin/bash

# Update MariaDB configuration to allow external connections
sed -i -e "s/127.0.0.1/0.0.0.0/g" "/etc/mysql/mariadb.conf.d/50-server.cnf"

# Start MariaDB service
service mariadb start

# Create the database if it does not exist
mariadb -uroot -p"root" -e "CREATE DATABASE IF NOT EXISTS \`ll\`;"

# Create the user if it does not exist
mariadb -uroot -p"root" -e "CREATE USER IF NOT EXISTS 'ohaimad'@'%' IDENTIFIED BY '0000';"

# Grant all privileges to the user on the specified database
mariadb -uroot -p"root" -e "GRANT ALL PRIVILEGES ON \`ll\`.* TO 'ohaimad'@'%' WITH GRANT OPTION;"

# Reload privileges to apply the changes
mariadb -uroot -p"root" -e "FLUSH PRIVILEGES;"

# Stop MariaDB service
service mariadb stop

# Restart MariaDB daemon
mariadbd
