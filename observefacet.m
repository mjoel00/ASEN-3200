function [observe,elevation_angle,camera_angle] = observefacet(rACAF,vertex,faces,facetnum)
phi = deg2rad(15);

facet = faces(facetnum,:);
vertpts = zeros(3,3);
vertpts(1,:) = vertex(facet(1),:);
vertpts(2,:) = vertex(facet(2),:);
vertpts(3,:) = vertex(facet(3),:);

rACAFhat = rACAF/norm(rACAF);
center = [mean(vertpts(:,1)) mean(vertpts(:,2)) mean(vertpts(:,3))];
d = center- rACAF;
dhat = d/norm(d);

A = zeros(1,3);
A(:) = vertpts(3,:) - vertpts(1,:);
B = zeros(1,3);
B(:) = vertpts(2,:) - vertpts(1,:);

n = cross(A,B);
nhat = n/norm(n);

elevation_angle  = (pi/2) - acos(nhat/dhat);

    if elevation_angle >= phi
    observe = 1;
    else
    observe = 0;
    end 
    
camera_angle = pi - acos(dhat/rACAFhat);

end