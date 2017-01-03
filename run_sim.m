function run_sim
% Runs simulations and displays attention modulation figures based on the Hu_etal15 CISS paper

%% Define model parameters (based on Marshall_etal96 paper)
global p; % global variable for storing model parameters

p.N1X = 70; p.N1Y = 35; p.N1 = 2450; % Number of neurons in first layer
p.N2X = 35; p.N2Y = 35; p.N2D = 15; p.N2 = 18375; p.N3 = 15; % Number of neurons in second/third layers
p.base1X = 0; p.base2X = 0; p.base1Y = 0; p.base2Y = 0; p.base2D = -7.0; % Neuron number offsets
p.scale1X = 1; p.scale2X = 1; p.scale1Y = 1; p.scale2Y = 1; p.scale2D = 1; % Neuron number scaling factors
p.sigma1X = 0.69; p.sigma1Y = 2.00; % Spread of connections (layer 1 -> layer 2 neurons)
p.sigma2X = 0.095; p.sigma2Y = 0.045; p.sigma2Z = 1.185; % Spread of connections (layer 2 -> layer 3 neurons)
p.thetae_12 = 0.18; p.thetae_23 = 0.18; p.thetai_22 = 0.01; p.thetai_33 = 0.02; p.bias = 0; % other parameters
p.e = 100; % e = 1/time constant (10 ms)

% Layer 2 parameters
p.T_2 = 1; p.beta_2 = 0.15; p.gamma_2 = 1.8;
% Layer 3 parameters
p.beta_3 = 0.05; p.gamma_3 = 0.2; % beta parameters controls strength of feedforward input

% Calculate feedforward, feedback, and lateral inhibition weights
p.W12 = importdata('W12.mat'); % use savedconnection weights
p.W23 = importdata('W23.mat');
p.W32 = importdata('W32.mat');

% p.W12 = W_12; % functions to create connections, don't need if you load in the saved connections
% p.W23 = W_23;
% p.W32 = p.W23';

