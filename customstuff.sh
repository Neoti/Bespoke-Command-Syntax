#!/bin/bash
STATE=$1
case $STATE in
        "lbstatus") echo "System uptime and Load: "  && uptime && echo "lsync Status: "  && service lsyncd status | grep Active  && echo "HAproxy Status: " && service haproxy status | grep Active && echo "Keepalived Status: " && service keepalived status | grep Active && echo "Current System: " && cat /opt/state.txt &&  echo "---COROSYNC STATUS---" && corosync-quorumtool && mysql -u root -pqwerty12 -e 'show slave status\G' | grep "State" && mysql -u root -pqwerty12 -e 'show slave status\G' | grep "Error"
                  ;;
        "lbstart") service keepalived start && echo "Starting Load Balancing Processes" && echo "   Load Balance Processes are initalizing." > /opt/state.txt
                  ;;
        "lbstop")  service keepalived stop && service haproxy stop  && echo "Stopping Load Balancing Processes" && echo "   Load Balance Processes are not running!!!" > /opt/state.txt
                  exit 0
                  ;;
	"restart")   service keepalived restart && echo "restarting Load balancing Processes"
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

