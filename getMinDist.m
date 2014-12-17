function [ dists ] = getMinDist(cor)
%% ------------------------------------------------------------------------
% FUNCTION:
%   getMinDist()
%
% SYNTAX:       
%   dists = getMinDist(cor)
%               
% INPUTS: 
%   cor     is the list of x and y values of the corners the corner()
%           function identifies in a binary image
%           x = cor(:, 1), y = cor(:, 2)
%               
% OUTPUTS:      
%   dists   is the list of distances from each point in the array cor to
%           the nearest neighbor within in the array cor.
%               
% DESCRIPTION:  
%   This function finds the distance between a each point in the array cor
%   and its nearest neighbor
%              
% AUTHOR:       
%   Dan Sweeney
%   sweeneyd@vt.edu
%               
% LAST UPDATE:         
%   December 16, 2014
%--------------------------------------------------------------------------
    dists = zeros(1, length(cor(:, 1)));
    dist_array = dists;
    for i = 1:length(cor(:, 1))
        xe = cor(i, 1);
        ye = cor(i, 2);
        for j = 1:length(cor(:, 1))
            x2 = cor(j, 1);
            y2 = cor(j, 2);
            if i == j
                dist_array(j) = nan;
            else
                dist_array(j) = sqrt((xe - x2)^2 + (ye-y2)^2);
            end
        end
        dists(i) = min(dist_array);
    end
end