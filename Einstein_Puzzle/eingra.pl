:- use_module(library(pce)).
:- use_module(library(lists)).

% ----------------------
% ENIGME D'EINSTEIN
% ----------------------

solution(Maisons) :-
    length(Maisons, 5),
    Maisons = [_, _, _, _, _],
    member(maison(1, _, norvegien, _, _, _), Maisons),
    member(maison(_, rouge, anglais, _, _, _), Maisons),
    member(maison(_, _, danois, the, _, _), Maisons),
    member(maison(_, _, allemand, _, _, prince), Maisons),
    member(maison(_, verte, _, cafe, _, _), Maisons),
    member(maison(_, jaune, _, _, _, dunhill), Maisons),
    member(maison(_, _, _, lait, _, _), Maisons),
    member(maison(_, _, _, _, oiseau, bluemaster), Maisons),
    member(maison(_, _, suedois, _, chien, _), Maisons),
    member(maison(_, _, _, biere, _, bluemaster), Maisons),
    member(maison(_, _, _, _, cheval, dunhill), Maisons),
    member(maison(_, _, _, _, chat, pallmall), Maisons),
    member(maison(_, _, _, _, poisson, _), Maisons),
    next_to(maison(, _, _, _, _, blend), maison(, _, _, _, chat, _), Maisons),
    next_to(maison(, _, _, _, _, blend), maison(, _, _, _, eau, _), Maisons),
    next_to(maison(, _, _, _, _, _), maison(, bleue, _, _, _, _), Maisons),
    left_of(maison(, verte, _, _, _, _), maison(, blanche, _, _, _, _), Maisons).

next_to(A, B, L) :- append(, [A,B|], L).
next_to(A, B, L) :- append(, [B,A|], L).
left_of(A, B, L) :- append(, [A,B|], L).

% ----------------------
% INTERFACE GRAPHIQUE
% ----------------------

start :-
    new(Dialog, dialog('Enigme d\'Einstein')),
    send(Dialog, append, new(TypeMenu, menu(type, cycle))),
    send_list(TypeMenu, append, [nationalite, position, animal, boisson, couleur, cigarette]),

    send(Dialog, append, new(Input, text_item('Indice (ex: poisson)'))),
    send(Dialog, append, button('Chercher', message(@prolog, traiter, TypeMenu?selection, Input?selection))),
    send(Dialog, append, new(Result, label(resultat, 'Résultat :'))),

    send(Dialog, open_centered).

% Traitement de la recherche
traiter(Type, Indice) :-
    solution(Maisons),
    member(maison(Pos, Couleur, Nat, Boisson, Animal, Cig), Maisons),
    Result = maison(Pos, Couleur, Nat, Boisson, Animal, Cig),
    chercher(Type, Indice, Result, Rep),
    format(atom(Msg), 'Résultat : ~w', [Rep]),
    get(@display, frame, Frame),
    get(Frame, member, resultat, Label),
    send(Label, selection, Msg).

% Recherche selon le critère demandé
chercher(nationalite, Valeur, maison(_, _, ValeurTrouve, _, _, _), ValeurTrouve) :- Valeur == poisson.
chercher(position, Valeur, maison(Pos, _, _, _, Animal, _), Pos) :- Animal == Valeur.
chercher(animal, Valeur, maison(_, _, _, _, ValeurTrouve, _), ValeurTrouve) :- Valeur == poisson.
chercher(boisson, Valeur, maison(_, _, _, ValeurTrouve, _, _), ValeurTrouve) :- Valeur == poisson.
chercher(couleur, Valeur, maison(_, ValeurTrouve, _, _, _, _), ValeurTrouve) :- Valeur == poisson.
chercher(cigarette, Valeur, maison(_, _, _, _, _, ValeurTrouve), ValeurTrouve) :- Valeur == poisson.
chercher(_, _, _, 'Aucune correspondance').