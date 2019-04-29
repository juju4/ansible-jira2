#!/bin/sh
## one script to be used by travis, jenkins, packer...

umask 022

if [ $# != 0 ]; then
rolesdir=$1
else
rolesdir=$(dirname $0)/..
fi

[ ! -d $rolesdir/juju4.redhat_epel ] && git clone https://github.com/juju4/ansible-redhat-epel $rolesdir/juju4.redhat_epel
[ ! -d $rolesdir/juju4.harden_apache ] && git clone https://github.com/juju4/ansible-harden-apache $rolesdir/juju4.harden_apache
[ ! -d $rolesdir/juju4.smarthostclient ] && git clone https://github.com/juju4/ansible-smarthostclient $rolesdir/juju4.smarthostclient
#[ ! -d $rolesdir/kbrebanov.java ] && git clone https://github.com/kbrebanov/ansible-java $rolesdir/kbrebanov.java
[ ! -d $rolesdir/kbrebanov.java ] && git clone https://github.com/juju4/ansible-java $rolesdir/kbrebanov.java
#[ ! -d $rolesdir/kbrebanov.jira ] && git clone https://github.com/kbrebanov/ansible-jira $rolesdir/kbrebanov.jira
[ ! -d $rolesdir/kbrebanov.jira ] && git clone https://github.com/juju4/ansible-jira $rolesdir/kbrebanov.jira
[ ! -d $rolesdir/geerlingguy.java ] && git clone https://github.com/geerlingguy/ansible-role-java $rolesdir/geerlingguy.java
[ ! -d $rolesdir/geerlingguy.postgresql ] && git clone https://github.com/juju4/ansible-role-postgresql $rolesdir/geerlingguy.postgresql
[ ! -d $rolesdir/geerlingguy.apache ] && git clone https://github.com/geerlingguy/ansible-role-apache $rolesdir/geerlingguy.apache
[ ! -d $rolesdir/cmprescott.xml ] && git clone https://github.com/cmprescott/ansible-xml $rolesdir/cmprescott.xml
#[ ! -d $rolesdir/manala.locales ] && git clone https://github.com/manala/ansible-role-locales $rolesdir/manala.locales
[ ! -d $rolesdir/manala.locales ] && git clone https://github.com/juju4/ansible-roles-1.git $rolesdir/manala-roles && cp -R $rolesdir/manala-roles/manala.locales $rolesdir/manala.locales

## galaxy naming: kitchen fails to transfer symlink folder
#[ ! -e $rolesdir/juju4.jira2 ] && ln -s ansible-jira2 $rolesdir/juju4.jira2
[ ! -e $rolesdir/juju4.jira2 ] && cp -R $rolesdir/ansible-jira2 $rolesdir/juju4.jira2

## don't stop build on this script return code
true
