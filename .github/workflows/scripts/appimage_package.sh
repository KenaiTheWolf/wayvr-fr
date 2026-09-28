#!/bin/sh
set -eu

case "$(uname -m)" in
  x86_64|amd64)
    APPIMAGE_ARCH=x86_64
    DESKTOP_FILE=wayvr-amd64.desktop
    ;;
  aarch64|arm64)
    APPIMAGE_ARCH=aarch64
    DESKTOP_FILE=wayvr-aarch64.desktop
    ;;
  *)
    echo "Unsupported architecture: $(uname -m)" >&2
    exit 1
    ;;
esac

LINUXDEPLOY="linuxdeploy-${APPIMAGE_ARCH}.AppImage"
VERSION="${GITHUB_REF_NAME:-dev}"
export VERSION

echo "Packaging AppImage for ${APPIMAGE_ARCH}"

"./${LINUXDEPLOY}" \
  -d"${DESKTOP_FILE}" \
  -iwayvr.png \
  --appdir="${APPDIR}" \
  --output appimage \
  --exclude-library '*libpipewire*'

mv "WayVR-${VERSION}-${APPIMAGE_ARCH}.AppImage" "WayVR-${APPIMAGE_ARCH}.AppImage"
