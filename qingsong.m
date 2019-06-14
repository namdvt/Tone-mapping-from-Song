function [ Ptgt ] = qingsong( in, Lamb )
% clear all
%% params
Xref = 40;
Lamb = Lamb + 0.1;
Ls = 80;
%% EOTF of the target TV (Standard EOTF with 1,000 nits peak)
p = 0:1:1023;
EOTF = 10000*get_L(p/1023);
% Lref = min(EOTF,1000); 
Lref = EOTF;
Lref(1) = 5e-05;
%% EOTF of the reference TV (Calibrated EOTF with 500 nits peak)
% a1 =        1347 ;
% b1 =        1157  ;
% c1 =       117.7  ;
% a2 =       627.5 ;
% b2 =        1025  ;
% c2 =       137.4  ;
% a3 =       67.44  ;
% b3 =       859.4  ;
% c3 =       113.5  ;
% a4 =       627.5  ;
% b4 =       937.3  ;
% c4 =       307.4  ;
% ltgt =   a1*exp(-((p-b1)/c1).^2) + a2*exp(-((p-b2)/c2).^2) + ...
%       a3*exp(-((p-b3)/c3).^2) + a4*exp(-((p-b4)/c4).^2);
% ltgt = min(ltgt, 500);

%% ref TV
n_ref = get_relative_contrast(Lref, 0, Ls, Xref);
%% image
% in = dpxread('D:\Samsung\input\im (2).dpx');
in = max(in,1);
hist = get_histogram(in);
hist = hist/1024;
%% recursive
start_point = 0;
end_point = 10;
count = 0;
z = 1;
while(1)
    count = count + 1;
    alpha = start_point + (end_point-start_point)/2;
    Ltgt = zeros(1,1024)*1e-5+Lamb/pi;
    for p=z:1:1023-z
        Ct_tgt_p = get_minimum_detectable_contrast(Ltgt(p), Lamb, Ls, Xref);
        temp = alpha*n_ref(p)*Ct_tgt_p*hist(p);
        Ltgt(p+1) = Ltgt(p)*(2 + temp)/abs(2 - temp);
    end
    Ltgt(1024) = Ltgt(1023);
    if (Ltgt(1024) - Lamb/pi < 500)
        start_point = alpha;
    end
    if (Ltgt(1024) - Lamb/pi > 500)
        end_point = alpha;
    end
    if (or(count == 20, Ltgt(1024) - Lamb/pi == 500))
        break;
    end
end

for p=1023-z:1:1024
    Ltgt(p) = Ltgt(1023-z);
end

Ptgt = 1023*get_N((Ltgt-Lamb/pi)/10000);
%% plot
% subplot(2,2,1)
% compare = min(EOTF,500);
% plot_ref = plot(compare);
% hold on
% plot_tgt = plot(Ltgt);
% hold off
% legend([plot_ref, plot_tgt],{'ref','tgt'},'Location','SouthEast');
% 
% subplot(2,2,2)
% linear = 1:1:1024;
% plot_ref = plot(linear); hold on
% plot_tgt = plot(Ptgt); hold off
% legend([plot_ref, plot_tgt],{'ref','tgt'},'Location','SouthEast');
% 
% subplot(2,2,3)
% n_tgt = get_relative_contrast(Ltgt, 0, Ls, Xref);
% plot_ref = plot(n_ref); hold on
% plot_tgt = plot(n_tgt); hold off
% legend([plot_ref, plot_tgt],{'ref','tgt'},'Location','SouthEast');
% 
% %% output
% subplot(2,2,4)
% out = Ptgt(in);
% imshow(double(out)/1024);

end

