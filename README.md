[![Actions Status - Master](https://github.com/juju4/ansible-jira2/workflows/AnsibleCI/badge.svg)](https://github.com/juju4/ansible-jira2/actions?query=branch%3Amaster)
[![Actions Status - Devel](https://github.com/juju4/ansible-jira2/workflows/AnsibleCI/badge.svg?branch=devel)](https://github.com/juju4/ansible-jira2/actions?query=branch%3Adevel)

# Jira ansible role

This role is a meta role to setup Jira in a sane and secure environment. Using
- kbrebanov.java
- kbrebanov.jira
- geerlingguy.postgresql
- geerlingguy.apache
- juju4.harden-apache
+ backup scripts
+ firewalling with ufw
(optional)
- juju4.smarthostclient

If you provide a sql dump, it can be restored and get directly operational.
Else, you will have to run the jira setup wizard to initialize database and license (trial available).

## Requirements & Dependencies

### Ansible
It was tested on the following versions:
 * 2.3
 * 2.5

### Operating systems

Ubuntu 14.04, 16.04, 18.04 and Centos7

## Example Playbook

Just include this role in your list.
For example

```
- hosts: all
  roles:
    - juju4.jira2
```

## Variables

Nothing specific for now.

## Continuous integration

This role has a travis basic test (for github), more advanced with kitchen and also a Vagrantfile (test/vagrant).
Default kitchen config (.kitchen.yml) is lxd-based, while (.kitchen.vagrant.yml) is vagrant/virtualbox based.

Once you ensured all necessary roles are present, You can test with:
```
$ gem install kitchen-ansible kitchen-lxd_cli kitchen-sync kitchen-vagrant
$ cd /path/to/roles/juju4.jira2
$ kitchen verify
$ kitchen login
$ KITCHEN_YAML=".kitchen.vagrant.yml" kitchen verify
```
or
```
$ cd /path/to/roles/juju4.jira2/test/vagrant
$ vagrant up
$ vagrant ssh
```

Role has also a packer config which allows to create image for virtualbox, vmware, eventually digitalocean, lxc and others.
When building it, it's advise to do it outside of roles directory as all the directory is upload to the box during building
and it's currently not possible to exclude packer directory from it (https://github.com/mitchellh/packer/issues/1811)
```
$ cd /path/to/packer-build
$ cp -Rd /path/to/juju4.jira2/packer .
## update packer-*.json with your current absolute ansible role path for the main role
## you can add additional role dependencies inside setup-roles.sh
$ cd packer
$ packer build packer-*.json
$ packer build -only=virtualbox-iso packer-*.json
## if you want to enable extra log
$ PACKER_LOG_PATH="packerlog.txt" PACKER_LOG=1 packer build packer-*.json
## for digitalocean build, you need to export TOKEN in environment.
##  update json config on your setup and region.
$ export DO_TOKEN=xxx
$ packer build -only=digitalocean packer-*.json
```

## Troubleshooting & Known issues

* Jira Server is [End of Sales since Feb 2021](https://www.atlassian.com/migration/journey-to-cloud) and will be End of Support in Feb 2024.

* JIRA recommends C.UTF-8, POSIX.UTF-8 or C for postgres lc_collate per https://confluence.atlassian.com/jirakb/how-to-fix-the-collation-of-a-postgres-jira-database-776657961.html.
C.UTF-8 is fine on Ubuntu by default but not on RedHat, so using customized role manala.locales to configure POSIX.UTF-8 for RedHat but not Ubuntu (not available)

* mod_security support limited
https://jira.atlassian.com/browse/JRASERVER-28458

## License

BSD 2-clause
