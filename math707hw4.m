%% math 707 hw 
clear all
close all
clc

Z = [3 1 -1; 
    1 1 1;
    -1 1 9]; 
[v,D] = eig(Z)

%% problem least squares 
clc
close all
clear all

A = [1 2]
[U,S,V] = svd(A)
T = pinv(A)


a = [1 2]'; %all vectors by convention are column vectors
b = 3; 
L = 0:.5:10;
xpi = zeros(2,length(L));

count = 1;

for lambda = L
    f = @(x) norm(a'*x-b) + lambda*norm(x,4); %assume x \in R^2 
    J = @(x) [2*(a(1)*x(1) + a(2) * x(2) - b) * a(1) + 4*lambda*x(1)^3, 2*(a(1) * x(1) + a(2) * x(2) - b) * a(2) + 4 * lambda * x(2)^3];
    %this is the jacobian of f 
    soln = fsolve(J,[.6 1.2]); %we start at x0 = pinv(A) * b
    xpi(:,count) = soln; 
    count = count + 1; 
end

%this is the solutions for lambda
plot(xpi(1,:),xpi(2,:),'ko-')


%this is the boundary of the ball 
x = -1:.001:1;
y = x; 

hold on 

[X,Y]  = meshgrid(x,y); 
Z = X.^4 + Y.^4;
contour(X,Y,Z,[1,1],'ShowText','on'); 
xlabel('x_1')
ylabel('x_2')

%this is the set S 

x2 = 0:.001:2; 
x1 = 3 - 2*x2; 

hold on 

plot(x1,x2)
title('locus of optimimum x_{PI}')
%% minimum distance n points in R^n 
close all
clear all
clc 

location_degree = [40.774336 -73.967533; %new york
    42.357230 -71.047202; %boston
    39.956580 -75.16646; %philadelphia
    38.94323 -77.018673; %washington
    40.429653 -79.990111] ; %pittsburgh

location_radians = location_degree * pi/180; 

radian_0 = (location_radians(1,:) + location_radians(end,:))/2; %start the initial guess midway between pittsburgh and new york 
x0 = [radian_0 0]; 


f0_inter = @(angle, s) s;
f00 = @(x) f0_inter([x(1) x(2)], x(3));
f0 = @(x) x(3); 

A = [];
b = []; 
Aeq = []; 
beq = []; 
lb = [0,-pi,-Inf];
ub = [pi,0,Inf]; 



xstar_rad = fmincon(f00,x0,A,b,Aeq,beq,lb,ub,@nonlinconmath707hw4); %note that you need the @ symbol to make sure it recognizes that this is a function 
xstar_deg = [xstar_rad(1:2)*180/pi xstar_rad(3)];
lat_opt = xstar_deg(1); 
long_opt = xstar_deg(2); 
fprintf('The latitude and longtitude coordinates of the meeting location are %2.6f N and %2.6f W\n',lat_opt,long_opt)