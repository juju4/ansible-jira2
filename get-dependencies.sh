#!/bin/sh
## one script to be used by travis, jenkins, packer...

umask 022

if [ $# != 0 ]; then
rolesdir=$1
else
rolesdir=$(dirname $0)/..
fi

#[ ! -d $rolesdir/juju4.redhat-epel ] && git clone https://github.com/juju4/ansible-redhat-epel $rolesdir/juju4.redhat-epel
[ ! -d $rolesdir/juju4.harden-apache ] && git clone https://github.com/juju4/ansible-harden-apache $rolesdir/juju4.harden-apache
[ ! -d $rolesdir/juju4.smarthostclient ] && git clone https://github.com/juju4/ansible-smarthostclient $rolesdir/juju4.smarthostclient
#[ ! -d $rolesdir/kbrebanov.java ] && git clone https://github.com/kbrebanov/ansible-java $rolesdir/kbrebanov.java
[ ! -d $rolesdir/kbrebanov.java ] && git clone https://github.com/juju4/ansible-java $rolesdir/kbrebanov.java
#[ ! -d $rolesdir/kbrebanov.jira ] && git clone https://github.com/kbrebanov/ansible-jira $rolesdir/kbrebanov.jira
[ ! -d $rolesdir/kbrebanov.jira ] && git clone https://github.com/juju4/ansible-jira $rolesdir/kbrebanov.jira
[ ! -d $rolesdir/geerlingguy.java ] && git clone https://github.com/geerlingguy/ansible-java $rolesdir/geerlingguy.java
[ ! -d $rolesdir/geerlingguy.postgresql ] && git clone https://github.com/geerlingguy/ansible-postgresql $rolesdir/geerlingguy.postgresql
[ ! -d $rolesdir/geerlingguy.apache ] && git clone https://github.com/geerlingguy/ansible-apache $rolesdir/geerlingguy.apache
[ ! -d $rolesdir/cmprescott.xml ] && git clone https://github.com/cmprescott/ansible-xml $rolesdir/cmprescott.xml

## galaxy naming: kitchen fails to transfer symlink folder
#[ ! -e $rolesdir/juju4.jira ] && ln -s ansible-jira $rolesdir/juju4.jira
[ ! -e $rolesdir/juju4.jira ] && cp -R $rolesdir/ansible-jira $rolesdir/juju4.jira

## don't stop build on this script return code
true

