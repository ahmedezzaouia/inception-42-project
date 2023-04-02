#!/bin/bash

# Start the MySQL service
service mysql start 

# Create a new SQL file with the command to create the database
echo "CREATE DATABASE IF NOT EXISTS $DB_NAME ;" > db1.sql

# Add to the SQL file the command to create a new user with the specified credentials
echo "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS' ;" >> db1.sql

# Add to the SQL file the command to grant all privileges to the user on the specified database
echo "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' ;" >> db1.sql

# Add to the SQL file the command to flush the privileges to ensure the changes take effect
echo "FLUSH PRIVILEGES;" >> db1.sql

# Execute the SQL file using the mysql command
mysql < db1.sql

# Stop the MySQL service
service mysql stop
kill $(cat /var/run/mysqld/mysqld.pid)
# Restart the MySQL service
mysqld --bind-address=0.0.0.0
