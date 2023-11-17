set -e

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
