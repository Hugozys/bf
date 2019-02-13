# An interpreter for BrainF****
This is a simple interpreter writen in SML. The main purpose of this program is to sharpen my functional programming skill for my course project ECE553 Compiler Construction, namely implementing a tiger compiler in SML.

# Files
The repository contains one SML source file and a bunch of brainf**** programs in directory `./bsrc` to check the correctness of the interpreter.

# How To Run
We will use `mlton -- a whole-program compiler for SML` to compile the sml code into binary executable. The interpreter has been compiled and tested on Ubuntu 18.04 Linux Distro. You need to have the following prerequisites installed on your Linux Machine:

* smlnj
* mlton

Type `sudo apt install -y smlnj mlton` on your terminal to get them installed.

Run `mlton bfsml.sml`. The mlton will generate a binary executable called bfsml. You could execute bf program by typing 

`./bfsml <filename>`



# Acknowledgement

The idea was inspired by my classmate Rui Zhang who wrote an interpreter for BrainF**** in Tex. Special thanks for all the bf testing programs provided by him. You could find his C version implementation [here](https://github.com/z-rui/bf) and Go version implementation [here](https://github.com/z-rui/bfgo)
