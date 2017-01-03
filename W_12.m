function Wij = W_12

% Weights from layer 1 to layer 2

global p;

i = 0:p.N1-1;
j = p.N1:p.N1+p.N2-1;
[Xi, Yi] = XY(i);
[Xj, Yj] = XY(j);
LRi = LR(i);
Dj = D(j);

Wij = rectify(exp(-(p.sigma1Y*(repmat(Yi', 1, p.N2)-repmat(Yj, p.N1, 1)).^2+p.sigma1X*(repmat(Xi', 1, p.N2)+repmat(LRi', 1, p.N2).*repmat(Dj, p.N1, 1)-repmat(Xj, p.N1, 1)).^2+p.bias*abs(repmat(Dj, p.N1, 1)))), p.thetae_12)';

end