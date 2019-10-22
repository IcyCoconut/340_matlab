load lab2_p1_data.mat
import func_fit.*

% X1 and Y1 points sho a very clear and clean trigonomitric pattern
x = [min(X1):0.01:max(X1)];
y = interp1(X1, Y1, x);
plot(X1, Y1, x, y);
title('Matlab built in interpolation function');
pause();

coefficient_vector = func_fit(X1, Y1, "trigonometric", "interpolation", [0 1 0]);
pause();

net = feedforwardnet(4);
net = train(net, x, y);
plotfit(net, x, y);
hold off;
pause();
close all;

coefficient_vector = func_fit(X1, Y1, "trigonometric", "approximation", [0 3 0]);
pause();

% X2 and Y2 shows a quadratic function pattern, but there are small noices
x = [min(X2):0.01:max(X2)];
y = interp1(X2, Y2, x);
plot(X2, Y2, x, y);
title('Matlab built in interpolation function');
pause();

coefficient_vector2 = func_fit(X2, Y2, "polynomial", "interpolation", [1 0 0]);
pause();

net = feedforwardnet(4);
net = train(net, x, y);
plotfit(net, x, y);
hold off;
pause();
close all;

coefficient_vector = func_fit(X2, Y2, "polynomial", "approximation", [2 0 0]);
pause();
close all;





