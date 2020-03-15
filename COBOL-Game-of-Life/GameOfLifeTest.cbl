*> Your task is to write a program to calculate the next
*> generation of Conway's game of life, given any starting
*> position.

*> You start with a two dimensional grid of cells, where
*> each cell is either alive or dead. The grid is finite,
*> and no life can exist off the edges. When calculating
*> the next generation of the grid, follow these four rules:

*> 1. Any live cell with fewer than two live neighbours
   *> dies, as if caused by underpopulation.
*> 2. Any live cell with more than three live neighbours
   *> dies, as if by overcrowding.
*> 3. Any live cell with two or three live neighbours
   *> lives on to the next generation.
*> 4. Any dead cell with exactly three live neighbours
   *> becomes a live cell.

*> Examples: * indicates live cell, . indicates dead cell

*> Example input: (4 x 8 grid)
*> 4 8
*> ........
*> ....*...
*> ...**...
*> ........

*> 4,2: 5,2 4,3 5,3

*> Example output:
*> 4 8
*> ........
*> ...**...
*> ...**...
*> ........

identification division.
program-id. GameOfLifeTest.

environment division.
*> configuration section.
    *> repository.
        *> function LifeGrid.

data division.
working-storage section.
    01 LifeGrid.
        02 StartingGrid pic x(32) value "............*......**...........".
        02 filler redefines StartingGrid.
            03 GridRow occurs 4 times.
                04 GridColumn occurs 8 times.
                       05 Cell pic x.

    01 OutputRow pic 9.
    01 OutputColumn pic 9.

procedure division.

    display "Starting grid:"
    perform DisplayGrid

    call "GameOfLife" using by reference StartingGrid.

    display "Resulting grid after one iteration:"
    perform DisplayGrid

    call "AssertEquals" using StartingGrid, "...........**......**...........", "Next iteration correct"

    stop run
.

DisplayGrid section.
    perform with test after varying OutputRow from 1 by 1 until OutputRow is equal to 4
        display GridRow(OutputRow)
    end-perform
.



end program GameOfLifeTest.
