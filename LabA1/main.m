clear
clc
%% 1
data = load('Unit7_Gyro_Auto_1');
time = data(:,1);                               %s
gyro_out = data(:,2);                           %rad/s
encoder_in = (data(:,3) / 60) * (2*pi); %rad/s


figure(1)
plot(encoder_in,gyro_out,'b.');
title('Encoder Input vs Gyro Output (Trial #1)')
xlabel('Encoder Velocity In [rad/s]')
ylabel('Gyro Rate Out [rad/s]')


fitter = polyfit(encoder_in,gyro_out,1);
scalefactor1 = fitter(1);
bias1 = fitter(2);
gyro_fitter = scalefactor1*encoder_in + bias1;

hold on
plot(encoder_in,gyro_fitter,'r','LineWidth',2);
legend('Experimental Data','Linear fitter')
hold off
%% 2


data = load('Unit7_Gyro_Auto_2');
time = data(:,1);                               %s
gyro_out = data(:,2);                           %rad/s
encoder_in = (data(:,3) / 60) * (2*pi);         %rad/s

figure(2)
plot(encoder_in,gyro_out,'b.');
title('Encoder Input vs Gyro Output (Trial #2)')
xlabel('Encoder Velocity In [rad/s]')
ylabel('Gyro Rate Out [rad/s]')


fitterterter = polyfit(encoder_in,gyro_out,1);
scalefactor2 = fitter(1);
bias2 = fitter(2);
gyro_fitter = scalefactor2*encoder_in + bias2;

hold on
plot(encoder_in,gyro_fitter,'r','LineWidth',2);
legend('Experimental Data','Linear fitter')
hold off
%% 3


data = load('Unit7_Gyro_Auto_3');
time = data(:,1);                               %s
gyro_out = data(:,2);                           %rad/s
encoder_in = (data(:,3) / 60) * (2*pi);         %rad/s

figure(3)
plot(encoder_in,gyro_out,'b.');
title('Encoder Input vs Gyro Output (Trial #3)')
xlabel('Encoder Velocity In [rad/s]')
ylabel('Gyro Rate Out [rad/s]')


fitter = polyfit(encoder_in,gyro_out,1);
scalefactor3 = fitter(1);
bias3 = fitter(2);
gyro_fitter = scalefactor3*encoder_in + bias3;

hold on
plot(encoder_in,gyro_fitter,'r','LineWidth',2);
legend('Experimental Data','Linear fitter')
hold off

hold on
plot(encoder_in,gyro_fitter,'r','LineWidth',2);
legend('Experimental Data','Linear fitter')
hold off

%% 4
data = load('Unit7_Gyro_Auto_4');
time = data(:,1);                               %s
gyro_out = data(:,2);                           %rad/s
encoder_in = (data(:,3) / 60) * (2*pi);         %rad/s

figure(4)
plot(encoder_in,gyro_out,'b.');
title('Encoder Input vs Gyro Output (Trial #4)')
xlabel('Encoder Velocity In [rad/s]')
ylabel('Gyro Rate Out [rad/s]')


fitter = polyfit(encoder_in,gyro_out,1);
scalefactor4 = fitter(1);
bias4 = fitter(2);
gyro_fitter = scalefactor4*encoder_in + bias4;

hold on
plot(encoder_in,gyro_fitter,'r','LineWidth',2);
legend('Experimental Data','Linear fitter')
hold off

hold on
plot(encoder_in,gyro_fitter,'r','LineWidth',2);
legend('Experimental Data','Linear fitter')
hold off


scalefactor = [scalefactor1 scalefactor2 scalefactor3 scalefactor4]';
bias = [bias1 bias2 bias3 bias4]';

scalefactorstats = datastats(scalefactor);
biasstats = datastats(bias);

scalefactormean = scalefactorstats.mean;
scalefactorSTD = scalefactorstats.std;

biasmean = biasstats.mean;
biasSTD = biasstats.std;

%% Plots of position and  rate
  data = load('Unit7_Gyro_Auto_1');
  time = data(:, 1); % ms
  gyro = (data(:, 2)); % reaction gyro movement (rad/s)
  in = (data(:,3) / 60) * (2*pi);   % input rate (rad/s)
  in = in(1:3407);
  % correction equation, base movement as a function of gyro measurements
  omega = @(g) (g - biasmean)/scalefactormean;

  idx = 2:length(time); % first point is all zeros
  time  = time(idx);
  gyro  = gyro(idx);
  omega = omega(gyro); % apply correct factor

  % each theta at a given t is an integral of omega from the beginning of measurement
  % to that time t, so we have to perform a ton of integrals here
  
   f = fit(time, in, 'smoothingspline');
  theta0 = zeros(length(time), 1);
  for i = 2:length(time)
    theta0(i) = theta0(i-1) + integral(@(t) f(t), time(i - 1), time(i), 'ArrayValued', true);
  end

  
  
  k = fit(time, omega, 'smoothingspline');
  theta = zeros(length(time), 1);
  for i = 2:length(time)
    theta(i) = theta(i-1) + integral(@(t) k(t), time(i - 1), time(i), 'ArrayValued', true);
  end

  angular_error = theta0 - theta;
  % make some plots
  figure(5); hold on; grid on;
  %plot(time, omega, 'DisplayName', '\omega (rad/s)');
  plot(time,theta0)
  plot(time, theta)
  xlabel('Time [s]');
  legend('True Angular Position \theta0','Measured Angular Position \theta');
  hold off
