function [ N ] = get_N( L )
%LUM2IMG Summary of this function goes here
%   Detailed explanation goes here

m1 = 2610/4096/4;
m2 = 2523/4096*128;
c2 = 2413/4096*32;
c3 = 2392/4096*32;
c1 = c3-c2+1;

N = ((c1 + c2*L.^m1)./(1 + c3*L.^m1)).^m2;

end