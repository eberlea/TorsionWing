% Supplemental Figures
%Load data 
load('RawData_Experimental_and_Computational.mat')

%% Figure S1
figureS1(zdiff_flap_exp, zdiff_flaprot_exp, zdiff_rot_exp,t_exp_disp)

%% Figure S2
figureS2(zdiff_rot_comp,zdiff_flap_comp,zdiff_flaprot_comp,T_comp_disp,zdiff_flap_exp, zdiff_flaprot_exp, zdiff_rot_exp,t_exp_disp)

%% Figure S3
figureS3(strainxy_rot_comp,strainxy_flap_comp,strainxy_flaprot_comp,T_comp_strain,strainxy_fnr, strainxy_fr, strainxy_nfr,t_exp_strainxy)

%% Figure S4
figureS4((strainyy_rot_comp),(strainyy_flap_comp),(strainyy_flaprot_comp),T_comp_strain,strainyy_flap_exp, strainyy_flaprot_exp, strainyy_rot_exp,t_exp_strainyy)

%% S6 - flap only - constant
T = T_c;
x = x_c;
y = y_c;
z_rot = z_flap_c;
z = zeros(size(z_rot));
strainx_rot = strainx_flap_c;
strainy_rot = strainy_flap_c;
strainxy_rot = strainxy_flap_c;
strainx = zeros(size(strainx_rot));
strainy = zeros(size(strainy_rot));
strainxy = zeros(size(strainxy_rot)); 

figure5_sup(T,x,y,z,z_rot,strainx,strainx_rot,strainy,strainy_rot,strainxy,strainxy_rot,flappingangle)

%% S7 - flaprot only - constant
z_rot = z_flaprot_c;
z = zeros(size(z_rot));
strainx_rot = strainx_flaprot_c;
strainy_rot = strainy_flaprot_c;
strainxy_rot = strainxy_flaprot_c;
strainx = zeros(size(strainx_rot));
strainy = zeros(size(strainy_rot));
strainxy = zeros(size(strainxy_rot)); 
figure5_sup(T,x,y,z,z_rot,strainx,strainx_rot,strainy,strainy_rot,strainxy,strainxy_rot,flappingangle)

%% S8 - flap only - periodic
z_rot = z_flap_periodic_comp;
z = zeros(size(z_rot));
strainx_rot = strainx_flap_periodic_comp;
strainy_rot = strainy_flap_periodic_comp;
strainxy_rot = strainxy_flap_periodic_comp;
strainx = zeros(size(strainx_rot));
strainy = zeros(size(strainy_rot));
strainxy = zeros(size(strainxy_rot)); 
figure5_sup(T,x,y,z,z_rot,strainx,strainx_rot,strainy,strainy_rot,strainxy,strainxy_rot,flappingangle)

%% S9 - flaprot only - periodic
z_rot = z_flaprot_periodic_comp;
z = zeros(size(z_rot));
strainx_rot = strainx_flaprot_periodic_comp;
strainy_rot = strainy_flaprot_periodic_comp;
strainxy_rot = strainxy_flaprot_periodic_comp;
strainx = zeros(size(strainx_rot));
strainy = zeros(size(strainy_rot));
strainxy = zeros(size(strainxy_rot)); 
figure5_sup(T,x,y,z,z_rot,strainx,strainx_rot,strainy,strainy_rot,strainxy,strainxy_rot,flappingangle)

%% S10 - flaprot minus flap - periodic (compare to Fig. 5 for constant)
z_rot = z_flaprot_periodic_comp;
strainx_rot = strainx_flaprot_periodic_comp;
strainy_rot = strainy_flaprot_periodic_comp;
strainxy_rot = strainxy_flaprot_periodic_comp;
z = z_flap_periodic_comp;
strainx = strainx_flap_periodic_comp;
strainy = strainy_flap_periodic_comp;
strainxy = strainxy_flap_periodic_comp;
figure5_supdiff(T,x,y,z,z_rot,strainx,strainx_rot,strainy,strainy_rot,strainxy,strainxy_rot,flappingangle)
