#!/bin/bash
result=`ps aux | grep suricata | awk '{ print $13 }' | tail -n +2 | sed 's/--name=//g' | wc -l`
server=`hostname`
if [ $result -lt 1 ]; then
        echo "Suricata IDS process has failed on $server"
        exit 2
fi
echo "$result Suricata Processes Running on $server: OK"
exit 0
