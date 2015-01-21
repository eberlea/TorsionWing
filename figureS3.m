function figure7(zdiff_rot_comp,zdiff_flap_comp,zdiff_flaprot_comp,T,zdisp_fnr, zdisp_fr, zdisp_nfr,t)
% Plotting Figure 6
fig_pos = [25,25, 700,900];
h = figure('Position',fig_pos,'Color',[1 1 1]);
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
hold on
subplot(5,2,1)
boundedline(T(1:333),zdiff_comp(2,:)*100,zdiff_std_comp(2,:)*100,'b')
axis([0 0.33 -.3e-1 .3e-1])
text(0.08,0.045,'Computational Results','FontName','Times')
ylabel('\epsilon_x_y_,_F (%)','FontName','Times')
h=text(-0.08,0.035,'(a)');
set(h,'FontName','Times')
xlabel('t (s)','FontName','Times')
set(gca,'YTick',[-0.02,0,0.02])

subplot(5,2,3)
boundedline(T(1:333),zdiff_comp(3,:)*100,zdiff_std_comp(3,:)*100,'g')
axis([0 0.33 -.3e-1 .3e-1])
ylabel('\epsilon_x_y_,_F_&_R (%)','FontName','Times')
xlabel('t (s)','FontName','Times')
h=text(-0.08,0.035,'(b)');
set(h,'FontName','Times')
set(gca,'YTick',[-0.02,0,0.02])

%%


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

Y_tot_fr = fft((zdiff_flaprot_comp-mean(zdiff_flaprot_comp)),NFFT)/L;
Y_tot_fnr = fft((zdiff_flap_comp-mean(zdiff_flaprot_comp)),NFFT)/L;
%%

subplot(5,2,9)
plot(f,(2*abs(Y_tot_fr(1:NFFT/2+1))-2*abs(Y_tot_fnr(1:NFFT/2+1)))*100,'k')
axis([0 100 -3e-4 3e-4])
h=text(-24.24,3.5e-4,'(c)');
set(h,'FontName','Times')

subplot(5,2,7)
plot(f,(2*abs(Y_tot_fr(1:NFFT/2+1)))*100,'g')
axis([0 100 -2e-5*5 6e-5*5])
h=text(-24.24,3.5e-4,'(bi)');
set(h,'FontName','Times')

subplot(5,2,5)
plot(f,(2*abs(Y_tot_fnr(1:NFFT/2+1)))*100,'b')
axis([0 100 -2e-5*5 6e-5*5])
h=text(-24.24,3.5e-4,'(ai)');
set(h,'FontName','Times')


%% Experimental results 
clear rot flap flaprot zdiff_comp zdiff_std_comp
% Plot experimental results 
P=findpeaks(1:length(zdisp_fr),zdisp_fr,0,-5,20,5,3);
index = 1; 
for k = 10:10:length(P(:,2))-10
    i = round(P(k,2));
    j = i+1667;
    rot(:,index) = detrend((zdisp_nfr(i:j)-mean(zdisp_nfr)));
    flap(:,index) = detrend((zdisp_fnr(i:j)-mean(zdisp_fnr)));
    flaprot(:,index) = detrend((zdisp_fr(i:j)-mean(zdisp_fr)));
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
hold on
subplot(5,2,2)
boundedline(t(1:1668),zdiff_comp(2,:)*100,zdiff_std_comp(2,:)*100,'b')
axis([0 0.33 -.3e-1 .3e-1])
h=text(0.08,0.045,'Experimental Results');
set(h,'FontName','Times')
h=text(-0.05,0.035,'(d)');
set(h,'FontName','Times')
set(gca,'YTick',[-0.02,0,0.02])
set(gca,'YTickLabel',[])
xlabel('t (s)','FontName','Times')


subplot(5,2,4)
boundedline(t(1:1668),zdiff_comp(3,:)*100,zdiff_std_comp(3,:)*100,'g')
axis([0 0.33 -.3e-1 .3e-1])
xlabel('t (s)','FontName','Times')
h=text(-0.05,0.035,'(e)');
set(h,'FontName','Times')
set(gca,'YTick',[-0.02,0,0.02])
set(gca,'YTickLabel',[])


%%
subplot(5,2,10)
clear Y_nfr Y_fr Y_fnr

Fs = 5000;
L = length(zdiff_comp(1,:));
NFFT = (L);
f = Fs/2*linspace(0,1,NFFT/2+1);

for i = 1:6
    Y_nfr(:,i) = fft(detrend(rot(:,i)-mean(rot(:,i))),NFFT)/L;
    Y_fr(:,i) = fft(detrend(flaprot(:,i)-mean(flaprot(:,i))),NFFT)/L;
    Y_fnr(:,i) = fft(detrend(flap(:,i)-mean(flap(:,i))),NFFT)/L;
end

Z_nfr = mean(abs(Y_nfr),2);
stdZ_nfr = std(abs(Y_nfr),0,2);
Z_fr = mean(abs(Y_fr),2);
stdZ_fr = std(abs(Y_fr),0,2);
Z_fnr = mean(abs(Y_fnr),2);
stdZ_fnr = std(abs(Y_fnr),0,2);
%%
dt = mean(diff(t(1:end)));
Fs = 1/dt;
L = length(t(1:end));
NFFT = (L);
f = Fs/2*linspace(0,1,NFFT/2+1);
Y_flap = fft((zdisp_fnr(1:end,:,:)-mean(zdisp_fnr)),NFFT)/L;
Y_flaprot = fft((zdisp_fr(1:end,:,:)-mean(zdisp_fr)),NFFT)/L;
Y_rot = fft((zdisp_nfr(1:end,:,:)-mean(zdisp_nfr)),NFFT)/L;
%%

