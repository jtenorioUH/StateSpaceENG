# StateSpaceENG
Here are two projects that I've worked on. 

Lab 2: 
tate Space Feedback Stabilization of Lifting Body Elevator Plant Model Using Matlab and Simulink
-Developed Simulink model of Lifting Body Elevator to analyze outputs for pitch rate, angle of attack, and speed change using a step input. Unbounded output resulted in unstable system and low performance
-Developed outer loop control algorithms via a PID controller to stabilize plant (See Github Link)
-Developed  controller with state feedback to have poles at -2.8, -2.4, -2±2j using A ̂=A-B ⃑K ⃑,A and B come from the state space matrix and K is the calculated feedback vector 

ConObs(A,B,C):
A is a matrix and B,c are vectors.
This function checks to see if the matrix A is squared. If A is nonsingular then we are able to find the Controllability matrix P and Observability matrix Q. If P is invertible then the system is controllable. If Q is invertible then the system is observable. The function returns the results for P and Q and returns the rank.

[Tc To] = TC(A,B,C)
A is a matrix and B,c are vectors.
This function uses a function handle to ConObs.m to check for controllability and observability. If the matrix A is controllable or observable TC(A,B,C) uses the function handle to pass in the Q and P matrix. It then find the controller type transformation matrix and observer type transformation matrix to convert our state space system into controller type companion form. 

