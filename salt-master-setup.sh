#!/bin/bash

#Install Salt, Salt master service, and Salt minion service on RedHat VM

mkdir /etc/apt/keyrings
rpm --import https://repo.saltproject.io/salt/py3/redhat/9/x86_64/SALT-PROJECT-GPG-PUBKEY-2023.pub
curl -fsSL https://repo.saltproject.io/salt/py3/redhat/9/x86_64/latest.repo | sudo tee /etc/yum.repos.d/salt.repo
yum clean expire-cache
yum install salt-master
yum install salt-minion
systemctl enable salt-master && systemctl start salt-master
systemctl enable salt-minion && systemctl start salt-minion



