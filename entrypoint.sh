#!/bin/sh

#### frontend
nginx -c /opt/nginx.conf

#### start mihomo
if [[ "x${SUBSCRIBE_URL}" != "x" ]]; then
  /opt/subscribe-daemon.sh &
fi

/opt/rebuild-config.sh

/mihomo
