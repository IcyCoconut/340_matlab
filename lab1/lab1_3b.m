% this is 26x16 matrix A 
A = [1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0; 0 0 0 0 1 1 1 1 0 0 0 0 0 0 0 0; ...
    0 0 0 0 0 0 0 0 1 1 1 1 0 0 0 0; 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1; ...
    1 0 0 0 1 0 0 0 1 0 0 0 1 0 0 0; 0 1 0 0 0 1 0 0 0 1 0 0 0 1 0 0; ...
    0 0 1 0 0 0 1 0 0 0 1 0 0 0 1 0; 0 0 0 1 0 0 0 1 0 0 0 1 0 0 0 1; ...
    1 1 0 0 1 0 0 0 0 0 0 0 0 0 0 0; 0 0 1 0 0 1 0 0 1 0 0 0 0 0 0 0; 0 0 0 1 0 0 1 0 0 1 0 0 1 0 0 0; ...
    0 0 0 0 0 0 0 1 0 0 1 0 0 1 0 0; 0 0 0 0 0 0 0 0 0 0 0 1 0 0 1 1; ...
    0 0 1 1 0 0 0 1 0 0 0 0 0 0 0 0; 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0; 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1; ...
    0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0; 0 0 0 0 0 0 0 0 1 0 0 0 1 1 0 0; ...
    0 1 1 1 0 0 0 1 0 0 0 0 0 0 0 0; 1 0 0 0 0 1 1 0 0 0 0 1 0 0 0 0; ...
    0 0 0 0 1 0 0 0 0 1 1 0 0 0 0 1; 0 0 0 0 0 0 0 0 1 0 0 0 1 1 0 0; ...
    1 1 0 0 1 0 0 0 1 0 0 0 0 0 0 0; 0 0 1 0 0 1 0 0 0 1 0 0 1 0 0 0; ...
    0 0 0 1 0 0 1 0 0 0 1 0 0 1 0 0; 0 0 0 0 0 0 0 1 0 0 0 1 0 0 1 1];
    
x = [9 14 10 8; 1 9 11 14; 8 5 10 3; 16 8 11 9];

b = A * reshape(x, [16, 1]);

reCalcX = reshape(A \ b, [4,4]);

A16 = [A(1:7, :); A(9:12, :); A(14:16, :); A(19, :); A(23, :)];
b16 = [b(1:7, :); b(9:12, :); b(14:16, :); b(19, :); b(23, :)];

rank(A16);




