
% 2D Wavelet Transform (multi-level)

clc;
clear;
close all;

% Read grayscale image
I = imread('ram.jpeg'); 

% Convert to grayscale if RGB
if size(I,3) == 3
    I = rgb2gray(I);
end

I = im2double(I);

% Display original image
figure;
imshow(I);
title('Original Image');

% Perform 2-level 2D DWT using 'haar' wavelet
level = 2; 
wavelet = 'haar';
[C,S] = wavedec2(I, level, wavelet);

% Extract approximation and detail coefficients at each level
CA2 = appcoef2(C,S,wavelet,2); % Level 2 approximation
[CH2,CV2,CD2] = detcoef2('all',C,S,2); % Level 2 details

CA1 = appcoef2(C,S,wavelet,1); % Level 1 approximation
[CH1,CV1,CD1] = detcoef2('all',C,S,1); % Level 1 details

% Display Level 2 coefficients
figure;
subplot(2,2,1); imshow(CA2,[]); title('Approximation CA2');
subplot(2,2,2); imshow(CH2,[]); title('Horizontal Detail CH2');
subplot(2,2,3); imshow(CV2,[]); title('Vertical Detail CV2');
subplot(2,2,4); imshow(CD2,[]); title('Diagonal Detail CD2');

% Reconstruct image from coefficients
I_rec = waverec2(C,S,wavelet);

% Display reconstructed image
figure;
imshow(I_rec,[]);
title('Reconstructed Image after 2-Level DWT');

% Calculate reconstruction error
error = immse(I, I_rec);
fprintf('Reconstruction Mean Squared Error: %.6f\n', error);
