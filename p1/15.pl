% 15.
% a. Write a predicate to transform a list in a set, considering the first occurrence.
% Eg: [1,2,3,1,2] is transform in [1,2,3].
% 
% 
% a -> vezi 13b si in loc de [H|R] pui [R|H]



% b. Write a predicate to decompose a list in a list respecting the following: [list of even numbers list of odd numbers] 
% and also return the number of even numbers and the numbers of odd numbers.
% [1, 3, 6, 4, 9, 13, 14, 90] -> [[1, 3, 9, 13], [6, 4, 14, 90]]

% Mathematical model
% decomposeList(l1l2...ln) =
%     { [[], [], 0, 0] , if n = 0
%     { decomposeList(l2..ln), l1 U even_list, 1+even_numbers, if l1 % 2 == 0
%     { decomposeList(l2..ln), l1 U odd_list, 1+odd_numbers, otherwise
% flow(i,o,o,o,o)
decomposeList([], [], [], 0, 0).
decomposeList([H|T], [H|EvenList], OddList, NewEvenNumbers, OddNumbers):-
    Rest is H mod 2,
    Rest =:= 0,
    !,
    decomposeList(T, EvenList, OddList, EvenNumbers, OddNumbers),
    NewEvenNumbers is 1+EvenNumbers.
decomposeList([H|T], EvenList, [H|OddList], EvenNumbers, NewOddNumbers):-
    decomposeList(T, EvenList, OddList, EvenNumbers, OddNumbers),
    NewOddNumbers is 1+OddNumbers.

decomposeListMain(L, [[EvenList|[OddList]], [EvenNumbers|OddNumbers]]):-
    decomposeList(L, EvenList, OddList, EvenNumbers, OddNumbers).
    
