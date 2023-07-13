%% cálculo de inercia para el generador

% extraído de la referencia P-087

P_n = [150 450 900 1200 1800 2300 20000]*10^3;  % la potencia debería estar en MW.

% la inercia puede calcularse a partir de considerar diferentes masas,
% diametros, velocidades nominales de las turbinas. Es importante pensar
% qué ocurre con el filtrado armónico cuando se incrementa la inercia del
% sistema

% primero hallamos la masa de la turbina en función del largo de la pala

gr
% g_r = [25    40    55    60    80    90   160];

L = (P_n/(310*2.08^1.99)).^(1/1.99);

D = 2.08*L;      % diámetro del rotor de la turbina.

m = 2.95*L.^2.13; % este es un vector de masa... L es un vector de longitudes deseadas para satisfacer la potencia requerida

J = 0.22*m.*L.^2.33    % esta es la inercia de la turbina.... pero!... PERO!!!

H = J*(1.01*50*pi)^2./(P_n)./(g_r.^2)

% La inercia debe ser referenciada al lado del generador. La inercia
% combinada del sistema brinda: Jt = Jm/kgb^2 + Jg donde Kgb es
% aproximadamente 90 veces, y es igual a la relación de engranes del
% generador... 

FRated = 50;            % estos parámetros nominales sirven para que el generador corra sin problema.
SRated = 150000;
VRated = 440;

t_end = 60*60*24;

dec = 2000;
load('wind.mat');
load('viento_fourier.mat');

%% PARA TRANSFORMADA DE FOURIER DE LAS POTENCIAS DEL VIENTO.

for i = 1:length(J)
    tic
    sim('ee_asm_generator_fourier.slx',Wf.time(end));
    Pf(i) = P_real;
    toc
end

% save('simu_fourier.mat','Pf');

% PF no se guardo!!!! es muy pesada... Entonces guardamos las otras
% variables por separado...

Pf_1 = Pf(1);
Pf_2 = Pf(2);
Pf_3 = Pf(3);
Pf_4 = Pf(4);
Pf_5 = Pf(5);
Pf_6 = Pf(6);
Pf_7 = Pf(7);

save('simu_fourier.mat','Pf_1','Pf_2','Pf_3','Pf_4','Pf_5','Pf_6','Pf_7');

%% Para evaluar los vientos con diferentes inercias

% load('wind.mat');

t_end = 60*24*24;

dec = 1000;

for i = 1:length(J)
    sim('ee_asm_generator_ed2.slx',t_end);
    P(i) = P_real;
end

save('simu_full.mat','P');
% save('simu_fig_2.mat','windprof','P_turb');

%% CHECKING

% CON ESTE SCRIPT VERIFICAMOS LOS DATOS ANTERIORES. EVALUAMOS CÓMO VIENEN
% FUNCIONANDO LAS SIMULACIONES.

for i = 1:length(J)
    plot(P(i).time(1:1:end),P(i).signals.values(1:1:end));hold on;
end

hold off;
%% PERFIL DEMANDA DE AUTITOS CARGANDO

% esta esta cargada en FB_car_power_madrid y _2 también... No detecto
% diferencia entre estos archivos. Incluso tienen en mismo largo.

%% CORRIENTE PARA LAS FB

pc1   = 20;
pc2   = 15;
pc3   = 50;
pc4   = 100;
pc5   = 40;

p_srb   = 200;
p_srb2  = 0.8;

duracion = 2;

% stairs(PRBS.time,PRBS.signals.values)
% ylim([-0.1;1.1])

PRBS2.signals.values = double(ltePRBS(5,24*60*60/duracion));
PRBS2.time   = (1:duracion:24*60*60);

PRBS3.signals.values = double(ltePRBS(10,24*60));
PRBS3.time   = (1:60:24*60*60);

load('simu_full.mat');

dec = 10;

for i = 1:length(J)
    sim('power_reference_2.slx',t_end);%24*60*60);
    FBI(i) = FB_current;
end

save('simu_full_corriente.mat','FBI');

%%
load('simu_full_corriente.mat');
run('init_block_cong_NC.m');

% load('sim_full_corriente.mat');

for i = 1:length(J)
    sim('Pers_track_ieee.slx',t_end);
    mini(i) = min_eig;
end

save('sim_persi_todas.mat','FBI','tita_elect_real');

for i = 1:length(J)
    sim('Parm_track_ieee.slx',t_end);
    para(i) = tita_elect;
end

save('sim_param_todos.mat','para','tita_elect');
