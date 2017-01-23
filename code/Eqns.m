function dy = Eqns(t, y)

% Use ODE45 Solver Function for differential equations
% Brian Hu, Johns Hopkins University, 2012

global p;

% linear units, so no nonlinear gain functions
B3 = p.W23*y(1:p.N2);
T2 = p.W32*y(p.N2+1:p.N2+p.N3);
E2 = p.B2.*(1+p.T_2*T2);
I2 = p.W22*y(1:p.N2);
I3 = p.W33*y(p.N2+1:p.N2+p.N3);

dy = zeros(size(y));

% layer 2   
dy(1:p.N2) = p.e*(-y(1:p.N2)+rectify(p.beta_2*E2-p.gamma_2*I2, 0));

% layer 3 (can apply attention here to the grouping cell corresponding to a specific surface)
attn_inp = zeros(p.N3, 1); % Note: if p.attend = 'baseline', no attention is applied
if strcmp(p.attend,'fp')
    attn_inp(3) = 0.25; % frontoparallel
elseif strcmp(p.attend,'bs')
    attn_inp(13) = 0.25; % back slant
end

% layer 3
dy(p.N2+1:p.N2+p.N3) = p.e*(-y(p.N2+1:p.N2+p.N3)+rectify(p.beta_3*(B3+attn_inp)-p.gamma_3*I3, 0));

end