function figure8(zdiff_rot_comp,zdiff_flap_comp,zdiff_flaprot_comp,T,strain_flap, strain_flaprot, strain_rot,time)
% Plotting Figure 6
fig_pos = [25,25, 700,500];
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
    rot(:,index) = (zdiff_rot_comp(i:j,1));
    flap(:,index) = (zdiff_flap_comp(i:j,1));
    flaprot(:,index) = (zdiff_flaprot_comp(i:j,1));
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

P=findpeaks(1:length(zdiff_flap_comp),zdiff_flaprot_comp,0,-5,20,5,3);
index = 1; 
for k = 10:10:length(P(:,2))-10
    i = round(P(k,2));
    j = i+332;
    rot(:,index) = (zdiff_rot_comp(i:j,2));
    flap(:,index) = (zdiff_flap_comp(i:j,2));
    flaprot(:,index) = (zdiff_flaprot_comp(i:j,2));
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
zdiff_comp_2(1,:) = avg_r;
zdiff_comp_2(2,:) = avg_f;
zdiff_comp_2(3,:) = avg_fr; 

zdiff_std_comp_2(1,:) = std_r;
zdiff_std_comp_2(2,:) = std_f;
zdiff_std_comp_2(3,:) = std_fr; 

% Plot results 
figure(h)
hold on
subplot(3,2,1)
boundedline(T(1:333),zdiff_comp(2,:)*100,zdiff_std_comp(2,:)*100,'b',T(1:333),zdiff_comp_2(2,:)*100,zdiff_std_comp_2(2,:)*100,'--k')
%axis([0 0.33 -.3e-1 .3e-1])
h =text(0.08,0.65,'Computational Results');
set(h,'FontName','Times')
ylabel('\epsilon_y_y_,_F (%)','FontName','Times')
h=text(-0.08,0.52,'(a)');
set(h,'FontName','Times')
axis([0 0.33 -.4 .4])
set(gca,'YTick',[-0.2 0 0.2])


subplot(3,2,3)
boundedline(T(1:333),zdiff_comp(3,:)*100,zdiff_std_comp(3,:)*100,'g',T(1:333),zdiff_comp_2(3,:)*100,zdiff_std_comp_2(3,:)*100,'--m')
%axis([0 0.33 -.3e-1 .3e-1])
ylabel('\epsilon_y_y_,_F_&_R (%)','FontName','Times')
xlabel('t (s)','FontName','Times')
h=text(-0.08,0.52,'(b)');
set(h,'FontName','Times')
axis([0 0.33 -.4 .4])
set(gca,'YTick',[-0.2 0 0.2])


%%

Fs = 1000;
L = length(zdiff_rot_comp);
NFFT = (L);
f = Fs/2*linspace(0,1,NFFT/2+1);

