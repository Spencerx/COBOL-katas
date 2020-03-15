identification division.
program-id. GameOfLife.

environment division.
configuration section.
    special-names.
        class IsLiveCell is "*".
        class IsDeadCell is ".".

data division.
working-storage section.
    01 CurrentColumn pic 9.
    01 CurrentRow pic 9.


    01 NumberOfAdjacentLiveCells pic 9.
    01 EvaluationColumnStart pic 9.
    01 EvaluationColumnEnd pic 9.
    01 EvaluationRowStart pic 9.
    01 EvaluationRowEnd pic 9.

    01 ColumnInEvaluation pic 9.
    01 RowInEvaluation pic 9.

    01 ThisGrid.
        02 GridRow occurs 4 times.
            03 GridColumn occurs 8 times.
                04 ThisCell pic x.
                    88 LiveCell value "*".
                    88 DeadCell value ".".

    01 NextGrid.
        02 GridRow occurs 4 times.
            03 GridColumn occurs 8 times.
                04 NextCell pic x.
                    88 NextLiveCell value "*".
                    88 NextDeadCell value ".".

linkage section.
    01 InputGrid pic x(32).

procedure division using InputGrid.
    move InputGrid to ThisGrid.
    perform with test after varying CurrentColumn from 1 by 1 until CurrentColumn is equal to 8
        perform with test after varying CurrentRow from 1 by 1 until CurrentRow is equal to 4

            move 0 to NumberOfAdjacentLiveCells
            if CurrentColumn is greater than 1 and CurrentColumn is less than 8 and
                CurrentRow is greater than 0 and CurrentRow is less than 4 then

                subtract 1 from CurrentColumn giving EvaluationColumnStart
                add 1 to CurrentColumn giving EvaluationColumnEnd

                perform with test after varying ColumnInEvaluation from EvaluationColumnStart by 1
                    until ColumnInEvaluation is equal to EvaluationColumnEnd

                            subtract 1 from CurrentRow giving EvaluationRowStart
                            add 1 to CurrentRow giving EvaluationRowEnd

                            perform with test after varying RowInEvaluation from EvaluationRowStart by 1
                                until RowInEvaluation is equal to EvaluationRowEnd

                                 if LiveCell(RowInEvaluation,ColumnInEvaluation) then

                                    if RowInEvaluation is equal to CurrentRow and ColumnInEvaluation is equal to CurrentColumn then
                                   else
                                        add 1 to NumberOfAdjacentLiveCells
                                    end-if

                                end-if
                            end-perform
                end-perform
            end-if

            *> set to live or dead
            evaluate true also NumberOfAdjacentLiveCells
                when ThisCell(CurrentRow, CurrentColumn) is IsLiveCell also less than 2
                    set NextDeadCell(CurrentRow, CurrentColumn) to true
                when LiveCell(CurrentRow, CurrentColumn) also greater than 3
                    set NextDeadCell(CurrentRow, CurrentColumn) to true
                when LiveCell(CurrentRow, CurrentColumn) also equal to 2 or equal to 3
                    set NextLiveCell(CurrentRow, CurrentColumn) to true
                when DeadCell(CurrentRow, CurrentColumn) also equal to 3
                    set NextLiveCell(CurrentRow, CurrentColumn) to true
                when other
                    if LiveCell(CurrentRow, CurrentColumn) then
                        set NextLiveCell(CurrentRow, CurrentColumn) to true
                    else
                        set NextDeadCell(CurrentRow, CurrentColumn) to true
                    end-if
            end-evaluate

        end-perform
    end-perform

    move NextGrid to InputGrid.

    goback.
end program GameOfLife.
