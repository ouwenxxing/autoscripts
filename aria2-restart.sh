#!/bin/bash
#pause all tasks
#pauseAll or unpauseAll
method=$1
if [[ $method == "unpauseAll" ]]; then
  sleep 5
  #resume them back
  /usr/bin/aria2c --conf-path /etc/aria2/aria2.conf
fi


echo "going execute this ..."
cmd="curl -i -X POST \
   -H "Content-Type:application/json" \
   -H "Accept:application/json" \
   -d '{\"jsonrpc\": \"2.0\",\"id\":1, \"method\": \"aria2.${method}\", \"params\":[]}' \
 'http://192.168.31.248:6800/jsonrpc'"

echo "cmd: $cmd\n"
echo $cmd | /bin/sh

if [[ $method == "pauseAll" ]]; then
  #stop task
  sleep 5
  killall aria2c
fi

