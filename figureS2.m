function figure6(zdiff_rot_comp,zdiff_flap_comp,zdiff_flaprot_comp,T,zdisp_fnr, zdisp_fr, zdisp_nfr,t)
% Plotting Figure 6
fig_pos = [25,25,700,900];
h=figure('Position',fig_pos,'Color',[1 1 1]);
set(h,'DefaultTextFontSize',11)
set(h,'DefaultAxesFontsize',11)
set(h,'DefaultTextFontName','Times')
set(h,'DefaultAxesFontName','Times')


%% Computational results 
% Find peaks in data so time averaging can be done accurately 
P=findpeaks(1:length(zdiff_flap_comp),zdiff_flaprot_comp,0,-5,20,5,3);
index = 1; 
for k = 10:10:length(P(:,2))-10
    i = round(P(k,2));
    j = i+332;
    rot(:,index) = (zdiff_rot_comp(i:j));
    flap(:,index) = (zdiff_flap_comp(i:j));
    flaprot(:,index) = (zdiff_flaprot_comp(i:j));
    index = index +1; 
end

% Take average of results over each rotation cycle 
avg_r = mean(rot');
std_r = std(rot',0); 
avg_f = mean(flap');
std_f = std((flap'),0);
avg_fr = mean(flaprot');
std_fr = std(flaprot',0);

% Put into matrix for rotating alone, flapping alone, and flapping and rotating 
zdiff_comp(1,:) = avg_r;
zdiff_comp(2,:) = avg_f;
zdiff_comp(3,:) = avg_fr; 

zdiff_std_comp(1,:) = std_r;
zdiff_std_comp(2,:) = std_f;
zdiff_std_comp(3,:) = std_fr; 

% Plot results 
figure(h)
hold on
subplot(5,2,1)
boundedline(T(1:333),zdiff_comp(2,:)*10,zdiff_std_comp(2,:)*10,'b')
axis([0 0.33 -.6e-1 .6e-1])
text(0.1,0.075,'Computational Results','FontName','Times')
ylabel('\DeltaD_F (mm)','FontName','Times')
h=text(-0.08,0.065,'(a)');
set(h,'FontName','Times')
ax = gca;
set(gca,'YTick',[-0.05,0,0.05])

subplot(5,2,3)
boundedline(T(1:333),zdiff_comp(3,:)*10,zdiff_std_comp(3,:)*10,'g')
axis([0 0.33 -.6e-1 .6e-1])
ylabel('\DeltaD_F_&_R (mm)','FontName','Times')
xlabel('t (s)')
h=text(-0.08,0.065,'(b)');
set(h,'FontName','Times')
set(gca,'YTick',[-0.05,0,0.05])

%%
%subplot(5,2,5)


Fs = 1000;
L = length(zdiff_comp(1,:));
NFFT = (L);
f = Fs/2*linspace(0,1,NFFT/2+1);

for i = 1:6
    Y_nfr(:,i) = fft(rot(:,i)-mean(rot(:,i)),NFFT)/L;
    Y_fr(:,i) = fft(flaprot(:,i)-mean(flaprot(:,i)),NFFT)/L;
    Y_fnr(:,i) = fft(flap(:,i)-mean(flap(:,i)),NFFT)/L;
end

Z_nfr = mean(abs(Y_nfr),2);
stdZ_nfr = std(abs(Y_nfr),0,2);
Z_fr = mean(abs(Y_fr),2);
stdZ_fr = std(abs(Y_fr),0,2);
Z_fnr = mean(abs(Y_fnr),2);
stdZ_fnr = std(abs(Y_fnr),0,2);
%%
Fs = 1000;
L = length(zdiff_rot_comp);
NFFT = (L);
f = Fs/2*linspace(0,1,NFFT/2+1);

Y_tot_fr = fft(zdiff_flaprot_comp,NFFT)/L;
Y_tot_fnr = fft(zdiff_flap_comp,NFFT)/L;
%%

subplot(5,2,9)
plot(f,(2*abs(Y_tot_fr(1:NFFT/2+1))-2*abs(Y_tot_fnr(1:NFFT/2+1)))*10,'k')
axis([0 100 -2e-3 6e-3])
h=text(-24.24,22e-3,'(c)');
set(h,'FontName','Times')

subplot(5,2,5)
plot(f,(2*abs(Y_tot_fnr(1:NFFT/2+1)))*10,'k')
axis([0 100 -2e-3 6e-3])
h=text(-24.24,22e-3,'(ai)');
set(h,'FontName','Times')

subplot(5,2,7)
plot(f,(2*abs(Y_tot_fr(1:NFFT/2+1)))*10,'k')
axis([0 100 -2e-3 6e-3])
h=text(-24.24,22e-3,'(bi)');
set(h,'FontName','Times')

%% Experimental results 

% Plot experimental results 
figureS2_experimental(zdisp_fnr, zdisp_fr, zdisp_nfr,t)

subplot(5,2,9)
min =-5e-3;
max = 20e-3;
axis([0 100 min max])
xlabel('f (Hz)','FontName','Times')
ylabel('|F[\DeltaD_F_&_R] - F[\DeltaD_F]| (mm)','FontName','Times')
set(gca,'XTick',[22 28 50 75])
h = line([22 22],[min max]);
set(h,'LineStyle','--')
set(h,'Color','r')
h = line([28 28],[min max]);
set(h,'LineStyle','--');
set(h,'Color','r')

subplot(5,2,5)
min =-5e-3;
max = 20e-3;
axis([0 100 min max])
xlabel('f (Hz)','FontName','Times')
ylabel('|F[\DeltaD_F]| (mm)','FontName','Times')
set(gca,'XTick',[22 28 50 75])
h = line([22 22],[min max]);
set(h,'LineStyle','--')
set(h,'Color','r')
h = line([28 28],[min max]);
set(h,'LineStyle','--');
set(h,'Color','r')

subplot(5,2,7)
min =-5e-3;
max = 20e-3;
axis([0 100 min max])
xlabel('f (Hz)','FontName','Times')
ylabel('|F[\DeltaD_F_&_R]| (mm)','FontName','Times')
set(gca,'XTick',[22 28 50 75])
h = line([22 22],[min max]);
set(h,'LineStyle','--')
set(h,'Color','r')
h = line([28 28],[min max]);
set(h,'LineStyle','--');
set(h,'Color','r')
