clc;
clear;
close all;

% ------------------ Input Image (8x8 Matrix) ------------------
I = [52 55 61 59 79 61 76 61;
     62 59 55 104 94 85 59 71;
     63 65 66 113 144 104 63 72;
     64 70 70 126 154 109 71 69;
     67 73 68 106 122 88 68 68;
     68 79 60 70 77 66 58 75;
     69 85 64 58 55 61 65 83;
     70 87 69 68 65 73 78 90];

I = uint8(I);   % Convert to uint8

% ------------------ Step 1: Histogram Calculation ------------------
[counts, grayLevels] = imhist(I);

% ------------------ Step 2: PDF Calculation ------------------
numPixels = numel(I);
pdf = counts / numPixels;

% ------------------ Step 3: CDF Calculation ------------------
cdf = cumsum(pdf);

% ------------------ Step 4: Normalize CDF ------------------
L = 256;  % Number of gray levels
cdf_norm = round((L - 1) * cdf);

% ------------------ Step 5: Intensity Mapping ------------------
I_eq = zeros(size(I), 'uint8');

for i = 1:numel(I)
    I_eq(i) = cdf_norm(I(i) + 1);
end

% ------------------ Step 6: Display Results ------------------
figure('Name','Histogram Equalization Without histeq');

subplot(2,2,1);
imshow(I);
title('Original Image');

subplot(2,2,2);
imhist(I);
title('Original Histogram');

subplot(2,2,3);
imshow(I_eq);
title('Equalized Image');

subplot(2,2,4);
imhist(I_eq);
title('Equalized Histogram');

% ------------------ Display Output Matrix ------------------
disp('Original Matrix:');
disp(I);

disp('Histogram Equalized Matrix:');
disp(I_eq);
