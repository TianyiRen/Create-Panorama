function [mask, result_img] = backwardWarpImg(src_img, resultToSrc_H,...
    dest_canvas_width_height)

p1 = dest_canvas_width_height(1);
p2 = dest_canvas_width_height(2);
x = repmat((1:p1)',1,p2)';
x = x(:)';
y = repmat(1:p2,1,p1);
F = resultToSrc_H * [x;y;ones(1,p1*p2)];
xn = F(1,:)./F(3,:);
yn = F(2,:)./F(3,:);
[m,n,l] = size(src_img);
%Ignore points that are out-of-boundary
id = find(xn >= 1 & xn <= n & yn >= 1 & yn <= m);
result_img = zeros(p1*p2,3);
%compute RGB
for i = 1 : 3
    result_img(id, i) = interp2(src_img(:,:,i),xn(id(:)),yn(id(:)));
end
result_img = reshape(result_img,p2,p1,3);
mask = zeros(1,p1*p2);
mask(id) = 1;
mask = reshape(mask,p2,p1);