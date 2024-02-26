#!/bin/bash
mkdir /etc/apt/keyrings
rpm --import https://repo.saltproject.io/salt/py3/redhat/9/x86_64/SALT-PROJECT-GPG-PUBKEY-2023.pub
curl -fsSL https://repo.saltproject.io/salt/py3/redhat/9/x86_64/latest.repo | tee /etc/yum.repos.d/salt.repo
yum clean expire-cache
yum install -y salt-minion
systemctl enable salt-minion && systemctl start salt-minion