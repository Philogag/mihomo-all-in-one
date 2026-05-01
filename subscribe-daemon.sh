while true;
do 
    sleep ${SUBSCRIBE_INTERVAL}

    curl -s ${SUBSCRIBE_URL} > /root/.config/mihomo/subscribe.yml

    /opt/rebuild-config.sh
done
