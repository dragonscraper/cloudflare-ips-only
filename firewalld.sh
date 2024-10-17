#!/bin/bash

curl https://www.cloudflare.com/ips-v4 > .ips-v4
curl https://www.cloudflare.com/ips-v6 > .ips-v6

firewall-cmd --new-zone=cloudflare --permanent
firewall-cmd --reload

for i in `<.ips-v4`; do firewall-cmd --zone=cloudflare --add-source=$i; done
for i in `<.ips-v6`; do firewall-cmd --zone=cloudflare --add-source=$i; done

firewall-cmd --zone=cloudflare --add-port=80/tcp
firewall-cmd --zone=cloudflare --add-port=443/tcp