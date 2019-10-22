load EllipsePoints.mat;

hold on

axis equal
plot(Y1(1, :), Y1(2, :), '*')
%plot(Y2(1, :), Y2(2, :), '.')
%plot(Y3(1, :), Y3(2, :), '.')

[A_mean, A_normalized, D, V] = myPCA(Y1);
plot(A_normalized(1,:), A_normalized(2,:), '.')

function [A_mean, A_normalized, D, V] = myPCA(A)
    A_mean = mean(A, 2);
    centerA = A - A_mean * ones(1, size(A, 2));

    covar = centerA * centerA.' / size(A, 2);

    [V, D] = eig(covar);
    
    A_normalized =  covar * centerA;
    
    hold on
    plot(centerA(1,:), centerA(2,:), 'g.');
    plot(D(1,1) * [0 V(1,1)], D(1,1) * [0 V(2,1)], 'r->');
    plot(D(2,2) * [0 V(1,2)], D(2,2) * [0 V(2,2)], 'b->');

end