<h1 align="center">The BS Programming Language</h1>

**Welcome to the hardest programming language of the modern age.**

Don't believe me? Then try guessing what the code below does.

```bash
m +8;l:;rm +4;l:;rm +2;rm +3;rm +3;rm +1;l 4;m -1
:l;rm +1;rm +1;rm -1;r 2;m +1;l:;l;:l;lm -1;:l;r 2
o;rm -3;o;m +7;o 2;m +3;o;r 2;o;lm -1;o;l;o;m +3;o
m -6;o;m -8;o;r 2;m +1;o;rm +2;o
```

Yup, that's what I thought, not even a clue! But I promise, stick with me long enough and I promise that understanding what the code above does will be the least of your worries.

BS is a programming language inspired by **brainfuck**. If you don't know what brainfuck is, you don't need to but here are some valuable resources to act as a remedy for curiousity:

- [brainfuck Esolang](https://esolangs.org/wiki/Brainfuck)
- [brainfuck Implementations](https://esolangs.org/wiki/Brainfuck_implementations)

Since brainfuck is only composed of 8 symbols, it is actually pretty easy to make a programming language that extends and compiles to it.

Therefore, I present to you: **BS**

If you are probably wondering what BS stands for, well it's just BS, I don't know what you were thinking, but really, the name just sparked into my brain when I realised it's a language that combines brainfuck and shell programming features.

## Overview

Just as many before it, the BS language is meant to simplify the brainfuck syntax just enough to add flavour to it, with a few extra constraints without stripping of it the thrill and terror of a low level turing complete programming language.

BS extends most of its features and syntax from shell programming languages like **bash**. It seemed pretty convenient considering that I am a linux user (probably makes it sound like some cult or something).

This means that you will need to compile this language in a shell related environment, to **brainfuck** code which will then be executed by a brainfuck interpreter of your choice. Sounds like fun? I know.

If you are worried about the compilation-execution process, worry not, for I have everything set up and ready to use with just one command, so that you can focus on wondering why your code is not working.

What makes these low level languages like brainfuck and BS very interesting is that, not only is it easy to extend and create a higher level programming language that compiles to them, with more features, but also easy to implement a compiler for them too.

I might consider creating a language that compiles to BS in the future, when I get bored again, because, why else would anyone program in such an amazingly inefficient language?.

## Compile & Execute

The BS language is compiled to brainfuck which can then be executed by any brainfuck interpreter/compiler.

To start running your first program, you just need a few things first.

1. A text editor of your choice, where you will create and edit BS files.
   BS source code files have an extension of `.bs` and BS compiled code files have an extension of `.b`.

2. Next you will need to have a shell interpreter, (Bourne Again Shell recommended) where you will run the compiler. I have included one with this project but an experienced programmer can easily create one of their own.

3. Then you will compile and run the code by following the steps below.

[Download](https://raw.githubusercontent.com/jorexdeveloper/bs-lang/refs/heads/main/bin/bs "Latest BS compiler.") the compiler.

Switch to the compiler directory and make it executable.

```bash
chmod u+x ./bs
```

Compile and execute BS code by invoking the compiler with the path to the BS file.

```bash
./bs <file name>
```

You will notice an extra file in your working directory with the same name as the file you compiled, and a extension of `.b`. That's the compiled BS code.

The compiler has an inbuilt brainfuck interpreter, but if it's slow, you are free to try other alternatives.

## Basic Syntax

The idea behind BS is memory manipulation. Basically you are given an array of 30,000 1 byte sized memory blocks. (The array size is actually dependent upon the implementation used in the interpreter), but standard BS states 30,000. Within this array, you can increase the memory pointer, increase the value at the memory pointer, etc.

BS implements key characters based mainly on the eight brainfuck operators (`+ - < > . , [ ]`) but most importantly, **every key character MUST be followed by a new line or a `;` (semicolon)**.

That's right, BS just got 10x more interesting and this is merely the beginning (until your code doesn't work because of a missing `;` that the compiler probably won't detect).

Yup, you heard me right, the compiler intentionally ignores missing `;` along with common syntax errors because this language is meant to give you the thrill and terror in order to qualify as the hardest of the modern age, otherwise you wouldn't be here right?

If you need a compiler to show you your mistakes, then you can't call yourself a real programmer!

The language is also case sensitive, so **p** is diffrent from **P** or **b**.

### Memory manipulation

#### The `m` key character

The `m` key character is used to increment/decrement the value at the memory pointer by the given value. (similar to brainfuck `+` and `-`)

This key character takes one **mandatory integer argument**, positive/negative for increment/decrement respectively.

Usage:

```bash
m +1; # increment current memory by 1

m -1; # decrement current memory by 1
```

### Memory navigation

#### The `l` & `r` key characters

The `l` and `r` key characters are used to move the memory pointer left and right by the given number of cells. (similar to brainfuck `<` and `>`)

These key characters take one **optional positive integer argument**, which defaults to **1** if not supplied.

Usage:

```bash
l; # move memory pointer left by 1 cell

l 5; # move memory pointer left by 5 cells

r; # move memory pointer right by 1 cell

r 5; # move memory pointer right by 5 cells
```

### Input/Output

#### The `i` & `o` key characters

The `i` and `o` key characters are used to input/output a character at the current memory pointer, the given number of times. (similar to brainfuck `,` and `.`)

These key characters take one **optional positive integer argument**, which defaults to **1** if not supplied.

For `i` values more than 1, the value a the current memory cell is overwritten every single time.

When a character is input, the memory stores it's ASCII value and when a value is output, it's corresponding ASCII character is output.

```bash
i; # input a character at current memory cell 1 time

i 5; # input a character at current memory cell 5 times

o; # output the character at current memory cell 1 time

o 5; # output than character at current memory cell 5 times
```

### Loops

#### The `l` key character

The `l` key character is used to start/stop a loop if appended/prepended a `:` respectively. (similar to brainfuck `[` and `]`)

Usage:

```bash
l: # start a loop

:l # stop a loop
```

##### Loop conditions

1. The loop starts only if the following conditions are met:

   - value at current memory pointer is **non-zero** when `l:` is invoked.

2. The loop continues until the conditions below are met:

   - value at current memory pointer is **zero** when `:l` is invoked.

### Comments

Any line that is preceeded by a `#` is ignored by the compiler.

Usage:

```bash
# This is a comment
m +1;
l:;
    m -1; # also a comment
:l;
```

## Advanced Syntax

BS provides an advanced syntax for combination of memory navigation characters with other key characters to make your code more readable/more complicated for you to understand.

In some cases you are going to need to move the memory pointer right/left, then operate on that value i.e

```bash
r; m +1;
```

In such cases, the advanced syntax allows you to combine the **r** and **m** key characters to shorten the code to:

```bash
rm +1
```

Other possible combinations and their equivalents are shown below.

| Basic syntax | Advanced syntax |
| ------------ | --------------- |
| r; m +1;     | rm +1           |
| l; m +1      | lm +1           |
| r; i 1       | ri 1            |
| l; i 1       | li 1            |
| r; o 1       | ro 1            |
| l; o 1       | lo 1            |

Notice that the memory navigation characters appear first.

## Examples

Now that you are familiar with the not-so-friendly syntax, let's dive into some examples. But to write programs in BS, I would suggest you get a few things first.

- First, I would suggest an ASCII chart with all the characters and their decimal equivalent value.

- Next on the items is would be a calculator. Any will do. It will help you figure out the Greatest Common Factors for use in incrementing a memory cell quickly.

- Lastly, I would recommend having no life and lots of time on your hands to actually want to sit and write programs in this amazingly inefficient language. I promise you, if you take the time to sit and write a program in BS for an hour or five, you will definitely see why it deserves to be called the hardest of the modern age.

Let's start small, with some simple programs.

```bash
m +1
l:
    i;o
:l
```

The program above inputs a character and prints it to the console. Let's break it down.

```bash
m +1
```

This increments memory cell **0** by 1.

```bash
l:
```

This starts a loop, and since the current memory cell (cell 0) is non-zero (value is 1), then the loop shall start.

```bash
i;o
```

This inputs a character at the current memory cell and outputs it after.

```bash
:l
```

This is where the loop ends, if the value at the current memory cell is zero. If the user input a null character (ASCII value of 0), then the loop should end, otherwise it contines.

Yup, I am not going to strip out the fun by walking you through every possible step, so let's jump into a more complex program.

### Hello World program

Recall the program from earlier?

```bash
m +8;l:;rm +4;l:;rm +2;rm +3;rm +3;rm +1;l 4;m -1
:l;rm +1;rm +1;rm -1;r 2;m +1;l:;l;:l;lm -1;:l;r 2
o;rm -3;o;m +7;o 2;m +3;o;r 2;o;lm -1;o;l;o;m +3;o
m -6;o;m -8;o;r 2;m +1;o;rm +2;o
```

Yup, that piece of gibberish is mean't to print the string 'Hello World!" to the console. I know I said BS was hard, but did I mention crazy?

Well, let's make the program more readable and break it down step by step.

```bash
m +8                      # Set cell 0 to 8
l:
    rm +4                 # Add 4 to cell 1; this will always set cell 1 to 4
    l:                    # as the cell will be cleared by the loop
        rm +2             # Add 4*2 to cell 2
        rm +3             # Add 4*3 to cell 3
        rm +3             # Add 4*3 to cell 4
        rm +1             # Add 4*1 to cell 5
        l 4; m -1         # Decrement the loop counter in cell 1
    :l                    # Loop till cell 1 is zero
    rm +1                 # Add 1 to cell 2
    rm +1                 # Add 1 to cell 3
    rm -1                 # Subtract 1 from cell 4
    r 2;  m +1            # Add 1 to cell 6
    l:
        l                 # Move back to the first zero cell you find; this will
    :l                    # be cell #1 which was cleared by the previous loop
    lm -1                 # Decrement the loop Counter in cell #0
:l                        # Loop till cell #0 is zero

# The result of this is:
# cell num :   0   1   2   3   4   5   6
# memory   :   0   0  72 104  88  32   8
# pointer  :   ^

r 2; o                    # cell 2 has value 72 which is 'H'
rm -3; o                  # Subtract 3 from cell 3 to get 101 which is 'e'
m +7; o 2; m +3; o        # Likewise for 'llo' from cell 3
r 2; o                    # cell 5 is 32 for the space
lm -1; o                  # Subtract 1 from cell 4 for 87 to give a 'W'
l; o                      # cell 3 was set to 'o' from the end of 'Hello'
m +3; o; m -6; o; m -8; o # cell 3 for 'rl' and 'd'
r 2; m +1; o              # Add 1 to cell 5 gives us an exclamation point
rm +2; o                  # And finally a newline from cell 6
```

I also highly recommend that you to remove just a few semi-colons and see what happens!
