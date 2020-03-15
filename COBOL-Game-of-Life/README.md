# Conway's Game of Life - solution in COBOL

You start with a two dimensional grid of cells, where
each cell is either alive or dead. The grid is finite,
and no life can exist off the edges. When calculating
the next generation of the grid, follow these four rules:

You start with a two dimensional grid of cells, where
each cell is either alive or dead. The grid is finite,
and no life can exist off the edges. When calculating
the next generation of the grid, follow these four rules:


1. Any live cell with fewer than two live neighbours
   dies, as if caused by underpopulation.
2. Any live cell with more than three live neighbours
   dies, as if by overcrowding.
3. Any live cell with two or three live neighbours
   lives on to the next generation.
4. Any dead cell with exactly three live neighbours
   becomes a live cell.

Examples: * indicates live cell, . indicates dead cell

Example input: (4 x 8 grid)
4 8
........
....*...
...**...
........

Example output:
4 8
........
...**...
...**...
........

To compile and run it using GnuCOBOL (version 1.x or 2.x), you'll also need the AssertEquals subprogram from [COBOL-Test-Suite](https://github.com/mikebharris/COBOL-Test-Suite) compiled and in your COBOL library path somewhere.

```
$ cobc -x -free GameOfLifeTest.cbl GameOfLife.cbl ../../COBOL-Test-Suite/AssertEquals.cbl
$ ./GameOfLifeTest
Starting grid:
........
....*...
...**...
........
Resulting grid after one iteration:
........
...**...
...**...
........
Passed: Next iteration correct
$
```
