function [inliers_id, H] = runRANSAC(Xs, Xd, ransac_n, ransac_eps)
max = 0;
i = 1;
while i <= ransac_n
    id = randi(length(Xs),1,4);
    H_3x3 = computeHomography(Xs(id,:), Xd(id,:));
    Dd = applyHomography(H_3x3, Xs);
    diff = Dd - Xd;
    s = sqrt(sum(diff.*diff,2));
    index = find(s < ransac_eps);
    if length(index) > max
        max = length(index);
        H = H_3x3;
        inliers_id = index;
    end
    i = i+1;
end