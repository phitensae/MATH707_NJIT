function [F b y_exact samplePts DCT_inv] = A6_Q1(m)

    n = 100;            %Length of the signal (change to increase resolution)
    

    %--------------------------------------------------
    %Generate the "True" signal.
    %
    %Test signal create
    L = pi;
    h = L/n;
    x = (0:(n-1))'*h;
    %num_s = 6;  %Number of cosine modes in signal
    %w = [.3 2 -1 -4 2 4]        %Create weights
    %f = [1 5 8 12 15 20];       %Create frequencies
    
    num_s = 4;  %Number of cosine modes in signal
    w = [.3 2 -1 -4];        %Create weights
    f = [1 5 8 12 ];       %Create frequencies
    
    y = zeros(n, 1);            
    for jj = 1:num_s
        y = y + w(jj)*cos(f(jj)*x);
    end
    %amp = 0;
    %y = y + (amp*rand(n, 1)-amp/2);
    %--------------------------------------------------
    
    %--------------------------------------------------
    % Choose 'm' random sampling points
    tempPts = sort( floor(n*rand(m,1)) + 1 );       %Choose m-- random points at random
    samplePts = [];                                 %Remove duplicate sampling points
    for jj = 2:m
         if (tempPts(jj-1) == tempPts(jj) )
         else
            samplePts = [samplePts; tempPts(jj)];
         end
    end
    while size(samplePts, 1) < m
        ind = floor(n*rand(1)) + 1; 
        if (isempty(find(samplePts == ind)) == 1)
            samplePts = sort([samplePts; ind]);
        end
    end
    %--------------------------------------------------
    
    DCT_mat = dctmtx(n);
    DCT_inv = inv(DCT_mat);
    A = DCT_inv(samplePts, :);
    b = y(samplePts);
    F = [A -A];
    y_exact = y;
    
    num_vec = 1:n;
    %plot(x, y, x(samplePts), y(samplePts), 'o')
    plot(num_vec, y, num_vec(samplePts), y(samplePts), 'o', 'linewidth', 2)
    title('Exact signal, and points sampled')
    legend('y (exact)', 'm-samples')
    xlabel('n'); ylabel('y')
end


