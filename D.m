function Di = D( i )

% Find disparity

global p;

Di = mod(i-p.N1, p.N2D)*p.scale2D + p.base2D;

end