Y_tot_fr = fft(diff(zdiff_flaprot_comp'),NFFT)/L;
Y_tot_fnr = fft(diff(zdiff_flap_comp'),NFFT)/L;
%%

subplot(3,2,5)
plot(f,(2*abs(Y_tot_fr(1:NFFT/2+1))-2*abs(Y_tot_fnr(1:NFFT/2+1)))*100,'k')
hold
%plot(f,(2*abs(Y_tot_fnr(1:NFFT/2+1)))*10,'b')
%plot(f,(2*abs(Y_tot_fr(1:NFFT/2+1)))*10,'g')
%axis([0 100 0 1e-4])
text(-24.24,8e-5*10,'(c)','FontName','Times')

% subplot(5,2,7)
% plot(f,(2*abs(Y_tot_fr(1:NFFT/2+1)))*100,'k')
% hold
% text(-24.24,8e-5*10,'(bi)','FontName','Times')
% 
% 
% subplot(5,2,5)
% plot(f,(2*abs(Y_tot_fnr(1:NFFT/2+1)))*100,'k')
% hold
% text(-24.24,8e-5*10,'(ai)','FontName','Times')

% subplot(3,2,5)
% [h1,hp] = boundedline(f,(Z_fr(1:NFFT/2+1)-Z_fnr(1:NFFT/2+1))*10,(stdZ_fnr(1:NFFT/2+1)+stdZ_fr(1:NFFT/2+1))*10,'-k');
% axis([0 100 -2e-3 6e-3])
% xlabel('f (Hz)')
%% Experimental results 

clear rot flap flaprot zdiff_comp zdiff_std_comp
% Plot experimental results 
strainyy_flap = strain_flap(:,1);
strainyy_flaprot = strain_flaprot(:,1);
strainyy_rot = strain_rot(:,1); 

P=findpeaks(1:length(strainyy_flap),strainyy_flap,0,-1,20,5,3);

index = 1; 
for k = 1:10:length(P(:,2))-20
    i = round(P(k,2));
    j = i+1667;
    rot(:,index) = detrend(strainyy_rot(i:j));
    flap(:,index) = detrend(strainyy_flap(i:j));
    flaprot(:,index) = detrend(strainyy_flaprot(i:j));
    index = index +1;
end
rot = rot(:,4:end);
flap = flap(:,4:end);
flaprot = flaprot(:,4:end);

avg_r = mean(rot');
std_r = std(rot',0); 
avg_f = mean(flap');
std_f = std((flap'),0);
avg_fr = mean(flaprot');
std_fr = std(flaprot',0);

strainyy(1,:) = avg_r;
strainyy(2,:) = avg_f;
strainyy(3,:) = avg_fr; 

strainyy_std(1,:) = std_r;
strainyy_std(2,:) = std_f;
strainyy_std(3,:) = std_fr; 

%%
clear blank flap rot flaprot
strainyy_flap = strain_flap(:,2);
strainyy_flaprot = strain_flaprot(:,2);
strainyy_rot = strain_rot(:,2); 

P=findpeaks(1:length(strainyy_flap),strainyy_flap,0,-1,20,5,3);

index = 1; 
for k = 7:10:length(P(:,2))-20
    i = round(P(k,2));
    j = i+1667;
    rot(:,index) = detrend(strainyy_rot(i:j));
    flap(:,index) = detrend(strainyy_flap(i:j));
    flaprot(:,index) = detrend(strainyy_flaprot(i:j));
    index = index +1;
end
rot = rot(:,4:end);
flap = flap(:,4:end);
flaprot = flaprot(:,4:end);

avg_r = mean(rot');
std_r = std(rot',0); 
avg_f = mean(flap');
std_f = std((flap'),0);
avg_fr = mean(flaprot');
std_fr = std(flaprot',0);

strainyy_2(1,:) = avg_r;
strainyy_2(2,:) = avg_f;
strainyy_2(3,:) = avg_fr; 

strainyy_std_2(1,:) = std_r;
strainyy_std_2(2,:) = std_f;
strainyy_std_2(3,:) = std_fr; 

subplot(3,2,2)
boundedline(time(1:1668),strainyy(2,:)*-100,strainyy_std(2,:)*-100,'b',time(1:1668),strainyy_2(2,:)*-100,strainyy_std_2(2,:)*-100,'--k')
axis([0 0.33 -.4 .4])
h=text(-0.05,0.52,'(d)');
set(h,'FontName','Times')
h=text(0.05,0.65,'Experimental Results');
set(h,'FontName','Times')
set(gca,'YTick',[-0.2,0,0.2])
set(gca,'YTickLabel',[])

subplot(3,2,4)
boundedline(time(1:1668),strainyy(3,:)*-100,strainyy_std(3,:)*-100,'g',time(1:1668),strainyy_2(3,:)*-100,strainyy_std_2(3,:)*-100,'--m')
axis([0 0.33 -.4 .4])
xlabel('t (s)','FontName','Times')
h=text(-0.05,0.52,'(e)');
set(h,'FontName','Times')
xlabel('t (s)','FontName','Times')
set(gca,'YTick',[-0.2,0,0.2])
set(gca,'YTickLabel',[])

%%
clear Y_nfr Y_fr Y_fnr

dt = mean(diff(time));
Fs = 1/dt;
L = length(time);
NFFT = (L);
f = Fs/2*linspace(0,1,NFFT/2+1);
Y_flap = fft(detrend(diff(strain_flap')),NFFT)/L;
Y_flaprot = fft(detrend(diff(strain_flaprot')),NFFT)/L;
Y_rot = fft(detrend(diff(strain_rot')),NFFT)/L;

subplot(3,2,6)
min = -2e-5*10;
max = 6e-5*10; 
axis([0 100 min max])
plot(f,100*(2*abs(Y_flaprot(1:NFFT/2+1))-2*abs(Y_flap(1:NFFT/2+1))),'k')
axis([0 100 min max])
h=text(-14.24,8e-5*10,'(f)');
set(h,'FontName','Times')
xlabel('f (Hz)','FontName','Times')
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
set(gca,'YTickLabel',[])

subplot(3,2,5)
axis([0 100 min max])
xlabel('f (Hz)','FontName','Times')
ylabel('|F[\Delta\epsilon_y_y_,_F_&_R] - F[\Delta\epsilon_y_y_,_F]| (%)','FontName','Times')
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
