function output = activation( W, x, gain1, gain2 )

% Calculate output firing rate based on weight matrix, input vector, and 
% corresponding gain functions at each stage (defined by function handles)

output = gain2(W*gain1(x));

end