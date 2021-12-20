% 11.
% a. Write a predicate to substitute an element from a list with another element in the list.
% b. Write a predicate to create the sublist (lm, …, ln) from the list (l1,…, lk).

% a. Write a predicate to substitute an element from a list with another element in the list.
% Mathematical model 
% substituteElement(l1l2...ln, elem, replacement) = 
%     { [], if n = 0
%     { replacement U substituteElement(l2...ln, elem, replacement), if l1 = elem
%     { l1 U substituteElement(l2...ln, elem, replacement), if l1 != elem
% substituteElement(L: List, E: Number, Replacement: Number, R: List) .... flow: substituteElement(i,i,i,o)

substituteElement([], _, _, []).
substituteElement([H|T], E, Replacement, [Replacement|R]):-
    H =:= E, !,
    substituteElement(T, E, Replacement, R).
substituteElement([H|T], E, Replacement, [H|R]):-
    H =\= E,
    substituteElement(T, E, Replacement, R).

% b. Write a predicate to create the sublist (lm, …, ln) from the list (l1,…, lk).
% Mathematical model
% createSublist(l1l2...ln, m, n, pos) = 
%      { false, if m > n or m < 1 or n < 1
%      { [l1] , if pos = n
%      { l1 U createSublist(l2...ln, m, n, pos+1), if m <= pos < n 
%      { createSublist(l2...ln, m, n, pos+1), if pos < m 
% createSublist(L: List, M: Number, N: Number, Pos: Number, R:List) ... flow:createSublist(i,i,i,i,o)

createSublist(_, M, N, _, []):- M >= N, !, fail.
createSublist([H|_], _,N, N, [H]):- !.
createSublist([H|T], M, N, Pos, [H|R]):- 
    M =< Pos, Pos < N, !,
    NewPos is Pos+1,
    createSublist(T, M, N, NewPos, R).
createSublist([_|T], M, N, Pos, R):- 
    NewPos is Pos+1,
    createSublist(T, M, N, NewPos, R).

createSublistMain(L, M, N, R):-
    createSublist(L, M, N, 1, R).

% createSublistMain([1,2,5,3,5,25,4,1], 5, 2, R) -> false
