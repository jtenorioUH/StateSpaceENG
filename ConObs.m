function [y1, y2, y3, y4]=ConObs(A,B,C) %y1=P,y2=inv(P),y3=Q,y4=inv(Q)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[m,n]=size(A);
    if m==n %we have to check if matrix is squared
        P=zeros(m);
        Q=zeros(m);
        for ind=1:m
            P(:,ind)=A^(ind-1)*B; %defining P and Q
            Q(ind,:)=C*A^(ind-1);
        end
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
%checking to see if matrix are singular
            y1=P;
            if det(y1)~0;
                y2=inv(P);
            else
                y2=0;
            end

            y3=Q;
            if det(y3)~0;
                y4=inv(Q);
            else
                 y4=0;
            end
            
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%            
%going through the different cases for P & Q
            if (rank(P)==m)&(rank(Q)==m)
                fprintf('The rank of the Pc matrix is: %d\n',rank(P))
                fprintf('The rank of the Oc matrix is: %d\n',rank(Q))
                fprintf('Matrix is both controllable & obervable\n');
            elseif rank(P)==m
                fprintf('The rank of the Pc matrix is: %d\n',rank(Q))
                fprintf('matrix is only controllable\n');
            elseif rank(Q)==m
                fprintf('The rank of the Oc matrix is: %d\n',rank(Q))
                fprintf('matrix is only obervable\n');
            elseif ~(rank(P)==m)&~(rank(Q)==m)   
                fprintf('The rank of the Pc matrix is: %d\n',rank(P))
                fprintf('The rank of the Oc matrix is: %d\n',rank(Q))
                fprintf('matrix is not controllable or obervable\n');
            end
    else
        fprintf('A must be a square matrix') %incase matrix is not squared
    end
end

