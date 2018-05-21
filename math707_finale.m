clear all; close all; clc

sv = 3; %start Vertex
ev = 6; %end Vertex
numVerticies = 8; 

big = 9999999; %instead of using inf
bigg = 999999999;
%weightsMat = inf(numVerticies); % all edges start at infinite weight
weightsMat = [0,2,0,0,0,1,0,0;
    2,0,2,2,4,0,0,0;
    0,2,0,0,3,0,0,1;
    0,2,0,0,4,3,0,0;
    0,4,3,4,0,0,7,0;
    1,0,0,3,0,0,5,0;
    0,0,0,0,7,5,0,6;
    0,0,1,0,0,0,6,0];

cost = big.*ones(1,numVerticies);
cost(sv) = 0; %no cost assigned to start vertex

t = ones(1,numVerticies); %being 1 here means the shortest cost path is unknown
cur = sv;% current vertex is set to start vertex
va = zeros(numVerticies);

while(t(ev)==1)
    %choose v with min cost thats in t
    i =i+1;
    
    temp = cost + bigg.*(t==0);
    [m,v] = min(temp);
    t(v) = 0;
    
    for ii = 1:numVerticies    
        if (t(ii)~=0) && (weightsMat(ii,v) ~= 0)
            if cost(ii)>transpose(weightsMat(ii,v))+cost(v)
                cost(ii)= transpose(weightsMat(ii,v))+cost(v);
                vA(ii) = v;
            end
        end
    end
    
    a = (transpose(t~=0) & weightsMat(:,v) ~= 0);
    cost(a)= min(cost(a),transpose(weightsMat(a,v))+cost(v));
end

path = [];
rr = ev;
path = [ev];

while rr ~= sv
    rr = vA(rr);
    path = [rr , path];
end

path
Cost =cost(ev)