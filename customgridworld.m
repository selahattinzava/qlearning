clc;clear;

GW = createGridWorld(10,10);  % with default NSEW actions

GW.TerminalStates = '[10,10]';
GW.ObstacleStates = ["[5,2]";"[5,3]";"[5,4]";"[5,5]";"[7,7]";"[7,8]";
"[7,9]";"[7,10]"];

disp(GW)

env = rlMDPEnv(GW);

plot(env)