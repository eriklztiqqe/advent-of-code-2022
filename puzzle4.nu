#! /usr/bin/env nu
open puzzle_input_4.txt | lines | parse "{a}-{b},{x}-{y}" | into int a b x y | where ($it.a <= $it.x and $it.b >= $it.y) or ($it.a >= $it.x and $it.b <= $it.y) | length 

open puzzle_input_4.txt | lines | parse "{a}-{b},{x}-{y}" | into int a b x y | where ($it.b >= $it.x and $it.a <= $it.y) or ($it.y >= $it.a and $it.x <= $it.b) | length 
