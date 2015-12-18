clc
format long

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Part 1(b)
fprintf('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n')
fprintf('1. (b)\n')
%A, B, C, D matrix
fprintf('A, B, C, D matrix for our state space system\n')
A=[0 1 0 0;0 0 1 0;0 0 0 1;-5.465 89.11 -15.49 -11.65], B=[0 0 0 1]', C=[263.4 29.21 -.000928 0],D=0

%State Space representation
fprintf('State Space Representation\n')
state=ss(A,B,C,D)
%Step input to state space
figure('Name','Step input into state space model','NumberTitle','off')
step(state,10)

%defining the tranfer function stateTF
stateTF=tf(state)

%zero poles and gains
[z, p ,k]=zpkdata(stateTF);
fprintf('\nFactored form of stateTF\n')
zpk(stateTF)
Z=cell2mat(z);
P=cell2mat(p);

fprintf('1. (c)\n')
fprintf('The zeros/poles of the tranferfunction are:\n\n')
for n=1:numel(Z)
    if n==1
        fprintf('Zeros:\n')
    end
        fprintf('%f\n',Z(n,1))
end

fprintf('\n')

for n=1:numel(P)
    if n==1
        fprintf('Poles:\n')
    end
        fprintf('%f\n',P(n,1))
end

fprintf('\n')

%Next we determine stability
%We set the counter to zero
counter=0;
for i=1:numel(P)
    if P(i,1)>0
        counter=i;
        fprintf('The system is unstable because of pole %f\n',P(i,1))
    
    elseif ((i==numel(P))&(counter==0))
            fprintf('The system is stable, no pole to the left of jw axis\n')
   
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Part 2 (a)
fprintf('\n%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n')
fprintf('Part 2 (a)\n')
Gc=pidtune(stateTF,pid)
Mc=feedback(Gc*stateTF,1)
figure('Name','Step input into the system with pid','NumberTitle','off')
figure(2)
step(Mc)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Part 3 (a)
fprintf('\n%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n')
fprintf('Part 3 (a)\n')
fprintf('Poles and zeros for original system:\n')
for n=1:numel(Z)
    if n==1
        fprintf('Zeros:\n')
    end
        fprintf('%f\n',Z(n,1))
end

fprintf('\n')

for n=1:numel(P)
    if n==1
        fprintf('Poles:\n')
    end
        fprintf('%f\n',P(n,1))
end

fprintf('\nPart 3 (b)\n')

fprintf('Poles and zeros for original system with negative feedback:\n')
[z, p ,k]=zpkdata(feedback(stateTF,1));
%fprintf('\nFactored form of stateTF\n')
%zpk(feedback(stateTF,1))
Z=cell2mat(z);
P=cell2mat(p);
for n=1:numel(Z)
    if n==1
        fprintf('Zeros:\n')
    end
        fprintf('%f\n',Z(n,1))
end

fprintf('\n')

for n=1:numel(P)
    if n==1
        fprintf('Poles:\n')
    end
        fprintf('%f\n',P(n,1))
end

fprintf('\nPart 3 (c)\n')
fprintf('Poles and zeros for original system with negative feedback and PID:\n')
Gc=pidtune(stateTF,pid);
Mc=feedback(Gc*stateTF,1);
[z, p ,k]=zpkdata(Mc);
%fprintf('\nFactored form of stateTF\n')
%zpk(feedback(stateTF,1))
Z=cell2mat(z);
P=cell2mat(p);
for n=1:numel(Z)
    if n==1
        fprintf('Zeros:\n')
    end
        fprintf('%f\n',Z(n,1))
end

fprintf('\n')

for n=1:numel(P)
    if n==1
        fprintf('Poles:\n')
    end
        fprintf('%f\n',P(n,1))
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Part 4(a)

fprintf('\n%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n')
fprintf('Part 4(a)\n')
%Now we find state space feedback vector K
fprintf('\nNow we find state space feedback vector K\n')
[z, p ,k]=zpkdata(stateTF);
P=cell2mat(p);
P=P';
for i=1:numel(P)
    if P(1,i)>0
        P(1,i)=-1*P(1,i);
    end
end

K=acker(A,B,P)
fprintf('A_hat=A-BK\n')
A_hat=A-B*K
eig(A_hat)
stateTF_New=ss(A_hat,B,C,D)
figure('Name','Step input into state feedback model','NumberTitle','off')
step(stateTF_New)