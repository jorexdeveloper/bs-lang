/*
 *	 bf2bs-raw
 *
 *	 Converts brainfuck to BS (BS decompiler), but keeps comments.
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

#include <stdio.h>

int count(int);

/*
 * Main logic.
 */
int main() {
	register int c = 0;

	while ((c = getchar()) != EOF)
		switch (c) {
			case '+':
				printf("m +%d;", (1 + count(c)));
				continue;
			case '-':
				printf("m -%d;", (1 + count(c)));
				continue;
			case '<':
				printf("l %d;", (1 + count(c)));
				continue;
			case '>':
				printf("r %d;", (1 + count(c)));
				continue;
			case '.':
				printf("o %d;", (1 + count(c)));
				continue;
			case ',':
				printf("i %d;", (1 + count(c)));
				continue;
			case '[':
				printf("l:;");
				continue;
			case ']':
				printf(":l;");
				continue;
			default:
				putchar(c);
				continue;
		}
}

/*
 * Counts consecutive occurrencies of a character.
 */
int count(register int c) {
	register int x, i;

	for (x = i = 0; (x = getchar()) != EOF && x == c; i++);

	ungetc(x, stdin);

	return i;
}
