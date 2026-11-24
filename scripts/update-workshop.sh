#!/usr/bin/env bash
set -euo pipefail

website="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
source="$(cd -- "${1:-$website/../Neural-Workshop-Enhanced-crossplatform}" && pwd)"
core="$source/nw-core"

git -C "$source" fetch origin main
revision="$(git -C "$source" rev-parse HEAD)"
if [[ "$revision" != "$(git -C "$source" rev-parse FETCH_HEAD)" || -n "$(git -C "$source" status --porcelain)" ]]; then
  echo "Check out the latest origin/main with a clean Workshop working tree before building." >&2
  exit 1
fi

staging="$(mktemp -d)"
trap 'rm -rf -- "$staging"' EXIT
# The pinned build consumes existing toolchain binaries and builds the game only.
NW_STAGE1_WASM_OBJECT="$staging/nwcore.o" \
NW_STAGE1_WASM_ARTIFACT="$staging/nwcore.wasm" \
  bash "$core/scripts/build_stage1_wasm.sh"

git -C "$source" archive "$revision" LICENSE THIRD_PARTY_NOTICES.md nw-core/shells/web nw-core/res |
  tar -xf - -C "$staging"
mkdir -p "$staging/nw-core/build"
cp "$staging/nwcore.wasm" "$staging/nw-core/build/"
mv "$staging/"{LICENSE,THIRD_PARTY_NOTICES.md} "$staging/nw-core/"
printf '%s\n' "$revision" > "$staging/nw-core/REVISION"
rm -f "$staging/nw-core/shells/web/"*_test.mjs
rsync -a --delete "$staging/nw-core/" "$website/workshop/game/"
