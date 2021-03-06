#!/usr/bin/env bash
# Script to install MT4 platform using winetricks.
set -e
CWD="$(cd -P -- "$(dirname -- "$0")" 2>/dev/null && pwd -P || pwd -P)"
WURL="https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks"
export WINEDLLOVERRIDES="mscoree,mshtml=,winebrowser.exe="
[ "$TRACE" ] && set -x

echo "Checking display..." >&2
if [ ! "$DISPLAY" ]; then
  echo "Configuring display..." >&2
  . "$CWD"/.funcs.cmds.inc.sh
  set_display
fi

echo "Installing winhttp..." >&2
sh -s winhttp < <(wget -qO- $WURL)

echo "Installing platform..." >&2
sh -s "$CWD"/install_mt4.verb < <(wget -qO- $WURL)

echo "Installation successful." >&2
echo "${BASH_SOURCE[0]} done." >&2
