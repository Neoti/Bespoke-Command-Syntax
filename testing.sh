#!/bin/bash
if [ service haproxy status | grep inactive  ]; then 
        echo "HAproxy : In Backup State"
else 
        echo "Haproxy : In Master State"
fi

