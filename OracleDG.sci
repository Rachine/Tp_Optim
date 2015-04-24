function[qdiese]= get_qdiese (lambda)
    qdiese = abs((r.^(-1)).*(Ar'*pr+Ad'*lambda));
    qdiese=qdiese.^(1/2);
    qdiese = qdiese.*(-sign((r.^(-1)).*abs(Ar'*pr+Ad'*lambda)));
endfunction

function [z] = lulu(lambda)
  qdiese = get_qdiese(lambda);
  Membre2=abs(qdiese).*qdiese.*r;
  Membre3=pr;
  Membre4=Ar*qdiese;
  Membre5=Ad*qdiese-fd;
  z = (qdiese'*Membre2)/3 + Membre3'*Membre4+lambda'*Membre5;
  z=-z;
  
endfunction 

function [y] = deriv(lambda)
    qdiese=get_qdiese(lambda);
    y=Ad*qdiese-fd;
    y=-y;
  endfunction
  
  

function [F, G, ind] = OracleDG (qc , ind)
    
    select ind,
  case 2 then [F,G]=(lulu(qc),0),
  case 3 then [F,G]=(0,deriv(qc)),
  case 4 then [F,G]=(lulu(qc),deriv(qc)),
    end 
endfunction
  
