set -ex

. ./bin/set-excalidraw.sh

version="$(date +%s)"

rm -rf node_modules/@jitsi/excalidraw package-lock.json
npm i
make
sed -i '' "s/jitsi-meet-web (1.0.1-1)/jitsi-meet-web \(1.0.$version\)/" debian/changelog
sed -i '' "s#libs/lib-jitsi-meet.min.js\?v=[^\"]*#libs/lib-jitsi-meet.min.js?v=$version#" index.html
sed -i '' "s#libs/app.bundle.min.js\?v=[^\"]*#libs/app.bundle.min.js?v=$version#" index.html
docker-compose -p jitsi-meet-deb-build -f bin/docker-compose.yml up --build
git checkout HEAD -- package-lock.json package.json debian/changelog index.html
echo "Use $(pwd)/bin/deb files"
