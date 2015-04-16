function [q,z,f,p]=HydrauliqueP(qc)


///////////////////////////////////////////////////////////////////////////////
//                                                                           //
// CALCUL DES VARIABLES HYDRAULIQUES DU RESEAU A PARTIR DU DEBIT DU CO-ARBRE //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
//
// Supposant connu le vecteur des debits sur le co-arbre, on calcule l'ensemble
// des variables  hydrauliques du reseau ; on dispose pour cela des matrices et
// du debit admissible qui ont ete calcules precedemment.
//
// Variables en entree
// -------------------
//
//    - qc   : vecteur des debits des arcs du co-arbre
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
//    - md   : nombre de noeuds de type demande
//    - Ar   : sous-matrice de la matrice d'incidence
//    - AdI  : matrice inverse de AdT
//    - B    : matrice des cycles (transposee)
//    - r    : vecteur des resistances des arcs
//    - pr   : vecteur des pressions des reservoirs
//    - fd   : vecteur des flux des noeuds de demande
//    - q0   : vecteur des debits admissibles
//
///////////////////////////////////////////////////////////////////////////////


// ---------------
// Debits des arcs
// ---------------

   q = q0 + (B*qc);

// -------------------------
// Pertes de charge des arcs
// -------------------------

   z = r .* abs(q) .* q;

// ---------------
// Flux aux noeuds
// ---------------

   f = [ Ar*q ; fd ];

// --------------------
// Pressions aux noeuds
// --------------------

   temp = (Ar'*pr) + z;
   p = [ pr ; -AdI'*temp(1:md) ];

endfunction
