# Demonstrate the basic use of sz80

`sz80` is a Z80 simulator that is part of the `sdcc` compiler tools.

`z80asm` is a simple Z80 assembler. Simpler, that is than the `sdasz80` assembler
that is part of the `sdcc` compiler tools.

This project demonstrates how to assemble a program using `z80asm` and 
execute it using `sz80` such that its instructions can be analyzed.

Use `make` to assemble the file and convert the binary file into an
Intel hex file recognized by the simulator:

```
~/Z80-assembly-intro/hello$ make
z80asm hello.asm -o hello.bin --list=hello.lst
objcopy -I binary -O ihex hello.bin hello.hex
rm hello.bin
~/Z80-assembly-intro/hello$ 
```

Run the simulator on the hex file like this:

```
sz80 hello.hex
```

The simulator will display its startup messages and a command prompt:

```
uCsim 0.5.4, Copyright (C) 1997 Daniel Drotos, Talker Bt.
uCsim comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
This is free software, and you are welcome to redistribute it
under certain conditions; type `show c' for details.
264 words read from hello.hex
0> 
```

Getting help for some useful commands for observing the execution of a program:

```
0> help dc
dch [start [stop]] Dump code in hex form
dc [start [stop]]  Dump code in disass form
0> help dch
dch [start [stop]] Dump code in hex form
Names of command: dch
long help of dch
0> help state
state              State of microcontroller
Names of command: state
long help of state
0> help step
step               Step
Names of command: s step
long help of step
0> 
```

Examples:

```
dch 0 0x100 16
dc
state
info registers
step
step
step
step
```

Note that pressing `enter` will repeat the last command.

Here is the output fromt he simulator when running the above commands:

```
~/Z80-assembly-intro/hello$ sz80 hello.hex
uCsim 0.5.4, Copyright (C) 1997 Daniel Drotos, Talker Bt.
uCsim comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
This is free software, and you are welcome to redistribute it
under certain conditions; type `show c' for details.
264 words read from hello.hex
0> dch 0 0x100 16
0x0000 3e ab 06 10 80 c3 04 00 00 00 00 00 00 00 00 00 >...............
0x0010 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
0x0020 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
0x0030 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
0x0040 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
0x0050 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
0x0060 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
0x0070 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
0x0080 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
0x0090 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
0x00a0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
0x00b0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
0x00c0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
0x00d0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
0x00e0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
0x00f0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
0x0100 00                                              .
0> dc
 ? 0x0000 3e ab       LD    A,#0xab
 ? 0x0002 06 10       LD    b,#0x10
 ? 0x0004 80          ADD   A,B
 ? 0x0005 c3 04 00    JP    #0x0004
 ? 0x0008 00          NOP
 ? 0x0009 00          NOP
 ? 0x000a 00          NOP
 ? 0x000b 00          NOP
 ? 0x000c 00          NOP
 ? 0x000d 00          NOP
 ? 0x000e 00          NOP
 ? 0x000f 00          NOP
 ? 0x0010 00          NOP
 ? 0x0011 00          NOP
 ? 0x0012 00          NOP
 ? 0x0013 00          NOP
 ? 0x0014 00          NOP
0> state
CPU state= OK PC= 0x000000 XTAL= 1.10592e+07
Total time since last reset= 0 sec (0 clks)
Time in isr = 0 sec (0 clks)   0%
Time in idle= 0 sec (0 clks)   0%
Max value of stack pointer= 0x000000, avg= 0x000000
0> info registers
SZ-A-PNC  Flags= 0x00   0 .  A= 0x00   0 .
00-0-000
BC= 0x0000 [BC]= 3e  62 >  DE= 0x0000 [DE]= 3e  62 >  HL= 0x0000 [HL]= 3e  62 >
IX= 0x0000 [IX]= 3e  62 >  IY= 0x0000 [IY]= 3e  62 >  SP= 0x0000 [SP]= 3e  62 >
 ? 0x0000 3e ab       LD    A,#0xab
0> step
SZ-A-PNC  Flags= 0x00   0 .  A= 0xab 171 .
00-0-000
BC= 0x0000 [BC]= 3e  62 >  DE= 0x0000 [DE]= 3e  62 >  HL= 0x0000 [HL]= 3e  62 >
IX= 0x0000 [IX]= 3e  62 >  IY= 0x0000 [IY]= 3e  62 >  SP= 0x0000 [SP]= 3e  62 >
 ? 0x0002 06 10       LD    b,#0x10
0> step
SZ-A-PNC  Flags= 0x00   0 .  A= 0xab 171 .
00-0-000
BC= 0x1000 [BC]= b1 177 .  DE= 0x0000 [DE]= 3e  62 >  HL= 0x0000 [HL]= 3e  62 >
IX= 0x0000 [IX]= 3e  62 >  IY= 0x0000 [IY]= 3e  62 >  SP= 0x0000 [SP]= 3e  62 >
 ? 0x0004 80          ADD   A,B
0> step
SZ-A-PNC  Flags= 0x80 128 .  A= 0xbb 187 .
10-0-000
BC= 0x1000 [BC]= b1 177 .  DE= 0x0000 [DE]= 3e  62 >  HL= 0x0000 [HL]= 3e  62 >
IX= 0x0000 [IX]= 3e  62 >  IY= 0x0000 [IY]= 3e  62 >  SP= 0x0000 [SP]= 3e  62 >
 ? 0x0005 c3 04 00    JP    #0x0004
0> step
SZ-A-PNC  Flags= 0x80 128 .  A= 0xbb 187 .
10-0-000
BC= 0x1000 [BC]= b1 177 .  DE= 0x0000 [DE]= 3e  62 >  HL= 0x0000 [HL]= 3e  62 >
IX= 0x0000 [IX]= 3e  62 >  IY= 0x0000 [IY]= 3e  62 >  SP= 0x0000 [SP]= 3e  62 >
 ? 0x0004 80          ADD   A,B
0> step
SZ-A-PNC  Flags= 0x80 128 .  A= 0xcb 203 .
10-0-000
BC= 0x1000 [BC]= b1 177 .  DE= 0x0000 [DE]= 3e  62 >  HL= 0x0000 [HL]= 3e  62 >
IX= 0x0000 [IX]= 3e  62 >  IY= 0x0000 [IY]= 3e  62 >  SP= 0x0000 [SP]= 3e  62 >
 ? 0x0005 c3 04 00    JP    #0x0004
0> step
SZ-A-PNC  Flags= 0x80 128 .  A= 0xcb 203 .
10-0-000
BC= 0x1000 [BC]= b1 177 .  DE= 0x0000 [DE]= 3e  62 >  HL= 0x0000 [HL]= 3e  62 >
IX= 0x0000 [IX]= 3e  62 >  IY= 0x0000 [IY]= 3e  62 >  SP= 0x0000 [SP]= 3e  62 >
 ? 0x0004 80          ADD   A,B
0> step
SZ-A-PNC  Flags= 0x80 128 .  A= 0xdb 219 .
10-0-000
BC= 0x1000 [BC]= b1 177 .  DE= 0x0000 [DE]= 3e  62 >  HL= 0x0000 [HL]= 3e  62 >
IX= 0x0000 [IX]= 3e  62 >  IY= 0x0000 [IY]= 3e  62 >  SP= 0x0000 [SP]= 3e  62 >
 ? 0x0005 c3 04 00    JP    #0x0004
0> step
SZ-A-PNC  Flags= 0x80 128 .  A= 0xdb 219 .
10-0-000
BC= 0x1000 [BC]= b1 177 .  DE= 0x0000 [DE]= 3e  62 >  HL= 0x0000 [HL]= 3e  62 >
IX= 0x0000 [IX]= 3e  62 >  IY= 0x0000 [IY]= 3e  62 >  SP= 0x0000 [SP]= 3e  62 >
 ? 0x0004 80          ADD   A,B
0> step
SZ-A-PNC  Flags= 0x80 128 .  A= 0xeb 235 .
10-0-000
BC= 0x1000 [BC]= b1 177 .  DE= 0x0000 [DE]= 3e  62 >  HL= 0x0000 [HL]= 3e  62 >
IX= 0x0000 [IX]= 3e  62 >  IY= 0x0000 [IY]= 3e  62 >  SP= 0x0000 [SP]= 3e  62 >
 ? 0x0005 c3 04 00    JP    #0x0004
0> step
SZ-A-PNC  Flags= 0x80 128 .  A= 0xeb 235 .
10-0-000
BC= 0x1000 [BC]= b1 177 .  DE= 0x0000 [DE]= 3e  62 >  HL= 0x0000 [HL]= 3e  62 >
IX= 0x0000 [IX]= 3e  62 >  IY= 0x0000 [IY]= 3e  62 >  SP= 0x0000 [SP]= 3e  62 >
 ? 0x0004 80          ADD   A,B
0> step
SZ-A-PNC  Flags= 0x80 128 .  A= 0xfb 251 .
10-0-000
BC= 0x1000 [BC]= b1 177 .  DE= 0x0000 [DE]= 3e  62 >  HL= 0x0000 [HL]= 3e  62 >
IX= 0x0000 [IX]= 3e  62 >  IY= 0x0000 [IY]= 3e  62 >  SP= 0x0000 [SP]= 3e  62 >
 ? 0x0005 c3 04 00    JP    #0x0004
0> step
SZ-A-PNC  Flags= 0x80 128 .  A= 0xfb 251 .
10-0-000
BC= 0x1000 [BC]= b1 177 .  DE= 0x0000 [DE]= 3e  62 >  HL= 0x0000 [HL]= 3e  62 >
IX= 0x0000 [IX]= 3e  62 >  IY= 0x0000 [IY]= 3e  62 >  SP= 0x0000 [SP]= 3e  62 >
 ? 0x0004 80          ADD   A,B
0> step
SZ-A-PNC  Flags= 0x01   1 .  A= 0x0b  11 .
00-0-001
BC= 0x1000 [BC]= b1 177 .  DE= 0x0000 [DE]= 3e  62 >  HL= 0x0000 [HL]= 3e  62 >
IX= 0x0000 [IX]= 3e  62 >  IY= 0x0000 [IY]= 3e  62 >  SP= 0x0000 [SP]= 3e  62 >
 ? 0x0005 c3 04 00    JP    #0x0004
0> step
SZ-A-PNC  Flags= 0x01   1 .  A= 0x0b  11 .
00-0-001
BC= 0x1000 [BC]= b1 177 .  DE= 0x0000 [DE]= 3e  62 >  HL= 0x0000 [HL]= 3e  62 >
IX= 0x0000 [IX]= 3e  62 >  IY= 0x0000 [IY]= 3e  62 >  SP= 0x0000 [SP]= 3e  62 >
 ? 0x0004 80          ADD   A,B
0> step
SZ-A-PNC  Flags= 0x00   0 .  A= 0x1b  27 .
00-0-000
BC= 0x1000 [BC]= b1 177 .  DE= 0x0000 [DE]= 3e  62 >  HL= 0x0000 [HL]= 3e  62 >
IX= 0x0000 [IX]= 3e  62 >  IY= 0x0000 [IY]= 3e  62 >  SP= 0x0000 [SP]= 3e  62 >
 ? 0x0005 c3 04 00    JP    #0x0004
0> step
SZ-A-PNC  Flags= 0x00   0 .  A= 0x1b  27 .
00-0-000
BC= 0x1000 [BC]= b1 177 .  DE= 0x0000 [DE]= 3e  62 >  HL= 0x0000 [HL]= 3e  62 >
IX= 0x0000 [IX]= 3e  62 >  IY= 0x0000 [IY]= 3e  62 >  SP= 0x0000 [SP]= 3e  62 >
 ? 0x0004 80          ADD   A,B
0> step
SZ-A-PNC  Flags= 0x00   0 .  A= 0x2b  43 +
00-0-000
BC= 0x1000 [BC]= b1 177 .  DE= 0x0000 [DE]= 3e  62 >  HL= 0x0000 [HL]= 3e  62 >
IX= 0x0000 [IX]= 3e  62 >  IY= 0x0000 [IY]= 3e  62 >  SP= 0x0000 [SP]= 3e  62 >
 ? 0x0005 c3 04 00    JP    #0x0004
0> step
SZ-A-PNC  Flags= 0x00   0 .  A= 0x2b  43 +
00-0-000
BC= 0x1000 [BC]= b1 177 .  DE= 0x0000 [DE]= 3e  62 >  HL= 0x0000 [HL]= 3e  62 >
IX= 0x0000 [IX]= 3e  62 >  IY= 0x0000 [IY]= 3e  62 >  SP= 0x0000 [SP]= 3e  62 >
 ? 0x0004 80          ADD   A,B
0> quit
~/Z80-assembly-intro/hello$
```
