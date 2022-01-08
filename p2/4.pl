% 4.a. Write a predicate to determine the sum of two numbers written in list representation.
% [9, 1, 4] [9, 1, 0, 0] => [1, 0, 0, 1, 4]l1=2  l2=4  => contor lungime?? contor rest?? [rest|R]

% Mathematical model
% addZeros(l1l2...ln, counter) =
%	{ l1l2...ln, if counter = 0
%	{ 0 U addZeros(l1l2..ln, counter-1), if counter != 0

addZeros(L, 0, L):- !.
addZeros(L, C, [0|R]):-
    CNew is C-1,
    addZeros(L, CNew, R).

sumListNumbers([H1], [H2], Rest, [Digit]):-
    Rest is (H1+H2) div 10, !,
    Digit is (H1+H2) mod 10.
sumListNumbers([H1|T1], [H2|T2], NewRest, [NewDigit|R1]):-
    sumListNumbers(T1, T2, Rest, R1),
    NewRest is (H1 + H2 + Rest) div 10,
    NewDigit is (H1 + H2 + Rest) mod 10.
sumListNumbersMain(Nr1, Nr2, [Rest|R1]):-
    sumListNumbers(Nr1, Nr2, Rest, R1),
    Rest =:= 1, !. 
sumListNumbersMain(Nr1, Nr2, R1):-
    sumListNumbers(Nr1, Nr2, _, R1).


% Mathematical model
% length(l1l2..ln) = 
%   { 0, if n=0
% 	{ 1 + length(l2...ln) , otherwise
len([], 0).
len([_|T], NewR):-
    len(T, R),
    NewR is R + 1.

% Mathematical model
% makeLengthEqual(l1l2..ln, p1p2...pm) =
%   {[addZeros(l1l2..ln, m-n), p1p2...pm],if n < m
%   {[l1l2...ln, addZeros(p1p2..pm, n-m)],if m <= n
makeLengthEqual(Nr1, Nr2, NewNr1, Nr2):-
    len(Nr1,N),
    len(Nr2, M),
    N < M, !,
    Diff is M-N,
    addZeros(Nr1, Diff, NewNr1).
makeLengthEqual(Nr1, Nr2, Nr1, NewNr2):-
    len(Nr1,N),
    len(Nr2, M),
    Diff is N-M,
    addZeros(Nr2, Diff, NewNr2).

mainA(Nr1,Nr2,R):-
    makeLengthEqual(Nr1,Nr2,NewNr1,NewNr2),
    sumListNumbersMain(NewNr1, NewNr2, R).

% b. For a heterogeneous list, formed from integer numbers and list of digits, write a predicate to compute the sum of all numbers represented as sublists.
% Eg.: [1, [2, 3], 4, 5, [6, 7, 9], 10, 11, [1, 2, 0], 6] => [8, 2, 2].

% Mathematical model
% sumLists(l1l2...ln, r1r2...rm) =
%   { r1r2...rm, if n = 0
%   { mainB(l2...ln, mainA(l1, r1r2...rm)), if l1 is list
%	{
sumLists([], Number, Number):-!.
sumLists([H|T], Number, R):-
    is_list(H), !,
    mainA(H, Number, NewNumber),
    sumLists(T, NewNumber, R).
sumLists([_|T], Number, R):-
    sumLists(T, Number, R).
mainB([H|T], R):-
    sumLists([H|T], [0], R).
