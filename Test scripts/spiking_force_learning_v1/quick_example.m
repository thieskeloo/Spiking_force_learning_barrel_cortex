%% Spiking force learning barrel cortex

%% savefolder for output files
addpath(genpath('Plot functions'))
f = filesep;
savename = 'quick_example';
savefolder = ['.' f 'Output' f savename];
%% Set the parameters to run the simulation
N = 2000;        % number of neurons
N_th = 200;     % number of thalamus neurons
N_train = 10;    % number of training trials
N_test = 2;     % number of validation trials
N_total = 1;    % number of epochs

% varying parameters
Win = [0.5];       % scales the input weights
G = [10];         % scales the static weights
Q = [1];         % scales the feedback weights
Winp = [1];      % network sparsity
alpha = 0.05;    % learning rate

% logicals
FORCE = true;   % apply FORCE learning during trials
makespikes = false; % make the trial spiking structures 
%% run the simulation
run = run_sim(N, N_th, N_train, N_test, N_total, Win, G, Q, Winp,...
    alpha, FORCE, makespikes, savefolder);
