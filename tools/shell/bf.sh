#!/usr/bin/env bash

#
# INTERPRETER
#

declare -a mem
max_mem=50
ptr=0

# Increment value at pointer
inc() {
	((mem[ptr]++))
}

# Decrement value at pointer
dec() {
	((mem[ptr]--))
}

# Move pointer right
mor() {
	((ptr++))
	! ((ptr < ${#mem[@]})) && exp
}

# Move pointer left
mol() {
	((ptr--))
	((ptr < 0)) && msg "Negative memory pointer at: ${ptr}"
}

# Output char at pointer location
cou() {
	echo -en "\x$(printf "%x" "${mem[${ptr}]}")"
}

# Input char to pointer location
cin() {
	read -rn1 -u2 mem[${ptr}]
	mem[ptr]=$(printf '%d' "'${mem[${ptr}]}")
}

# Execute brainfuck char
exe() {
	case "${1}" in
		"+") inc ;;
		"-") dec ;;
		">") mor ;;
		"<") mol ;;
		".") cou ;;
		",") cin ;;
	esac
}

# Execute brainfuck file
run() {
	if [[ -n "${1}" ]] && ! [[ -f "{1}" ]]; then
		local ifs="${IFS}"
		local depth=0
		local code=""
		local i=0
		exp
		while read -r line || ((i < ${#code})); do
			[[ -n "${line}" ]] && code+="${line}"
			# echo "${line}"
			# while true; do # Prevents reading of not yet needed lines for efficiency
			# printf "%d" $i
			case "${code:${i}:1}" in
				'[') ((mem[ptr] == 0)) && ((depth++)) ;;
				']')
					if ((depth > 0)); then
						((depth--))
					elif ((mem[ptr] != 0)); then
						((i--))
						while ((depth > 0)) || [[ "${code:${i}:1}" != '[' ]]; do
							case "${code:${i}:1}" in
								'[') ((depth--)) ;;
								']') ((depth++)) ;;
							esac
							((i--))
						done
						((i--))
					fi
					;;
				*) ((depth == 0)) && exe "${code:${i}:1}" ;;
			esac
			((i++))
			((i == ${#code})) && break
			# done
		done <"${1}"
		IFS="${ifs}"
	fi
}

# Expand memory blocks
exp() {
	if [[ "${#mem[@]}" -lt "${max_mem}" ]]; then
		for ((m = 1; m > 0; m--)); do
			mem+=(0)
		done
	else
		msg "Out of memory at memory block: [${#mem[@]}]."
	fi
}

# Print memory blocks
prm() {
	local c=0
	echo
	for i in "${mem[@]}"; do
		printf " [%3d]" "${i}"
		((c == ptr)) && echo -n "*" || echo -n ' '
		((c++))
		! ((c % 8)) && echo
	done
	echo
}

# Prints text to console
msg() {
	echo "${1}"
	exit 1
}
