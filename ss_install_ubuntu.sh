#!/bin/bash
interface=$1
passwd=$2
sspath=$(which ssserver)
if [[ "" == $sspath ]]; then
  echo "installing shadowsocks..." 
  /usr/bin/pip install shadowsocks -q
fi

ip=$(ifconfig | grep -A 1 "$interface" | grep -v $interface | cut -d':' -f2 | cut -d' ' -f1)
echo "ip is: $ip"

echo '{
    "server": "'$ip'",
    "port_password": {
        "8889": "'$passwd'"
    },
    "timeout": 300,
    "method": "aes-256-cfb"
}' > /etc/shadowsocks.json
/bin/cp -f /etc/shadowsocks.json /root/ss_config/shadowsocks.json.template

pid=$(ps -aux | grep ssserver | grep -v grep | cut -d' ' -f7)
if [[ "" != $pid ]]; then 
  echo "killing the current process $pid..."
  kill $pid
fi
/usr/local/bin/ssserver -c /etc/shadowsocks.json > /var/log/ssserver.log 2>&1 &

