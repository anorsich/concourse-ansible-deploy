## Concourse on Ubuntu 1504 with Vagrant + Ansible

Installs [Concourse CI](http://concourse.ci/) from [binaries](https://github.com/vito/concourse-bin), Nginx, Postgresql using docker
and configures systemd jobs. Ubuntu 1504 is recommended as the minimum kernel version required for Concourse is currently 3.19.

You can use Ubuntu 1404 if you wish but you will additionally need to install vivid kernel packages.

### Prerequisites

1. Ansible 1.9 or higher is required
2. Vagrant (and Virtualbox, or an AWS account and vagrant-aws plugin installed)

### Configuration
1. Rename `vars/credential.sample.yml` into `credential.yml` and update vars with your passwords
2. Create `files` folder and put your private keys there, as described [here](https://github.com/vito/concourse-bin#prerequisites)
3. Install ansible-galaxy dependencies (docker install & firewall install) `ansible-galaxy install -r requirements.txt -f`

### Virtualbox

```
vagrant up --provider=virtualbox
```

Concourse should be available on http://192.168.66.66

### AWS

In AWS, create/note the keypair to be used on the machine, and if you haven't already created a security group with inbound port 80 allow from wherever you need, do that too and note the `sg-xxxxxx` id for later. If you're deploying into a VPC, note down the subnet id to be deployed into.

Using an elastic IP is recommended (allocate one in AWS and note its address). Create a Route53 record for Concourse to use with that elastic IP. Update the `nginx_server_name` value in `vars/credentials.yml` with this DNS address before you deploy.

Ensure the required environment variables listed below are set (and override any optional ones) :

| Environment Variable  | Default |
| ------------- | ------------- |
| CC_AWS_ACCESS_KEY_ID  | None (required) |
| CC_AWS_SECRET_ACCESS_KEY  | None (required) |
| CC_AWS_KEYPAIR |  concourse |
| CC_AWS_AMI | ami-3a229449 (Ubuntu 1504 in eu-west-1) |
| CC_AWS_INSTANCE_TYPE | t2.small |
| CC_AWS_SUBNET_ID | None (set if you're using in a VPC) |
| CC_AWS_EIP | None (required) |
| CC_AWS_SEC_GRP | None (required) |
| CC_AWS_REGION | eu-west-1 |
| CC_PRIVATE_KEY_PATH | None (required) |

```
vagrant plugin install vagrant-aws
vagrant up --provider=aws
```

After the machine has been created, and Ansible has finished deploying you're all set.
