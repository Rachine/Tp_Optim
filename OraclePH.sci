

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
  

function [y]= hessien(qc)
        d = diag(r.*abs(q0+B*qc));
        y= 2*B'*d*B;
    
endfunction
  
  

function [F, G, H, ind] = OraclePG (qc , ind)
    
    select ind,
  case 2 then [F,G,H]=(lulu(qc),0,0),
  case 3 then [F,G,H]=(0,deriv(qc),0),
  case 4 then [F,G,H]=(lulu(qc),deriv(qc),0),
  case 5 then [F,G,H]=(0,0,hessien(qc)),
  case 6 then [F,G,H]=(0,deriv(qc),hessien(qc)),
  case 7 then [F,G,H]=(lulu(qc),deriv(qc),hessien(qc)),
    end 
endfunction
  
