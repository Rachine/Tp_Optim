///////////////////////////////////////////////////////////////////////////////
//                                                                           //
// STRUCTURES DE DONNEES NECESSAIRES A LA RESOLUTION DES EQUATIONS DU RESEAU //
//                                                                           //
//          (matrices stockees en exploitant leur structure creuse)          //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
//
// A partir des deux vecteurs contenant  respectivement les noeuds initiaux et
// finaux des arcs, on construit la matrice d'incidence de graphe noeuds-arcs.
//
// De la sous-matrice extraite de la matrice d'incidence noeuds-arcs du graphe
// en supprimant les lignes  correspondant aux noeuds reservoirs (mr premieres
// lignes de cette matrice), on extrait le plus grand bloc carre et inversible
// (on suppose que les colonnes qui forment ce bloc correspondent aux premiers
//  arcs dans la numerotation du graphe).
//
// On calcule le vecteur des debits admissibles du reseau (c.a.d. satisfaisant
// la 1-iere loi de Kirchhoff) associe au vecteur des debits nuls du co-arbre.
//
// Les tableaux et les variables utilises pour modeliser le reseau proviennent
// du script  Scilab Probleme.sce. On en rappelle ci-dessous la signification.
// Ils sont disponibles dans l'environnement  Scilab, et peuvent etre utilises
// par les fonctions necessaires a la resolution du probleme.
//
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
//
// Dimensions du reseau
// --------------------
//
// n    : nombre d'arcs
// m    : nombre de noeuds
// mr   : nombre de noeuds de type reservoir
// md   : nombre de noeuds de type demande (= m-mr)
//
// Topologie du reseau
// -------------------
//
// orig : vecteur des numeros des noeuds initiaux des arcs : M(1,n)
// dest : vecteur des numeros des noeuds finaux   des arcs : M(1,n)
// absn : vecteur des abscisses des noeuds                 : M(1,m)
// ordn : vecteur des ordonnees des noeuds                 : M(1,m)
//
// Donnees hydrauliques
// --------------------
//
// r    : vecteur des resistances des arcs                 : M(n,1)
// pr   : vecteur des pressions des noeuds reservoirs      : M(mr,1)
// fd   : vecteur des flux des noeuds de demande           : M(md,1)
//
// Matrices d'incidence
// --------------------
//
// A    : matrice d'incidence noeuds-arcs du graphe        : M(m,n)
// Ar   : sous-matrice de A correspondant aux reservoirs   : M(mr,n)
// Ad   : sous-matrice complementaire de Ar pour A         : M(md,n)
// AdT  : plus grande sous-matrice carree inversible de Ad : M(md,md)
// AdI  : matrice inverse de AdT                           : M(md,md)
// AdC  : sous-matrice complementaire de AdT pour Ad       : M(md,n-md)
// B    : matrice d'incidence arcs-cycles du graphe        : M(n,n-md)
//
// Debit admissible
// ----------------
//
// q0   : vecteur des debits admissibles des arcs          : M(n,1)
//
// Variables hydrauliques
// ----------------------
//
// q    : vecteur des debits des arcs                      : M(n,1)
// z    : vecteur des pertes de charge des arcs            : M(n,1)
// f    : vecteur des flux des noeuds                      : M(m,1)
// p    : vecteur des pressions des noeuds                 : M(m,1)
//
///////////////////////////////////////////////////////////////////////////////

// -----------------------------------------
// Matrice d'incidence noeuds-arcs du graphe
// -----------------------------------------

   indices = [ [orig ; [1:n]]' ; [dest ; [1:n]]' ];
   valeurs = [ -ones(n,1) ; ones(n,1) ];
   A = sparse(indices,valeurs);

// -----------------------------------------
// Partition de A suivant le type des noeuds
// -----------------------------------------

   Ar = A(1:mr,:);
   Ad = A(mr+1:m,:);

// -------------------------------------------------
// Sous-matrice de Ad associee a un arbre et inverse
// -------------------------------------------------

   AdT = Ad(:,1:md);
   AdI = inv(AdT);

// ----------------------------------------
// Sous matrice de Ad associee a un coarbre
// ----------------------------------------

   AdC = Ad(:,md+1:n);

// --------------------------------
// Matrice d'incidence arcs-cycles
// --------------------------------

   Temp = clean(-AdI*AdC);
   B = [ Temp ; speye(n-md,n-md) ];

// ------------------------------
// Vecteur des debits admissibles
// ------------------------------

   q0 = [ AdI*fd ; zeros(n-md,1) ];
