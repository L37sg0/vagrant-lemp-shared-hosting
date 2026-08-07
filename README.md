# LEMP Shared Hosting Development Environment

A fully automated Vagrant environment designed to mimic a professional LEMP (Linux, Nginx, MySQL, PHP) stack setup. This repository provides a consistent, reproducible development environment suitable for testing shared hosting configurations.
Architecture

This setup consists of two isolated virtual machines running Ubuntu 22.04 (Jammy Jellyfish):

* **`db (192.168.56.11)`**: Dedicated database server hosting MySQL. Includes custom configuration synchronization for database tuning.

* **`web (192.168.56.12)`**: Web server hosting Nginx and PHP-FPM. Includes SFTP configuration and mapped project directories.

---

## Project Structure

* **`etc/`**: Contains custom configuration overrides for MySQL, Nginx, and PHP to ensure production-like settings.

* **`html/`**: The project root directory synced to the web server, containing entry points for your web application.

* **`shell/`**: Automation scripts used for initial provisioning (bs-db.sh, bs-web.sh) and SFTP environment setup.

* **`tmp/`**: Staging area for temporary configuration files like sftp.conf.

* **`Vagrantfile`**: The core configuration file that defines machine resources, networking, synced folders, and provisioning triggers.

---

## Quick Start

* Ensure you have Vagrant and a compatible provider (like VirtualBox) installed.

* Clone this repository.

* Bring up the entire environment:

```bash
vagrant up
```

* Once provisioned, you can access your web project by navigating to http://localhost:8080 on your host machine.

---

## Customization

### Configuration Overrides

To modify server behavior, update the files within the etc directory. Changes are automatically synchronized to the virtual machines upon provision or can be reloaded manually via service restarts within the guest machines.
Networking

* The environment uses a private network range (192.168.56.x) for inter-VM communication.

* Port 80 on the web server is forwarded to port 8080 on your local machine.

### Provisioning

The environment uses shell scripts located in the shell directory for bootstrapping. You can modify these scripts to install additional packages or services required for your specific development needs.

---

## Provisioning and Services

The environment uses automated shell scripts and file synchronization to set up the LEMP stack components during the initial vagrant up phase:
### Database Server (db)

* Provision Script **`(shell/bs-db.sh)`**: Handles the installation and secure configuration of the MySQL server.

* Custom Configuration **`(etc/mysql/custom/z-my.cnf)`**: Mapped directly to MySQL's configuration directory, allowing you to override database parameters and performance tuning without modifying the base VM image.

### Web Server (web)

* Provision Script **`(shell/bs-web.sh)`**: Installs Nginx and PHP-FPM, setting up the necessary web service dependencies.

* PHP Overrides **`(etc/php/custom/99-local.ini)`**: Mapped to PHP's configuration directory to adjust limits (such as memory limit, upload size, and execution time) for local development.

* Nginx Sites **`(etc/nginx/sites-available/99-example.conf)`**: Mapped to Nginx's sites-available directory for easy virtual host management.

* SFTP Setup **`(shell/configure-sftp.sh & tmp/sftp.conf)`**: Automatically configures secure file transfer access to manage web files within the html directory.