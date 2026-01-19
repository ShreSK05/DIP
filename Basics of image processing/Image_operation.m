clear all;
close all;
clc;
I=imread('demo.png');
imshow(I);
figure;
Ig=rgb2gray(I);
imshow(Ig)
Ired=I;
Ired(:,:,2)=0;
Ired(:,:,3)=0;
figure;
imshow(Ired)
Ib=Ig>100;
figure;
imshow(Ib);
Ieq=histeq(Ig);
figure;
imshow(Ieq);

