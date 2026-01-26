
% Huffman coding with manual computation
clc;
clear;
close all;

% Input symbols and probabilities
symbols = {'m1','m2','m3','m4','m5','m6','m7','m8'};
P = [0.22 0.18 0.15 0.12 0.10 0.09 0.08 0.06];

% Normalize probabilities
P = P / sum(P);

% Display given symbols and probabilities
disp('Given Symbols and Probabilities');
for i = 1:length(symbols)
    fprintf('%s : %.3f\n', symbols{i}, P(i));
end

% Manual Huffman computation (probability merging)
disp(' ');
disp('Manual Huffman Merging Steps');

temp_probs = P;
temp_syms = symbols;

step = 1;
while length(temp_probs) > 1
    
    [temp_probs, idx] = sort(temp_probs);
    temp_syms = temp_syms(idx);
    
    fprintf('Step %d: Merge %.3f (%s) and %.3f (%s) -> %.3f\n', ...
        step, temp_probs(1), temp_syms{1}, temp_probs(2), temp_syms{2}, ...
        temp_probs(1) + temp_probs(2));
    
    temp_probs(2) = temp_probs(1) + temp_probs(2);
    temp_syms{2} = [temp_syms{1} '+' temp_syms{2}];
    
    temp_probs(1) = [];
    temp_syms(1) = [];
    
    step = step + 1;
end

% Generate Huffman dictionary
dict = huffmandict(symbols, P);

% Display final Huffman codes
disp(' ');
disp('Final Huffman Codes');
for i = 1:length(dict)
    codeStr = num2str(dict{i,2});
    codeStr(codeStr==' ') = '';
    fprintf('%s  P=%.3f  Code=%s\n', ...
        dict{i,1}, P(strcmp(symbols,dict{i,1})), codeStr);
end
