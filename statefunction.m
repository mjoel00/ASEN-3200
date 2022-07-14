function [dr] = statefunction(t,X0,vars,options)
rx = X0(1);
ry = X0(2);
rz = X0(3);
vx = X0(4);
vy = X0(5);
vz = X0(6);

A = vars(1);
msat = vars(2);
mA = vars(3);
G = vars(4);
Cr = vars(5);
p_sr = vars(6);
u = vars(7);


r = norm([rx ry rz]);
rhat = [rx ry rz]/r;


% accel due to gravity
a_g = -((G*mA)/ r^2) .* rhat;
% accel due to SRP
a_srp = -((p_sr*Cr*A)/msat);


ax = a_g(1) - a_srp;
ay = a_g(2);
az = a_g(3);

dr = [vx;vy;vz;ax;ay;az];  % [km/s,km/s^2]

end