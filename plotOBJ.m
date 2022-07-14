function [vertex,faces] =  plotOBJ(fname)
data = readmatrix('Preliminary_Bennu.obj','FileType','text');

vertex = data(59:25408,2:4);
faces = data(25409:end,2:4);

figure;
patch('Faces',faces,'Vertices',vertex,'FaceVertexCData',vertex(:,3),...
    'facecolor','interp','edgecolor','k');
title('Surface of Bennu')
ylabel('[km]');xlabel('[km]')
view(3)
end