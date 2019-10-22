% This is test #1
% it should have result x = [0.125; 1.625; 0.875]
A = [1,0,1; 1/3,1,0; 2/3,1/3,1];
b = [1;5/3;3/2];

% this is test #2
% it should have result x = [11; 10; 6]
% A = [1,-1,0; -1,2,-1; 0,-1,2];
% b = [1; 3; 2];

% these 3 lines of code will solve for x such that Ax = b
[L, U] = myLU(A);
y = fwdSubst(L,b);
x = backSubst(U,y)

% Given A, k. It Returns M_k and L_k
function [M, L] = elimMat(A, k)
    [~, n] = size(A);
    
    % recursively solve for M_k-1 first
    if k ~= 1
        [Mprev, ~] = elimMat(A, k-1);
        A = Mprev * A;
    end
    
    % initialize e and m
    e = eye(n);
    e = e(:, k).';
    m = zeros(n, 1);
    
    % fill m according to A
    m(k+1:n, 1) = A(k+1:n, k) / A(k, k);
    
    % this is formula of M_k, L_k is the inverse of M_k
    M = eye(n) - m * e;
    L = inv(M);
    
end

% Given A. It returns L and U
function [L, U] = myLU(A)
    
    % initialize n, U, L
    [~, n] = size(A);
    U = A;
    L = eye(n);
    
    % increase k to generate M_1 to M_n-1 and L_1 to L_n-1
    for k = 1:n-1
        if A(k, k) == 0
            break;
        end
        
        [Mk,Lk] = elimMat(A, k);
        
        % U = M_k * M_k-1 * M_k-2 * ... * M_1 * A
        % L = I * L_k * L_k-1 * L_k-2 * ... * L_1
        U = Mk*U;
        L = L*Lk;
    end
    
end

% Given U, y. It returns x such that Ux = y
function x = backSubst(U, y)
% initialize n and x
    [~, n] = size(U);
    x = zeros(n, 1);
    
    % traverse backward
    for j = n:-1:1
        if U(j, j) == 0
            break;
        end
        % calculate a new x element
        x(j, 1) = y(j, 1) / U(j, j);
        % substitude the new x element
        y(1:j-1, 1) = y(1:j-1, 1) - U(1:j-1, j) * x(j, 1);
    end
    
end

% Given L, b. It returns y such that Ly = b
function y = fwdSubst(L, b)
    % initialize n and y
    [~, n] = size(L);
    y = zeros(n, 1);

    % forward traverse
    for j = 1:n
        if L(j, j) == 0
            break;
        end
        % calculate a new y element
        y(j, 1) = b(j, 1) / L(j, j);
        % substitude the new y element
        b(j+1:n, 1) = b(j+1:n, 1) - L(j+1:n, j) * y(j, 1);
    end
end