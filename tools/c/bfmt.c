/*
 *	 bfmt
 *	 Formats brainfuck code.
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

#include <ctype.h>
#include <stdbool.h>
#include <stdio.h>

#define MAX_CHAR 5
#define MAX_LINE 25

bool ischar(int);
void indent(int);

int main(void) {
	register int c, b, l, i;
	c = b = l = i = 0;
	while ((c = getchar()) != EOF) {
		if (ischar(c)) {
			if (!ischar(b)) {
				indent(l);
			} else if (c != b || (i > 0 && (i % MAX_LINE) == 0)) {
				putchar('\n');
				indent(l);
				i = 0;
			} else if (i > 1 && (i % MAX_CHAR) == 0)
				putchar(' ');
			putchar(c);
			b = c;
			i++;
			continue;
		} else if (c == '[') {
			l++;
		} else if (c == ']') {
			l--;
		} else if (isspace(c)) {
			if (ischar(b))
				continue;
			else if (b == '[' || b == ']') {
				i = 0;
				continue;
			} else if (c == b && c != '\n')
				continue;
			else {
				putchar(c);
				i = 0;
				b = c;
				continue;
			}
		} else {
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

bool ischar(int x) {
	return (x == '+' || x == '-' || x == ',' || x == '.' || x == '<' || x == '>');
}

void indent(int y) {
	while (y > 0) {
		putchar('\t');
		y--;
	}
}
