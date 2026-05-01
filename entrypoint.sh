#!/bin/bash

#### frontend
nginx -c /opt/nginx.conf

#### start mihomo
if [[ "x${SUBSCRIBE_URL}" != "x" ]]; then
  /opt/subscribe-daemon.sh &
fi

if [[ "x/opt/custom/custom-daemon.sh" != "x" ]]; then
  /opt/custom/custom-daemon.sh &
fi

/opt/rebuild-config.sh

/mihomo
