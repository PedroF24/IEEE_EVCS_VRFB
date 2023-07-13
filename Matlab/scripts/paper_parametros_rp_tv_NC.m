%% PARÁMETROS DE LA FC CON TANQUE Y RESISTENCIA DE PÉRDIDA
% clc,clear all

ts   = 1e-4;
Ts   = 1e-5;
Tse  = 1e-3;
dec  = 1000;

r1   = 560;    % resistencia de perdidas
r2   = 0.101;  % resistencia del tanque
r3   = 0.051;  % resistencia serie

c1   = 18000;    % capacidad principal
c2   = 25;    % capacidad del tanque
c11  = 14850;    % capacidad principal nominal

E0   = 450;
v0   = 400;       % tensión inicial
maxv = 420;       % 
minv = 350;

r1_c = 8e3;      
r2_c = 0.13;
r3_c = 220e-3;

c1_c = 485;
c2_c = 55;

m5_l   = -(c1*r1 + c2*r2)/(c1*c2*r1*r2);
m4_l   = -1/(c1*c2*r1*r2);
m3_l   = (r1 + r2 + r3)/(c1*c2*r1*r2);
m2_l   = (c1*r1*r2 + c1*r1*r3 + c2*r1*r2 + c2*r2*r3)/(c1*c2*r1*r2);
m1_l   = r3;

% MÁXIMA CARGA Y DEMÁS DE LA FB
F  = 96500;
T  = 315;
R  = 8.314;
V  = 18000;
cv = 2;
nc = 450;

k = 2*T*R/F*nc;
qmax = F*V*cv/nc;

x = 0.001:1e-4:1-1e-4;
ocv = E0 + nc*2*R*T/F*log(x./(1-x));
plot(x,ocv)

% exp((E0-461)/k)/((1+exp((E0-461)/k))^2)*qmax/k;
% clear F T R V cv nc
% 
