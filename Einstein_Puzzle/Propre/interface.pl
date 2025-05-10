% filepath: /home/albert/Bureau/Logique-Prolog/Einstein_Puzzle/Propre/interface.pl
:- use_module(main).
:- use_module(library(pce)).

% Lancement de linterface
start :-
    new(Dialog, dialog('Assistant de résolution - Problème d\'Einstein')),
    send(Dialog, append, new(Input, text_item('Question'))),
    send(Dialog, append, new(Output, text_item('Réponse', ''))),
    send(Dialog, append, button('Soumettre', message(@prolog, traiter_question, Input?selection, Output))),
    send(Dialog, open).

% Traitement de la question
traiter_question(Question, Output) :-
    % Exemple : Question = "Quelle est la couleur de la maison de l'Anglais ?"
    (Question = "Quelle est la couleur de la maison de l'Anglais ?" ->
        solution(Maisons),
        member(maison(_, Couleur, anglais, _, _, _), Maisons),
        send(Output, selection, Couleur)
    ; send(Output, selection, 'Question non reconnue')).