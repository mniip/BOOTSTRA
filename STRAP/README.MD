STRAP
=====

STRAP is a programming language designed to be a middle ground between
assembly and a C-like language, borrowing some ideas from Forth and FALSE.

Provided here is a STRAP compiler that produces standalone COM files. It is
written in BatAs assembly and can be compiled by running MAKE.BAT. Note that
this process might take multiple tens of seconds.

Usage
=====

    STRAP <Input.str> <Output.com>

Language
========

A `#` at any point starts a comment that spans until the end of the line.

A program consists of data blocks delimited by `[` and `]`; and text (code)
blocks delimited by `{` and `}`. Data blocks are used to place raw data in
memory, while text blocks translate to machine code.

A number is either a decimal or a hexadecimal constant, truncated to 16 bits.
A `'` (single quote) followed by a character is equivalent to the numeric
ASCII code of that character.

An identifier is a letter or an underscore followed by zero or more letters,
digits, and underscores.

Labels
======

A `:` followed by an identifier denotes a label, which can be referenced from
any other location in the program.

Data
====

In a data block, the following commands can be used to place data:

 * A `$` followed by a number produces the 16-bit constant in native byte
   order.
 * A bare number produces the least significant byte of the constant
 * A `$` followed by an identifier produces the 16-bit address of the referred
   label.
 * A bare identifier produces the least significant byte of the label's
   address.

Semantics
=========

There is a stack of 16-bit word values, separated into frames. A frame has a
predefined number of local variables and then a dynamic number of values
further down the stack. A function's local variables can be referred to by
their indices at any point in the function.

Most operations pop some values off the stack, perform a computation, and then
push some values back on stack. A function call pushes the return address on
the same stack. There is a construct that creates a stack frame of a fixed
size. There are constructs that rotate values at the top of the previous frame
in and out of the bottom of the current frame, this is how functions take
parameters and return values.

Text
====

In a text block, each command translates to machine code. The behavior of the
generated machine code is as follows:

 * A `:` followed by a number creates a stack frame with that number of local
   variables. It should be immediately be followed by a `{}`-delimited text
   block.
 * A `$` followed by an identifier pushes the address of the label into the
   stack.
 * A bare identifier calls a function at the given label.
 * A bare number pushes the number into the stack.
 * A `@` followed by a number pushes the value of the local variable referred 
   to by that number.
 * A `@=` followed by a number pops a value from the stack into the local
   variable referred to by that number.
 * A `$` followed by a number pushes a value from the previous stack frame,
   counting that many elements from the top.
 * `$:` moves the zeroth local variable to the top of the previous stack
   frame, shifting the indices of other local variables down by one. This
   effectively returns `@0` from the function.
 * `$;` shifts all local variable indices up by one and moves the top of the
   previous stack frame into the zeroth local variable. This effectively
   introduces the `$0` argument as `@0`.
 * `@` followed by an identifier performs an unconditional jump to the label.
 * `$$` followed by a `{}`-delimited text block causes all the code in the
   block to be skipped.
 * `$?` followed by two `{}`-delimited text blocks (if-block and else-block)
   pops a value from the stack, and if it's nonzero then the if-block is
   executed, otherwise, the else-block is executed.
 * `$@` followed by two `{}`-delimtied text blocks (condition-block and
   body-block) executes a loop. The condition is executed, then a value is
   popped from the stack. If zero, the loop ends. otherwise the body is
   executed and the loop begins again.

 The rest are pretty straightforward:

 * `+` pops two values and pushes their sum.
 * `-` pops the subtrahend and the minuend and pushes their difference.
 * `*` pops two values and pushes their unsigned product.
 * `/` pops the divisor and the dividend and pushes their truncated unsigned 
   quotient.
 * `%` pops the divisor and the divident and pushes their unsigned remainder.
 * `&` pops two values and pushes their bitwise AND.
 * `|` pops two values and pushes their bitwise OR.
 * `^` pops two values and pushes their bitwise XOR.
 * `=` pops two values and pushes 1 if they're equal and 0 otherwise.
 * `<` pops two values and pushes 1 if the number popped last was less, and
   0 otherwise.
 * `` ` `` (apostrophe) pops a value and pushes its negation.
 * `~` pops a value and pushes its bitwise NOT.
 * `,` pops a value and pushes it back twice.
 * `.` pops a value and discards it.
 

 * `$-` pops an address and pushes a zero-extended byte read from that
   address.
 * `$+` pops an address and a value and writes the least significant byte of
   the value at that address.
 * `$*` pops an address and pushes a 16-bit word read from that address.
 * `$/` pops an address and a value and and writes the 16-bit word at that
   address.

Program
=======

The outermost block that encompasses the entire file is a data block, but a 
program starts executing _machine code_ from the start of the file.

Example
=======

A complete example program is available in `HELLO.STR` in this directory.
