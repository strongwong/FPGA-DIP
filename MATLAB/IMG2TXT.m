clear all
close all
clc
img = imread('test.jpg');
[a,b,c]= size(img);
R1=img(:,:,1);
G1=img(:,:,2);
B1=img(:,:,3);

fidR1= fopen('testR.txt','w');
fidG1= fopen('testG.txt','w');
fidB1= fopen('testB.txt','w');
for i=1:a
    for j= 1:b
      fprintf(fidR1,'%d\n',R1(i,j)); %frame1
      fprintf(fidG1,'%d\n',G1(i,j));
      fprintf(fidB1,'%d\n',B1(i,j));
    end
end
fclose(fidR1);
fclose(fidG1);
fclose(fidB1);

%以下为对应YCbCr色域转换显示
figure,
subplot(221),imshow(imrotate(img,0)),title('YCbCr');
subplot(222),imshow(imrotate(img(:,:,1),0)),title('Y');
subplot(223),imshow(imrotate(img(:,:,2),0)),title('Cb');
subplot(224),imshow(imrotate(img(:,:,3),0)),title('Cr');
