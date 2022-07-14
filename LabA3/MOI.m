clear
clc
close all

data = load('moiRun1');

time = data(:,1);             %s
omega = 0.10472*(data(:,3));
alpha = norm(omega).^2;   %rad/s
M = 10;                    %Nm


I = M/alpha;

fprintf('The MOI of the s/c is %f \n',I)