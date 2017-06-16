------------------------------- MODULE hanoi -------------------------------
EXTENDS Integers, Sequences

VARIABLES left, middle, right



Init ==
/\ left = <<1, 2, 3, 4, 5, 6, 7, 100>>
/\ middle = <<100>>
/\ right = <<100>>

LeftToMiddle == /\ Len(left) > 1
/\ Head(left) < Head(middle)
/\ left' = Tail(left)
/\ middle' = <<Head(left)>> \o middle
/\ right' = right

LeftToRight== /\ Len(left) > 1
/\ Head(left) < Head(right)
/\ left' = Tail(left)
/\ middle' = middle
/\ right' = <<Head(left)>> \o right

MiddleToLeft == /\ Len(middle) > 1
/\ Head(middle) < Head(left)
/\ left' = <<Head(middle)>> \o left
/\ middle' = Tail(middle)
/\ right' = right

MiddleToRight == /\ Len(middle) > 1
/\ Head(middle) < Head(right)
/\ left' = left
/\ middle' = Tail(middle)
/\ right' = <<Head(middle)>> \o right

RightToMiddle == /\ Len(right) > 1
/\ Head(right) < Head(middle)
/\ left' = left
/\ middle' = <<Head(right)>> \o middle
/\ right' = Tail(right)

RightToLeft== /\ Len(right) > 1
/\ Head(right) < Head(left)
/\ left' = <<Head(right)>> \o left
/\ middle' = middle
/\ right' = Tail(right)

Next == \/ LeftToMiddle
\/ MiddleToLeft
\/ MiddleToRight
\/ RightToMiddle
\/ RightToLeft
\/ LeftToRight

=============================================================================
