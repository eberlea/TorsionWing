function figure5(T,x,y,z,z_rot,strainx,strainx_rot,strainy,strainy_rot,strainxy,strainxy_rot,flappingangle)
%%
fig_pos = [25,25, 800,1200];
h = figure('Position',fig_pos,'Color',[1 1 1]);

figure(h)
positionVector1 = [0.1, 0.53, 0.39, 0.2];
subplot('Position',positionVector1)
plot(T(2481:3141)-T(2481),-flappingangle(2481:3141),'k','LineWidth',2)
ylabel('Flapping angle (rad)','Fontsize',10,'fontname','Times','FontWeight','Bold')
xlabel('t/T','Fontsize',10,'fontname','Times','FontWeight','Bold')
hold on
vect = [2481:10:2561];
for i = 1:5
    k = vect(i);
    plot(T(k)-T(2481),-flappingangle(k),'.r', 'markersize', 30)
end
box off
axis([0 0.04 -0.4 0.4])
set(gca,'XTickLabel',[0:0.25:1])
set(gca, 'XTick', [0:0.01:0.04] );
set(gca,'YTick',(-0.3:0.3:0.3))
set(gca,'FontSize',10,'fontname','Times')
set(gca,'XGrid','on')
set(gca,'GridLineStyle', '--','LineWidth',2)

