set -ex

. ./bin/set-excalidraw.sh

rm -rf node_modules/@jitsi/excalidraw package-lock.json
npm i
make
sed -i '' "s/jitsi-meet-web (1.0.1-1)/jitsi-meet-web \(1.0.$(date +%s)\)/" debian/changelog
docker-compose -p jitsi-meet-deb-build -f bin/docker-compose.yml up --build
git checkout HEAD -- package-lock.json package.json debian/changelog
echo "Use $(pwd)/bin/deb files"
