#!/bin/bash

zip -r /backups/`hostname`-system_backup.zip /etc/keepalived/*
zip -r /backups/`hostname`-system_backup.zip /etc/haproxy/*
zip -r /backups/`hostname`-system_backup.zip /opt/*
zip -r /backups/`hostname`-system_backup.zip ~/.bashrc
zip -r /backups/`hostname`-system_backup.zip /etc/corosync/*
zip -r /backups/`hostname`-system_backup.zip /etc/lsync*
zip -r /backups/`hostname`-system_backup.zip /etc/mysql*
zip -r /backups/`hostname`-system_backup.zip /etc/asterisk/*
zip -r /backups/`hostname`-system_backup.zip /usr/src/*

chown test:test /backups/`hostname`-system_backup.zip
