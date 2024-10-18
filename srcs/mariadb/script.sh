#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Initialize the MariaDB data directory
echo "Initializing MariaDB data directory..."
mysql_install_db --user=mysql --datadir=/var/lib/mysql

# Start the MariaDB service
echo "Starting MariaDB service..."
service mysql start

# Create a new root user and grant all privileges
echo "Setting up root user and privileges..."
mysql -e "CREATE USER 'root'@'%' IDENTIFIED BY 'your_password';"
mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;"
mysql -e "FLUSH PRIVILEGES;"

# Optionally, run a .sql file to set up the initial database (if provided)
if [ -f /var/local/bin/your_database.sql ]; then
    echo "Running the provided SQL script..."
    mysql < /var/local/bin/your_database.sql
fi

# Stop the MariaDB service to prepare for running in the container
echo "Stopping MariaDB service..."
service mysql stop

echo "MariaDB setup completed successfully."
