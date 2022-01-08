% 5. 
% a. Substitute all occurrencesof an element of a list with all the elementsof another list. 
% Eg. subst([1,2,1,3,1,4],1,[10,11],X) produces X=[10,11,2,10,11,3,10,11,4].

%a 
% [1,2,3,4] si inserez la inceput [2,3] => [2,3,1,2,3,4]
% Mathematical model
% inserare(l1l2...ln, list) = 
%   { list, if n = 0
%   { l1 U inserare(l2...ln, list), otherwise

inserare([], List, List).
inserare([H|T], List, [H|R]):-
    inserare(T, List, R).

% Mathematical model
% substitute(l1l2...ln, elem, list) =
%	{ [], if n = 0
%	{ substitute(inserare(list, l2...ln), elem, list), if l1 = elem
%	{ l1 U substitute(l2..ln, elem, list), otherwise

substitute([], _, _, []):- !.
substitute([H|T], Elem, List, R):-
    Elem =:= H, !,
    inserare(List, T, NewTail),
    substitute(NewTail, Elem, List, R).
substitute([H|T], Elem, List, [H|R]):-
    substitute(T, Elem, List, R).

%b 
% b. For  a  heterogeneous  list,  formed  from  integer  numbers  and  list  of  numbers,  replace  in  every  sublist  all occurrences of the first element 
% from sublist it a new given list.
% Eg.: [1, [4, 1, 4], 3, 6, [7, 10, 1, 3, 9], 5, [1, 1,1], 7] si [11, 11] =>[1, [11, 11, 1, 11, 11], 3, 6, [11, 11, 10, 1, 3, 9], 5, [11 11 11 11 11 11], 7]

% Model matematic:
% heterList(l1...ln, list) = 
% 	[], n = 0
% 	substitute_elem(l'1...l'm, l'1, list), heterList(l2...ln), is_list(l1) = True, where l1 = l'1...l'm
% 	l1 + heterList(l2...ln), number(l1) = True

% heterList(L:list, R:list)
% flow model: heterList(i, o)

heterList([], _, []).
heterList([[H|HT]|T], E, [HR|R]) :- 
    substitute([H|HT], H, E, HR),
    heterList(T, E, R).
heterList([H|T], E, [H|R]) :- number(H),
    heterList(T, E, R).
