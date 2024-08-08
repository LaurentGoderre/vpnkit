#!/usr/bin/env sh
set -e

# echo $OPAM_SWITCH_PREFIX
echo $1

pkg=(
    $(opam list -s --installed --required-by=vpnkit --recursive --columns package --nobuild --color=never)
)

dir="sbom_temp"
mkdir "$dir"

cp vpnkit.opam "$dir"

for p in ${pkg[@]}; do
  echo $p >> "$1"
  cp -r "$OPAM_SWITCH_PREFIX/.opam-switch/packages/$p" "$dir/$p"
done

# TODO: Run Docker Scout SBOM Scanner

# TODO: rm -rf sbom_temp
