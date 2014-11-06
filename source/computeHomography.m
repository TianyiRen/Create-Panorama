function H_3x3 = computeHomography(src_pts_nx2, dest_pts_nx2)

xs = src_pts_nx2(:,1);
ys = src_pts_nx2(:,2);
xd = dest_pts_nx2(:,1);
yd = dest_pts_nx2(:,2);

A = zeros(8,8);

for i = 1:4
    A(2*i-1,1:3) = [xs(i),ys(i),1];
    A(2*i,4:6) = [xs(i),ys(i),1];
    A(2*i-1,7:9) = -xd(i)*[xs(i),ys(i),1];
    A(2*i,7:9) = -yd(i)*[xs(i),ys(i),1];
end
[V,D] = eig(A'*A);
[lambda,col] = min(diag(D));

vector = V(:,col);
for i = 1:3
        H_3x3(1,i) = vector(i);
        H_3x3(2,i) = vector(1*3+i);
        H_3x3(3,i) = vector(2*3+i);
end
