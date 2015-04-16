function []=Verification(q,z,f,p)

  
///////////////////////////////////////////////////////////////////////////////
//                                                                           //
// VERIFICATION DES EQUATIONS D'EQUILIBRE D'UN RESEAU DE DISTRIBUTION D'EAU  //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
//
// On suppose determinee la solution du probleme d'equilibre du reseau, et on
// calcule le plus grand ecart sur les 2 series d'equations qui caracterisent
// l'equilibre.
//
// Variables en entree
// -------------------
//
//    - q : vecteur des debits des arcs
//    - z : vecteur des pertes de charge des arcs
//    - f : vecteur des flux aux noeuds
//    - p : vecteur des pressions aux noeuds
//
//
// On suppose que l'environnement Scilab contient :
//
//    - A : matrice d'incidence noeuds-arcs du reseau
//
//
// Remarque
//
// Pour la deuxieme loi de Kirchhoff,  on peut utiliser le fait  que la
// matrice B contient les cycles du reseau, calculer la perte de charge
// le long de chacun de ces cycles (= B'*z), et lui oter le cas echeant
// les pressions des reservoirs aux extremites du cycle.  Ce calcul est
// plus precis que le precedent (on utilise les pertes de charge et non
// les pressions, qui sont d'un ordre de grandeur bien superieur et qui
// de plus n'interviennent que par leur difference : la pression est de
// l'ordre de 100 metres,alors que la perte de charge est de l'ordre du
// metre), mais necessite de determiner les cycles avec  reservoirs aux
// extremites et d'oter  la difference de leurs pressions a la perte de
// charge du cycle pour connaitre l'ecart.
//
///////////////////////////////////////////////////////////////////////////////


// ------------------------------------------
// Ecarts maximaux dur les lois de Kirschhoff
// ------------------------------------------

   tol1 = max(abs(A*q-f));
   tol2 = max(abs(A'*p+z));

// ------------------------
// Affichage alphanumerique
// ------------------------

   tols = ['sur les debits    : ';'sur les pressions : '];
   tols = [tols,[string(tol1);string(tol2)]];
   disp('Verification des equations d''equilibre du reseau')
   disp(tols)

endfunction
