WEB_RELEASE_URL="https://api.github.com/repos/MetaCubeX/metacubexd/releases/latest"

wget $(curl -s ${WEB_RELEASE_URL} | jq -r .assets[0].browser_download_url)