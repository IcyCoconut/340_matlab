% Usage:
% coefficients = func_fit(X_data, Y_data, basis, type, parameters)
% basis = an array with one or more of "polynomial", "trigonometric", "exponential"
% type = one of "approximation", "interpolation"
% parameters = [degree of poly, degree of trig, degree of expo]

% Example:
% coe_1 = func_fit([1 2 3], [1 4 9], ["polynomial"], "interpolation", [2 0 0])
% coe_2 = func_fit(X, FX, ["polynomial", "trigonometric"], "approximation", [2 2 0])

function [coefficient_vector] = func_fit(X, Y, basis, type, parameters)
    % visualize the original dataset first
    scatter(X, Y, 'k');
    hold on;
    
    % deside the degree of functions
    % depends on the mode
    if type == "approximation"
        for i = 1:3
            degree(i) = parameters(i);
        end
    elseif type == "interpolation"
        for i = 1:3
            degree(i) = length(X) - 1;
        end
    end
    
    
    % generate Vandermonde matrix and make similar matrix for trig and exp functions
    
    % A is used to combine different basis by concatenate matrices
    
    % first and last are used to remember which coefficients are polynomial
    % terms, or trig terms, or exponential terms. For example, all elements
    % in coefficient_vector between first(2) and last(2) are coefficients
    % of trigonometric terms
    A = [];
    first = [1 1 1];
    last = [1 1 1];
    if max(ismember(basis, "polynomial"))
        V = fliplr(vander(X));
        if degree(1) < length(X)
            V = V(:, 1:degree(1)+1);
        end
        A = [V];
        [~, last(1)] = size(A);
        first(2) = last(1) + 1;
    end
    if max(ismember(basis, "trigonometric"))
        V = ones(size(X));
        for i = 1:degree(2)
            V = [V; sin(i*X);cos(i*X)];
        end
        V = V.';
        A = [A V];
        [~, last(2)] = size(A);
        first(3) = last(2)+1;
    end
    if max(ismember(basis, "exponential"))
        V = ones(size(X));
        for i = 1:degree(3)
            V = [V; exp(i*X)];
        end
        V = V.';
        A = [A V];
        [~, last(3)] = size(A);
    end

    % This is the one we should return
    coefficient_vector = A\(Y.');
    
    % draw graph
    
    % prepare test_x and test_y, they are used to draw a more detailed
    % graph of how our function really looks like
    test_x = [min(X):0.01:max(X)];
    test_y = ones(size(test_x)) * coefficient_vector(first(1), 1);
    if max(ismember(basis, "polynomial"))
        % calculate each y with respect to each x in test_x
        % by substituting each coefficient
        for i = first(1)+1:last(1)
            test_y = test_y + test_x.^(i-1) * coefficient_vector(i, 1);
        end
    end
    if max(ismember(basis, "trigonometric"))
        % I must treat indecis differently depends on how many different
        % types of basis I have
        if max(ismember(basis, "polynomial"))
            test_y = test_y + coefficient_vector(first(2), 1);
            for i = first(2)+1:2:last(2)
                test_y = test_y + ...
                    sin(((i-last(1))/2)*test_x) * coefficient_vector(i, 1) + ...
                    cos((i-last(1)/2)*test_x) * coefficient_vector(i+1,1);
            end
        else
            for i = first(2)+1:2:last(2)
                test_y = test_y + ...
                    sin((i/2)*test_x) * coefficient_vector(i, 1) + ...
                    cos((i/2)*test_x) * coefficient_vector(i+1,1);
            end
        end
    end
    if max(ismember(basis, "exponential"))
        if (max(ismember(basis, "polynomial")) || max(ismember(basis, "trigonometric")))
            test_y = test_y + coefficient_vector(first(3), 1);
            for i = first(3)+1:last(3)
                test_y = test_y + exp((i-max(last(2:3))-1)*test_x) * coefficient_vector(i, 1);
            end
        else
            for i = first(3)+1:last(3)
                test_y = test_y + exp((i-1)*test_x) * coefficient_vector(i, 1);
            end
        end
    end
    
    Y_predict = A * coefficient_vector;
    
    % draw line of x and f(x) for x = [min(X): 0.01: max(X)]
    % this is more detail
    plot(test_x, test_y, 'y-.'); % -.-.-.-.-.- line
    
    % draw line of x and f(x) for each x in original dataset
    % this is less detail, but it shows how predicted f(x) fists to the
    % original dataset
    plot(X, Y_predict, 'r:.');   % ......*.... line
    title('My Implementation');
    hold off;
end