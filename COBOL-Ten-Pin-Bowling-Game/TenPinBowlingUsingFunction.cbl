*> Write a program to score a game of Ten-Pin Bowling.

*> Input: string (described below) representing a bowling game
*> Ouput: integer score

*> The scoring rules:

*> Each game, or "line" of bowling, includes ten turns,
*> or "frames" for the bowler.

*> In each frame, the bowler gets up to two tries to
*> knock down all ten pins.

*> If the first ball in a frame knocks down all ten pins,
*> this is called a "strike". The frame is over. The score
*> for the frame is ten plus the total of the pins knocked
*> down in the next two balls.

*> If the second ball in a frame knocks down all ten pins,
*> this is called a "spare". The frame is over. The score
*> for the frame is ten plus the number of pins knocked
*> down in the next ball.

*> If, after both balls, there is still at least one of the
*> ten pins standing the score for that frame is simply
*> the total number of pins knocked down in those two balls.

*> If you get a spare in the last (10th) frame you get one
*> more bonus ball. If you get a strike in the last (10th)
*> frame you get two more bonus balls.
*> These bonus throws are taken as part of the same turn.
*> If a bonus ball knocks down all the pins, the process
*> does not repeat. The bonus balls are only used to
*> calculate the score of the final frame.

*> The game score is the total of all frame scores.

*> Examples:

*> X indicates a strike
*> / indicates a spare
*> - indicates a miss
*> | indicates a frame boundary
*> The characters after the || indicate bonus balls

*> X|X|X|X|X|X|X|X|X|X||XX
*> Ten strikes on the first ball of all ten frames.
*> Two bonus balls, both strikes.
*> Score for each frame == 10 + score for next two
*> balls == 10 + 10 + 10 == 30
*> Total score == 10 frames x 30 == 300

*> 9-|9-|9-|9-|9-|9-|9-|9-|9-|9-||
*> Nine pins hit on the first ball of all ten frames.
*> Second ball of each frame misses last remaining pin.
*> No bonus balls.
*> Score for each frame == 9
*> Total score == 10 frames x 9 == 90

*> 5/|5/|5/|5/|5/|5/|5/|5/|5/|5/||5
*> Five pins on the first ball of all ten frames.
*> Second ball of each frame hits all five remaining
*> pins, a spare.
*> One bonus ball, hits five pins.
*> Score for each frame == 10 + score for next one
*> ball == 10 + 5 == 15
*> Total score == 10 frames x 15 == 150

*> X|7/|9-|X|-8|8/|-6|X|X|X||81
*> Total score == 167

identification division.
program-id. TenPinBowling.

environment division.
configuration section.
    repository.
        function CalculateScoreFromScorecard.

data division.
working-storage section.

01 ScoreCardsTable.
    02 ScoreCardsValues.
        03 filler pic x(36) value "X|X|X|X|X|X|X|X|X|X||XX          300".
        03 filler pic x(36) value "5/|5/|5/|5/|5/|5/|5/|5/|5/|5/||5 150".
        03 filler pic x(36) value "9-|9-|9-|9-|9-|9-|9-|9-|9-|9-||  090".
        03 filler pic x(36) value "X|7/|9-|X|-8|8/|-6|X|X|X||81     167".
    02 filler redefines ScoreCardsValues.
        03 ScoreCards occurs 4 times.
            04 TestScoreCard pic x(33).
            04 ExpectedScore pic 999.

01 CurrentScoreCard pic 9.
01 ReturnedScore pic 999 value zero.

procedure division.

    perform with test after varying CurrentScoreCard from 1 by 1
        until CurrentScoreCard equal to 4

        display "Test score card " CurrentScoreCard " is " TestScoreCard(CurrentScoreCard)

        compute ReturnedScore = CalculateScoreFromScorecard(TestScoreCard(CurrentScoreCard))

        if ReturnedScore equal to ExpectedScore(CurrentScoreCard) then
            display "Test score card " CurrentScoreCard " result of " ReturnedScore " matches expected... Test passed"
        else
            display "Test score card " CurrentScoreCard " result of " ReturnedScore " does not match "
                ExpectedScore(CurrentScoreCard) " ... Test failed"
        end-if
        display spaces
    end-perform

    stop run.

end program TenPinBowling.
