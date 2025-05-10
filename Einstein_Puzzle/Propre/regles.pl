% filepath: /home/albert/Bureau/Logique-Prolog/Einstein_Puzzle/regles.pl
:- module(regles, [voisin/2]).

% Définition de la règle voisin
voisin(X, Y) :- X is Y + 1 ; Y is X + 1.