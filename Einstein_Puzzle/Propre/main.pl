% filepath: /home/albert/Bureau/Logique-Prolog/Einstein_Puzzle/Propre/main.pl
:- module(main, [solution/1, requete/2]).

:- use_module('./regles').  % Chemin relatif vers regles.pl
:- use_module('./indices'). % Chemin relatif vers indices.pl

% Résolution du problème
solution(Maisons) :-
    Maisons = [
        maison(1, _, _, _, _, _),
        maison(2, _, _, _, _, _),
        maison(3, _, _, _, _, _),
        maison(4, _, _, _, _, _),
        maison(5, _, _, _, _, _)
    ],
    indices(Maisons).

% Requête pour obtenir une information
requete(Indice, Valeur) :-
    solution(Maisons),
    member(maison(_, Couleur, Nationalite, Boisson, Cigarette, Animal), Maisons),
    (Indice = couleur, Valeur = Couleur;
     Indice = nationalite, Valeur = Nationalite;
     Indice = boisson, Valeur = Boisson;
     Indice = cigarette, Valeur = Cigarette;
     Indice = animal, Valeur = Animal).