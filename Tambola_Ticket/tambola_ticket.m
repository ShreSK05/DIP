
% Tambola (Housie) Ticket Generator
% 3 x 9 ticket with 15 numbers

clc;
clear;

ticket = zeros(3,9);   % Empty ticket

% Column-wise number ranges
ranges = [1 9;
          10 19;
          20 29;
          30 39;
          40 49;
          50 59;
          60 69;
          70 79;
          80 90];

% Step 1: Decide number of entries per column (1 or 2)
colCount = ones(1,9);
extra = 6;   % Need total 15 numbers (9 + 6)

while extra > 0
    idx = randi(9);
    if colCount(idx) < 2
        colCount(idx) = colCount(idx) + 1;
        extra = extra - 1;
    end
end

% Step 2: Fill numbers column-wise
for c = 1:9
    nums = randperm(ranges(c,2) - ranges(c,1) + 1, colCount(c)) ...
           + ranges(c,1) - 1;
    nums = sort(nums);

    rows = randperm(3, colCount(c));
    for k = 1:colCount(c)
        ticket(rows(k), c) = nums(k);
    end
end

% Step 3: Ensure 5 numbers per row
for r = 1:3
    while nnz(ticket(r,:)) > 5
        cols = find(ticket(r,:) ~= 0);
        c = cols(randi(length(cols)));
        ticket(r,c) = 0;
    end
end

% Display ticket
disp('Tambola Ticket');
disp(ticket);
