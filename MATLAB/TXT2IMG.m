clear all
close all
clc

imgori = imread('test.jpg');
[a,b,c]= size(imgori);

img1R = uint8(textread('R.txt','%u'));
img1G = uint8(textread('G.txt','%u'));
img1B = uint8(textread('B.txt','%u'));

img1(:,:,1) = reshape(img1R,[b,a]);
img1(:,:,2) = reshape(img1G,[b,a]);
img1(:,:,3) = reshape(img1B,[b,a]);

img=flipdim(img1,1);

figure,
subplot(221),imshow(imrotate(img,-90)),title('YCbCr');
subplot(222),imshow(imrotate(img(:,:,1),-90)),title('Y');
subplot(223),imshow(imrotate(img(:,:,2),-90)),title('Cb');
subplot(224),imshow(imrotate(img(:,:,3),-90)),title('Cr');
