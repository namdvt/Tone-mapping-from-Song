function [ CSF ] = get_CSF( fq,L,Ls,X )
% Calculate contrast sensitivity based on paper entitled:
% P. G. J. Barten, “Formula for the contrast sensitivity of the human eye,” 
% in Proc. SPIE Image Quality and System Performance, Dec. 2003.
%
% Input Arguments:
% fq: Spatial frequency in cycle/degree
% L: Display luminance in cd/m2
% Ls: Surround luminance in cd/m2
% X: Field of view in degree
%
% Output Arguments:
% CSF: Contrast sensitivity

Itm1 = 5400*exp(-0.0016*fq.^2*(1+100/L)^0.08);
Itm2 = 1+144/(X^2)+0.64*fq.^2;
Itm3 = 63./(L^0.86)+1./(1-exp(-0.02*fq.^2));
CSF_uncorrected = Itm1./sqrt(Itm2.*Itm3);

Itm4 = (Ls/L)*(1+144/(X^2))^0.25;
Itm5 = (1+144/(X^2))^0.25;
Itm6 = ((log(Itm4))^2-(log(Itm5))^2)/(2*log(32)*log(32));
Surround_factor = exp(-Itm6);
CSF = CSF_uncorrected.*Surround_factor;
end