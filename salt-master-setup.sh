#Install Salt, Salt master service, and Salt minion service on RedHat VM
#!/bin/bash
mkdir /etc/apt/keyrings
rpm --import https://repo.saltproject.io/salt/py3/redhat/9/x86_64/SALT-PROJECT-GPG-PUBKEY-2023.pub
curl -fsSL https://repo.saltproject.io/salt/py3/redhat/9/x86_64/latest.repo | tee /etc/yum.repos.d/salt.repo
yum clean expire-cache
yum install -y salt-master
yum install -y salt-minion
rm -f /etc/salt/minion
echo "master: 127.0.0.1" >> /etc/salt/minion
echo "salt-master-01" > /etc/salt/minion_id 
systemctl enable salt-master && systemctl start salt-master
systemctl enable salt-minion && systemctl start salt-minion




