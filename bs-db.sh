#!/usr/bin/env bash
set -e

# Non-interactive
export DEBIAN_FRONTEND=noninteractive

# 1. Install services
apt-get update
apt-get install -y mysql-server

# 2. Symlinc
ln -sf /etc/mysql/conf.d/custom/z-my.cnf /etc/mysql/mysql.conf.d/z-my.cnf

# 3. Set up mysql for php
# Create new user with password for php to use mysql
mysql -e "CREATE USER IF NOT EXISTS 'dbuser'@'192.168.56.%' IDENTIFIED WITH mysql_native_password BY '123456';"
mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'dbuser'@'192.168.56.%' WITH GRANT OPTION;"
mysql -e "FLUSH PRIVILEGES;"

# 4. Restart services and apply changes
systemctl restart mysql