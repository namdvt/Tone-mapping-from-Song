function [ L ] = get_L( N )
% Pixel value to luminance conversion
%
% Input Argument:
% N : Pixel value (0-1)
%
% Output Argument:
% L : Luminance value (0-1)

m1 = 2610/4096/4;
m2 = 2523/4096*128;
c2 = 2413/4096*32;
c3 = 2392/4096*32;
c1 = c3-c2+1;

L = (max((N.^(1/m2)-c1),0)./(c2-c3*N.^(1/m2))).^(1/m1);
end

