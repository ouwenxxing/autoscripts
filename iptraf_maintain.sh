#!/bin/bash
pid=$(ps -axf | grep iptraf | grep -v grep | grep -v iptraf_maintain.sh | awk '{print $1}')
if [[ "" != $pid ]]; then
  echo "iptraf id is: $pid, killing it..."
  kill $pid
fi
/usr/sbin/iptraf  -s eth1 -B 
new_pid=$(ps -axf | grep iptraf | grep -v grep | grep -v iptraf_maintain.sh | awk '{print $1}')
echo "started new iptraf process, new pid is: $new_pid."
