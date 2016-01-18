#!/bin/sh
ansible-playbook deploy-concourse.yml -i hosts -u root "$@"
