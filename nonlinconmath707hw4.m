function [c,ceq] = nonlinconmath707hw4(x)

%we need to set these things up again
location_degree = [40.774336 -73.967533; %new york
    42.357230 -71.047202; %boston
    39.956580 -75.16646; %philadelphia
    38.94323 -77.018673; %washington
    40.429653 -79.990111] ; %pittsburgh

location_radians = location_degree * pi/180; 

J = @(theta, phi) [-sin(theta)*cos(phi) -cos(theta)*sin(phi); 
    -sin(theta)*sin(phi) cos(theta)*cos(phi); 
    cos(theta) 0]; 
J_NY = J(location_radians(1,1) ,location_radians(1,2)) ; %use new york as reference
 
diffangular_norm = @(angle) (J_NY*angle)'*J_NY*angle;

%the constraints 
boston = @(angle) diffangular_norm((angle - location_radians(2,:))'); 
newyork = @(angle) diffangular_norm((angle - location_radians(1,:))'); 
philadelphia = @(angle) diffangular_norm((angle - location_radians(3,:))'); 
washington = @(angle) diffangular_norm((angle - location_radians(4,:))'); 
pittsburgh = @(angle) diffangular_norm((angle - location_radians(5,:))'); 

c1 = @(angle, s) boston(angle) - s;
c2 = @(angle, s) newyork(angle) - s; 
c3 = @(angle, s) philadelphia(angle) - s; 
c4 = @(angle, s) washington(angle) - s; 
c5 = @(angle, s) pittsburgh(angle) - s; 

c_inter = @ (angle, s) [c1(angle,s); 
    c2(angle,s);
    c3(angle,s);
    c4(angle,s);
    c5(angle,s)] ; 

angle = [x(1), x(2)];
s = x(3);
c = c_inter(angle,s); 
ceq = []; 
end