
# ec2-salt-scripts

With AWS EC2 launch templates, you can specify configuration information for an EC2 instance. You might create a launch template that creates a Linux instance and deploys the instance in a particular security group. 

Once you create the template, you can deploy as many instances as you like from the template. This saves you time from having to deploy each instance manually. If you have 1000 VMs to deploy, you don’t want to go through the Launch instance workflow 1000 times. 

This repository contains two scripts that install [Salt](https://saltproject.io) on EC2 instances. The scripts install and enable the Salt master service and the Salt minion service. After the instance is deployed, you can SSH into the VM to test the installation and communication between the Salt master and Salt minion(s).

These scripts install Salt on RedHat (RHEL) operating systems. If you want to install Salt on other operating systems, view the manual installation instructions.

Visit the [AWS documentation](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/user-data.html) for instructions on creating launch templates and passing user data to your EC2 instances.



## Usage

The `salt-master-setup` script does the following:

1. Installs the Salt Project repository and key
2. Installs the Salt master service and Salt minion service on the node (you can manage your Salt masters as a minion if you like)
3. Sets the hostname for the Salt master
4. Sets the minion id for the Salt master
5. Enables and starts the Salt master and Salt minion service

```bash
#!/bin/bash
mkdir /etc/apt/keyrings
rpm --import https://repo.saltproject.io/salt/py3/redhat/9/x86_64/SALT-PROJECT-GPG-PUBKEY-2023.pub
curl -fsSL https://repo.saltproject.io/salt/py3/redhat/9/x86_64/latest.repo | tee /etc/yum.repos.d/salt.repo
yum clean expire-cache
yum install -y salt-master
yum install -y salt-minion
rm -f /etc/salt/minion
echo "master: 127.0.0.1" >> /etc/salt/minion 
echo "salt-master-01" > /etc/salt/minion_id #Sets minion id for the Salt master
systemctl enable salt-master && systemctl start salt-master
systemctl enable salt-minion && systemctl start salt-minion
```

The `salt-minion-setup` does the following:

1. Installs the Salt Project repository and key
2. Installs the Salt minion service
3. Enables and starts the Salt minion service

```bash
#!/bin/bash
mkdir /etc/apt/keyrings
rpm --import https://repo.saltproject.io/salt/py3/redhat/9/x86_64/SALT-PROJECT-GPG-PUBKEY-2023.pub
curl -fsSL https://repo.saltproject.io/salt/py3/redhat/9/x86_64/latest.repo | tee /etc/yum.repos.d/salt.repo
yum clean expire-cache
yum install -y salt-minion
systemctl enable salt-minion && systemctl start salt-minion
```

## Authors

- [@itsdeannat](https://www.gitlab.com/itsdeannat)





