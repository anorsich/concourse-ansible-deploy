## Concourse deployment with Ansible, Nginx, Upstart

Installs [Concourse CI](http://concourse.ci/) from [binaries](https://github.com/vito/concourse-bin), Nginx, Postgresql using docker
and configure upstart jobs.

### Prerequisites

1. Ansible 1.9 or higher is required

### Configuration
1. Rename `vars/credential.sample.yml` into `credential.yml` and update vars with your passwords
2. Create `files` folder and put your private keys there, as described [here](https://github.com/vito/concourse-bin#prerequisites)
3. Install ansible-galaxy dependencies (docker install & firewall install) `ansible-galaxy install -r requirements.txt -f`
4. Rename `hosts.sample` into `hosts` and update server ip. Note: ansible must have ssh access to that server.

### Configuring new server

This is typically need to be run only once.
```
./bin/setup-server.sh
```

### Deploy concourse CI:

```
./bin/deploy-concourse.sh
```

That's it! Enjoy concourse ci!
