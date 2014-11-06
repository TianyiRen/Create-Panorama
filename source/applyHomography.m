function dest_pts_nx2 = applyHomography(H_3x3, src_pts_nx2)
M(1,:)=src_pts_nx2(:,1)';
M(2,:)=src_pts_nx2(:,2)';
M(3,:)=ones(1,length(src_pts_nx2));
F=H_3x3*M;
for i=1:2
    x(i,:)= F(i,:)./F(3,:);
end
dest_pts_nx2 = x';