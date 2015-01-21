function [x,y,z,strainx,strainy,strainxy,T,flappingangle,rotationangle] = flappermodel_doublesine(flapamp,rotamp,fflap,frot,cycles,sampfreq,periodic,dampingfactor)
%%
% Function to solve ordinary differential equations for plate model of wing flapping with concurrent body rotation 
% Created by Annika Eberle 
% September 20, 2013
% Modified August 4, 2014


% Outputs: 
% x = x position
% y = y position 
% z = z position (equal to surface displacement, i.e. w(x,t,t)) 
% T = time; 
% flappingangle = input flapping; 
% rotation angle = input rotation; 
%
% Inputs: 
% flapamp = amplitude of flapping (in deg) 
% rotamp = amplitude of rotation (in deg)
% fflap = frequency of flapping (in Hz)
% frot = frequency of rotation (in Hz)
% cycles = number of rotation cycles desired to be run
% sampfreq = sampling frequency for output strains and displacements (in Hz)
% periodic = toggle for type of angular velocity (if 1, then periodic angular velocity; if 0, then constant angular velocity)

%% Parameterize model 
%Geometry and nodes
    nodes = 4;
    a = 1.25; %half chord in cm
    b = 2.5; %half span in cm
    xpos = [-a a a -a]; %x position of plate nodes
    ypos = [0 0 2*b 2*b];%y position of plate nodes

%Material properties 
    E = 3e9*10^-2;%Young's modulus (converting from kg/m/s2 to kg/cm/s2) - currently for acrylic (3 GPa), but for moth:500e9*10^-2
    nu = 0.35; %Poisson's ratio for the plate - currently for acrylic. for moth: 0.49 
    G = E/(2*(1+nu)); %Shear modulus for isotropic material
    h = 1.27e-2;%plate height in cm -- currently for acrylic sheet, but for moth:50e-4
    density = 1180*(1e-2)^3;%density of plate in kg/cm^3 (converting from m^3)
    %dampingfactor = 63; %multiplier for velocity-proportional damping via mass matrix 

%Kinematics of input angles for flapping and rotation 
    syms x y t %create symbolic variables 
    
    %Specify properties for sigmoidal startup
    sigprop = [1;10;3];
    sigd = sigprop(1);
    sigc = sigprop(2);
    sign = sigprop(3);

    % LOCAL FLAPPING 
    %local flapping about x axis is governed by phi
    phi = flapamp/180*pi.*(sin(2*pi*fflap*t)+0.1852*sin(2*pi*2*fflap*t)).*(sigd.*(2*pi*fflap*t).^sign)./(sigc+sigd.*(2*pi*fflap*t).^sign);
    %local rotation about y axis is governed by theta
    theta = 0;
    %local rotation about z axis is governed by gamma
    gamma = 0;

    % GLOBAL BODY ROTATION about yaw axis (z-axis) is governed by gamma_global
    if periodic == 1
        %PERIODIC rotation
        gamma_global = rotamp/180*pi.*sin(2*pi*frot*t).*(sigd.*(2*pi*frot*t).^sign)./(sigc+sigd.*(2*pi*frot*t).^sign);
    elseif periodic == 0
        %CONSTANT rotation
        gamma_global = rotamp/180*2*pi*frot*t.*(sigd.*(2*pi*frot*t).^sign)./(sigc+sigd.*(2*pi*frot*t).^sign);
    else
        disp('value for periodic toggle must be 0 or 1')
    end

%Velocity and acceleration of the body (i.e. center base of plate)
    v0 = [0 0 0];
    dv0 = [0 0 0];

%Shape functions and their spatial derivatives 
    N = shapefunc2(a,b,nodes,xpos,ypos); %generate shape functions 
    N = [N(3,:).';N(4,:).']; %put into matrix form 

    for i = 1:6
        dxi(:,i) = [diff(N(i),x,2);diff(N(i),y,2);2*diff(diff(N(i),x),y)]; %compute second spatial derivative 
    end

%% Generate function with equations for ODEs
%Delete prior PlateODE.m file     
delete('/Users/Annika/Desktop/3D plate model/Plate Model 1 element/Final simulations for Torsion Paper/PlateODE.m')
clear PlateODE
[M K Ma Ia Q] = createODEfile(a,b,E,G,nu,h,density,dampingfactor,phi,theta,gamma,gamma_global,N,dxi);

pause(2) %make sure file saves before solving the ODE 
iter =1; 
while exist('PlateODE.m', 'file') ~= 2 && iter<5
    pause(2)
    iter = iter+1; 
end 

%% Solve ODE 
%Specify initial conditions and damping matrix
    init = zeros(2*6,1); %zero initial conditions

%Solve ODE
    disp('solving ode')
    pause(1)
    options = odeset('RelTol',1e-5);
    teval = 0:1/sampfreq:1/frot*cycles; %time matrix at which solution will be evaluated
    [T,Y] = ode45(@(t,y) PlateODE(t,y,v0,dv0,M,K,Ma,Ia,Q,cycles,frot),teval,init,options);

%% Postprocess results 
disp('postprocessing')
pause(1)
%Specify spatial locations where the solution will be evaluated
    xeval = -a:2*a/9:a;
    yeval = 0:2*b/19:2*b;
    [x,y]=meshgrid(xeval,yeval);

%Evaluate shape functions and their derivatives for strains, and spatial derivatives of strain
    for i = 1:6
        Ndisc(i,:,:) = eval(N(i)); %shape function
        strainxi(i,:,:) = eval(dxi(1,i)); %for normal strain along x axis
        strainyi(i,:,:) = eval(dxi(2,i))'; %for normal strain along y axis
        strainxyi(i,:,:) = eval(dxi(3,i))'; %for shear strain in x-y
    end

%Multiply by solution to ODE and sum over all components to solve for actual strains and displacements
    for j = 1:length(Y(:,1))
        %Multiply over all components
        for i = 1:6
            xxnew1(i,:,:) = Ndisc(i,:,:)*squeeze(Y(j,i));
            strainx1(i,:,:)= strainxi(i,:,:)*squeeze(Y(j,i));
            strainy1(i,:,:)= strainyi(i,:,:)*squeeze(Y(j,i));
            strainxy1(i,:,:)= strainxyi(i,:,:)*squeeze(Y(j,i));        
        end

        %Sum over all components
        z(j,:,:) = squeeze(sum(xxnew1,1));
        strainx(j,:,:) = squeeze(sum(strainx1,1))*-h/2;
        strainy(j,:,:) = squeeze(sum(strainy1,1))*-h/2;
        strainxy(j,:,:) = squeeze(sum(strainxy1,1))*-h/2;
        j
    end

%Evaluate flapping input, phi(t)
    t = T;
    if phi ~= 0
        flappingangle = eval(phi);
    else
        flappingangle = zeros(length(t),1);
    end

%Evaluate rotating input, phi(t)
    t = T;
    if gamma_global ~= 0
        rotationangle = eval(gamma_global);
    else
        rotationangle = zeros(length(t),1);
    end
    
   
filename = sprintf('Resultsfinal_doublesine_damping%d_periodic%d_flappingamp%d_rotatingamp%d_flapfreq%d_rotfreq%d_samplfreq%d_damping0.15.mat', dampingfactor,periodic,flapamp,rotamp,fflap,frot,sampfreq);
save(filename,'rotationangle','flappingangle','x','y','z','strainx','strainy','strainxy','T')
