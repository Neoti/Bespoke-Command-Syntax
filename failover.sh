#!/bin/bash
TYPE=$1
NAME=$2
STATE=$3
case $STATE in
        "MASTER") /usr/sbin/service haproxy start && echo "Starting HAProxy as we are Master" && echo "   We Are : MASTER" > /opt/state.txt
                  ;;
        "BACKUP") /usr/sbin/service haproxy stop && echo "Stopping HAProxy as we are Backup" && echo "   We Are : BACKUP" > /opt/state.txt
                  ;;
        "FAULT")  /usr/sbin/service haproxy stop && echo "There is a fault!" > /opt/state.txt
                  exit 0
                  ;;
	"STOP")   /usr/sbin/service haproxy stop && echo "Stopping HAProxy as Keepalived stopeed"
		  exit 0
		  ;;
	"HEARTBEAT") if [ ! -f /var/run/keepalived.pid ]; then
    			/usr/sbin/service haproxy stop && echo "Stopping HAproxy as Keepalived has stopped"
		     else 
			echo "Keep alive has passed checks"
		     fi
		  ;;
        *)        exit 1
                  ;;
esac
