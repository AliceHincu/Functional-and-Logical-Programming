% 3.
% a. Define a predicate to remove from a list all repetitive elements.
% Eg.: l=[1,2,1,4,1,3,4] => l=[2,3])
% b. Remove all occurrences of a maximum value from a list on integer numbers.

% a.
% nrOcc(l1l2...ln, e) = { 0, if n = 0
%			{ 1 + nrOcc(l2...ln, e), if l1 = e
%			{ nrOcc(l2...ln, e), otherwise
%
nrOcc([], _, 0).
nrOcc([H|T], E, R):-
    H =:= E,
    nrOcc(T, E, R1),
    R is R1 + 1.
nrOcc([H|T], E, R):-
    H =\= E,
    nrOcc(T, E, R).

% removeElement(l1l2...ln, e) = { [], if n = 0
% 				{ l1 U removeElement(l2...ln, e), if l1 != e
%				{ removeElement(l2...ln, e), otherwise
%
removeElement([], _, []).
removeElement([H|T], E, [H|R]):-
    H =\= E,
    removeElement(T, E, R).
removeElement([H|T], E, R):-
    H =:= E,
    removeElement(T, E, R).

% repetitiveElem(l1l2...ln) = 
%       { [], if n = 0
%	{ repetitiveElem(removeElement(l1l2...ln, l1)) , if nrOcc(l2..ln, l1) > 0
%   	{ l1 U repetitiveElem(l2...ln), otherwise}
%

repetitiveElem([], []).
repetitiveElem([H|T], R):-
    nrOcc(T, H, NrOccHead),
    NrOccHead > 0,
    removeElement([H|T], H, NewList),
	repetitiveElem(NewList, R).
repetitiveElem([H|T],[H|R]):-
    nrOcc(T, H, NrOccHead),
    NrOccHead =:= 0,
    repetitiveElem(T, R).

% b. Remove all occurrences of a maximum value from a list on integer numbers.

% maximum(a, b) = { a, a>b
%		  { b, b>=a
%					   
maximum(A, B, A):-
    A > B.
maximum(A, B, B):- 
    B >= A.

% maximumList(l1l2...ln) = { l1, if n=1
% 			   { maximum(maximumList(l2...ln), l1), otherwise

maximumList([E], E).
maximumList([H|T], Max):-
    maximumList(T, Max1),
    maximum(H, Max1, Max).

% removeMaxOcc(l1l2...ln) = removeElement(L1L2..LN, maximumList(l1l2..ln))

removeMaxOcc([H|T], R):-
    maximumList([H|T], Max),
    removeElement([H|T], Max, R).

% removeMaxOcc([1,6,1,1,3,3,6,3,6,1], R)
