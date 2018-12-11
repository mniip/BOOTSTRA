This is an experiment in bootstrapping some sort of programming language or
environment on a clean MSDOS install. The idea is that with access to any
documentation, but no compiled binaries, I should be able to implement
everything starting from just the tools MSDOS gives me. Writing tools on
another machine to generate code for this machine is also not allowed, so any
tools I use must be implemented in terms of simpler tools, or those already
provided by MSDOS.

At the start, the most powerful tool is undoubtedly DEBUG.EXE with its ability to assemble and create executable files. It has just one handicap though: there
are no labels. One has to manually adjust jump and variable locations.

I've somewhat overcome this by writing a 8086 assembler in MSDOS batch, as seen
under the BATAS directory.

There is currently ongoing work more sophisticated tools that are soon to
appear in this repository.
