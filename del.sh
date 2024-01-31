#!/bin/bash
echo " __   ___ _     ___ ___ _ _  _  ___     ___ _ _     ___  ___     ";
echo "|  \ |___ |    |___  |  | |\ | | __    |___ | |    |___ [__      ";
echo "|__/ |___ |___ |___  |  | | \| |__]    |    | |___ |___ ___] ....";

echo "           __   ___     ___  __   ___  ___  ___ _  _ _    ";
echo "          |__] |___    |    |__| |__/ |___ |___ |  | |    ";
echo "          |__] |___    |___ |  | |  \ |___ |    |__| |___ ";

echo "       ___  __  _  _ ___ _ _  _ _  _  ___    _   _   _  _ ";
echo "      |    |  | |\ |  |  | |\ | |  | |___     \_/  / |\ | ";
echo "      |___ |__| | \|  |  | | \| |__| |___      |  /  | \| ";

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

read -p "" choice
case "$choice" in
  y|Y ) rm "$@";;
  n|N ) echo "Exiting without any change.....";exit 0;;
  * ) echo "Exiting without any change......";exit 0;;
esac
