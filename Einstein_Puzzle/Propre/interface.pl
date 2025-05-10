% filepath: /home/albert/Bureau/Logique-Prolog/Einstein_Puzzle/Propre/interface.pl
:- use_module(main).
:- use_module(library(pce)).

% Lancement de linterface
start :-
    % Créer une fenêtre principale (frame)
    new(Frame, frame('Assistant de résolution - Problème d\'Einstein')),
    send(Frame, size, size(700, 750)),  % Taille de la fenêtre

    % Ajouter un conteneur (dialog) dans la fenêtre
    new(Dialog, dialog),
    send(Frame, append, Dialog),
    send(Dialog, append, new(Enonce, text(' 
    ------------------------------------------------------ Énigme d\'Einstein -------------------------------------------- \n \n 
        Il y a cinq maisons de couleurs différentes alignées en une rangée. Dans chaque \n 
        maison vit une personne de nationalité différente, qui boit une boisson spécifique,\n 
        fume une marque de cigare particulière et possède un animal de compagnie unique. \n
        Voici les indices pour résoudre l\'énigme :\n\n
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
        15. L\'homme qui fume des Blends a un voisin qui boit de l\'eau.\n\n'
        ))),
    send(Enonce, font, font(helvetica, bold, 14)),  % Police plus grande
    send(Enonce, alignment, center),               % Centrer le texte
    send(Dialog, append, Enonce),

    % Ajouter un champ pour poser une question
    send(Dialog, append, new(Input, text_item('Posez votre question :'))),
    send(Input, length, 70),  % Taille du champ de texte
    send(Input, alignment, center),  % Centrer le champ

    % Ajouter un champ pour afficher la réponse
    new(Output, text_item('Réponse :', '')),  % Utiliser text_item pour afficher la réponse
    send(Output, editable, @off),  % Rendre le champ non modifiable
    send(Output, length, 70),      % Taille du champ de réponse
    send(Dialog, append, Output),

    % Ajouter un bouton pour soumettre la question
    send(Dialog, append, button('Soumettre', message(@prolog, traiter_question, Input?selection, Output))),

    % Espacement entre les éléments
    send(Dialog, gap, size(20, 20)),

    % Ouvrir la fenêtre
    send(Frame, open).

% Traitement de la question
traiter_question(Question, Output) :-
    (sub_string(Question, _, _, _, "maison verte") ->
        solution(Maisons),
        member(maison(_, verte, Nationalite, _, _, _), Maisons),
        format(atom(Reponse), "La maison verte est habitée par l'~w.", [Nationalite]),
        send(Output, value, Reponse);
     sub_string(Question, _, _, _, "Pall Mall") ->
        solution(Maisons),
        member(maison(_, _, _, _, 'Pall Mall', Animal), Maisons),
        format(atom(Reponse), "La personne qui fume Pall Mall possède le ~w.", [Animal]),
        send(Output, value, Reponse);
     sub_string(Question, _, _, _, "boit du café") ->
        solution(Maisons),
        member(maison(_, _, _, cafe, _, Animal), Maisons),
        format(atom(Reponse), "La personne qui boit du café possède le ~w.", [Animal]),
        send(Output, value, Reponse);
     sub_string(Question, _, _, _, "cheval") ->
        solution(Maisons),
        member(maison(_, Couleur, _, _, _, cheval), Maisons),
        format(atom(Reponse), "La maison de la personne qui a un cheval est de couleur ~w.", [Couleur]),
        send(Output, value, Reponse);
     sub_string(Question, _, _, _, "lait") ->
        solution(Maisons),
        member(maison(_, Couleur, _, lait, _, _), Maisons),
        format(atom(Reponse), "La maison où l'on boit du lait est de couleur ~w.", [Couleur]),
        send(Output, value, Reponse);
     sub_string(Question, _, _, _, "Blends") ->
        solution(Maisons),
        member(maison(_, Couleur, _, _, blends, _), Maisons),
        format(atom(Reponse), "La maison où l'on fume des Blends est de couleur ~w.", [Couleur]),
        send(Output, value, Reponse);
     sub_string(Question, _, _, _, "poisson") ->
        solution(Maisons),
        member(maison(_, _, Nationalite, _, _, poisson), Maisons),
        format(atom(Reponse), "l'~w est la personne qui a le poisson.", [Nationalite]),
        send(Output, value, Reponse);
     send(Output, value, 'Question non reconnue')).