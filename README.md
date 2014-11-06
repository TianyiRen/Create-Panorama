HW3
Name: Tianyi Ren
UNI: tr2400
Email: tr2400@columbia.edu

a. Given four source points and corresponding destination points, compute the eigenvalues and select the smallest one to generate Homography matrix;

b. Given points in the destination image, compute corresponding points in the source image. Only consider points within the bounding box: compute its rgb values in the dest image and set its mask to true;

c. Set parameters: ransac_n = 5000, ransac_eps = 2.5;

d. Computation of weighted mask: used the root value after bwdist function

e. Order of input arguments: center, left, right
   Used the homography matrix (from previous questions) to compute the bounding box of the warped image. If it is larger than the size of the image, compute the excess and extend the bounding box. Homography matrix should be updated every time the size gets extended; 

f. Captured Image: Watson_left.jpg, Watson_right.jpg
   Stitched Image: Watson_panorama.jpg
