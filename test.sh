#!/bin/bash
# Checks the cask the way Homebrew's own CI does, then installs and removes it.
# Pass --no-install to skip the install round trip.
# Removing Trois never asks for a password; only brew uninstall --zap does.

set -eo pipefail

TAP_DIR="$(cd "$(dirname "$0")" && pwd)"
TAP=trois-dev/tap
# Uninstalling must not take other formulae with it.
export HOMEBREW_NO_AUTOREMOVE=1

# Linked rather than tapped so uncommitted changes are what gets checked.
LINK="$(brew --repository)/Library/Taps/trois-dev/homebrew-tap"
if [ -e "$LINK" ] && [ ! -L "$LINK" ]; then
    echo "$LINK is a real tap; untap it first"
    exit 1
fi
mkdir -p "$(dirname "$LINK")"
ln -sfn "$TAP_DIR" "$LINK"
trap 'rm -f "$LINK"' EXIT

brew style --cask "$TAP/trois"

# Installs into a scratch folder so an existing /Applications/Trois.app is left alone.
if [ "$1" != "--no-install" ]; then
    APPDIR="$(mktemp -d)"
    brew install --cask --appdir="$APPDIR" "$TAP/trois"
    test -d "$APPDIR/Trois.app"
    spctl --assess --type execute "$APPDIR/Trois.app"
    brew uninstall --cask "$TAP/trois"
    test ! -e "$APPDIR/Trois.app"
    rmdir "$APPDIR"
fi

brew audit --cask --strict --online "$TAP/trois"

echo "cask ok"
