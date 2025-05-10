% filepath: /home/albert/Bureau/Logique-Prolog/Einstein_Puzzle/indices.pl
:- module(indices, [indices/1]).

% Définition des indices
indices(Maisons) :-
    % Indice 1 : L'Anglais vit dans la maison rouge
    member(maison(_, rouge, anglais, _, _, _), Maisons),

    % Indice 2 : Le Suédois a des chiens
    member(maison(_, _, suedois, _, _, chiens), Maisons),

    % Indice 3 : Le Danois boit du thé
    member(maison(_, _, danois, the, _, _), Maisons),

    % Indice 4 : La maison verte est immédiatement à gauche de la blanche
    member(maison(VP, verte, _, _, _, _), Maisons),
    member(maison(BP, blanche, _, _, _, _), Maisons),
    VP is BP - 1,

    % Indice 5 : Le propriétaire de la maison verte boit du café
    member(maison(_, verte, _, cafe, _, _), Maisons),

    % Indice 6 : La personne qui fume Pall Mall élève des oiseaux
    member(maison(_, _, _, _, 'Pall Mall', oiseaux), Maisons),

    % Indice 7 : Le propriétaire de la maison jaune fume Dunhill
    member(maison(_, jaune, _, _, dunhill, _), Maisons),

    % Indice 8 : L’homme vivant dans la maison du centre boit du lait
    member(maison(3, _, _, lait, _, _), Maisons),

    % Indice 9 : Le Norvégien vit dans la première maison
    member(maison(1, _, norvegien, _, _, _), Maisons),

    % Indice 10 : L’homme qui fume Blends vit à côté de celui qui a des chats
    member(maison(BP1, _, _, _, blends, _), Maisons),
    member(maison(CP1, _, _, _, _, chats), Maisons),
    voisin(BP1, CP1),

    % Indice 11 : L’homme qui a un cheval vit à côté de celui qui fume Dunhill
    member(maison(HP, _, _, _, _, cheval), Maisons),
    member(maison(DP, _, _, _, dunhill, _), Maisons),
    voisin(HP, DP),

    % Indice 12 : L’homme qui fume Blue Master boit de la bière
    member(maison(_, _, _, biere, 'Blue Master', _), Maisons),

    % Indice 13 : L’Allemand fume Prince
    member(maison(_, _, allemand, _, prince, _), Maisons),

    % Indice 14 : Le Norvégien vit à côté de la maison bleue
    member(maison(NP, _, norvegien, _, _, _), Maisons),
    member(maison(BP2, bleue, _, _, _, _), Maisons),
    voisin(NP, BP2),

    % Indice 15 : L’homme qui fume Blends a un voisin qui boit de l’eau
    member(maison(BP3, _, _, _, blends, _), Maisons),
    member(maison(WP, _, _, eau, _, _), Maisons),
    voisin(BP3, WP).