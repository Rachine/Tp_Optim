///////////////////////////////////////////////////////////////////////////////
//                                                                           //
//        DONNEES ASSOCIEES A LA RESOLUTION DES EQUATIONS D'UN RESEAU        //
//                                                                           //
//        Probleme_S : reseau de taille parametrable (arbre binaire)         //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////////
//
// On donne les dimensions du reseau (nombres d'arcs, de noeuds, de reservoirs
// le constituant). On donne aussi deux vecteurs, contenant respectivement les
// numeros des noeuds initiaux et finaux des arcs du reseau. On suppose que le
// reseau comporte au moins un reservoir, que les reservoirs sont associes aux
// premiers  noeuds du graphe, et que la numerotation des noeuds du graphe est
// contigue (de 1 a m). On donne pour finir le vecteur de resistances des arcs
// du reseau, le vecteur des pressions des reservoirs ainsi que le vecteur des
// demandes aux noeuds autres que ceux correspondant aux reservoirs.
//
// On peut des a present noter que la numerotation implicite des arcs que l'on
// obtient ne doit pas etre  quelconque : on suppose en effet que les premiers
// arcs dans cette numerotation forment un arbre, ce qui fournit facilement le
// plus grand bloc carre inversible de la matrice d'incidence noeuds-arcs.
//
// On donne (de maniere facultative) les coordonnees des noeuds du reseau afin
// de pouvoir representer graphiquement le reseau. En Scilab, cette etape sera
// effectuee a l'aide de Metanet.
//
///////////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////////
//
// Variables du probleme
// ---------------------
//
// nom  : nom du reseau
//
// n    : nombre total d'arcs
// m    : nombre total de noeuds
// mr   : nombre de noeuds de type reservoir
// md   : nombre de noeuds de type demande (= m-mr)
//
// orig : vecteur des numeros des noeuds initiaux des arcs : M(1,n)
// dest : vecteur des numeros des noeuds finaux   des arcs : M(1,n)
// absn : vecteur des abscisses des noeuds                 : M(1,m)
// ordn : vecteur des ordonnees des noeuds                 : M(1,m)
//
// r    : vecteur des resistances des arcs                 : M(n,1)
// pr   : vecteur des pressions des noeuds reservoirs      : M(mr,1)
// fd   : vecteur des flux des noeuds de demande           : M(md,1)
//
///////////////////////////////////////////////////////////////////////////////


// -------------
// Nom du reseau
// -------------

   nom = 'Parametrable';

// ---------------------------------------------------------------------
// Nombre de niveaux de l'arbre ; initialisation du generateur aleatoire
//
// Les niveaux sont numerotes de 0 a T. On construit un arbre binaire
// (la racine correspondant au niveau 0), et on ferme tous les cycles
// elementaires (soit 2^t - 1 cycles au niveau t).
//  --------------------------------------------------------------------

   titre = "Nombre de niveaux de l''arbre (sans compter la racine)";
   labels = ["Nombre de niveaux";"Graine aleatoire"];
   typ = list("vec",1,"vec",1);
   default = ["7";"123"];
   [ok,T,gral] = getvalue(titre,labels,typ,default);

   rand("seed",gral);

// --------------------
// Dimensions du reseau
// --------------------

   m  = (2^(T+1)) - 1;
   mr = 1;
   md = m - mr;


   n  = ((2^(T+1))-1) + ((2^(T+1))-1) - (T+1) - 1;

// ----------------------------------------------
// Numeros des noeuds initiaux et finaux des arcs
// ----------------------------------------------

   orig = [];
   dest = [];

// - arcs de l'arbre

   num = 1;
   for t = 0:T-1
      ni = (2^t);
      nf = (2^(t+1)) - 1;
      nz = 2 * (nf-ni+1);
      aorg = [ [ni:nf] ; [ni:nf] ];
      orig = [ orig aorg(1:nz)' ];
      dest = [ dest [num+1:num+nz] ];
      num = num + nz;
   end

// - arcs du coarbre

   for t = 1:T
      ni = (2^t);
      nf = (2^(t+1)) - 1;
      orig = [ orig [ni:nf-1] ];
      dest = [ dest [ni+1:nf] ];
   end

// ----------------------
// Coordonnees des noeuds
// ----------------------

   absn = [];
   for t = 0:T
      ni = (2^t);
      nf = (2^(t+1)) - 1;
      na = 2^(T-t+1);
      nb = 2^(T-t);
      num = na*[0:nf-ni] + nb;
      absn = [ absn num ];
   end

   ordn = [];
   for t = 0:T
      ni = (2^t);
      nf = (2^(t+1)) - 1;
      ordn = [ ordn (T-t+1)*ones(1,nf-ni+1) ];
   end

// --------------------
// Resistances des arcs
// --------------------

   r = 1000 * rand(n,1);

// -------------------------------------
// Pressions au pied du reservoir (en m)
// -------------------------------------

   pr = [200]';

// ------------------------------------
// Flux aux noeuds de demande (en m3/s)
// ------------------------------------

   fd = 0.1 * (rand(md,1)-0.5);
