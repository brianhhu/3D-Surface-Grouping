function Wij = W_23

% Weights from layer 2 to layer 3 (and vice versa for W32)

global p;

j = p.N1:p.N1+p.N2-1; % layer 2
[Xj, Yj] = XY(j);
Dj = D(j);

% new experiment (N = 15 planes)
XYj = [17 17; 17 17; 17 17; 17 17; 17 17; %FP
    17 8; 17 12.5; 17 17; 17 21.5; 17 26 %FS
    17 8; 17 12.5; 17 17; 17 21.5; 17 26]; %BS
STZj = [0 pi/2 -6; 0 pi/2 -3; 0 pi/2 0; 0 pi/2 3; 0 pi/2 6; 
    pi/4 pi/2 0; pi/4 pi/2 0; pi/4 pi/2 0; pi/4 pi/2 0; pi/4 pi/2 0;
    pi/4 3*pi/2 0; pi/4 3*pi/2 0; pi/4 3*pi/2 0; pi/4 3*pi/2 0; pi/4 3*pi/2 0;];


% % % correct definitions- inverse rotation matrices
e1 = p.sigma2X*(cos(repmat(STZj(:,1)', p.N2, 1)).*cos(repmat(STZj(:,2)', p.N2, 1)).*(repmat(Xj', 1, p.N3)-repmat(XYj(:,1)', p.N2, 1))+cos(repmat(STZj(:,1)', p.N2, 1)).*sin(repmat(STZj(:,2)', p.N2, 1)).*(repmat(Yj', 1, p.N3)-repmat(XYj(:,2)', p.N2, 1))-sin(repmat(STZj(:,1)', p.N2, 1)).*(repmat(Dj', 1, p.N3)-repmat(STZj(:,3)', p.N2, 1)));
e2 = p.sigma2Y*(-sin(repmat(STZj(:,2)', p.N2, 1)).*(repmat(Xj', 1, p.N3)-repmat(XYj(:,1)', p.N2, 1))+cos(repmat(STZj(:,2)', p.N2, 1)).*(repmat(Yj', 1, p.N3)-repmat(XYj(:,2)', p.N2, 1)));
e3 = p.sigma2Z*(sin(repmat(STZj(:,1)', p.N2, 1)).*cos(repmat(STZj(:,2)', p.N2, 1)).*(repmat(Xj', 1, p.N3)-repmat(XYj(:,1)', p.N2, 1))+sin(repmat(STZj(:,1)', p.N2, 1)).*sin(repmat(STZj(:,2)', p.N2, 1)).*(repmat(Yj', 1, p.N3)-repmat(XYj(:,2)', p.N2, 1))+cos(repmat(STZj(:,1)', p.N2, 1)).*(repmat(Dj', 1, p.N3)-repmat(STZj(:,3)', p.N2, 1)));


Wij = rectify(exp(-(e1.^2+e2.^2+e3.^2)), p.thetae_23)';

end