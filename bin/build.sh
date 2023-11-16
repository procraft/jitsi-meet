set -ex

npm i
make
docker-compose -p jitsi-meet-deb-build -f bin/docker-compose.yml up --build
echo "Use $(pwd)/bin/deb files"