subplot(5,2,6)
min = -2e-5*5;
max = 6e-5*5; 
axis([0 100 min max])
plot(f,(2*abs(Y_flap(1:NFFT/2+1)))*100,'b')
axis([0 100 min max])
h=text(-14.24,3.5e-4,'(di)');
set(h,'FontName','Times')
xlabel('f (Hz)','FontName','Times')
set(gca,'XTick',[22 28 47 53 72 78])
h = line([22 22],[min max]);
set(h,'LineStyle','--');
set(h,'Color','r')
h = line([28 28],[min max]);
set(h,'LineStyle','--');
set(h,'Color','r')
h=line([47 47],[min max]);
set(h,'LineStyle','--')
set(h,'Color','r')
h=line([53 53],[min max]);
set(h,'LineStyle','--')
set(h,'Color','r')
h=line([72 72],[min max]);
set(h,'LineStyle','--')
set(h,'Color','r')
h=line([78 78],[min max]);
set(h,'LineStyle','--')
set(h,'Color','r')
set(gca,'YTickLabel',[])


subplot(5,2,8)
min = -2e-5*5;
max = 6e-5*5; 
axis([0 100 min max])
plot(f,(2*abs(Y_flaprot(1:NFFT/2+1)))*100,'g')
axis([0 100 min max])
h=text(-14.24,3.5e-4,'(ei)');
set(h,'FontName','Times')
xlabel('f (Hz)','FontName','Times')
set(gca,'XTick',[22 28 47 53 72 78])
h = line([22 22],[min max]);
set(h,'LineStyle','--');
set(h,'Color','r')
h = line([28 28],[min max]);
set(h,'LineStyle','--');
set(h,'Color','r')
h=line([47 47],[min max]);
set(h,'LineStyle','--')
set(h,'Color','r')
h=line([53 53],[min max]);
set(h,'LineStyle','--')
set(h,'Color','r')
h=line([72 72],[min max]);
set(h,'LineStyle','--')
set(h,'Color','r')
h=line([78 78],[min max]);
set(h,'LineStyle','--')
set(h,'Color','r')
set(gca,'YTickLabel',[])

subplot(5,2,10)
min = -3e-4;
max = 3e-4; 
axis([0 100 min max])
plot(f,(2*abs(Y_flaprot(1:NFFT/2+1))-2*abs(Y_flap(1:NFFT/2+1)))*100,'k')
axis([0 100 min max])
h=text(-14.24,3.5e-4,'(f)');
set(h,'FontName','Times')
xlabel('f (Hz)','FontName','Times')
set(gca,'XTick',[22 28 47 53 72 78])
h = line([22 22],[min max]);
set(h,'LineStyle','--');
set(h,'Color','r')
h = line([28 28],[min max]);
set(h,'LineStyle','--');
set(h,'Color','r')
h=line([47 47],[min max]);
set(h,'LineStyle','--')
set(h,'Color','r')
h=line([53 53],[min max]);
set(h,'LineStyle','--')
set(h,'Color','r')
h=line([72 72],[min max]);
set(h,'LineStyle','--')
set(h,'Color','r')
h=line([78 78],[min max]);
set(h,'LineStyle','--')
set(h,'Color','r')
set(gca,'YTickLabel',[])


subplot(5,2,5)
xlabel('f (Hz)','FontName','Times')
ylabel('|F[\epsilon_x_y_,_F]| (%)','FontName','Times')
set(gca,'XTick',[22 28 47 53 72 78])
h = line([22 22],[min max]);
set(h,'LineStyle','--')
set(h,'Color','r')
h = line([28 28],[min max]);
set(h,'LineStyle','--');
set(h,'Color','r')
h=line([47 47],[min max]);
set(h,'LineStyle','--')
set(h,'Color','r')
h=line([53 53],[min max]);
set(h,'LineStyle','--')
set(h,'Color','r')
h=line([72 72],[min max]);
set(h,'LineStyle','--')
set(h,'Color','r')
h=line([78 78],[min max]);
set(h,'LineStyle','--')
set(h,'Color','r')

subplot(5,2,9)
xlabel('f (Hz)','FontName','Times')
ylabel('|F[\epsilon_x_y_,_F_&_R] - F[\epsilon_x_y_,_F]| (%)','FontName','Times')
set(gca,'XTick',[22 28 47 53 72 78])
h = line([22 22],[min max]);
set(h,'LineStyle','--')
set(h,'Color','r')
h = line([28 28],[min max]);
set(h,'LineStyle','--');
set(h,'Color','r')
h=line([47 47],[min max]);
set(h,'LineStyle','--')
set(h,'Color','r')
h=line([53 53],[min max]);
set(h,'LineStyle','--')
set(h,'Color','r')
h=line([72 72],[min max]);
set(h,'LineStyle','--')
set(h,'Color','r')
h=line([78 78],[min max]);
set(h,'LineStyle','--')
set(h,'Color','r')

subplot(5,2,7)
xlabel('f (Hz)','FontName','Times')
ylabel('|F[\epsilon_x_y_,_F_&_R]| (%)','FontName','Times')
set(gca,'XTick',[22 28 47 53 72 78])
h = line([22 22],[min max]);
set(h,'LineStyle','--')
set(h,'Color','r')
h = line([28 28],[min max]);
set(h,'LineStyle','--');
set(h,'Color','r')
h=line([47 47],[min max]);
set(h,'LineStyle','--')
set(h,'Color','r')
h=line([53 53],[min max]);
set(h,'LineStyle','--')
set(h,'Color','r')
h=line([72 72],[min max]);
set(h,'LineStyle','--')
set(h,'Color','r')
h=line([78 78],[min max]);
set(h,'LineStyle','--')
set(h,'Color','r')