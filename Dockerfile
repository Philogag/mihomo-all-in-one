ARG MIHOMO_VERSION=latest

FROM metacubex/mihomo:${MIHOMO_VERSION}

RUN apk update \
 && apk add --no-cache curl wget jq nginx lua5.3 lua5.3-lyaml

RUN mkdir -p /opt/www/metacubexd \
 && wget $(curl -s "https://api.github.com/repos/MetaCubeX/metacubexd/releases/latest" | jq -r .assets[0].browser_download_url) \
 && tar -xf compressed-dist.tgz -C /opt/www/metacubexd \
 && rm compressed-dist.tgz

ADD . /opt

RUN chmod +x /opt/*.sh \
 && cp /opt/fill-backend.js /opt/www/metacubexd \
 && sed -i 's@</head>@<script src="fill-backend.js"></script></head>@' /opt/www/metacubexd/index.html

ENV SUBSCRIBE_URL=
ENV SUBSCRIBE_INTERVAL=86400

EXPOSE 9091

ENTRYPOINT [ "/bin/sh" ]
CMD [ "/opt/entrypoint.sh" ]