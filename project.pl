:- use_module(library(lists)).

anywhere(X, Board):-
	append(Prefix, [X | Suffix], Board).

next_to(X,X,_). 
next_to(X,Y,[A,B,C,D,E,F]) :- 
    consecutive(X,Y,[A,B,C,D,E,F]). 
next_to(X,Y,[A,B,C,D,E,F]) :- 
    consecutive(Y,X,[A,B,C,D,E,F]).

consecutive(X,Y,Board) :-  
   append(Prefix, [X, Y | Suffix], Board).

one_space(X, X,_).
one_space(X, Y, [A,B,C,D,E,F]):-
	append(Prefix, [X, _, Y| Suffix], [A,B,C,D,E,F]).
one_space(X, Y, [A,B,C,D,E,F]):-
	append(Prefix, [Y, _, X| Suffix], [A,B,C,D,E,F]).

across(X, X,_).
across(X, Y, [A,B,C,D,E,F]):-
	P1 = [A, B],
	P2 = [D, E, F],
	member(X, P1), member(Y, P2).

across(X, Y, [A,B,C,D,E,F]):-
	P1 = [A, B],
	P2 = [D, E, F],
	member(X, P2), member(Y, P1).

same_edge(X, X,_).
same_edge(X, Y, [A,B,C,D,E,F]):-
	P = [A, B],
	member(X, P), member(Y, P).

same_edge(X, Y, [A,B,C,D,E,F]):-
	P = [D, E, F],
	member(X, P), member(Y, P).

position(X, X, _).
position(X, [F | R], Board):-
	nth1(F, Board, X).

position(X, [F | R], Board):-
	position(X, R, Board).


satisfies([], _).
satisfies([Constraint | Constraints], Board) :-
    call(Constraint, Board),
    satisfies(Constraints, Board).

generate(Board) :- permutation([yellow, green, blue, orange, white, black], Board).

solve(Constraints, Board) :-
    generate(Board),
    satisfies(Constraints, Board).


score_single(Constraint, Board, 0) :- call(Constraint, Board), !.
score_single(Constraint, Board, -1).

score_all([], Board, 0).
score_all([Constraint | Constraints], Board, Score) :-
    score_all(Constraints, Board, ScoreRest),
    score_single(Constraint, Board, ScoreSingle),
    Score is ScoreSingle + ScoreRest.

best_score(Constraints, Score) :-
    findall(Permutation, generate(Permutation), Permutations),
    best_score(Constraints, Permutations, Score).

best_score(_, [], -7).
best_score(Constraints, [Permutation | Permutations], Score) :-
    score_all(Constraints, Permutation, ScoreSingle),
    best_score(Constraints, Permutations, ScoreRest),
    Score is max(ScoreSingle, ScoreRest).

/*
run with:
example(1, _E), solve(_E, Solutions).
*/
%% 12 solutions
example(1, [ next_to(white,orange), 
             next_to(black,black), 
             across(yellow,orange), 
             next_to(green,yellow), 
             position(blue,[1,2,6]), 
             across(yellow,blue) ]).  
%% 1 solution 
example(2, [ across(white,yellow), 
             position(black,[1,4]), 
             position(yellow,[1,5]), 
             next_to(green, blue), 
             same_edge(blue,yellow), 
             one_space(orange,black) ]).  
%% no solutions (5 constraints are satisfiable) 
example(3, [ across(white,yellow), 
             position(black,[1,4]), 
             position(yellow,[1,5]), 
             same_edge(green, black), 
             same_edge(blue,yellow), 
             one_space(orange,black) ]).  
%% same as above, different order of constraints 
example(4, [ position(yellow,[1,5]), 
             one_space(orange,black), 
             same_edge(green, black), 
             same_edge(blue,yellow), 
             position(black,[1,4]), 
             across(white,yellow) ]).