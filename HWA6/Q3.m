% ASEN 3200
% HW A-6: Problem 3
%Matthew Pabin

% Vector triad 
b_s = [(sqrt(3)/2) 0 .5]';
b_m = [(-sqrt(3)/2) 0 .5]';

i_s =  [0 -1 0]';
i_m = [0 .5 sqrt(3)/2]';

b_t1 = b_s;
b_t2 = cross(b_s,b_m)/norm(cross(b_s,b_m));
b_t3 = cross(b_t1,b_t2);

BT = [b_t1 b_t2 b_t3];
i_t1 = i_s;
i_t2 = cross(i_s,i_m)/norm(cross(i_s,i_m));
i_t3 = cross(i_t1,i_t2);

IT = [i_t1 i_t2 i_t3];
% DCM
BI = BT*(IT');
DCM = BI;
%Quaternion
beta_0 = (+1)*(1/2)*sqrt(DCM(1,1) + DCM(2,2) + DCM(3,3) +1);
beta_1 = (DCM(2,3) - DCM(3,2))/(4*beta_0);
beta_2 = (DCM(3,1) - DCM(1,3))/(4*beta_0);
beta_3 = (DCM(1,2) - DCM(2,1))/(4*beta_0);
D = DCM;
BI_q = [( D(1,1) - D(2,2) - D(3,3) )   	( D(2,1) + D(1,2) )      	( D(3,1) + D(1,3) )      	( D(2,3) - D(3,2) );...
     	( D(2,1) + D(1,2) )   	( -D(1,1) + D(2,2) - D(3,3))  	( D(3,2) + D(2,3) )      	( D(3,1) - D(1,3) );...
     	( D(3,1) + D(1,3) )        	( D(3,2) + D(2,3) ) 	( -D(1,1) - D(2,2) + D(3,3))  	( D(1,2) - D(2,1) );...
     	( D(2,3) - D(3,2) )        	( D(3,1) - D(1,3) )      	( D(1,2) - D(2,1) )   	( D(1,1) + D(2,2) + D(3,3)) ]*(1/3);
% Euler 313
theta1 = rad2deg(atan2(DCM(3,1),-DCM(3,2)));
theta2 = rad2deg(acos(DCM(3,3)));
theta3 = rad2deg(atan2(DCM(1,3),DCM(2,3)));
euler = [theta1 theta2 theta3];

fprintf('DCM : ')
disp(BI)
fprintf('\n')
fprintf('\n')
fprintf('Quaternion:')
disp(BI_q)
fprintf('\n')
fprintf('\n')
fprintf('Euler 313:')
disp(euler)