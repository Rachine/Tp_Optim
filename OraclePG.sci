

function [z] = lulu(qc)
  Membre1=q0+B*qc;
  Membre2=abs(q0+B*qc).*(q0+B*qc).*r;
  Membre3=pr;
  Membre4=Ar*(q0+B*qc);
  z = (Membre1'*Membre2)/3 + Membre3'*Membre4;
  
endfunction 

function [y] = deriv(qc)
    Membre1=B'*(abs(q0+B*qc).*(q0+B*qc).*r);
    Membre2=(Ar*B)'*pr;
    y=Membre1+Membre2;
  endfunction
  
  

function [F, G, ind] = OraclePG (qc , ind)
    
    select ind,
  case 2 then [F,G]=(lulu(qc),0),
  case 3 then [F,G]=(0,deriv(qc)),
  case 4 then [F,G]=(lulu(qc),deriv(qc)),
    end 
endfunction
  
