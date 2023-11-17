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
npm i
make
sed -i '' "s/jitsi-meet-web (1.0.1-1)/jitsi-meet-web \(1.0.$(date +%s)\)/" debian/changelog
docker-compose -p jitsi-meet-deb-build -f bin/docker-compose.yml up --build
git checkout HEAD -- package-lock.json package.json debian/changelog
echo "Use $(pwd)/bin/deb files"
