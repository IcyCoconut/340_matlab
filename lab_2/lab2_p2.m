import func_fit.*

% dataset I, just use polynomial interpolation
% The answer is:
% y = 486 - 4.86x^2
% The function fits data very well, because it follows gravitation law,
% 4.86 * 2 = 9.71 which is close to gravity of the Earth, the data may
% be recorded every 0.5 second. 
T = [ 0.  1.  2.  3.  4.  5.  6.  7.  8.  9. 10.];
D = [486.   481.14 466.56 442.26 408.24 364.5  311.04 247.86 174.96  92.34 0.  ];
coefficient_vector = func_fit(T, D, "polynomial", "interpolation", [2 0 0])
pause();
clear();


% dataset II, also use a degree-2 polynomial to approximate it
% The answer is:
% y = -0.133 + 0.0067x + 1.0114x^2
% We cannot use interpolation which causes an overfitting and Runge's Phenomenon
% The derivative between points will be too big or small and becomes meaningless
load datasetII.mat
coefficient_vector = func_fit(x, y, "polynomial", "approximation", [2 0 0])

% calculate the derivative at each point and total area under all data points
syms var
f = -0.133 + 0.0067*var + 1.0114*var^2;
df = simplify(diff(f));
dfdx = double(subs(df, x))

area = double(int(f, -5, 5))

pause();
clear();

% dataset IV, use a degree-2 polynomial and degree-10 trigonometric
% combination to approximate it (actually interpolation)
% The answer is:
% y = -0.5x^2 + 0.3*sin(10x)
% The function best model the drift is 0.3*sin(10x)
load datasetIV.mat
coefficient_vector = func_fit(X2, Y2, ["polynomial" "trigonometric"], "approximation", [2 10 0])