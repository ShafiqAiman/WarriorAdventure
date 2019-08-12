%MyGame

head([H|_], H).



play :- retractall(health(_, _)), assertz(health(1, 100)) ,how_to_play, read(X), scene(X).

healthdeduction :- findall(A, health(1, A), L), head(L, B), C is B - 20,(C > 0 -> retractall(health(_, _)), assertz(health(1, C)));(false) .

how_to_play :-  write('Welcome to Warrior Adventure!'),nl,nl,
		
		write('You are a knight.'),nl,
		write('Your princess was taken away by a dragon into a cave.'),nl,
		write('You are in front of the cave now.'),nl,nl,
		%write('Good Luck!'),nl,nl,
		write('Are you brave enough to risk your own life to save the princess from the dragon?'),nl,
		write('Press a for YES'),nl,
		write('Press b for NO'),nl.

scene(X) :-	(X = 'b' -> nl,write('You are such a coward!'),nl,
		write('You dont deserve to be knight!'),nl,
		write('The princess is died because of you! Bye!'),false);
		(X = 'a' -> nl,
		write('There are three levels that you need to pass in order to save the princess'),nl,
		write('Each level has different challenge, you may get hurt in the journey of rescuing.'),nl,
		write('Goodluck!'),nl,
		satu, read(Y), ques1(Y)).

satu :-		write('--------------------------------------------------------------------------'),nl,
		nl, write('LEVEL 1'),nl,nl,
		write('Now you have entered the cave'),nl,
		write('Based on legendary, the outsider needs to face three levels in order to go to The Chamber of Dragon inside the cave.'),nl,nl,
		write('First Level - Dwarf Riddle'),nl,
		write('Second Level - Mage Tic Tac Toe'),nl,
		write('Third Level - Killing the Dragon'),nl,nl,
		write('You are given 100% health'),nl,nl,
		write('LEVEL 1 - Dwarf Riddle'),nl,nl,
		write('The dwarf blocked you from going deeper into the cave.'),nl,
		write('However, he will allow you to pass if you solve a RIDDLE..'),nl,
		riddle.


riddle :-	nl, write('The riddle goes--'),nl,nl,
		findall(A, health(1, A), L), head(L, B), write('Health = '), write(B), nl,
		write('Which dragon is used by Harry Potter during Triwizard Tournament?'),nl,
		write('a. Antipodean Opaleye'),nl,
		write('b. Norwegian Ridgeback'),nl,
		write('c. Hungarian Horntail'),nl,
		write('d. Ukrainian Ironbelly'),nl,
		write('Your move?'),nl,nl,
		read(G),ques1(G).

ques1(G) :-	(G = 'c' -> nl,write('Your answer is correct ! The dwarf allows you to pass and he rewards you a Dragon Chamber key!'),nl,nl, dua);
		(G \= 'c' -> nl,healthdeduction,write('You have given a wrong answer.'), nl,
		write('You need to sacrifice some of your blood in order to reanswer the question.'),
		nl,riddle).

dua :-		nl,write('--------------------------------------------------------------------------'),nl,
		write('LEVEL 2'),nl,nl,
		write('You are now in front of The Gate of Dragon Chamber!'),nl,
		write('You search the dungeon for a key.'),nl,
		write('You stumble upon a treasure chest that you suspect has the key inside.'),nl,
		write('The treasure chest is locked.'),nl,
		write('You try to unlock the chest.'),nl,
		write('To unlock the chest, you have 1 TRY to find the key in the boxes below...'),nl,nl,
		write('Find the box with the k logo.'),nl,
		write('Select the number to unlock each box'),nl,
		ques2.

ques2 :-	disp([1,2,3,4,5,6,7,8,9]), stt([a,a,a,a,a,a,a,a,a]).

disp([A,B,C,D,E,F,G,H,I]) :-
	write('|'),
	write([A,B,C]),write('|'),nl,
	write('|'),
	write([D,E,F]),write('|'),nl,	write('|'),
        write([G,H,I]),write('|'),nl,nl.

stt(Lst) :- write('Your move..'),nl,nl, read(Z), move(Lst, Z, Ulst), disp(Ulst), wins(Ulst) .

%ctr(R) :- (((R > 0) , (R < 4)) -> strt([a,a,a,a,a,a,a,a,a]), ctr(R-1)); (R > 4 -> tiga); (R < 1, write('OUT OF MOVES!! BYE BYE'),nl,nl), false.

move([a,B,C,D,E,F,G,H,I], 1, [a,B,C,D,E,F,G,H,I]).
move([A,a,C,D,E,F,G,H,I], 2, [A,a,C,D,E,F,G,H,I]).
move([A,B,a,D,E,F,G,H,I], 3, [A,B,a,D,E,F,G,H,I]).
move([A,B,C,a,E,F,G,H,I], 4, [A,B,C,a,E,F,G,H,I]).
move([A,B,C,D,a,F,G,H,I], 5, [A,B,C,D,k,F,G,H,I]).
move([A,B,C,D,E,a,G,H,I], 6, [A,B,C,D,E,a,G,H,I]).
move([A,B,C,D,E,F,a,H,I], 7, [A,B,C,D,E,F,a,H,I]).
move([A,B,C,D,E,F,G,a,I], 8, [A,B,C,D,E,F,G,a,I]).
move([A,B,C,D,E,F,G,H,a], 9, [A,B,C,D,E,F,G,H,a]).


