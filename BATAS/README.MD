BatAs
=====

This is a 8086 assembler written in MSDOS batch. It depends on just two
utilities: RPN.COM and APPFB.COM, the rest is completely in batch.

The source for the utilities is provided in DEBUG.EXE script form (RPN.DBG
and APPFB.DBG) and they can be "built" by invoking MAKE.BAT. For your
convenience the utilities have also been provided in binary form. You can
verify their integrity using any 8086 disassembler. The same utilities are
also provided in form accepted by AS.BAT (RPN.S and APPFB.S). They don't
produce identical binaries, but they do produce identical assembly listings,
as some instructions have more than one possible encoding.

Usage
=====

    AS [/P <Path\To\BatAs>] <Input.S> <Output.COM>

If running from a directory other than where AS.BAT is located, you need to
supply the /P switch.

Due to the nature of the assembler (as described below), for larger programs
you may wish to increase the environment block size of your interpreter (see
the /E switch in the COMMAND.COM manual).

Language
========

Due to there being nearly no string processing functions in MSDOS batch, the
input to the assembler is actually also batch script full of CALL commands
that execute .BAT files from this directory.

For example, to move a value from one register to another, you can write:

    CALL MOV BX AX

Register names are case sensitive. The CALL is necessary because otherwise
our batch script terminates as soon as MOV.BAT does.

The syntax of various addressing modes is as follows:

    CALL MOV [SI] AX
    CALL MOV [BX+SI] AX
    CALL MOV [BX+SI+BYTE] 123 AX
    CALL MOV [BX+SI+WORD] 12345 AX
    CALL MOV [WORD] 12345 AX

An immediate value in arithmetic opcodes has to be prefixed with the words
BYTE or WORD, depending on the size of the operand. In 8086, arithmetic
instructions allow an encoding where a 8-bit immediate is sign extended and
then used in a 16-bit operation. Such immediates are to be prefixed with BTW:

    CALL ADD AL BYTE 123
    CALL ADD AX WORD 12345
    CALL ADD AX BTW 123

Unconditional jump (JMP) defaults to a local jump with a 8-bit displacement.
To override, use either JMP NEAR for a 16-bit displacement or JMP FAR for a
far jump.

"CALL" is a batch builtin so the CALL 8086 mnemonic had to be spelled "CLL".

Labels
======

Unlike DEBUG.EXE, this assembler supports arbitrary backward- and
forward-referencing labels. You can create a label with LABEL.BAT and further
use it as a regular batch variable:

    CALL MOV AX [WORD] %Data%
    CALL LABEL Test
    CALL JMP %Test%
    CALL LABEL Data
    CALL DW 0

Example
=======

Here's an example hello-world program:

    REM Place the string in DS:DX
    CALL PUSH CS
    CALL POP DS
    CALL MOV DX WORD %String%
    
    REM AH=9 Output string
    CALL MOV AH BYTE 9
    CALL INT 33
    
    REM Terminate program
    CALL INT 32
    
    CALL LABEL String
    REM     H  e   l   l   o   ,     w
    CALL DB 72 101 108 108 111 44 32 119
    REM     o   r   l   d   !  $
    CALL DB 111 114 108 100 33 36
