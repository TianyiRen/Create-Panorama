function stitched_img = stitchImg(varargin)
input = varargin{1};
[m,n,l] = size(input);
test = [1,1;n,1;1,m;n,m];
stitched_img = input;
count = 1;
param = 0.1;
while count < length(varargin)
    count = count+1;
    input = varargin{count};
    [Xs, Xd] = genSIFTMatches(input, stitched_img);
    [inliers_id, H_3x3] = runRANSAC(Xs, Xd, 5000, 2.5);
    dest = applyHomography(H_3x3, test);
    bounding_1 = min(dest(:,1));
    bounding_2 = max(dest(:,1));
    bounding_3 = min(dest(:,2));
    bounding_4 = max(dest(:,2));
    %extend the size of the image if out-of-boundary
    if (bounding_1 < 1)
        stitched_img = [zeros(m,ceil(1-bounding_1),l),stitched_img];
    end
    if (bounding_2 > n)
        stitched_img = [stitched_img,zeros(m,ceil(bounding_2-n),l)];
    end
    n = n+max(0,ceil(1-bounding_1))+max(0,ceil(bounding_2-n));
    if (bounding_3 < 1)
        stitched_img = [zeros(ceil(1-bounding_3),n,l);stitched_img];
    end
    if (bounding_4 > m)
        stitched_img = [stitched_img;zeros(ceil(bounding_4-m),n,l)];
    end
    m = m + max(0,ceil(bounding_4-m)) + max(0,ceil(1-bounding_3));
    
    dest(:,1) = floor(dest(:,1)) + max(0,ceil(1-bounding_1));
    dest(:,2) = floor(dest(:,2)) + max(0,ceil(1-bounding_3));
    %update Homography matrix
    H_3x3 = computeHomography(test, dest);
    dest_canvas_width_height = [size(stitched_img, 2), size(stitched_img, 1)];
    [mask, dest_img] = backwardWarpImg(input, inv(H_3x3), dest_canvas_width_height);
    stitched_img = blendImagePair(dest_img*255, mask, stitched_img*255, rgb2gray(stitched_img),'blend', param);
    stitched_img = im2single(stitched_img); 
end
