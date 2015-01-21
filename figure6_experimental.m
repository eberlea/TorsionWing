function figur6experimental_withraw(zdisp_fnr, zdisp_fr, zdisp_nfr,t)

% Plotting experimental data 
len = length(zdisp_fnr(:,1,1)); 

zsum_fnr = zeros(167,9,5);
index1 = 1:168:len;
index2 = 169:168:len; 
for k = 1:7
    i = index1(k);
    j = index2(k);
    zdiff_fnr(:,k) = zdisp_fnr(i:j,end,end)-zdisp_fnr(i:j,end,1); 

end 
zdiffavg_fnr = mean((zdiff_fnr'));
stdzdiff_fnr = std((zdiff_fnr'),0);


%%
%zdisp_fr = z_fr; 
zsum_fr = zeros(168,9,5);
index1 = 1:168:len;
index2 = 169:168:len; 
for k = 1:7
    i = index1(k);
    j = index2(k);
    zdiff_fr(:,k) = zdisp_fr(i:j,end,end)-zdisp_fr(i:j,end,1); 
end 
zdiffavg_fr = mean((zdiff_fr'));
stdzdiff_fr = std((zdiff_fr'),0);
%%

zsum_fr = zeros(168,9,5);
index1 = 1:168:len;
index2 = 169:168:len; 
for k = 1:7
    i = index1(k);
    j = index2(k);
    zdiff_nfr(:,k) = zdisp_nfr(i:j,end,end)-zdisp_nfr(i:j,end,1); 
end 
zdiffavg_nfr = mean((zdiff_nfr'));
stdzdiff_nfr = std((zdiff_nfr'),0);
%%
axis([0 0.33 -0.06 0.06])
subplot(3,2,2)
[h1,hp] = boundedline(t(1:169),zdiffavg_fnr,stdzdiff_fnr,'b');
axis([0 0.33 -0.06 0.06])
h=text(0.08,0.075,'Experimental Results');
set(h,'FontName','Times')
h=text(-0.05,0.065,'(d)');
set(h,'FontName','Times')
set(gca,'YTick',[-0.05,0,0.05])
set(gca,'YTickLabel',[])

subplot(3,2,4)
[h1,hp] = boundedline(t(1:169),zdiffavg_fr,stdzdiff_fr,'g');
axis([0 0.33 -0.06 0.06])
h=text(-0.05,0.065,'(e)');
set(h,'FontName','Times')
xlabel('t (s)','FontName','Times')
set(gca,'YTick',[-0.05,0,0.05])
set(gca,'YTickLabel',[])

%%

Fs = 500;
L = 169;
NFFT = (L);
f = Fs/2*linspace(0,1,NFFT/2+1);

Y_tot_fr = fft(zdisp_fr(:,end,end)-zdisp_fr(:,end,1),NFFT)/L;
Y_tot_fnr = fft(zdisp_fnr(:,end,end)-zdisp_fnr(:,end,1),NFFT)/L;
for i = 1:7
    Y_nfr(:,i) = fft(zdiff_nfr(:,i)-mean(zdiff_nfr(:,i)),NFFT)/L;
    Y_fr(:,i) = fft(zdiff_fr(:,i)-mean(zdiff_fr(:,i)),NFFT)/L;
    Y_fnr(:,i) = fft(zdiff_fnr(:,i)-mean(zdiff_fnr(:,i)),NFFT)/L;
end

Z_nfr = mean(abs(Y_nfr),2);
stdZ_nfr = std(abs(Y_nfr),0,2);
Z_fr = mean(abs(Y_fr),2);
stdZ_fr = std(abs(Y_fr),0,2);
Z_fnr = mean(abs(Y_fnr),2);
stdZ_fnr = std(abs(Y_fnr),0,2);


Fs = 500;
L = length(zdisp_fr(:,1,1));
NFFT = (L);
f = Fs/2*linspace(0,1,NFFT/2+1);

Y_tot_fr = fft(zdisp_fr(:,end,end)-zdisp_fr(:,end,1),NFFT)/L;
Y_tot_fnr = fft(zdisp_fnr(:,end,end)-zdisp_fnr(:,end,1),NFFT)/L;
%%

min=-5e-3;
max=20e-3;
subplot(3,2,6)
plot(f-1.5,2*abs(Y_tot_fr(1:NFFT/2+1))-2*abs(Y_tot_fnr(1:NFFT/2+1)),'k')
axis([0 100 min max])
xlabel('f (Hz)','FontName','Times')
set(gca,'XTick',[22 28 50 75])
h=text(-14.24,22e-3,'(f)');
set(h,'FontName','Times')
h = line([22 22],[min max]);
set(h,'LineStyle','--')
set(h,'Color','r')
h = line([28 28],[min max]);
set(h,'LineStyle','--');
set(h,'Color','r')
set(gca,'YTickLabel',[])


