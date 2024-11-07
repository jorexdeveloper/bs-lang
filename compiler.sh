#!/usr/bin/env bash

# Name      : BS Compiler
# Purpose   : Compile BS language to brainfuck and execute it.
# Author    : Jore

#
# COMMANDS
#

# increment/decrement memory block
# by arg
m() {
	if [ "${1}" -gt "0" ]; then
		for ((i = ${1}; i > 0; i--)); do
			echo -n '+'
		done
	elif [ "${1}" -lt "0" ]; then
		for ((i = ${1}; i < 0; i++)); do
			echo -n '-'
		done
	fi
}

# move right and increment/decrement
# memory block block by arg
rm() {
	r
	m "${@}"
}

# move left and increment/decrement
# memory block block by arg
lm() {
	l
	m "${@}"
}

# move pointer right arg blocks
r() {
	[ -z "${1}" ] && set -- 1
	for ((i = ${1}; i > 0; i--)); do
		echo -n '>'
	done
}

# move pointer left arg blocks
l() {
	[ -z "${1}" ] && set -- 1
	for ((i = ${1}; i > 0; i--)); do
		echo -n '<'
	done
}

# input character arg times
i() {
	[ -z "${1}" ] && set -- 1
	for ((i = ${1}; i > 0; i--)); do
		echo -n ','
	done
}

# move right and input character arg times
ri() {
	r
	i "${@}"
}

# move right and input character arg times
li() {
	l
	i "${@}"
}

# print character arg times
o() {
	[ -z "${1}" ] && set -- 1
	for ((i = ${1}; i > 0; i--)); do
		echo -n '.'
	done
}

# move right and print character arg
# times
ro() {
	r
	o "${@}"
}

# move right and print character arg
# times
lo() {
	l
	o "${@}"
}

# Start loop n times
l:() {
	[ -z "${1}" ] && set -- 1
	for ((i = ${1}; i > 0; i--)); do
		echo -n '['
	done
}

# End loop n times
:l() {
	[ -z "${1}" ] && set -- 1
	for ((i = ${1}; i > 0; i--)); do
		echo -n ']'
	done
}

#
# COMPILER
#

compile() {
	wrap=80
	if [ -z "${1}" ]; then
		_usage
	else
		local file="${1%.bs}.b"
		echo "#!/usr/bin/env bf" >"${file}"
		source "${1}" | sed -e "s/\(.\{${wrap}\}\)/&\n/g" >>"${file}"
		echo "@" >>"${file}"
		chmod u+x "${file}"
		echo "${file}"
	fi
}

usage() {
	echo "BS Compiler"
	echo "Usage: $(basename "${0}") FILE"
}

#
# ENTRY
#

if [ -x "$(command -v bf)" ]; then
	bf "$(compile "${1}")"
else
	echo "No brainfuck interpreter (command 'bf') found! Will only compile."
	compile "${1}"
fi
