clear all;

close all;

clc;

img = imread('test.jpg');

figure,imshow(img);

img1 = rgb2ycbcr(img); 

figure,
subplot(221),imshow(imrotate(img1,0)),title('YCbCr');
subplot(222),imshow(imrotate(img1(:,:,1),0)),title('Y');
subplot(223),imshow(imrotate(img1(:,:,2),0)),title('Cb');
subplot(224),imshow(imrotate(img1(:,:,3),0)),title('Cr');
