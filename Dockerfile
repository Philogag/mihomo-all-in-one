FROM debian:stable-slim AS runner
ARG MIHOMO_VERSION=v1.19.24
ARG TARGETARCH

RUN apt-get update \
 && apt-get install -y --no-install-recommends ca-certificates tzdata iptables curl wget jq nginx lua5.3 liblua5.3-0 gzip \
 && rm -rf /var/lib/apt/lists/*

ADD . /opt

RUN chmod +x /opt/*.sh \
 && /opt/install.sh ${MIHOMO_VERSION} ${TARGETARCH} \
 && cp /opt/fill-backend.js /opt/www/metacubexd \
 && sed -i 's@</head>@<script src="fill-backend.js"></script></head>@' /opt/www/metacubexd/index.html

ENV SUBSCRIBE_URL=
ENV SUBSCRIBE_INTERVAL=86400

EXPOSE 9091

VOLUME ["/root/.config/mihomo/"]

ENTRYPOINT [ "/bin/sh" ]
CMD [ "/opt/entrypoint.sh" ]