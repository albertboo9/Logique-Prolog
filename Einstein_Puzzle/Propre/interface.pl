% filepath: /home/albert/Bureau/Logique-Prolog/Einstein_Puzzle/Propre/interface.pl
:- use_module(main).
:- use_module(library(pce)).

% Lancement de linterface
start :-
    % Créer une fenêtre principale (frame)
    new(Frame, frame('Assistant de résolution - Problème d\'Einstein')),
    send(Frame, size, size(700, 700)),  % Taille de la fenêtre

    % Ajouter un conteneur (dialog) dans la fenêtre
    new(Dialog, dialog),
    send(Frame, append, Dialog),
    send(Dialog, append, new(Enonce, text('Énigme d\'Einstein :\n\n
        1. L\'Anglais vit dans la maison rouge.\n
        2. Le Suédois a des chiens comme animaux de compagnie.\n
        3. Le Danois boit du thé.\n
        4. La maison verte est juste à gauche de la maison blanche.\n
        5. Le propriétaire de la maison verte boit du café.\n
        6. La personne qui fume Pall Mall élève des oiseaux.\n
        7. Le propriétaire de la maison jaune fume des Dunhill.\n
        8. L\'homme vivant dans la maison du centre boit du lait.\n
        9. Le Norvégien vit dans la première maison.\n
        10. L\'homme qui fume des Blends vit à côté de celui qui a des chats.\n
        11. L\'homme qui a un cheval vit à côté de celui qui fume des Dunhill.\n
        12. L\'homme qui fume des Blue Master boit de la bière.\n
        13. L\'Allemand fume des Prince.\n
        14. Le Norvégien vit à côté de la maison bleue.\n
        15. L\'homme qui fume des Blends a un voisin qui boit de l\'eau.\n\n
        '))),
    send(Enonce, font, font(helvetica, bold, 14)),  % Police plus grande
    send(Enonce, alignment, center),               % Centrer le texte
    send(Dialog, append, Enonce),

    % Ajouter un champ pour poser une question
    send(Dialog, append, new(Input, text_item('Posez votre question :'))),
    send(Input, length, 70),  % Taille du champ de texte
    send(Input, alignment, center),  % Centrer le champ

    % Ajouter un champ pour afficher la réponse
    send(Dialog, append, new(Output, text_item('Réponse :', ''))),
    send(Output, editable, @off),  % Rendre le champ de réponse non modifiable
    send(Output, length, 70),      % Taille du champ de réponse
    send(Output, alignment, center),  % Centrer le champ

    % Ajouter un bouton pour soumettre la question
    send(Dialog, append, button('Soumettre', message(@prolog, traiter_question, Input?selection, Output))),

    % Espacement entre les éléments
    send(Dialog, gap, size(20, 20)),

    % Ouvrir la fenêtre
    send(Frame, open).

% Traitement de la question
traiter_question(Question, Output) :-
    % Analyse de la question
    (sub_string(Question, _, _, _, "couleur") ->
        (sub_string(Question, _, _, _, "Anglais") ->
            solution(Maisons),
            member(maison(_, Couleur, anglais, _, _, _), Maisons),
            send(Output, selection, Couleur)
        ; send(Output, selection, 'Nationalité non reconnue'));
     sub_string(Question, _, _, _, "boisson") ->
        (sub_string(Question, _, _, _, "Danois") ->
            solution(Maisons),
            member(maison(_, _, danois, Boisson, _, _), Maisons),
            send(Output, selection, Boisson)
        ; send(Output, selection, 'Nationalité non reconnue'));
     sub_string(Question, _, _, _, "animal") ->
        (sub_string(Question, _, _, _, "Suédois") ->
            solution(Maisons),
            member(maison(_, _, suedois, _, _, Animal), Maisons),
            send(Output, selection, Animal)
        ; send(Output, selection, 'Nationalité non reconnue'));
     send(Output, selection, 'Question non reconnue')).