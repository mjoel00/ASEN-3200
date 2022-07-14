clear 
clc
close all


t = 1:500;

omega(1:100) = 0.1*t(1:100);
omega(101:200) = 10;
omega(201:400) = (400-t(201:400))*0.05;
omega(401:500) = 0;
theta(1:100) = 0.05*t(1:100).^2;
theta(101:200) = 10*t(101:200);
theta(201:400) = 20*t(201:400) - 0.025*t(201:400).^2;
theta(401:500) = theta(end);
theta_f = theta(end);

figure(1)
plot(t,omega,'b','LineWidth',2)
xlabel('t (s)')
ylabel('\omega (deg/s)')
ylim([-0.1 11])
title('Angular Rate vs Time')
figure(2)
plot(t,theta,'r','LineWidth',2)
ylim([0 5000])
xlabel('t (s)')
ylabel('\theta (deg)')
title('Pointing Angle vs Time')

fprintf('The final pointing angle of the satellite is %.0f deg \n',theta_f)
fprintf('\n')
fprintf('\n')