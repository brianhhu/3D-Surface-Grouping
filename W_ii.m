function Wij = W_ii(W, thetai)

% Lateral inhibition weights (based on common input from feedforward layer)

global p;

c = size(W,2); % c: size of lateral inhibition layer
Wij = zeros(c);

d = D(p.N1:p.N1+p.N2-1); % d: disparity for neurons in second layer
scale = 1; %scale: how much to attenuate synaptic weights along same disparity
thresh = 2; %thresh: which value to cut off weights at the zero disparity line

for i=1:c-1
    Wij(i, i+1:c) = sum(bsxfun(@min, W(:,i+1:end), W(:,i)));
    Wij(i, i+1:c) = Wij(i, i+1:c).*(d(i+1:c) ~= d(i)) + scale*rectify(Wij(i, i+1:c).*(d(i+1:c) == d(i)), thresh);
end

Wij = rectify(triu(Wij,1)' + Wij, thetai); % create symmetric matrix
Wij = Wij./max(max(Wij)); % normalize values to between 0 and 1

end