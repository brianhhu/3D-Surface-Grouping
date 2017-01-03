function vec = rectify(vec, theta)

% Rectifies a vector input based on threshold
%
% Inputs:
%   [vec, theta]     vector, threshold input
%
% Outputs:
%   [vec]     rectified vector output
%
% Created By Brian Hu, Johns Hopkins University, 2012

vec(vec<=theta) = 0;

end