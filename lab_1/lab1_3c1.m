load char_c1.mat
load mri_c1.mat
for i = 1:7
    img = reshape(Achar\Bchar(:, i), imsize).'; 
    subplot(1, 7, i);
    imshow(img);
end


for i = 1:10
    img = reshape(Amri\Bmri(:, i), imsize).';
    subplot(1, 10, i);
    imshow(img);
end




