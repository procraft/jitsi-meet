set -ex

TGZ_FIRST=""
if [ -d ../excalidraw ]; then
  TGZ_FIRST="$(ls -1 ../excalidraw/bin/*.tgz | head -1)"
  if [ ! "" = "$TGZ_FIRST" ]; then
    TGZ="file://$(realpath $TGZ_FIRST)"
  fi
fi
if [ "" = "$TGZ_FIRST" ]; then
  read -p "Enter path to package: " TGZ
fi

sed -i '' "s#\"@jitsi/excalidraw\":.*#\"@jitsi/excalidraw\": \"$(echo $TGZ | xargs)\",#" package.json
rm -rf node_modules/@jitsi/excalidraw package-lock.json
npm cache ls @jitsi/excalidraw | npm cache clean --force
npm i
make
docker-compose -p jitsi-meet-deb-build -f bin/docker-compose.yml up --build
git checkout HEAD -- package-lock.json package.json
echo "Use $(pwd)/bin/deb files"
