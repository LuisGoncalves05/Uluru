# Uluru

A small Uluru puzzle solver written in Prolog.

## Features

- Solves Uluru logic puzzles
- Returns all possible solutions

## How to Run

### Requirements
- swipl

### Compile

`swipl -o uluru -c project.pl`

### Run

`./uluru`

### Example Usage
```bash
./uluru
?- example(1, _E), solve(_E, Solutions).
_E = [next_to(white, orange), next_to(black, black), across(yellow, orange), next_to(green, yellow), position(blue, [1, 2, 6]), across(yellow, blue)],
Solutions = [yellow, green, white, orange, black, blue] ;
_E = [next_to(white, orange), next_to(black, black), across(yellow, orange), next_to(green, yellow), position(blue, [1, 2, 6]), across(yellow, blue)],
Solutions = [yellow, green, black, orange, white, blue] .
```
