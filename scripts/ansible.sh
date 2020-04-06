#!/bin/bash -eux

# Install Ansible repository.
apt -y update && apt-get -y upgrade
apt -y install python3-minimal python3-pip

# Install Ansible.
pip3 install ansible==2.9.6
