% 1.
% a. Write a predicate to determine the lowest common multiple of a list formed 
% from integer numbers.
% b. Write a predicate to add a value v after 1-st, 2-nd, 4-th, 8-th, … 
% element in a list.


% a
% f
% 2, 3, 5, 10, 15 -> 30
% p / cmmdc. p =300, cmmdc = 1. cmmmc = 300
% ans= 2
% i = 1 -> cmmdc(2,3) = 1 ... p = 2*3=6 ... => cmmmc = 6/1 = 6 = ans
% i = 2 -> cmmdc(ans, 5) = 1 ... p = 6*5=30 ... -> cmmmc = 30/1 = 30 = ans
% i = 3 -> cmmdc(ans, 10) = 10 ... p = 10*30=300 ... -> cmmmc = 300/10 = 30 = ans
% i - 4 -> cmmdc(ans, 15) = 15 ... p = 15*30=450 ... -> cmmmc = 450/15 = 30 = ans
    
%  - functie cmmdc pe  numere.
%  - functie cmmdc pe lista
 
% ans = arr[0]
% for (int i = 1; i < n; i++)
%         ans = (((arr[i] * ans)) /
%                 (gcd(arr[i], ans)));

% Mathematical model:
% cmmdc(a, b) = { a, if b = 0
% 				{ b, if a = 0
%				{ a, if a = b
%               { cmmdc(a-b, b), if a > b
%				{ cmmdc(a, b-a), if b > a
cmmdc(0, B, B) :- !.
cmmdc(A, 0, A) :- !.
cmmdc(A, A, A) :- !.
cmmdc(A, B, R):-
    A > B,
    !,
    NewA is A-B,
    cmmdc(NewA, B, R).
cmmdc(A, B, R):-
    B > A,
    !,
    NewB is B-A, 
    cmmdc(A, NewB, R).

% Mathematical model:
% cmmmc(l1l2...ln) = { 0, if n = 0
% 					 { l1, if n = 1
% 					 { l1 * cmmmc(l2...ln) / cmmdc(l1, cmmmc(l2...ln)), otherwise

cmmmc([], 0).
cmmmc([H], H).
cmmmc([H|T], R):-
    cmmmc(T, Ans),
    Product is H*Ans,
    cmmdc(H, Ans, Gcd),
    R is Product/Gcd.

% b. Write a predicate to add a value v after 1-st, 2-nd, 4-th, 8-th, … 
% element in a list.
% [1, 2, 3, 4, 5, 6, 7, 8, 9] -> [1, 10, 2, 10, 3, 4, 10, 5, 6, 7, 8, 10, 9]

% Modelul matematic:
% insert_value(l1l2...ln, val, pos, putereDoi) = 
% 	{ [] , if n = 0
% 	{ l1 U val U insert_value(l2..ln, val, pos+1, putereDoi*2) , if pos = putereDoi
% 	{ l1 U insert_value(l2..ln, val, pos+1, putereDoi), is pos != putereDoi

insert_value([], _, _, _, []).
insert_value([H|T], Val, Pos, PutereDoi, [H, Val|R]):-
    Pos =:= PutereDoi,
    NewPos is Pos+1,
    NewPutereDoi is PutereDoi*2,
    insert_value(T, Val, NewPos, NewPutereDoi, R).
insert_value([H|T], Val, Pos, PutereDoi, [H|R]):-
    Pos =\= PutereDoi,
    NewPos is Pos+1,
    insert_value(T, Val, NewPos, PutereDoi, R).

insertMain(L, Val, R):-
    insert_value(L, Val, 1, 1, R).

% insertMain([1, 2, 3, 4, 5, 6, 7, 8, 9], 10, R)
