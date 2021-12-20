% 5.
% a. Write a predicate to compute the union of two sets.
% b. Write a predicate to determine the set of all the pairs of elements in a list.
% Eg.: L = [a b c d] => [[a b] [a c] [a d] [b c] [b d] [c d]].

% a. Write a predicate to compute the union of two sets.
% a = [1, 2, 3, 6], b = [2, 5, 7, 9, 1] => [1, 2, 3, 5, 6, 7, 9]

% Model matematic:
% search(l1l2...ln, e) = 
%     { false, if n = 0
%     { true, if l1 = e
%     { search(l2...ln), otherwise
% search(L: List, E: number), flow-> search(i,i)

search([H|_], E):-
    H =:= E.
search([_|T], E):-
    search(T, E).
% search([2,3,4,5,6,6,6,8], 10)

% Model matematic:
% uniune(l1l2...ln, p1p2...pm) = 
%     { p1p2...pm, if n = 0
%     { uniune(l2...ln, p1p2...pm), if search(p1...pm, l1) = true
%     { l1 U uniune(l2...ln, p1p2...pm), if  search(p1...pm, l1) = false

uniune([], P, P).
uniune([H|T], P, R):-
    search(P, H),
    !,
    uniune(T, P, R).
uniune([H|T], P, [H|R]):-
    uniune(T, P, R).
% uniune([1, 2, 3, 6], [2, 5, 7, 9, 1], R)


% b. Write a predicate to determine the set of all the pairs of elements 
% in a list.
% Eg.: L = [a b c d] => [[a b] [a c] [a d] [b c] [b d] [c d]].
% [[a, b], [a, c], [a, d], [b, c], [b, d], [c, d]], R

% makeElementPairs(l1l2...ln, E) = 
%     { [], if n=0
%     { [E, l1] U makeElementPairs(l2..ln, E), otherwise
% makeElementPairs(L:List, E:Element)

makeElementPairs([], _, []).
makeElementPairs([H|T], E, [[E,H]|R]):-
    makeElementPairs(T, E, R).
% makeElementPairs([b,c,d], a, R)

% Mathematical model:
% makePairs(l1l2...ln) =
%     { [], if n=0 
%     { [l1, l2], if n=1
%     { makeElementPairs(l2..ln, l1) U makePairs(l2..ln), if n !=1 
% makePairs(L:List, R:List), flow -> makePairs(i,o)

makePairs([], []).
makePairs([E1, E2], [[E1, E2]]):- !.
makePairs([H|T], [Pairs|R]):-
    makeElementPairs(T, H, Pairs),
    makePairs(T, R).
    
    
    
