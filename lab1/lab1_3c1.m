% S C I E N C E
load char_c1.mat
[~, img_count] = size(Bchar);
for i = 1:img_count
    x = Achar\Bchar(:, i);
    x = reshape(x, imsize).'; 
    subplot(1, img_count, i);
    imshow(x);
end

% pause and wait an enter to run the next task
pause();

% B R A I N
load mri_c1.mat
[~, img_count] = size(Bmri);
for i = 1:img_count
    x = Amri\Bmri(:, i);
    x = reshape(x, imsize).';
    subplot(2, img_count/2, i);
    imshow(x);
end




