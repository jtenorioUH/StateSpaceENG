clc
format long

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Part 1
fprintf('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n')
fprintf('Part 1\n\n')
%A, B, C, D matrix
fprintf('A, B, C, D matrix for our state space system\n')
A=[1 -14 -1 0;1 -1 0 1;0 0 0 1;1 -5 0 -.5], B=[-1 -.1 0 -9]', C=[1 1 0 1],D=0

%State Space representation
fprintf('State Space Representation\n')
state=ss(A,B,C,D)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Part 2.
fprintf('\n\n%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n')
fprintf('Part 2\n\n')

%Stability, eigenvalues, and zeros of simulation
fprintf('Stability, eigenvalues, and zeros of simulation\n')

%defining the tranfer function stateTF
stateTF=tf(state)

%zero poles and gains
[z, p ,k]=zpkdata(stateTF);
fprintf('\nFactored form of stateTF\n')
zpk(stateTF)
Z=cell2mat(z);
P=cell2mat(p);

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

fprintf('Next we determine stability\n\n')
%Next we determine stability

counter=0; %We set the counter to zero
for n=1:numel(P)
    if P(n,1)>0
        counter=n;
        fprintf('The system is unstable because of pole %f\n',P(n,1))
    
    elseif ((n==numel(P))&(counter==0))
            fprintf('The system is stable, no pole to the left of jw axis\n')
   
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Part 3
fprintf('\n\n%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n')
fprintf('Part 3\n\n')
fprintf('See figure\n')

%Impulse input to state space
figure('Name','Impulse input into state space model','NumberTitle','off')
impulse(state,100)

%Step input to state space
figure('Name','Step input into state space model','NumberTitle','off')
step(state,100)

%Sinusoidal input to state space
figure('Name','Sinusoidal input into state space model','NumberTitle','off')
T = 0:0.01:100;        
U = sin(2*pi*T);    % no input
X0 = [0 0 0 0];    % initial conditions of the three states
lsim(state, U, T, X0)  % "state" is the system model

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Part 4
fprintf('\n\n%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n')
fprintf('Part 4\n\n')
fprintf('Controller Type Transformation\n')

[Tc To]=TC(A,B,C);
Ac=Tc*A*inv(Tc)
Bc=Tc*B
Cc=C*inv(Tc)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Part 5
%Observer Type Transformation

fprintf('\n\n%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n')
fprintf('Part 5\n\n')
fprintf('Observer Type Transformation\n')

Ao=inv(To)*A*To
Bo=inv(To)*B
Co=C*To

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Part 6
%Controller design
fprintf('\n\n%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n')
fprintf('Part 6\n\n')
fprintf('Controller design\n')

%Now we find state space feedback vector K
fprintf('\nNow we find state space feedback vector K\n\n')
[z, p ,k]=zpkdata(stateTF);
P=cell2mat(p);
P=P';
fprintf('Original poles of the system\n')
P

for n=1:numel(P)
    if P(1,n)>0
        P(1,n)=-1*real(P(1,n))+i*(imag(P(1,n)));
    end
end


fprintf('P with poles at -2.8, -2.4, -2+2i, -2-2j\n')
P=[-2.8, -2.4, -2+2i, -2-2i]

K=acker(A,B,P)
fprintf('A_hat=A-BK\n')
A_hat=A-B*K
fprintf('Eigen values of new A_hat\n')
eig(A_hat)
stateTF_New=ss(A_hat,B,C,D);
figure('Name','Step input at specified poles','NumberTitle','off')
step(stateTF_New)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Part 7

fprintf('See figures\n')

%Impulse input to state space
figure('Name','Impulse input with Controller','NumberTitle','off')
impulse(stateTF_New,4)

%Step input to state space
figure('Name','Step input into with Controller','NumberTitle','off')
step(stateTF_New,4)

%Sinusoidal input to state space
figure('Name','Sinusoidal input with Controller','NumberTitle','off')
T = 0:0.01:100;        
U = sin(2*pi*T);    % no input
X0 = [0 0 0 0];    % initial conditions of the three states
lsim(stateTF_New, U, T, X0)  % "state" is the system model

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Part 8
