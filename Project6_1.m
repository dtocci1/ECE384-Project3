%% ECE 384 Project 6.1
%% Tyler Botelho, Lewis Brum, Matt LaVoie, Dylan Tocci
clear;clc; close all;

% 1. Generate six sequences of uniform random variables (length = 10,000) in the
% range [−0.5, 0.5]. Each element in the ith sequence can be considered to be one
% realization of the random variable Xi
    % Generate six sequences
    X1 = unifrnd(-0.5,0.5,[1 10000]); % Generate random uniform distribution with 10000 points
    X2 = unifrnd(-0.5,0.5,[1 10000]); % Generate random uniform distribution with 10000 points
    X3 = unifrnd(-0.5,0.5,[1 10000]); % Generate random uniform distribution with 10000 points
    X4 = unifrnd(-0.5,0.5,[1 10000]); % Generate random uniform distribution with 10000 points
    X5 = unifrnd(-0.5,0.5,[1 10000]); % Generate random uniform distribution with 10000 points
    X6 = unifrnd(-0.5,0.5,[1 10000]); % Generate random uniform distribution with 10000 points
    
    % Generate new random variables Y1 and Y2
    Y1 = X1+X2+X3+X4+X5+X6; % -2.5 to 2.5
    Y2 = X1 + (0.5.*X2) + (0.8.*X3) + (1.8.*X4) + (0.3.*X5) + (0.5.*X6); % -2.45 to 2.45
    
    [PDY1,CDY1,pY1Range, cY1Range] = PdfCdf(Y1,25); % Calculate Y1 PDF and CDF with 25 bins
    [PDY2,CDY2,pY2Range, cY2Range] = PdfCdf(Y2,25); % Calculate Y2 PDF and CDF with 25 bins
    
    % Generate measured PDF, CDF, mean, and variance for Y1 and Y2
    
    figure(1);
    subplot(2,2,1)
    plot(pY1Range, PDY1);
    xlim([-2.5,2.5])
    subplot(2,2,2)
    plot(cY1Range,CDY1);
    xlim([-2.5,2.5])
    subplot(2,2,3)
    plot(pY2Range,PDY2);
    xlim([-2.5,2.5])
    subplot(2,2,4)
    plot(cY2Range,CDY2);
    xlim([-2.5,2.5])
    
    mY1=mean(Y1)
    mY2=mean(Y2)
    varY1=var(Y1)
    varY2=var(Y2)
    
    xRange = linspace(-2.5,2.5,10000);
    Y1T = normpdf(xRange,mY1,sqrt(varY1));
    Y2T = normpdf(xRange,mY2,sqrt(varY2));

    % Plot theoretical PDF
    figure(1)
    subplot(2,2,1)
    hold on;
    plot(xRange,Y1T);
    hold off;
    subplot(2,2,3)
    hold on;
    plot(xRange,Y2T);
    hold off;
    
    %Y2T = normcdf(x,mu,sd);
    
    
    
    
% 2. Generate 20 sequences of IID exponential random variables Xi using parameter
% lambda = 0.5i for the ith sequence.

    lambda = 0.5;
    Y=0;
    % summation from 1 to 20 of Xi
    for i = 1:20
        Y = Y + exprnd(lambda*i,1,10000); % generates [1:10000] vector Xi and sums it
    end
  
    [PDY,CDY,pYRange, cYRange] = PdfCdf(Y,20) % generates PDF with 20 bins (looked best)
    
    figure(2)
    subplot(2,1,1)
    plot(pYRange, PDY)
    subplot(2,1,2);
    plot(cYRange, CDY)

% 3. Successively convolve 50 Bernoulli PMFs (not the random variables). Choose
% p = 0.8 for all of the PMFs. Plot and compare the shape (only the shape)
% of the result to that of the Gaussian PDF