This is an experiment in bootstrapping some sort of programming language or
environment on a clean MSDOS install. The idea is that with access to any
documentation, but no compiled binaries, I should be able to implement
everything starting from just the tools MSDOS gives me. Writing tools on
another machine to generate code for this machine is also not allowed, so any
tools I use must be implemented in terms of simpler tools, or those already
provided by MSDOS. Everything here, despite impressive size, has been written
in the 25x80 window of the EDIT.COM editor, and is, so far, fair game.

At the start, the most powerful tool is undoubtedly DEBUG.EXE with its ability
to assemble and create executable files. It has just one handicap though: there
are no labels. One has to manually adjust jump and variable locations.

I've somewhat overcome this by writing a 8086 assembler in MSDOS batch, as seen
under the BATAS directory.

Next step is a slightly higher level Forth-like language that is still
backwards compatible with machine code, as seen under the STRAP directory.

There is currently ongoing work more sophisticated tools that are soon to
appear in this repository.
