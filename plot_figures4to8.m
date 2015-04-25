%Load data 
load('RawData_Experimental_and_Computational.mat')

%% Figure 4
figure4(T_c,z_flap_c,z_flaprot_posc,z_flaprot_negc)

%% Figure 5
figure5(T_c,x_c,y_c,z_flap_c,z_flaprot_c,strainx_flap_c,strainx_flaprot_c,strainy_flap_c,strainy_flaprot_c,strainxy_flap_c,strainxy_flaprot_c,flappingangle)

%% Figure 6 
figure6(zdiff_rot_comp,zdiff_flap_comp,zdiff_flaprot_comp,T_comp_disp,zdiff_flap_exp, zdiff_flaprot_exp, zdiff_rot_exp,t_exp_disp)

%% Figure 7 
figure7(strainxy_rot_comp,strainxy_flap_comp,strainxy_flaprot_comp,T_comp_strain,strainxy_fnr, strainxy_fr, strainxy_nfr,t_exp_strainxy)

%% Figure 8 
figure8((strainyy_rot_comp),(strainyy_flap_comp),(strainyy_flaprot_comp),T_comp_strain,strainyy_flap_exp, strainyy_flaprot_exp, strainyy_rot_exp,t_exp_strainyy)

