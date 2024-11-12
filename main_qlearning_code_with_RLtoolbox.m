clear;
% Example for basic env = rlPredefinedEnv("BasicGridworld");

% created environment grid based
GW = createGridWorld(10,10);  % with default NSEW actions

GW.TerminalStates = '[10,10]';
GW.ObstacleStates = ["[5,2]";"[5,3]";"[5,4]";"[5,5]";"[7,7]";"[7,8]";
"[7,9]";"[7,10]"];

nS = numel(GW.States);
nA = numel(GW.Actions);
GW.R = -1*ones(nS,nS,nA);
GW.R(:,state2idx(GW,GW.TerminalStates),:) = 10;

disp(GW)

env = rlMDPEnv(GW);

% created q table
obsInfo = getObservationInfo(env);
actInfo = getActionInfo(env);
qTable = rlTable(obsInfo,actInfo);

qFunction = rlQValueFunction(qTable,obsInfo,actInfo);

% Creating agent with options
agentOpts = rlQAgentOptions;
agentOpts.DiscountFactor = 1;
agentOpts.EpsilonGreedyExploration.Epsilon = 0.9;
agentOpts.CriticOptimizerOptions = rlOptimizerOptions(Algorithm="sgdm", LearnRate=0.1, L2RegularizationFactor=0);


qAgent = rlQAgent(qFunction, agentOpts);

% traning options
trainOpts = rlTrainingOptions;
trainOpts.MaxStepsPerEpisode = 50;
trainOpts.MaxEpisodes = 400;
trainOpts.StopTrainingCriteria = "none";
trainOpts.StopTrainingValue = "none";
trainOpts.ScoreAveragingWindowLength = 30;

trainingStats = train(qAgent,env,trainOpts);

plot(env);
env.Model.Viewer.ShowTrace = true;

env.Model.Viewer.clearTrace;
env.ResetFcn = @() 1;
sim(qAgent,env)
