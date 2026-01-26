clc;
clear all;
close all;

% Read image
I = imread('ronaldo.jpeg');   % Color image

% Convert to grayscale if RGB
if size(I,3) == 3
    I = rgb2gray(I);
end

I = im2uint8(I);

% Display original image
figure;
imshow(I);
title('Original Grayscale Image');

% Bit Plane Slicing
figure;
bit_planes = zeros([size(I), 8]);   % Store bit planes

for k = 1:8
    bit_planes(:,:,k) = bitget(I, k);
    
    subplot(2,4,k);
    imshow(bit_planes(:,:,k) * 255);  % Scale for visibility
    title(['Bit Plane ', num2str(k)]);
end

% Reconstruction using ALL bit planes
reconstructed_full = zeros(size(I), 'uint8');

for k = 1:8
    reconstructed_full = reconstructed_full + ...
        uint8(bit_planes(:,:,k) * 2^(k-1));
end

figure;
imshow(reconstructed_full);
title('Reconstructed Image (All Bit Planes)');

% Reconstruction using MSB planes (6,7,8)
reconstructed_msb = ...
    bit_planes(:,:,8)*128 + ...
    bit_planes(:,:,7)*64 + ...
    bit_planes(:,:,6)*32;

figure;
imshow(uint8(reconstructed_msb));
title('Reconstructed Image (MSB Bit Planes Only)');
