function result_img = ...
    showCorrespondence(orig_img, warped_img, src_pts_nx2, dest_pts_nx2)
fh1=figure();
imshow([orig_img,warped_img]);
hold on; 
plot(src_pts_nx2(:,1), src_pts_nx2(:,2), 'r.', 'MarkerFaceColor', [1 1 1]);
hold on;
plot(dest_pts_nx2(:,1)+size(orig_img,2), dest_pts_nx2(:,2), 'r.', 'MarkerFaceColor', [1 1 1]);
srcLen = length(src_pts_nx2);
for i=1:srcLen
    line([src_pts_nx2(i,1), dest_pts_nx2(i,1)+size(orig_img,2)], [src_pts_nx2(i,2), dest_pts_nx2(i,2)], 'LineWidth',1.2, 'Color', [1, 0, 0]);
end

set(fh1, 'WindowStyle', 'normal');
img = getimage(fh1);
truesize(fh1, [size(img, 1), size(img, 2)]);
frame = getframe(fh1);
frame = getframe(fh1);
result_img = frame.cdata;