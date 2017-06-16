# Towers of Hanoi

This was my first experiment with TLA+, after watching the video
lectures by Leslie Lamport: http://lamport.azurewebsites.net/video/videos.html

What I found most interesting was how it forces you to think about the
problem.  With TLA+, you start by asking "how do I describe this
system?" instead of "how do I solve this problem?".

Solution feels a bit crude, but was surprised how easy it was to get
started with TLA+.  Most of the work was was just figuring out syntax.
The first thing I got tripped up on was thinking procedurally, instead
of thinking in states / state transitions.  I originally had this
definition:

```
Init ==
/\ left = <<1, 2, 3>>
/\ middle = <<>>
/\ right = <<>>

LeftToMiddle == /\ Len(left) > 0
/\ Head(left) < Head(middle)
/\ left' = Tail(left)
/\ middle' = <<Head(left)>> \o middle
/\ right' = right
```

But got the error `Attempted to apply Head to the empty sequence.`.
Ahh, makes sense, let's change the one line to:

```
/\ (Len(middle) > 0 \/ Head(left) < Head(middle))
```

... thinking that the left side would short-circuit the right side.
But there's no short-circuiting in a mathematical statement like that!
`or` is commutative, so it's equivalent to `(Head(left) <
Head(middle) \/ Len(middle) > 0)`

One way to solve it would be to create two separate states: one for
when the middle is empty and one for when it's not, but that felt a
bit verbose.

Eventually I settled on having the "base" of the towers be larger than
any of the discs:

```
Init ==
/\ left = <<1, 2, 3, 100>>
/\ middle = <<>>
/\ right = <<>>

LeftToMiddle == /\ Len(left) > 1
/\ Head(left) < Head(middle)
/\ left' = Tail(left)
/\ middle' = <<Head(left)>> \o middle
/\ right' = right
```

Is the solution always to create degenerate base cases like this?
Maybe there's a better way...
