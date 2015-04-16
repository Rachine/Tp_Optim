function [q,z,f,p]=HydrauliqueD(pd)


///////////////////////////////////////////////////////////////////////////////
//                                                                           //
//    CALCUL DES VARIABLES HYDRAULIQUES DU RESEAU A PARTIR DES PRESSIONS     //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
//
// Supposant connues les pressions aux noeuds de demande, on calcule l'ensemble
// des variables hydrauliques du reseau ; on dispose pour cela des matrices qui
// ont ete calcules precedemment.
//
// Variables en entree
// -------------------
//
//    - pd   : vecteur des pressions aux noeuds de demande
//
// Variables en sortie
// -------------------
//
//    - q    : vecteur des debits des arcs
//    - z    : vecteur des pertes de charge des arcs
//    - f    : vecteur des flux des noeuds
//    - p    : vecteur des pressions des noeuds
//
//
// On suppose que l'environnement Scilab contient :
//
//    - A    : matrice d'incidence noeuds-arcs
//    - Ar   : sous-matrice de la matrice d'incidence
//    - r    : vecteur des resistances des arcs
//    - pr   : vecteur des pressions des reservoirs
//    - fr   : vecteur des flux des noeuds de demande
//
//
///////////////////////////////////////////////////////////////////////////////


// --------------------
// Pressions aux noeuds
// --------------------

   p = [ pr ; pd ];

// -------------------------
// Pertes de charge des arcs
// -------------------------

   z = - A' * p;

// ---------------
// Debits des arcs
// ---------------

   q = z ./ sqrt(r.*abs(z));

// ---------------
// Flux aux noeuds
// ---------------

   f = [ Ar*q ; fd ];

endfunction
