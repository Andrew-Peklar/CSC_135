/* Author:  Andrew Peklar
 * Course:  CSC 135-01
 * Title :  Homework Assingment 3
 */

 /*Adding line to test atom*/

%% Problem 1: dogEnthusiest
/* Someone is a "dogEnthusiast" if they own AT LEAST TWO dogs --> A\=M */
dogEnthusiast(X) :- owner(X,A), owner(X,M), breed(A,dog), breed(M,dog), A\=M.
owner(eric, chester).
owner(eric, paul).
owner(millie, raj).
breed(raj, dog).
breed(chester, dog).
breed(paul, dog).

%%	Input  :	?- dogEnthusiast(A).
%	Output :	A = eric ;
%			A = eric ;
%			false.
%   --------    -------------------------
%	Input  :	?- dogEnthusiast(millie).
%	Output :	false.
%   --------    -------------------------
%   	Input  :	?- dogEnthusiast(eric).
%  	Output :    	true ;
%		   	true ;
%			false.
%%
/*******************************************************************/

%% Problem 2: ListPicker
/*base case*/
listPicker(D,[],[]).
listPicker(D,[PA|PD],[F|R]) :- nth(PA,D,F), listPicker(D,PD,R).
nth(1,[X|Y],X).
nth(N,[X|Y],G) :- N>1, N1 is N-1, nth(N1,Y,G).

/********************************************************************/

%% Problem 3: Crypto for GRIPLOCK = TOCK*TOCK
/* Assign numeric values */
num(1).
num(2).
num(3).
num(4).
num(5).
num(6).
num(7).
num(8).
num(9).
num(0).
/*Crypto rule and assign random numbers to letters*/
crypto(G,R,I,P,T,O,C,K) :- num(G), num(R), num(I), num(P),
                           num(T), num(O), num(C), num(K),
/*Each of the 4 letters (T,O,C,K) stands for a different digit*/
T\=O, T\=C, T\=K,
O\=C, O\=K,
C\=K,
/*Assign to digit placement, multiply, then check if answers match*/
L      is T * 1000 + O * 100 + C * 10 + K,
Answer is G * 10000000 + R * 1000000 + I * 100000 + P * 10000 + T * 1000 + O * 100 + C * 10 + K,
Total is L*L, Total = Answer.

%%	Input  :	?- crypto(G,R,I,P,T,O,C,K).
%	Output :	G = 8,
%			R = C, C = 7,
%			I = T, T = 9,
%			P = 0,
%			O = 3,
%			K = 6 ;
%			G = R, R = T, T = 0,
%			I = 3,
%			P = 9,
%			O = 6,
%			C = 2,
%			K = 5 ;
%%	Answers:	87909376 and 00390625
/*******************************************************************/

%% Problem 4: interleave
/*base case*/
interleave([],[],[]) :- !.
interleave([X|Y], [A|B], [X, A|Z]) :- interleave(Y, B, Z).
/* If the two lists are different lengths, include the excess elements at
 * the end of the result list, with a "999" inserted first.             */
interleave([], A, [999|A]).
interleave(X, [], [999|X]).

%%	Input  :	?- interleave([1,2],[4,5,6,7],X).
%	Output :	X = [1, 4, 2, 5, 999, 6, 7]
%	--------	---------------------------------
%	Input  :	?- interleave([1,2,3,4],[6,7],X).
%%	Output :	X = [1, 6, 2, 7, 999, 3, 4]
/*******************************************************************/

%% Problem 5
%% Takes input of an arbitrary number of digits and returns an integer constructed of the original inputs
%% digits, each incremented by one.

%% (if (< x 10)(modulo (+ 1 x)10)
digitinc(I, A) :- I < 10, T is I + 1, A is T mod 10.
%% (+ (* 10 (digitinc (floor (/ x 10))))(modulo (+ 1 x)10))))
digitinc(I, A) :- T is I/10, T2 is floor(T), digitinc(T2, X), T3 = I mod 10, digitinc(T3, X2),
				  X3 = X * 10, A is X2 + X3, !.

%%	Input  :	?- digitinc(22897,X).
%%	Output :	X = 33908.
