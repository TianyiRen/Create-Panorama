function out_img = blendImagePair(wrapped_imgs, masks, wrapped_imgd, maskd, mode, param)

masks = logical(masks);
maskd = logical(maskd);
fm = masks.*maskd;
Ds = bwdist(masks-fm)+1;
Dd = bwdist(maskd-fm)+1;
switch mode
    case 'blend'
        z1 = Ds.*masks;
        z2 = Dd.*maskd;
        max1 = max(z1(:));
        max2 = max(z2(:));
        z1 = (max1+1-z1).*masks/max1;
        z2 = (max2+1-z2).*maskd/max2;
        z1 = nthroot(z1,param);
        z2 = nthroot(z2,param);
        out_img = uint8((double(wrapped_imgs).*cat(3, z1, z1, z1)+double(wrapped_imgd).*cat(3, z2, z2, z2))./cat(3,z1+z2,z1+z2,z1+z2));
    case 'overlay'
        out_img = (wrapped_imgs.*uint8(cat(3, masks, masks, masks))).*uint8(cat(3,~maskd,~maskd,~maskd))+wrapped_imgd.*uint8(cat(3, maskd, maskd, maskd));
end
