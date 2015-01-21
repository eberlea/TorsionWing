% List of simulations run 

% Constant 
[x,y,z,strainx,strainy,strainxy,T,flappingangle,rotationangle] = flappermodel_doublesine(15,0,25,3,10,1000,0,63);[x,y,z,strainx,strainy,strainxy,T,flappingangle,rotationangle] = flappermodel_doublesine(15,-133,25,3,10,1000,0,63);[x,y,z,strainx,strainy,strainxy,T,flappingangle,rotationangle] = flappermodel_doublesine(15,133,25,3,10,1000,0,63);

% Displacement actuator - single sine 
[x,y,z,strainx,strainy,strainxy,T,flappingangle,rotationangle] = flappermodel_singlesine(15,10,25,3,10,1000,1,63);[x,y,z,strainx,strainy,strainxy,T,flappingangle,rotationangle] = flappermodel_singlesine(15,0,25,3,10,1000,1,63);[x,y,z,strainx,strainy,strainxy,T,flappingangle,rotationangle] = flappermodel_singlesine(0,10,25,3,10,1000,1,63);

% Strain actuator - double sine 
[x,y,z,strainx,strainy,strainxy,T,flappingangle,rotationangle] = flappermodel_doublesine(15,10,25,3,30,5000,1,63);[x,y,z,strainx,strainy,strainxy,T,flappingangle,rotationangle] = flappermodel_doublesine(15,0,25,3,30,5000,1,63);[x,y,z,strainx,strainy,strainxy,T,flappingangle,rotationangle] = flappermodel_doublesine(0,10,25,3,30,5000,1,63);