vecthorz = [0.06:0.1:1];
for i = 1:5
    k = vect(i);
    
    increase = 0;
    if i ==1
        increase = 0.055;
    end
    
    a = 1;
    b = 2;
    valuehorz = vecthorz(i);
    positionVector1 = [valuehorz-increase, 0.4, 0.08+increase, 0.1];
    figure(h)
    hold on
    subplot('Position',positionVector1)
    zrel = squeeze((z_rot(k,1:2:end,1:2:end)-z(k,1:2:end,1:2:end)))'*100;
    surf(x(1:2:end,1:2:end)',y(1:2:end,1:2:end)',zrel,'EdgeColor','k');%,'FaceColor','w');
    %shading interp
    %colormap autumn
    axis([-2.5*a 2.5*a 0 2*b -max(max(max(z_rot-z)))*2*100 max(max(max(z_rot-z)))*2*100])
    box off
    grid off
    axis off
    caxis([-1 1]*max(max(max(z_rot-z)))*100*0.8)
    view([0.5,0.7,0.5])
    if i ==1
        cbar_handle1 = colorbar('Location','WestOutside');
        set(get(cbar_handle1,'xlabel'),'string','\Delta z (mm)','fontsize',10,'fontname','Times')
        axpos = get(gca,'Position');
        cpos = get(cbar_handle1,'Position');
        cpos(4) = 0.5*cpos(4);
        cpos(2) = cpos(2)+0.75*cpos(4);
        set(cbar_handle1,'Position',cpos)
        set(gca,'Position',axpos)
    end
    line([-1.5 1.5], [0 0],[0 0])
    line([-1 -1.5], [0 -0.5],[0 0.2]*max(max(max(z_rot-z)))*100)
    line([-0.5 -1], [0 -0.5],[0 0.2]*max(max(max(z_rot-z)))*100)
    line([0 -.5], [0 -0.5],[0 0.2]*max(max(max(z_rot-z)))*100)
    line([0.5 0],[0 -0.5],[0 0.2]*max(max(max(z_rot-z)))*100)
    line([1 0.5],[0 -0.5],[0 0.2]*max(max(max(z_rot-z)))*100)

    positionVector1 = [valuehorz-increase, 0.28, 0.08+increase, 0.1];
    subplot('Position',positionVector1)
    surf(x',y',squeeze(z_rot(k,:,:)-z(k,:,:))',squeeze((strainy_rot(k,:,:)-strainy(k,:,:)))*100,'EdgeColor','none')
    %shading interp
    axis([-2.5*a 2.5*a 0 2*b -max(max(max(z_rot-z)))*2*100 max(max(max(z_rot-z)))*2*100])
    box off
    grid off
    axis off
    caxis([-1 1]*2e-3)
    view([0,1,1])
    if i ==1
        colorbar('delete')
        cbar_handle2 = colorbar('Location','WestOutside');
        set(get(cbar_handle2,'xlabel'),'string','\Delta \epsilon_y_y (%)','fontsize',10,'fontname','Times')
        axpos = get(gca,'Position');
        cpos = get(cbar_handle2,'Position');
        cpos(4) = 0.5*cpos(4);
        cpos(2) = cpos(2)+0.5*cpos(4);
        set(cbar_handle2,'Position',cpos)
        set(gca,'Position',axpos)
    end
    line([-1.25 1.25], [0 0])
    line([-1 -1.25], [0 -0.75])
    line([-0.5 -.75], [0 -0.75])
    line([0 -.25], [0 -0.75])
    line([0.5 0.25],[0 -0.75])
    line([1 0.75],[0 -0.75])
    
    positionVector1 = [valuehorz-increase, 0.16, 0.08+increase, 0.1];
    subplot('Position',positionVector1)
    strainxx= squeeze((strainx_rot(k,:,:)-strainx(k,:,:)))'*100;
    strainxx(:,1) = zeros(10,1);
    surf(x',y',squeeze(z_rot(k,:,:)-z(k,:,:))',strainxx,'EdgeColor','none')
    %shading interp
    axis([-2.5*a 2.5*a 0 2*b -max(max(max(z_rot-z)))*2*100 max(max(max(z_rot-z)))*2*100])
    box off
    grid off
    axis off
    caxis([-1 1]*1e-5)
    view([0,1,1])
    colorbar('delete')
    if i ==1
        cbar_handle3 = colorbar('Location','WestOutside');
        set(get(cbar_handle3,'xlabel'),'string','\Delta \epsilon_x_x (%)','fontsize',10,'fontname','Times')
        axpos = get(gca,'Position');
        cpos = get(cbar_handle3,'Position');
        cpos(4) = 0.5*cpos(4);
        cpos(2) = cpos(2)+0.5*cpos(4);
        set(cbar_handle3,'Position',cpos)
        set(gca,'Position',axpos)
    end
    line([-1.25 1.25], [0 0])
    line([-1 -1.25], [0 -0.75])
    line([-0.5 -.75], [0 -0.75])
    line([0 -.25], [0 -0.75])
    line([0.5 0.25],[0 -0.75])
    line([1 0.75],[0 -0.75])
    
    positionVector1 = [valuehorz-increase, 0.04, 0.08+increase, 0.1];
    subplot('Position',positionVector1)
    surf(x',y',squeeze(z_rot(k,:,:)-z(k,:,:))',squeeze((strainxy_rot(k,:,:)-strainxy(k,:,:)))*100,'EdgeColor','none')
    % shading interp
    axis([-2.5*a 2.5*a 0 2*b -max(max(max(z_rot-z)))*2*100 max(max(max(z_rot-z)))*2*100])
    box off
    grid off
    axis off
    caxis([-1 1]*6e-3)
    view([0,1,1])
    colorbar('delete')
    if i ==1
        cbar_handle4 = colorbar('Location','WestOutside');
        set(get(cbar_handle4,'xlabel'),'string','\Delta \epsilon_x_y (%)','fontsize',10,'fontname','Times')
        axpos = get(gca,'Position');
        cpos = get(cbar_handle4,'Position');
        cpos(4) = 0.5*cpos(4);
        cpos(2) = cpos(2)+0.5*cpos(4);
        set(cbar_handle4,'Position',cpos)
        set(gca,'Position',axpos)
    end
    
    line([-1.25 1.25], [0 0])
    line([-1 -1.25], [0 -0.75])
    line([-0.5 -.75], [0 -0.75])
    line([0 -.25], [0 -0.75])
    line([0.5 0.25],[0 -0.75])
    line([1 0.75],[0 -0.75])
end
