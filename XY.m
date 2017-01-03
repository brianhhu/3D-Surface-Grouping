function [ Xi, Yi ] = XY( i )

% Find x,y locations of each index

global p;

% initialize Xi, Yi
Xi = zeros(size(i));
Yi = zeros(size(i));

% perform elementwise comparison within bounds
XY_1 = (i >= 0 & i < p.N1);
XY_2 = (i >= p.N1 & i < p.N1+p.N2);
% XY_3 = (i >= p.N1+p.N2 & i < p.N1+p.N2+p.N3);

% calculate Xi
Xi(XY_1 == 1) = floor(mod(i(XY_1 == 1), p.N1X)/2)*p.scale1X + p.base1X;
Xi(XY_2 == 1) = floor((i(XY_2 == 1)-p.N1)/(p.N2Y*p.N2D))*p.scale2X + p.base2X;
% Xi(XY_3 == 1) = floor((i(XY_3 == 1)-(p.N1+p.N2))/(p.N3Z*p.N3S*p.N3T*p.N3Y))*p.scale3X + p.base3X;

% calculate Yi
Yi(XY_1 == 1) = floor(i(XY_1 == 1)/p.N1X)*p.scale1Y + p.base1Y;
Yi(XY_2 == 1) = mod(floor((i(XY_2 == 1)-p.N1)/p.N2D), p.N2Y)*p.scale2Y + p.base2Y;
% Yi(XY_3 == 1) = mod(floor((i(XY_3 == 1)-(p.N1+p.N2))/(p.N3Z*p.N3S*p.N3T)), p.N3Y)*p.scale3Y + p.base3Y;

end