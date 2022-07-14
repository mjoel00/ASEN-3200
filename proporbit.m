function [a,e,i,omega,w,theta,rvec,vvec,t] = proporbit(tspan,X0,vars)

options = odeset('RelTol',1e-8,'AbsTol',1e-10);

A = vars(1);
msat = vars(2);
mA = vars(3);
G = vars(4);
Cr = vars(5);
p_sr = vars(6);
u = vars(7);

 % [km, km/s]
% call ode
[t,dr] = ode45(@(t,X0) statefunction(t,X0,vars), tspan, X0,options);

rx = dr(:,1);
ry = dr(:,2);
rz = dr(:,3);
vx = dr(:,4);
vy = dr(:,5);
vz = dr(:,6);


rvec = [rx ry rz];
vvec = [vx vy vz];
zmat = zeros(length(t),3);
zmat(:,3) = 1;

for h = 1:length(t)
hvec(h,:) = cross(rvec(h,:),vvec(h,:));
end
for n = 1:length(t)
nvec(n,:) = cross(zmat(n,:),hvec(n,:));
end

for x = 1:length(t)
vh(x,:) = cross(vvec(x,:),hvec(x,:));    
end 

for e = 1:length(t)
evec(e,:) = (vh(e,:)/u)-(rvec(e,:)/norm(rvec(e,:)));
end


for j = 1:length(t)
r(j) = norm(rvec(j,:));
v(j) = norm(vvec(j,:));
h(j) = norm(hvec(j,:)); 
n(j) = norm(nvec(j,:));
e(j) = norm(evec(j,:));
end
r = r';
v = v';
h = h';
n = n';
e = e';



for k = 1:length(t)
    a(k) = (h(k)^2)/(u*(1-e(k)^2));
    i(k) = acos(hvec(k,3)/h(k));
    if nvec(k,2)> 0 
    omega(k) = acos(nvec(k,1)/n(k));
    else
    omega(k) = (2*pi) - acos(nvec(k,1)/n(k));
    end
    
    if evec(k,3) > 0
    w(k) = acos((dot(nvec(k,:),evec(k,:)))/(n(k)*e(k)));
    else 
    w(k) = (2*pi) - acos((dot(nvec(k,:),evec(k,:)))/(n(k)*e(k)));
    end
   a1 = rvec(k,:);
   b1 = evec(k,:);
     num(k) = dot(a1/norm(a1),b1/norm(b1)); 
    
     z(k) = num(k);
     if dot(rvec(k,:),vvec(k,:)) > 0
     theta(k) = acos(z(k));
     else 
     theta(k) = (2*pi) - acos(z(k));
     end
end 
a = a';
i = i';
omega = omega';
w = w';
theta = theta';


plot3(rx,ry,rz,'b','LineWidth',2)
title('Spacecraft Orbit around Bennu')

end