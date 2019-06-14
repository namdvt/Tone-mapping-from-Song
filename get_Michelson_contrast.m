function [ contrast ] = get_Michelson_contrast( L1, L2, Lamb )
    contrast = 2*abs(L1-L2)/(L1+L2+2*Lamb/pi);
    contrast=max(contrast,0.001);
end

