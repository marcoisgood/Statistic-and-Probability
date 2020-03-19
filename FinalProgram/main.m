%%
% Read Image
image = imread('fruit1.bmp');
color_image=image;
figure;
imshow(image);
title('Original Image');

%%
%Double Threshold
[h,w,c]=size (image);
if(c==3)
image=rgb2gray(image);
end 

[Iprime, rgbTlo] = doubleThresh(image);
figure;
imshow(Iprime);
title('Treshold -- Foreground Background separated');

[L,num_components,labels] = ConnectedComponentsByRepeatedFloodfill(Iprime);


u_out = uint8(L);
figure;
imshow(u_out);
A=rgb2gray(u_out);
title('Separate Components');

%% Your algorithm to draw axes under
% Draw the axes for banans only. To find the label of bananas in separate components image, use the figures data cursor option

Ateam_BestEllipse(image,L,num_components,labels);
