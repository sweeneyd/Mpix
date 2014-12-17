function [ dists ] = getminDist(cor)
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