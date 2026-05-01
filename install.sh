VERSION=$1
TARGETARCH=$2

if [ "${TARGETARCH}" = "arm64" ]; then
  ARCH_FILE="mihomo-linux-arm64-${VERSION}.gz";
else
  ARCH_FILE="mihomo-linux-amd64-v1-${VERSION}.gz";
fi
echo ARCH_FILE=$ARCH_FILE

wget -q "https://github.com/MetaCubeX/mihomo/releases/download/${VERSION}/${ARCH_FILE}" -O /mihomo.gz
gzip -d /mihomo.gz
chmod +x /mihomo

mkdir -p /opt/www/metacubexd 
wget $(curl -s "https://api.github.com/repos/MetaCubeX/metacubexd/releases/latest" | jq -r .assets[0].browser_download_url) 
tar -xf compressed-dist.tgz -C /opt/www/metacubexd
rm compressed-dist.tgz
