
#!/bin/bash

FILES="/opt/basic-config.yml"

if [[ ! -f /tmp/mihomo-api-secret.yml ]]; then
  SECRET=$(head -c 10 /dev/urandom | md5sum | cut -c 1-16)
  echo "secret: ${SECRET}" > /tmp/mihomo-api-secret.yml
  sed -i "s@var METACUBEXD_SECRET=.*@var METACUBEXD_SECRET=\"${SECRET}\"@g" /opt/www/metacubexd/fill-backend.js
fi
FILES="${FILES} /tmp/mihomo-api-secret.yml"

if [[ -f /root/.config/mihomo/patch.yml ]]; then
  FILES="${FILES} /root/.config/mihomo/patch.yml"
fi

if [[ "x${SUBSCRIBE_URL}" != "x" ]]; then
  if [[ ! -f /root/.config/mihomo/subscribe.yml ]]; then
    curl -s ${SUBSCRIBE_URL} > /root/.config/mihomo/subscribe.yml
  fi
  FILES="${FILES} /root/.config/mihomo/subscribe.yml"
fi

echo "Merge Config: ${FILES}"
lua5.3 /opt/merge-yaml.lua $FILES > /root/.config/mihomo/config.yaml

# report to reload if already up
if [[ -f /var/run/mihomo.sock ]]; then
  curl -s -X PUT http://localhost:9091/core/configs?force=true
fi
