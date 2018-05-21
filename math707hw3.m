%% for problem 2d
clear all
close all
clc 

Z = [-2 0 6; 
    0 1 0; 
    6 0 -2]; 
Z
[v,D] = eig(Z); 
eigenvalues = diag(D); 

running_sum = eigenvalues .* (eigenvalues >=0); 
N = length(running_sum); 
A = zeros(N,N);

for ii = 1:N
    p(:,ii) = norm(v(:,ii))*v(:,ii); %it would be nice to get whole numbers
    A = A + running_sum(ii)*p(:,ii)*p(:,ii)';
end
A
%% for problem 3b
x = -5:.001:5;
f = @(x) 1./(1+x.^2); 
g = @(x) x - 2; 

h = @(x) f(g(x)) + g(f(x)); 
plot(x,h(x))
title('f(g(x)) + g(f(x))')