#!/bin/sh
printf '\033c\033]0;%s\a' EcoTime
base_path="$(dirname "$(realpath "$0")")"
"$base_path/EcotimeLinux.x86_64" "$@"
