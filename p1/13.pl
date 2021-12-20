% 13.
% a. Transform a list in a set, in the order of the last occurrences of elements. Eg.: [1,2,3,1,2] is transformed in [3,1,2].
% b. Define a predicate to determine the greatest common divisor of all numbers in a list.

% DOUA METODE: checkExistence sau numeri aparitiile
% checkExistence(l1...ln, e) =
%     { false , if n = 0
%     { true , if l1 = e
%     { checkExitence(l2..ln, e), otherwise  
%
checkExistence([],_):-fail.
checkExistence([H|_], E):-
    H =:= E, !.
checkExistence([_|T], E):-
    checkExistence(T, E).

% transformListInSet(l1l2...ln) =
%     { [], if n = 0
%     { l1 U transformListInSet(l2...ln), if checkExistence(l2..ln, l1) is false
%     { transformListInSet(l2...ln), if checkExistence(l2..ln, l1) is true
%
transformListInSet([], []).
transformListInSet([H|T], R):-
    checkExistence(T, H),
    !,
    transformListInSet(T, R).
transformListInSet([H|T], [H|R]):-
    transformListInSet(T, R).

% pt b vezi 9
