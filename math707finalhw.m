%% problem 1
close all
clear all
clc

count = 1;
m = 95
[F,b,y,samplepoints,D] = A6_Q1(m);
t = 1000000; 

f = @(w)  w * ones(size(w))'  + 1/t * sum(-log(w)); 
A = [];
Aeq = F; 
beq = b;
lb = []; 
w = zeros(1,200); 
ub = []; 
w0 = 2*randn(size(w)) + 6 ; 
b_mincon = [];
nonlincon = []; 
%options = optimoptions('fmincon','Algorithm','sqp');


%w_star = fmincon(f,w0,A,b_mincon,Aeq,beq,lb,ub,nonlincon,options); 
w_star = fmincon(f,w0,A,b_mincon,Aeq,beq,lb,ub,nonlincon);


ustar = w_star(1:100); 
vstar = w_star(101:200); 

Zstar = ustar - vstar; 
zstar = D\Zstar'; 
n = 1:100; 
plot(n,y,'k',n,zstar,'rx-')
legend('exact','approximate')
title(sprintf('Using %d points at random',m))