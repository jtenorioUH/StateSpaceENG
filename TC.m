function [Tc To]= TC(A,B,C)
 Control=@ConObs;
 
 [y1, y2, y3, y4]=Control(A,B,C); %y1=P,y2=inv(P),y3=Q,y4=inv(Q)
 
   [m,n]=size(y1);
   Bc=zeros(m,1);
   Bc(m,1)=1;
   Co=Bc';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
 if det(y1)~0;
 
        T_c1=Bc'*inv(y1);
        
        for n=1:size(y1)
            Tc(n,:)=T_c1*A^(n-1);
        end
 else 
     fprintf('\nNo controller type tranform exist because P matrix is singular\n')
end
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 if det(y3)~0;
     
        T_o1=inv(y3)*Co';
        
        for n=1:size(y3)
            To(:,n)=A^(n-1)*T_o1;
        end
 else
     fprintf('\nNo observer type tranform exist because Q matrix is singular\n')
     
 end
end