#!/usr/bin/env bash

cmd() {
	for command in tr head sed bfstrip bfmt bf2bs-raw; do
		if ! [ -x "$(command -v ${command})" ]; then
			echo "Required command '${command}' not available!"
			echo "Install and try again."
			exit 1
		fi
	done
}

conv() {
	local bs
	mkdir -vp ../programs
	for bf in "${@}"; do
		bs="../programs/$(basename "${bf%.b}").bs"
		echo "'${bf}' -> '${bs}'"
		head -n 5 "${bf}" | sed 's/env\sbf$/env bs/g' >"${bs}"
		echo >>"${bs}"
		bfstrip <"${bf}" | tr -d '@' | bfmt | bf2bs-raw | sed 's/;$//g' >>"${bs}"
	done
}

cmd
if [ -z "${*}" ]; then
	echo "Usage: ${0} FILE..."
else
	conv "${@}"
fi
