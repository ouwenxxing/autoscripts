#!/bin/bash
/bin/cp -f /root/ss_config/shadowsocks.json.template /root/ss_config/shadowsocks.json.tmp
users=$(cat /root/ss_config/users-pwd.txt | cut -d'#' -f1)
for user in $users
do
  sed -i '4 i \ \ \ \ \ \ \ \ '$user /root/ss_config/shadowsocks.json.tmp
done
cat /root/ss_config/shadowsocks.json.tmp > /etc/shadowsocks.json
rm /root/ss_config/shadowsocks.json.tmp
pid=$(ps -axf | grep ssserver | grep -v grep | grep -v ss_maintain.sh | awk '{print $1}')
if [[ "" != $pid ]]; then
  echo "ssserver id is: $pid, killing it..."
  kill $pid
fi
/usr/local/bin/ssserver -c /etc/shadowsocks.json > /var/log/ssserver.log 2>&1 &
new_pid=$(ps -axf | grep ssserver | grep -v grep | grep -v ss_maintain.sh | awk '{print $1}')
echo "started new ssserver process, new pid is: $new_pid" 
