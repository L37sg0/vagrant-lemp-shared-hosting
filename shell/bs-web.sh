#!/usr/bin/env bash
set -e

# Non-interactive
export DEBIAN_FRONTEND=noninteractive

# 1. Install services
apt-get update
apt-get install -y nginx unzip \
    php8.1-fpm php8.1-cli php8.1-common php8.1-mysql \
    php8.1-zip php8.1-gd php8.1-mbstring php8.1-curl \
    php8.1-xml php8.1-bcmath

# 2. Symlinc
# sites-available to sites-enabled for example.conf
rm -f /etc/nginx/sites-enabled/default /etc/nginx/sites-available/default 
ln -sf /etc/nginx/sites-available/99-example.conf /etc/nginx/sites-enabled/
rm -f /var/www/html/index.nginx-debian.html
# php and mysql custom configurations
ln -sf /etc/php/8.1/fpm/conf.d/custom/99-local.ini /etc/php/8.1/fpm/conf.d/99-local.ini

# 4. Restart services and apply changes
systemctl restart php8.1-fpm
systemctl restart nginx

# 5. Install Composer
if [ ! -f /usr/local/bin/composer ]; then
    curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
fi
mkdir -p /home/vagrant/.composer
chown -R vagrant:vagrant /home/vagrant/.composer
composer --version