wins(Ulst) :-	(Ulst = [_,_,_,_,k,_,_,_,_] -> write('You found the key! Proceed to last level.'),nl,nl, tiga); write('BYE BYE!'),false,nl,nl.

tiga :- nl,write('--------------------------------------------------------------------------'),nl,
		write('LEVEL 3'),nl,nl,
		write('You are out of the dungeon.'),nl,
		write('You are now almost out of the tunnel.'),nl,
		write('On your out of the tunnel, you encounter SKELETON KING.'),nl,
		write('To exit the tunnel, you have to win a game against the king.'),nl,
		write('The King challenges you to a game of tictactoe.'),nl,
		write('Defeat the King and you will have FREEDOM...'),nl,nl,
		queslast,nl,nl.

%start tictactoe
queslast :-	how_to_plays, strt([a,a,a,a,a,a,a,a,a]).

win(Brd, Plyr) :- rwin(Brd, Plyr);
                  cwin(Brd, Plyr);
                  dwin(Brd, Plyr).

%row win
rwin(Brd, Plyr) :- Brd = [Plyr,Plyr,Plyr,_,_,_,_,_,_];
                   Brd = [_,_,_,Plyr,Plyr,Plyr,_,_,_];
		   Brd = [_,_,_,_,_,_,Plyr,Plyr,Plyr].

%column win
cwin(Brd, Plyr) :- Brd = [Plyr,_,_,Plyr,_,_,Plyr,_,_];
%                  Brd = [_,Plyr,_,_,Plyr,_,_,Plyr,_];
		   Brd = [_,_,Plyr,_,_,Plyr,_,_,Plyr].

%diagonal win
dwin(Brd, Plyr) :- Brd = [Plyr,_,_,_,Plyr,_,_,_,Plyr];
		   Brd = [_,_,Plyr,_,Plyr,_,Plyr,_,_].

omove([a,B,C,D,E,F,G,H,I], Plyr, [Plyr,B,C,D,E,F,G,H,I]).
omove([A,a,C,D,E,F,G,H,I], Plyr, [A,Plyr,C,D,E,F,G,H,I]).
omove([A,B,a,D,E,F,G,H,I], Plyr, [A,B,Plyr,D,E,F,G,H,I]).
omove([A,B,C,a,E,F,G,H,I], Plyr, [A,B,C,Plyr,E,F,G,H,I]).
omove([A,B,C,D,a,F,G,H,I], Plyr, [A,B,C,D,Plyr,F,G,H,I]).
omove([A,B,C,D,E,a,G,H,I], Plyr, [A,B,C,D,E,Plyr,G,H,I]).
omove([A,B,C,D,E,F,a,H,I], Plyr, [A,B,C,D,E,F,Plyr,H,I]).
omove([A,B,C,D,E,F,G,a,I], Plyr, [A,B,C,D,E,F,G,Plyr,I]).
omove([A,B,C,D,E,F,G,H,a], Plyr, [A,B,C,D,E,F,G,H,Plyr]).

xmove([a,B,C,D,E,F,G,H,I], 1, [x,B,C,D,E,F,G,H,I]).
xmove([A,a,C,D,E,F,G,H,I], 2, [A,x,C,D,E,F,G,H,I]).
xmove([A,B,a,D,E,F,G,H,I], 3, [A,B,x,D,E,F,G,H,I]).
xmove([A,B,C,a,E,F,G,H,I], 4, [A,B,C,x,E,F,G,H,I]).
xmove([A,B,C,D,a,F,G,H,I], 5, [A,B,C,D,x,F,G,H,I]).
xmove([A,B,C,D,E,a,G,H,I], 6, [A,B,C,D,E,x,G,H,I]).
xmove([A,B,C,D,E,F,a,H,I], 7, [A,B,C,D,E,F,x,H,I]).
xmove([A,B,C,D,E,F,G,a,I], 8, [A,B,C,D,E,F,G,x,I]).
xmove([A,B,C,D,E,F,G,H,a], 9, [A,B,C,D,E,F,G,H,x]).



dispa([A,B,C,D,E,F,G,H,I]) :-
	write('|'),
	write([A,B,C]),write('|'),nl,
	write('|'),
	write([D,E,F]),write('|'),nl,	write('|'),
        write([G,H,I]),write('|'),nl,nl.




how_to_plays :-
  write('You are x player, enter positions followed by a period.'),
  nl,
  dispa([1,2,3,4,5,6,7,8,9]).

strt(Brd) :- win(Brd, x), write('You win!'), true.
strt(Brd) :- win(Brd, o), write('King win!'), false.
strt(Brd) :- read(N),
  xplay(Brd, N, NewBrd),
  dispa(NewBrd),
  oplay(NewBrd, NewnewBrd),
  dispa(NewnewBrd),
  strt(NewnewBrd).

can_x_win(Brd) :- omove(Brd, x, NewBrd), win(NewBrd, x).

xplay(Brd, N, NewBrd) :- xmove(Brd, N, NewBrd).

%oplay functions

oplay(Brd,NewBrd) :-
  omove(Brd, o, NewBrd),
  win(NewBrd, o),!.

oplay(Brd,NewBrd) :-
  omove(Brd, o, NewBrd),
  not(can_x_win(NewBrd)).

oplay(Brd,NewBrd) :-
  omove(Brd, o, NewBrd).

oplay(Brd,NewBrd) :-
  not(member(a,Brd)),!,
  write('Game Ended without Winner!'), nl,
  NewBrd = Brd, false.
