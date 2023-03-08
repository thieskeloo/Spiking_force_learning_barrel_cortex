%% Quick example spiking force learning barrel cortex

%% Savefolder for output files
f = filesep;
savename = 'training_consistency1';
savefolder = ['.' f 'Output' f savename];

%% Set the parameters to run the simulation
% input parameters
N = 2000;        % number of neurons
N_th = 200;      % number of thalamus neurons
N_train = 20;     % number of training trials
N_test = 10;      % number of validation trials
N_total = 2;     % number of epochs

% N = 20;        % number of neurons
% N_th = 200;      % number of thalamus neurons
% N_train = 10;     % number of training trials
% N_test = 10;      % number of validation trials
% N_total = 1;     % number of epochs

% weight scaling parameters
Win = 0.5;       % scales the input weights
G = 10;          % scales the static weights
Q = 1;           % scales the feedback weights
Winp = 1;        % network sparsity
alpha = 0.05;    % learning rate

% logicals
FORCE = true;       % if TRUE; apply FORCE learning during trials
makespikes = false;  % if TRUE; make the trial spiking structures 

% percentage of excitatory neurons if Dale's law is applied
Pexc = 0;   % percentage of excitatory neurons; set to 0 to ignore Dale's law restrictions

% Input type
input_type = 'spikes';  % options: 'ConvTrace', 'PSTH', 'spikes'

%running parameters
repeat = 3; % how many times to repeat the test(s)
seed = 42; % seed used for all rng (trial selection and random network generation etc)

%% generate input spiketrain files


%% Run the simulation
parfor i=1:repeat
%     disp(randi(intmax('uint32'),'uint32'))
    run = run_sim(N, N_th, N_train, N_test, N_total, Win, G, Q, Winp, alpha, Pexc, FORCE, makespikes, input_type, savefolder, seed);
end
