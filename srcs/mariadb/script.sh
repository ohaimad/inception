#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Check if the MariaDB data directory is already initialized
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
else
    echo "MariaDB data directory already initialized. Skipping initialization."
fi

# Start the MariaDB server
echo "Starting MariaDB server..."
/usr/bin/mysqld_safe --skip-networking &

# Wait for MariaDB to start
echo "Waiting for MariaDB to start..."
sleep 5

# Create a new root user and grant all privileges
echo "Setting up root user and privileges..."
mysql -u root -e "CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY 'your_password';"
mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;"
mysql -u root -e "FLUSH PRIVILEGES;"

# Optionally, run a .sql file to set up the initial database (if provided)
# if [ -f /var/local/bin/your_database.sql ]; then
#     echo "Running the provided SQL script..."
#     mysql -u root < /var/local/bin/your_database.sql
# fi

# Stop the MariaDB server gracefully
echo "Stopping MariaDB server..."
mysqladmin -u root -p'your_password' shutdown

echo "MariaDB setup completed successfully."
