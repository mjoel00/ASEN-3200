%%%%%%%% ASEN 3200: Orbits Project Part 1 %%%%%%%%%%
%
% Matthew J. Pabin
% 4/1/22
%

clear 
clc
close all

%% Calculate Angular Velocity of Bennu
spinT = 4.29746*3600; % [s]
angVel = 2*pi/spinT;  % [rad/s]

%% Call readconstell.m to plot Bennu

[vertex,faces] = plotOBJ('Preliminary_Bennu.obj');   % 1A
hold on

%% Constants

Cr = 1.2;
A = 5 * 10^-6; % [km^2]
msat = 1000; % [kg]
G = 6.67408 * 10^-20; %[km^3/kg/s^2] 
p_sr = 4.57*10^-3; %[N/km^2]
u = 4.892*10^-9; %[km^3/s^2]
mA = u/G; % Mass of Bennu calculation [kg]
vars = [A,msat,mA,G,Cr,p_sr,u];
X0 = [0;-1;0;0;0;sqrt(u)];

%% Constellation Design

% Initial position of Satellite 1
X10 = [0.5;-1;0;0;0;sqrt(u)]; %[km, km/s]
% Initial position of Satellite 2
X20 = [0;1;0;0;0;-sqrt(u)]; %[km, km/s]

% One week in one minute time steps
tspanReal = 0:60:604800;  % [s]

%% Propogate Orbit and Compute Orbital Elements

% Call proporbit.m to propogate the orbits
% Orbit of Satellite 1
[a1,e1,i1,omega1,w1,theta1,rvec1,vvec1,t1] = proporbit(tspanReal,X10,vars);  % 1B

% Orbit of Satellite 2
[a2,e2,i2,omega2,w2,theta2,rvec2,vvec2,t2] = proporbit(tspanReal,X20,vars);

% Angle of Bennu rotation through time
for i = 1:length(t1)
    ang(i) = angVel * t1(i);
end

facetnum =1;

% Iterate through whole orbit to find position
for j = 1:length(t1)
    
    
    % Rotation Matrix from ACI to ACAF
    cRot = [cos(ang(j)) -sin(ang(j)) 0; sin(ang(j)) cos(ang(j)) 0; 0 0 1];
    
    
    % Position vec before rotation
    f1 = rvec1(j,1:3)';
    % Add rotation
    outNew1 = cRot * f1;
    outNew1 = outNew1';
    % New position vector
    rNew1(j,1:3) = outNew1;
    % Check if observable 
    [observe1(j),elevation_angle1(j),camera_angle1(j)] = ...    % 1C
        observefacet(rNew1(j,1:3),vertex,faces,facetnum);
    
    % Repeat for second satellite
    f2 = rvec2(j,1:3)';
    outNew2 = cRot * f2;
    outNew2 = outNew2';
    rNew2(j,1:3) = outNew2;
    [observe2(j),elevation_angle2(j),camera_angle2(j)] = ...
        observefacet(rNew2(j,1:3),vertex,faces,facetnum);
    
end 
%% Plot
% Satellite 1
plot3(rNew1(:,1),rNew1(:,2),rNew1(:,3),'b','LineWidth',2);
xlim([-1.5 1.5]);
ylim([-1.5 1.5]);
grid on
hold on 
% Satellite 2
plot3(rNew2(:,1),rNew2(:,2),rNew2(:,3),'r','LineWidth',2);

% Legend
legend('Bennu','Satellite 1','Satellite 2');


% End 


