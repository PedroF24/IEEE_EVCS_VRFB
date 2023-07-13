%% Plotting for the EUROPEAN CONGRES

% this section must be connected with the rest of the made simulations.
% Therefore I will try to make it consistent in such a way that every
% simulation can be carried on without major inconvinients.

run paper_parametros_rp_tv_NC.m
% load('FB_car_power_madrid.mat');
% load('FB_current_madrid_2');

As  = [-1/(c1*r1) 0 ; 0 -1/(c2*r2)];
Bs  = [1/c1 ; 1/c2];
Cs  = [1 1];
Ds  = r3;

% con un filtro con dos polos en 10 el valor más grande de la D es 40
% con un filtro con dos polos en 10 el valor más grande de la D es 206
LipI2T = 2550;
LipFT  = 850;

L1     = 1450;
L2     = 850;

m5_lc   = -(c1*r1 + c2*r2)/(c1*c2*r1*r2);
m4_lc   = -1/(c1*c2*r1*r2);
m3_lc   = (r1 + r2 + r3)/(c1*c2*r1*r2);
m2_lc   = (c1*r1*r2 + c1*r1*r3 + c2*r1*r2 + c2*r2*r3)/(c1*c2*r1*r2);
m1_lc   = r3-1e-2;

p       = 50;
pc      = 20;
p2      = 50*50;
p3      = 5;

Gc      = 0.1*[0.30 0 0 0 0;0 0.8 0 0 0;0 0 0.30 0 0;0 0 0 0.3692 0;0 0 0 0 0.022]
GcD     = 1*[0.9 0 0 0 0;0 1 0 0 0;0 0 1 0 0;0 0 0 1 0;0 0 0 0 1];
Gcs     = 4.2*[1 0 0 0;0 0.3 0 0;0 0 0.21 0;0 0 0 0.5]
% Gcs     = 0.3*eye(4);

q       = 0.034;      % factor de olvido para la estimación simplificada
qc      = 0.003;       % factor de olvido para la estimación completa
Tse    = 0.004;
lambda = exp(-Tse*q*10);

clear duracion

T_conv_S = 3/(min(eig(Gcs))*2*0.01)
T_conv_C = 3/(min(eig(Gc))*2*1)

