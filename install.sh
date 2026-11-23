#!/bin/sh
# OnyxScale helper installer for macOS and Linux.
#
#   curl -fsSL https://raw.githubusercontent.com/wabibito/onyxscale/main/install.sh | sh
#
# Downloads the helper for this computer from the latest release, checks it
# against the release's SHA256SUMS.txt, and registers it with your browsers
# for your user only. No sudo, no system packages.
set -eu

REPO="wabibito/onyxscale"
BASE="https://github.com/$REPO/releases/latest/download"

say() { printf '%s\n' "$*"; }
die() { printf 'onyxscale: %s\n' "$*" >&2; exit 1; }

case "$(uname -s)" in
  Darwin) os=macos ;;
  Linux) os=linux ;;
  *) die "unsupported system $(uname -s); download a helper from https://github.com/$REPO/releases" ;;
esac
case "$(uname -m)" in
  x86_64 | amd64) arch=amd64 ;;
  arm64 | aarch64) arch=arm64 ;;
  *) die "unsupported processor $(uname -m)" ;;
esac
asset="onyxscale-$os-$arch"

command -v curl >/dev/null 2>&1 || die "curl is required"
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT INT TERM

say "Downloading $asset..."
curl -fsSL "$BASE/$asset" -o "$tmp/$asset" || die "download failed"
curl -fsSL "$BASE/SHA256SUMS.txt" -o "$tmp/SHA256SUMS.txt" || die "could not download checksums"

want=$(awk -v f="$asset" '$2 == f || $2 == "*"f { print $1 }' "$tmp/SHA256SUMS.txt")
[ -n "$want" ] || die "no checksum for $asset"
if command -v sha256sum >/dev/null 2>&1; then
  got=$(sha256sum "$tmp/$asset" | awk '{print $1}')
else
  got=$(shasum -a 256 "$tmp/$asset" | awk '{print $1}')
fi
[ "$want" = "$got" ] || die "checksum mismatch for $asset; not installing"

chmod +x "$tmp/$asset"
# The helper copies itself to its permanent place and registers with Chrome,
# Edge, Brave, Chromium, Vivaldi, Arc (macOS), Firefox and Flatpak browsers.
"$tmp/$asset" install
