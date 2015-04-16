function []=Visualg(logG,logP,Cout)


///////////////////////////////////////////////////////////////
//                                                           //
//   VISUALISATION DES ITEREES D'UN ALGORITHME               //
//                                                           //
// Affichage des resultats obtenus durant l'algorithme       //
//                                                           //
//   - logG : tableau contenant le log base 10 de la norme   //
//            du gradient du critere pour chaque iteration   //
//            de l'algorithme d'optimisation.                //
//   - logP : tableau contenant le log base 10 du pas de     //
//            gradient pour chaque iteration.                //
//   - Cout : tableau contenant la valeur du critere pour    //
//            chaque iteration.                              //
//                                                           //
// L'affichage du cout est probablement le moins interessant //
// et peut etre omis. Afficher le log en base 10 de la norme //
// du gradient permet bien representer la convergence vers 0 //
// du gradient. Enfin,  afficher le log en base 10 du pas de //
// descente donne par l'algorithme de recherche lineaire est //
// un bon  moyen de verifier que cet algorithme de recherche //
// lineaire fonctionne de maniere satisfaisante.             //
//                                                           //
///////////////////////////////////////////////////////////////


numwin = 10;
typvis =  1;

[nlig,ncol] = size(logG);
absX = [1:nlig]';

if typvis == 0 then

//
// Affichage des 3 graphiques, un par fenetre
//

   xset("window",numwin);
   clf(numwin);
   plot2d(logG);
   xtitle('Norme du gradient (echelle logarithmique)','Iter.','log||G||');

   numwin = numwin + 1;
   xset("window",numwin);
   clf(numwin);
   plot2d(logP);
   xtitle('Pas de gradient (echelle logarithmique)','Iter.','log(alpha)');

   numwin = numwin + 1;
   xset("window",numwin);
   clf(numwin);
   plot2d(Cout);
   xtitle('Evolution du critere','Iter.','Cout');

else

//
// Affichage de 2 graphiques sur une meme fenetre
//

   xset("window",numwin);
   xset("wdim",600,650);
   clf(numwin);

   xtitle(titrgr);

   subplot(211);
   plot2d(absX,logG,style=5,...
          leg='Norme du gradient (echelle logarithmique) '+...
              'en fonction des iterations');

   subplot(212);
   plot2d(absX,logP,style=2,...
          leg='Pas de gradient (echelle logarithmique) '+...
              'en fonction des iterations');

end

endfunction
