clear
clc
close all

% Experimental Values
expT = [3.79 4.52 4.87 5.2 5.9 6.63 6.87 6.86]; %s
expMega = (2*pi)./expT;

g = 9.8;        %
r = 0.3302;     %m
omega = [16 18 20 22 24 26 28 30] / r;  %rad\s
m = 3.72;       %kg

mega = (4/3) .* (g./(omega.*r));
T = (2*pi)./mega;

figure(1)
plot(omega,T,'b-','LineWidth',2)
xlabel('Wheel Spin Rate (rad/s)')
ylabel('Precession Period (s)')
title('Wheel Spin Rate vs Precession Period')
hold on
plot(omega,expT,'b--','LineWidth',2)
legend('Predicted T_{p}','Measured T_{p}')


figure(2)
plot(omega,mega,'r-','LineWidth',2)
xlabel('Wheel Spin Rate (rad/s)')
ylabel('Precession Rate (rad/s)')
title('Wheel Spin Rate vs Precession Rate')
hold on
plot(omega,expMega,'r--','LineWidth',2)
legend('Predicted \omega_{p}','Measured \omega_{p}')

