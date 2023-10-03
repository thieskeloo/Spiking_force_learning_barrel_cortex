load('whiskmat.mat')

proximal = filtered_whiskmat(12);
% distal = filtered_whiskmat(6);

plot(proximal.thetaVec)