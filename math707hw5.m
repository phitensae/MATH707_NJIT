%% math 707 hw problem 4
close all
clear all
clc 

M = 100; %max number of iterations 
f = @(x) x(1)^2 + 6*x(2) + x(2)^2 + 2*x(6)^3 - x(3); 
g = @(x) x(1) + x(2) - x(3) - 1; 

LHS = @(x,nu) [2 0 0 1; 
    0 2 0 1; 
    0 0 60*x(3)^4 -1; 
    1 1 -1 0]; 
RHS = @(x,nu) [-2*x(1); 
    -(2*x(2) + 6); 
    -(12*x(3)^5 - 1); 
    0];

x = zeros(3,M);
x(:,1) = [1 0 0]';
nu = 5; 

for ii = 1:M-1
    xn = x(:,ii); %use the last recorded guess for x
    A = LHS(xn,nu); 
    b = RHS(xn,nu); 
    dz = A\b; 
    dx = dz(1:3);
    nu = dz(4); %update the value of nu 
    x_new = xn + dx; %update the value of xn 
    x(:,ii+1) = x_new;
    e = x_new - xn; 
    if abs(e) < 1e-8
        disp('The method has converged officially')
        break
    end
end
solution = x_new; 
fprintf('x(1) = %2.9f, x(2) = %2.9f, x(3) = %2.9f \n',solution(1),solution(2),solution(3))

%% hw problem 2 
close all
clear all
clc 

load A5_Q2_data.mat
psi = @(z) z.^2 + z.^4; 
lambda = 1; 
f = @(x)  sum(psi(x - y)) + lambda * sum((x(2:end) - x(1:end-1)).^2); 

A = []; 
b = []; 
x_star = fmincon(f,y,A,b); 
t = linspace(0,1,length(y)); 
plot(t,x_star,'k',t,y,'b')

hold on 

lambda = 10; 
f = @(x)  sum(psi(x - y)) + lambda * sum((x(2:end) - x(1:end-1)).^2); 

A = []; 
b = []; 
x_star = fmincon(f,y,A,b); 
t = linspace(0,1,length(y)); 
plot(t,x_star,'r')


hold on 
lambda = 1000; 
f = @(x)  sum(psi(x - y)) + lambda * sum((x(2:end) - x(1:end-1)).^2); 

A = []; 
b = []; 
x_star = fmincon(f,y,A,b); 
t = linspace(0,1,length(y)); 
plot(t,x_star,'g')

legend('original','\lambda = 1','\lambda = 10','\lambda = 1000')