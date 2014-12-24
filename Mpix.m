function [pix_dim] = Mpix(filename, corners)
%% ------------------------------------------------------------------------
% FUNCTION:
%   Mpix()
%
% SYNTAX:       
%   pix_dim = Mpix(example.jpg, corners)
%               
% INPUTS: 
%   example.jpg     is a .jpg image file the poor wretch is trying to find
%                   the length of the side of a pixel from the original 
%                   image. example.jpg should be a sufficiently pixelated 
%                   image that has been zoomed too far and resaved as a 
%                   .jpg, losing scale information. 
%
%   corners         is the number of corners the algorithm will find within 
%                   the canny edges (corners = 300 by default)
%
%   (NOTE: this method should not replace scaling information placed in the
%   original file by the imaging modality software (CT, microscopy, etc.)
%   and will be nowhere as accurate as the original measurements.)
%               
% OUTPUTS:      
%   pix_dim         is the mode side length of the original pixel prior to 
%                   import
%               
% DESCRIPTION:  
%   This function calculates the length of a pixel in a
%   pixelated image using 
%              
% AUTHOR:       
%   Dan Sweeney
%   sweeneyd@vt.edu
%               
% LAST UPDATE:         
%   December 16, 2014
%--------------------------------------------------------------------------
    if nargin < 2
        corners = 300;
    end
    raw = imread(filename);
    bw_avg = rgb2gray(raw);
    canny_bw = edge(bw_avg, 'canny');
    cor = corner(canny_bw, corners);
    d = getMinDist(cor);
    bins = ceil(2/3*corners);
    h = histogram(d, bins);
    hist_width = get(h, 'BinWidth');
    hist_vals = get(h, 'Values');
    pix_dim = hist_width*find(hist_vals == max(hist_vals), 1);
    
    % If to big, cut off top and bottom 10%
    if pix_dim < 15
        pix_dim = hist_width*find(hist_vals(floor(bins/10):end) == max(hist_vals(floor(bins/10):end)), 1);
    end
end
