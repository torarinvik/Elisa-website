# Browser game

The Play button loads the cross-platform Workshop browser shell in an iframe.
The deployed snapshot lives in `game/`, with its upstream commit recorded in
`game/REVISION`.

To update it, bring the sibling `Neural-Workshop-Enhanced-crossplatform`
checkout to its latest `origin/main` and run `bash scripts/update-workshop.sh`
from the website repository. The script also accepts the path to a different
Workshop checkout as its first argument. It uses the Workshop's existing
pinned Stage1 toolchain and replaces the snapshot after the upstream WASM
build and artifact tests succeed. Commit and push the resulting website
changes to publish them through GitHub Pages.

The browser snapshot includes the upstream license and third-party notices.
Some tasks require optional media that the upstream repository does not ship.
