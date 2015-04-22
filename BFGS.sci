exec('Wolfe_Skel.sci');

function [fopt,xopt,gopt]=BFGS(Oracle,xini)


///////////////////////////////////////////////////////////////////////////////
//                                                                           //
//         RESOLUTION D'UN PROBLEME D'OPTIMISATION SANS CONTRAINTES          //
//                                                                           //
//         Methode de gradient conjugué                                    //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////


// ------------------------
// Parametres de la methode
// ------------------------

   titre = "Parametres du gradient a pas Variable";
   labels = ["Nombre maximal d''iterations";...
             "Valeur du pas de gradient";...
             "Seuil de convergence sur ||G||"];
   typ = list("vec",1,"vec",1,"vec",1);
   default = ["5000";"0.0005";"0.000001"];
   [ok,iter,alphai,tol] = getvalue(titre,labels,typ,default);

// ----------------------------
// Initialisation des variables
// ----------------------------
   
   logG = [];
   logP = [];
   Cout = [];

   timer();

// -------------------------
// Boucle sur les iterations
// -------------------------

   x = xini;
    [F,G]=Oracle(x,4);
    dim=size(G)
    Id=eye(dim(1),dim(1));
    Wqs=Id;
    D=-G;
    x_av=x;
    [alpha,ok] = Wolfe(alphai,x,D,Oracle);
    x = x + (alpha*D); 
    kstar = iter;
    for k=2:iter
       

   stop=0;


//    - valeur du critere et du gradient
      [F_av,G_av]=(F,G);
      ind = 4;
      [F,G] = Oracle(x,ind);
      diffx=x-x_av;
      diffg=G-G_av;
//    - test de convergence

      if norm(G) <= tol then
         kstar = k;
         break
      end

//    - calcul de la direction de descente avec la formule de BFGS inverse

      //D = -G;
          dm=diffg'*diffx;
          Wqs = (Id-(diffx*diffg')/dm)*Wqs*(Id-(diffg*diffx')/dm);
          Wqs = Wqs + (diffx*diffx')/dm;
          D= - Wqs * G;
       
//    - calcul de la longueur du pas de gradient

      [alpha,ok] = Wolfe(alphai,x,D,Oracle);


//    - mise a jour des variables
      x_av=x;
      x = x + (alpha*D);
        
//    - evolution du gradient, du pas et du critere

      logG = [ logG ; log10(norm(G)) ];
      logP = [ logP ; log10(alpha) ];
      Cout = [ Cout ; F ];

   end
// ---------------------------
// Resultats de l'optimisation
// ---------------------------

   fopt = F;
   xopt = x;
   gopt = G;

   tcpu = timer();

   cvge = ['Iteration         : ' string(kstar);...
           'Temps CPU         : ' string(tcpu);...
           'Critere optimal   : ' string(fopt);...
           'Norme du gradient : ' string(norm(gopt))];
   disp('Fin de la methode de gradient a pas fixe')
   disp(cvge)

// - visualisation de la convergence

   Visualg(logG,logP,Cout);

endfunction
