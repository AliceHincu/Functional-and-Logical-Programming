% 9.
% a. Insert an element on the position n in a list.
% b. Define a predicate to determine the greatest common divisor of all numbers from a list

% a. Insert an element on the position n in a list.
% Mathematical model:
% insert_position(l1l2...ln, e, index, pos) = 
%    { e U l1l2...ln, if index = pos  
%    { l1 U insert_position(l1l2...ln, index + 1, pos), otherwise
% insert_position(L:List, E: Number, Index: Number, Pos: Number, R:List) .... flow: insert_position(i, i, i, i, o)
insertPosition(L, E, Pos, Pos, [E|L]):- !.
insertPosition([H|T], E, Index, Pos, [H|R]):-
    NewIndex is Index + 1,
    insertPosition(T, E, NewIndex, Pos, R).

insertPositionMain(L, E, Pos, R):-
    insertPosition(L, E, 1, Pos, R).
% insertPositionMain([], 10, 1, R)
% insertPositionMain([1,2,3,4,5,6], 10, 3, R)

% b. Define a predicate to determine the greatest common divisor of all numbers from a list
% cmmdc(a, b) = 
%       { cmmdc(a-b, b), if a>b
%       { cmmdc(b-a, a), if b>a
%       { a, if b=a
% cmmdc(A: Number, B: Number, R: Number) ... flow: cmmdc(i,i, o)
cmmdc(A, A, A):- !.
cmmdc(A, B, R):- 
    A > B, !,
    NewA is A - B,
    cmmdc(NewA, B, R).
cmmdc(A, B, R):- 
    A < B, !,
    NewB is B - A,
    cmmdc(A, NewB, R).

% Mathematical model
% cmmmdcList(l1l2...ln) = 
%     { l1 , if n = 1
%     { cmmdc(l1, cmmmdcList(l2l3..l)), otherwise
% cmmdcList(L: List, R: Number)

cmmdcList([H], H):- !.
cmmdcList([H|T], R):-
    cmmdcList(T, R1),
    cmmdc(H, R1, R).

% cmmdcList([4,16,32], R)
