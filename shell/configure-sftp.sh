#!/usr/bin/env bash
set -e

# Non-interactive
export DEBIAN_FRONTEND=noninteractive

sudo mv /tmp/sftp.conf /etc/ssh/ssh_config.d/sftp.conf
sudo chown root:root /etc/ssh/ssh_config.d/sftp.conf
sudo chmod 644 /etc/ssh/ssh_config.d/sftp.conf

sudo sshd -t && sudo systemctl restart ssh

if sudo sshd -t; then
    sudo systemctl restart ssh
    echo "SFTP Jail configuration applied and /tmp cleaned."
else
    echo "Critical: SSH config error!"
    exit 1
fi