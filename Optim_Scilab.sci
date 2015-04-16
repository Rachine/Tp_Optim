function [fopt,xopt,gopt]=Optim_Scilab(Oracle,xini)


///////////////////////////////////////////////////////////////////////////////
//                                                                           //
//      RESOLUTION DU PROBLEME D'OPTIMISATION DU RESEAU SANS CONTRAINTES     //
//                                                                           //
// On utilise directement la fonction  "optim"  presente dans Scilab, qui    //
// permet de choisir entre gradient conjugue et quasi-Newton.                //
//                                                                           //
// On rappelle que l'oracle de calcul (argument) demande la presence d'un    //
// certain nombre de tableaux et de variables dans l'environnement Scilab.   //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////


// ------------------------
// Parametres de la methode
// ------------------------

   titre = "Parametres de la fonction optim";
   labels = ["Gradient conjugue (gc) ou quasi-Newton (qn)";...
             "Nombre maximal d''iterations";...
             "Seuil de convergence sur  G"];
   typ = list("str",1,"vec",1,"vec",1);
   default = ["qn";"250";"0.000001"];
   [ok,meth,iter,tolg] = getvalue(titre,labels,typ,default);

   nap = 4 * iter;

// ---------------------
// Appel de l'optimiseur
// ---------------------

   timer();
   [fopt,xopt,gopt] = optim(Oracle,xini,meth,'ar',nap,iter,tolg,imp=1);
   tcpu = timer();

// ---------------------------
// Resultats de l'optimisation
// ---------------------------

   cvge = ['Temps CPU         : ' string(tcpu);...
           'Critere optimal   : ' string(fopt);...
           'Norme du gradient : ' string(norm(gopt))];
   disp('Fin de la methode d''optimisation integree a Scilab')
   disp(cvge)

endfunction
