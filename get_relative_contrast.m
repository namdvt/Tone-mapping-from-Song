function [ relative_contrast ] = get_relative_contrast( L, Lamb, Ls, X )
% Get the relative contrast
%
% Input Arguments:
% L : Display luminance in cd/m2
% Lamb : Ambient light in lx
% Ls : Adaptive luminance in cd/m2
% X : Field of view in degree
%
% Output Arguments:
% tmc : tone mapping curve

fq = 0:0.1:20;
CSF = zeros(1,length(L));
Milchelson_contrast = zeros(1,length(L));

for j=1:1:length(L)
    % find max CSF of a luminance value under difference frequencies
    CSF_fq = ones(1, length(fq));
    for i=1:1:length(fq)
        CSF_fq(i) = get_CSF(fq(i), L(j), Ls + Lamb/pi, X);
    end
    CSF(j) = max(CSF_fq);
    
    % measure the Milchelson contrast
    if j~=1
        Milchelson_contrast(j) = (L(j)-L(j-1))/(L(j)+L(j-1)+2*Lamb/pi);
        Milchelson_contrast(j)=max(Milchelson_contrast(j),0.001);
    end
end

% compute relative contrast based on 
% S. Miller, M. Nezamabadi and S. Daly, "Perceptual Signal Coding for More 
% Efficient Usage of Bit Codes," The 2012 Annual Technical Conference & Exhibition, 
% Hollywood, CA, USA, 2012, pp. 1-9
relative_contrast = 2*CSF.*Milchelson_contrast*1.27/2;
end

