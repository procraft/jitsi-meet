set -ex

. ./bin/set-excalidraw.sh

rm -rf node_modules/@jitsi/excalidraw package-lock.json
npm i
git checkout HEAD -- package-lock.json package.json
make dev
