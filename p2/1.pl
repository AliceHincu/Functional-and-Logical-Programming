% 1. 
% a. Sort a list with removing the double values. E.g.: [4 2 6 2 3 4] --> [2 3 4 6]
% b. For a heterogeneous list, formed from integer numbers and list of numbers, write a predicate to sort every sublist with removing the doubles.
% Eg.: [1, 2, [4, 1, 4], 3, 6, [7, 10, 1, 3, 9], 5, [1, 1, 1], 7] =>[1, 2, [1, 4], 3, 6, [1, 3, 7, 9, 10], 5, [1], 7].

%  1 2 3 4 5 6 
% [4 2 6 2 3 4] --> [2 3 4 6]
% []
% a
% 
% =============== HELPER FUNCTIONS =================
% Mathematical model
% length(l1l2..ln) = 
%   { 0, if n=0
% 	{ 1 + length(l2...ln) , otherwise
len([], 0).
len([_|T], NewR):-
    length(T, R),
    NewR is R + 1.

% Mathematical model
% append(l1l2...ln, elem) = 
%   { elem, if n = 0
%   { l1 U append(l2...ln, elem), otherwise
append([], E, [E]).
append([H|T], E, [H|R]):-
    append(T, E, R).

% =============== SORTING =================

% [4 2 6 2 3 4] -> [4 2 6], [2, 3, 4]
% [4 2 6 2 3 4] -> right = [2 6 2 3 4] left = [4]  => right = [6 2 3 4]  left = [4 2] => right = [2 3 4]  left [4 2 6]
%split(a1a2..an, l1l2..lm):-
%	{ [a1...an, l1...lm] if m-n = 0 or m-n = 1
%   { split(a2...an, l1l2...lm U a1), otherwise
%
% flow : (i, i, o, o)
% lista initiala devine right 
split([H|T], Left, Left, [H|T]):-
    len(Left, LengthLeft),
    len([H|T], LengthRight),
    Diff is LengthLeft-LengthRight,
    Diff =< 1,
    Diff >= 0,
    !.
    
split([H|T], Left, ResLeft, ResRight):-
    append(Left, H, NewLeft),
    split(T, NewLeft, ResLeft, ResRight).

splitMain([H|T], ResLeft, ResRight):-
    split([H|T], [], ResLeft, ResRight).

%
% Mathematical model
% merge(l1l2..ln, r1r2..rm) =
%   { l1l2..ln, m = 0
%   { r1r2..rm, n = 0
%   { l1 U merge(l2..ln, r1r2..rm), if l1 < r1
%   { r1 U merge(l1l2..ln, r2..rm), if r1 <= l1
myMerge(Left, [], Left):- !.
myMerge([], Right, Right):- !.
myMerge([HLeft|TLeft], [HRight|TRight], [HLeft|R]):-
    HLeft < HRight, !,
    myMerge(TLeft, [HRight|TRight], R).
myMerge([HLeft|TLeft], [HRight|TRight], [HRight|R]):-
    HLeft >= HRight,
    myMerge([HLeft|TLeft], TRight, R).

% Mathematical model 
% merge_sort(l1l2...ln, left, right)= 
%	{  [], n=0
%   {  [l1], n=1
%   {  merge(merge_sort(l1...l(n/2)), merge_sort(l(n/2+1)...ln)), otherwise 

merge_sort([], []):-!.
merge_sort([E], [E]):-!.
merge_sort([H|T], R):-
    splitMain([H|T], Left, Right),
	merge_sort(Left, SortedLeft),
	merge_sort(Right, SortedRight),
	myMerge(SortedLeft, SortedRight, R).


% =============== REMOVING =================
% Mathematical model
% removeDuplicatesSorted(l1l2...ln) =
%   { [], if n = 0
%   { [l1], if n = 1
%   { removeDuplicatesSorted(l2..ln) , if l1 = l2
%   { l1 U removeDuplicatesSorted(l2..ln), if l1 != l2

removeDuplicatesSorted([], []):-!.
removeDuplicatesSorted([E], [E]):-!.
removeDuplicatesSorted([H,H|T], R):-
    !,
    removeDuplicatesSorted([H|T], R).
removeDuplicatesSorted([H1,H2|T], [H1|R]):-
    removeDuplicatesSorted([H2|T], R).

% =============== MAIN =================
% Mathematical model:
% sortRemoveDoublesList(L) = removeDuplicatesSorted(merge_sort(L))
sortRemoveDoublesList(L, R):-
    merge_sort(L, RSorted),
    removeDuplicatesSorted(RSorted, R).

%b For a heterogeneous list, formed from integer numbers and list of numbers, write a predicate to sort every sublist with removing the doubles.
%Eg.: [1, 2, [4, 1, 4], 3, 6, [7, 10, 1, 3, 9], 5, [1, 1, 1], 7] =>[1, 2, [1, 4], 3, 6, [1, 3, 7, 9, 10], 5, [1], 7].

% Mathematical model:
% mainB(l1l2..ln) = 
%   { [], if n=0
%   { l1 U mainB(l2..ln), if l1 is not list
%   { sortRemoveDoublesList(l1) U mainB(l2..ln),if l2 is list

mainB([], []):- !.
mainB([H|T], [RezH|R]):-
    is_list(H), !,
    sortRemoveDoublesList(H, RezH),
    mainB(T, R).
mainB([H|T], [H|R]):-
    mainB(T, R).
    
