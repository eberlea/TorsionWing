function figure4(T,z,z_rot_pos,z_rot_neg)
% Plotting Figure 4 
%%
figure;
subplot(2,2,1)
plot(T-0.255,z(:,end,end)*10,'b',T-0.255,(z(:,end,1))*10,'--r')
axis([0 0.2 -40 40])
xlabel('t (s)')
ylabel('Tip Disp. (mm)')

subplot(2,2,3)
plot(T-0.254,(z(:,end,end)-z(:,end,1))*10,'--k')
hold on
plot(T-0.255,(z_rot_pos(:,end,end)-z_rot_pos(:,end,1))*10,'k')
axis([0 0.2 -.5 .5])
xlabel('t (s)')
ylabel('D_L - D_R (mm)')

subplot(2,2,4)
plot(T-0.255,(z(:,end,end)-z(:,end,1))*10,'--k')
hold on
plot(T-0.255,(z_rot_neg(:,end,end)-z_rot_neg(:,end,1))*10,'k')
axis([0 0.2 -.5 .5])
xlabel('t (s)')