p.W22 = importdata('W22.mat');
% p.W22 = sparse(W_ii(p.W12', p.thetai_22)); % Note: this takes a long time to calculate

p.W33 = importdata('W33.mat');
% p.W33 = W_ii(p.W23', p.thetai_33); % original Marshall et al, '96 design- inhibition based on degree of common FF input

% time vector (how long to simulate for)
tspan = [0; 0.5]; % seconds, i.e. 0.5 sec = 500 msec

thresh = 0.0001; % threshold for displaying active neurons in figures

% stimuli, frontoparallel (defines depth offsets and slant of array elements)
% p.attend = 'baseline'; % use for baseline condition (comment out other p.attend cases)
p.attend = 'fp'; % attend to middle frontoparallel plane

%% 2A (based on Nakayama_etal95 figure convention)
%% Attend frontoparallel, array elements frontoparallel
% initial input vector (all zeros)
y_0 = zeros(p.N2+p.N3, 1);

p.x1 = fp([6 0 -6], 0); % define stimulus
p.B2 = p.W12*p.x1; % feedforward input to network

[~, y] = ode45(@Eqns, tspan, y_0); % don't use the time output

[a, b] = XY(p.N1:p.N1+p.N2-1); % pull out x/y locations of neurons
d = D(p.N1:p.N1+p.N2-1); % pull out depth location of neurons

ind = find(y(end,1:p.N2) > thresh); % set threshold here instead of using zero

% select out frontoparallel attended plane
ind1 = find(y(end,1:p.N2) > thresh & d >= -1 & d <= 1); % FP (target)

% Show color display map of attentional modulation
% baseline = y(end,1:p.N2); % no attention case, saved
% save('2a.mat', 'baseline') % 2a

load('2a.mat'); % baseline, no attention (pre-computed)

SM_2(1) = sum(y(end, ind1)-baseline(ind1)); % store surface modulation index for frontoparallel condition
fprintf('\nFrontoparallel Attention Case\n')
disp(['Surface Modulation Index (2a): ' num2str(SM_2(1))])

a = a(ind);
b = b(ind);
c = 1000*(y(end,ind)-baseline(ind)); % scale for visualization purposes
d = d(ind);

figure;
scatter3(a, d, b, 50, c, 'filled'); % show color map of attention modulation
colorbar
title('Frontoparallel Attention, Frontoparallel Array');
caxis([-1 5]); % common color axis

axis equal
xlim([0 34])
ylim([-7 7])
zlim([0 34])

%% 2B
%% Attend frontoparallel, array elements back slanted
% initial input vector (all zeros)
y_0 = zeros(p.N2+p.N3, 1);

p.x1 = fp([6 0 -6], -1); % define stimulus
p.B2 = p.W12*p.x1; % feedforward input to network

[~, y] = ode45(@Eqns, tspan, y_0); % don't use time output

[a, b] = XY(p.N1:p.N1+p.N2-1); % pull out x/y locations of neurons
d = D(p.N1:p.N1+p.N2-1); % pull out depth locations of neurons

ind = find(y(end,1:p.N2) > thresh); % set threshold here instead of using zero

% select out frontoparallel attended plane
ind1 = find(y(end,1:p.N2) > thresh & d >= -1 & d <= 1); % FP (target)

% Show color display map of attentional modulation
% baseline = y(end,1:p.N2); % no attention case, saved
% save('2b.mat', 'baseline') % 2b

load('2b.mat'); % baseline, no attention

SM_2(2) = sum(y(end, ind1)-baseline(ind1));
disp(['Surface Modulation Index (2b): ' num2str(SM_2(2))])

a = a(ind);
b = b(ind);
c = 1000*(y(end,ind)-baseline(ind)); % scale for visualization purposes
d = d(ind);

figure;
scatter3(a, d, b, 50, c, 'filled'); % show color map of attention modulation
colorbar
title('Frontoparallel Attention, Back Slanted Array');
caxis([-1 5]); % common color axis

axis equal
xlim([0 34])
ylim([-7 7])
zlim([0 34])

%% 2C
%% Attend frontoparallel, array elements front slanted
% initial input vector (all zeros)
y_0 = zeros(p.N2+p.N3, 1);

p.x1 = fp([6 0 -6], 1); % define stimulus
p.B2 = p.W12*p.x1; % feedforward input to network

[~, y] = ode45(@Eqns, tspan, y_0); % don't use time output

[a, b] = XY(p.N1:p.N1+p.N2-1); % pull out x/y locations of neurons
d = D(p.N1:p.N1+p.N2-1); % pull out depth locations of neurons

ind = find(y(end,1:p.N2) > thresh); % set threshold here instead of using zero

% select out frontoparallel attended plane
ind1 = find(y(end,1:p.N2) > thresh & d >= -1 & d <= 1); % FP (target)

% Show color display map of attentional modulation
% baseline = y(end,1:p.N2); % no attention case, saved
% save('2c.mat', 'baseline') % 2c

load('2c.mat'); % baseline, no attention

SM_2(3) = sum(y(end, ind1)-baseline(ind1));
disp(['Surface Modulation Index (2c): ' num2str(SM_2(3))])

a = a(ind);
b = b(ind);
c = 1000*(y(end,ind)-baseline(ind)); % scale for visualization purposes
d = d(ind);

figure;
scatter3(a, d, b, 50, c, 'filled'); % show color map of attention modulation
colorbar
title('Frontoparallel Attention, Front Slanted Array');
caxis([-1 5]); % common color axis

axis equal
xlim([0 34])
ylim([-7 7])
zlim([0 34])

% stimuli, back slanted (defines depth offsets and slant of array elements)
p.attend = 'bs'; % attend to middle back slanted plane

%% 3A
%% Attend back slanted, array elements back slanted
% initial input vector (all zeros)
y_0 = zeros(p.N2+p.N3, 1);

p.x1 = bs([6 0 -6], -1); % define stimulus
p.B2 = p.W12*p.x1; % feedforward input to network

[~, y] = ode45(@Eqns, tspan, y_0); % don't use time output

[a, b] = XY(p.N1:p.N1+p.N2-1); % pull out x/y locations of neurons
d = D(p.N1:p.N1+p.N2-1); % pull out depth locations of neurons

ind = find(y(end,1:p.N2) > thresh); % set threshold here instead of using zero

% select back slanted attended plane
ind1 = find((y(end,1:p.N2) > thresh & b >= 10 & b <= 12) | (y(end,1:p.N2) > thresh & b >= 16 & b <= 18) | ( y(end,1:p.N2) > thresh & b >= 22 & b <= 24)); % BS (target)

% Show color display map of attentional modulation
% baseline = y(end,1:p.N2); % no attention case, saved
% save('3a.mat', 'baseline') % 3a

load('3a.mat'); % baseline, no attention

SM_3(1) = sum(y(end, ind1)-baseline(ind1)); % store surface modulation index for back slanted condition
fprintf('\nBack Slanted Attention Case\n')
disp(['Surface Modulation Index (3a): ' num2str(SM_3(1))])

a = a(ind);
b = b(ind);
c = 1000*(y(end,ind)-baseline(ind)); % scale for visualization purposes
d = d(ind);

figure;
scatter3(a, d, b, 50, c, 'filled'); % show color map of attention modulation
colorbar
title('Back Slanted Attention, Back Slanted Array');
caxis([-1 5]); % common color axis

axis equal
xlim([0 34])
ylim([-7 7])
zlim([0 34])

%% 3B
%% Attend back slanted, array elements frontoparallel
% initial input vector (all zeros)
y_0 = zeros(p.N2+p.N3, 1);

p.x1 = bs([6 0 -6], 0); % define stimulus
p.B2 = p.W12*p.x1; % feedforward input to network

[~, y] = ode45(@Eqns, tspan, y_0); % don't use time output

[a, b] = XY(p.N1:p.N1+p.N2-1); % pull out x/y locations of neurons
d = D(p.N1:p.N1+p.N2-1); % pull out depth locations of neurons

ind = find(y(end,1:p.N2) > thresh); % set threshold here instead of using zero

% select back slanted attended plane
ind1 = find((y(end,1:p.N2) > thresh & b >= 10 & b <= 12) | (y(end,1:p.N2) > thresh & b >= 16 & b <= 18) | ( y(end,1:p.N2) > thresh & b >= 22 & b <= 24)); % BS (target)

% Show color display map of attentional modulation
% baseline = y(end,1:p.N2); % no attention case, saved
% save('3b.mat', 'baseline') % 3b

load('3b.mat'); % baseline, no attention

SM_3(2) = sum(y(end, ind1)-baseline(ind1));
disp(['Surface Modulation Index (3b): ' num2str(SM_3(2))])

a = a(ind);
b = b(ind);
c = 1000*(y(end,ind)-baseline(ind)); % scale for visualization purposes
d = d(ind);

figure;
scatter3(a, d, b, 50, c, 'filled'); % show color map of attention modulation
colorbar
title('Back Slanted Attention, Frontoparallel Array');
caxis([-1 5]); % common color axis

axis equal
xlim([0 34])
ylim([-7 7])
zlim([0 34])

%% 3C
%% Attend back slanted, array elements front slanted
% initial input vector (all zeros)
y_0 = zeros(p.N2+p.N3, 1);

p.x1 = bs([6 0 -6], 1); % define stimulus
p.B2 = p.W12*p.x1; % feedforward input to network

[~, y] = ode45(@Eqns, tspan, y_0); % don't use time output

[a, b] = XY(p.N1:p.N1+p.N2-1); % pull out x/y locations of neurons
d = D(p.N1:p.N1+p.N2-1); % pull out depth locations of neurons

ind = find(y(end,1:p.N2) > thresh); % set threshold here instead of using zero

% select back slanted attended plane
ind1 = find((y(end,1:p.N2) > thresh & b >= 10 & b <= 12) | (y(end,1:p.N2) > thresh & b >= 16 & b <= 18) | ( y(end,1:p.N2) > thresh & b >= 22 & b <= 24)); % BS (target)

% Show color display map of attentional modulation
% baseline = y(end,1:p.N2); % no attention case, saved
% save('3c.mat', 'baseline') % 3c
load('3c.mat'); % baseline, no attention

SM_3(3) = sum(y(end, ind1)-baseline(ind1));
disp(['Surface Modulation Index (3c): ' num2str(SM_3(3))])

a = a(ind);
b = b(ind);
c = 1000*(y(end,ind)-baseline(ind)); % scale for visualization purposes
d = d(ind);

figure;
scatter3(a, d, b, 50, c, 'filled'); % show color map of attention modulation
colorbar
title('Back Slanted Attention, Front Slanted Array');
caxis([-1 5]); % common color axis

axis equal
xlim([0 34])
ylim([-7 7])
zlim([0 34])

end