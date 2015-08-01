# Dice Simulator
Dice Game simulator in Julia and C.

This is a simulator used to generate random dice for the [Reddit r/math dice game](https://www.reddit.com/r/math/comments/3eytm1/nontransitive_dice_an_rmath_conpetition/)

I chose to write this using a mix of C and Julia as an excercise in learning both languages.

# Requirements

Requires [Julia](http://julialang.org/) and gcc.

# Usage

Build the C library with `make build`

Run (default 8 cores) with `make run` or `julia -p n driver.jl` where `n` is the number of cores on your computer.
