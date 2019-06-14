function [ his ] = get_histogram( img )
img = rgb2gray(img);
his = zeros(1,1024);
[h,w] = size(img);
for i=1:h
    for j=1:w
        his(img(i,j)) = his(img(i,j)) + 1;
    end
end
end

