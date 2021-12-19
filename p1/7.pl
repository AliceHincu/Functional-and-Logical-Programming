% 7.
% a. Write a predicate to compute the intersection of two sets.
% 
% Mathematical model:
% nrOcc(l1l2..ln, e) = { 0, if n = 0
% 					   { 1 + nrOcc(l2...ln, e), if l1 = e
% 					   {nrOcc(l2...ln, e), otherwise
% nrOcc(L: List, E:Number, R: Number)... flow: nrOcc(i,i,o)
nrOcc([], _, 0).
nrOcc([E|T], E, R):-
    !,
    nrOcc(T, E, R1),
    R is R1 + 1.
nrOcc([_|T], E, R):-
    nrOcc(T, E, R).
% nrOcc([1,2,3,4,1,4, 1], 1, R)

% Mathematical model:
% intersection(l1l2...ln, p1p2...pm) = {[] , if n = 0
% 									   {l1 U intersection(l2...ln, p1p2..pm) , if nrOcc(p2p3...pn, l1) = 1
% 									   {intersection(l2...ln, p1p2..pm), otherwise
% intersection(L: List, P:List, R:List)
intersection([], _, []).
intersection([H|T], P, [H|R]):-
    nrOcc(P, H, NrOcc),
    NrOcc =:= 1, 
    !,
    intersection(T, P, R).
intersection([_|T], P, R):-
    intersection(T, P, R).
% intersection([1,2,5,4], [2, 3, 4, 9], R)

% b. Write a predicate to create a list (m, ..., n) of all integer numbers from the interval [m, n].
% 
% Mathematical model:
% createRangeList(m, n) = { [], if n>m
% 						  {	[n] , if m=n
% 						  { m U createRangeList(m+1, n) ,otherwise
% createRangeList(M: Number, N:Number, R:List) .... flow -> createRangeList(i,i,o)
createRangeList(M, N, []):-
    M > N,
    !.
createRangeList(M, N, [N]):-
    M =:= N, 
    !.
createRangeList(M, N, [M|R]):-
    NewM is M + 1,
    createRangeList(NewM, N, R).

% createRangeList(2, 8, R)
