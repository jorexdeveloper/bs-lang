/*
 *	 bfmt.c
 *	 brainfuck code formatter/prettifier.
 *
 *	 Copyright (C) 2024  Jore <https://github.com/jorexdeveloper>
 *
 *	 This program is free software: you can redistribute it and/or modify
 *	 it under the terms of the GNU General Public License as published by
 *	 the Free Software Foundation, either version 3 of the License, or
 *	 (at your option) any later version.
 *
 *	 This program is distributed in the hope that it will be useful,
 *	 but WITHOUT ANY WARRANTY; without even the implied warranty of
 *	 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *	 GNU General Public License for more details.
 *
 *	 You should have received a copy of the GNU General Public License
 *	 along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

#include <stdbool.h>
#include <stdio.h>

#define MAX_LINE 25 /* Max chars before new line. */
#define MAX_CHAR 5	/* Max chars before whitespace. */

bool ischar(int);
void indent(int);

int main(void) {
	register int c, b, l, i;
	c = b = l = i = 0;
	while ((c = getchar()) != EOF) {
		switch (c) {
			case '+':
			case '-':
			case ',':
			case '.':
			case '<':
			case '>':
				i++;
				if (!ischar(b)) {
					indent(l);
				} else if (c != b || (i % MAX_LINE) == 0) {
					putchar('\n');
					indent(l);
					i = 0;
				} else if (i > 1 && ((i - 1) % MAX_CHAR) == 0)
					putchar(' ');
				putchar(c);
				b = c;
				continue;
			case '[':
				l++;
				break;
			case ']':
				l--;
				break;
			case '\n':
				if (ischar(b) || b == '[' || b == ']') {
					i = 0;
					continue;
				}
			default:
				putchar(c);
				i = 0;
				b = c;
				continue;
		}
		putchar('\n');
		if (l > 0)
			indent(c == '[' ? l - 1 : l);
		putchar(c);
		putchar('\n');
		b = c;
		i = 0;
	}
}

/*
 * Returns true if 'c' is a brainfuck non-loop char.
 */
bool ischar(int c) {
	return (c == '+' || c == '-' || c == ',' || c == '.' || c == '<' || c == '>');
}

/*
 * Print tabs equal to 'i'.
 */
void indent(register int i) {
	while (i > 0) {
		putchar('\t');
		i--;
	}
}
