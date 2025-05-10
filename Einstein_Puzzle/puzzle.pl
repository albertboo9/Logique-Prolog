:- use_module(library(pce)).
:- dynamic solution/1.

% Structure d'une maison : maison(Nationalite, Couleur, Animal, Boisson, Cigarette)

start :-
    new(Dialog, dialog('Énigme d\'Einstein')),
    send(Dialog, append, new(NomChamp, text_item('Critère (animal, nationalite, boisson, etc.)'))),
    send(Dialog, append, new(IndiceChamp, text_item('Valeur (poisson, norvegien, etc.)'))),
    send(Dialog, append, button(rechercher, message(@prolog, traiter, NomChamp?selection, IndiceChamp?selection))),
    send(Dialog, append, button(quitter, message(Dialog, destroy))),
    send(Dialog, open).

% Fonction pour traiter la recherche
traiter(Critere, Valeur) :-
    downcase_atom(Critere, C),
    downcase_atom(Valeur, V),
    solution(Maisons),
    attribut_index(C, Index),
    (   nth1(Pos, Maisons, Maison),
        arg(Index, Maison, V)
    ->  format(atom(Msg), 'La valeur "~w" se trouve dans la maison numéro ~w.', [V, Pos]),
        send(@display, inform, Msg)
    ;   send(@display, inform, 'Aucune maison ne contient cette valeur.')
    ).

% Obtenir l'index de l'attribut de la maison
attribut_index(nationalite, 1).
attribut_index(nationalité, 1).
attribut_index(couleur, 2).
attribut_index(animal, 3).
attribut_index(boisson, 4).
attribut_index(cigarette, 5).

% Énigme d'Einstein - solution
solution(Maisons) :-
    Maisons = [_, _, _, _, _],
    member(maison(anglais, rouge, _, _, _), Maisons),
    member(maison(suedois, _, chien, _, _), Maisons),
    member(maison(danois, _, _, the, _), Maisons),
    a_droite(maison(, verte, _, _, _), maison(, blanche, _, _, _), Maisons),
    member(maison(_, verte, _, cafe, _), Maisons),
    member(maison(_, _, oiseau, _, pall_mall), Maisons),
    member(maison(_, jaune, _, _, dunhill), Maisons),
    nth1(3, Maisons, maison(_, _, _, lait, _)),
    nth1(1, Maisons, maison(norvegien, _, _, _, _)),
    a_cote(maison(, _, _, _, blend), maison(, _, chat, _, _), Maisons),
    a_cote(maison(, _, cheval, _, _), maison(, _, _, _, dunhill), Maisons),
    member(maison(_, _, _, biere, bluemaster), Maisons),
    member(maison(allemand, _, _, _, prince), Maisons),
    a_cote(maison(norvegien, , _, _, _), maison(, bleu, _, _, _), Maisons),
    a_cote(maison(, _, _, _, blend), maison(, _, _, eau, _), Maisons),
    member(maison(_, _, poisson, _, _), Maisons).

% Relations de position
a_droite(A, B, Liste) :- nextto(B, A, Liste).
a_cote(A, B, Liste) :- nextto(A, B, Liste); nextto(B, A, Liste).