# Mihomo All In One

combine the Mihomo-meta core and 
support simple subscribe of channels

## Usage:

```
services:

  mihomo:
    build: .
    ports:
      - 9091:9091
      - 7890:7890
    volumes:
      - ./config:/root/.config/mihomo/
    environment:
      - TZ=Asia/Shanghai
      - SUBSCRIBE_URL=http://replace.your.subscribe.channel
```

up the container and access the 9091 for admin page