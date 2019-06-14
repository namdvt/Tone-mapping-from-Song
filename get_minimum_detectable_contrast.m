function [ minimum_detectable_contrast ] = get_minimum_detectable_contrast( L, Lamb, Ls, X )

fq = 0:0.1:20;

% find max CSF of a luminance value under difference frequencies
CSF_fq = ones(1, length(fq));
for i=1:1:length(fq)
    CSF_fq(i) = get_CSF(fq(i), L, Ls + Lamb/pi, X);
end
CSF = max(CSF_fq);

minimum_detectable_contrast = 1/CSF*2/1.27;
end

