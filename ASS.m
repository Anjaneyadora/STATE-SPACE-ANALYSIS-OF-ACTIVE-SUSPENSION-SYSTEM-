%MATLAB Code 
%State Space Analysis Of Active Suspension System.

clc
close all
clear all

t = 10;  %Simulation Time
si = 0.01; %Sub-interval

%Simulation Of Road Disturbance
x = 0;   
a1 = 0.03; %Constant
a2 = 0.04; %Constant
for i = 0:si:t
    x = x+1;
    if i<0.5
        ud(x) = a1*(1-cos(4*pi*i));
    elseif i>2 && i<2.5
        ud(x) = a2*(1-cos(4*pi*i));
    else 
        ud(x) = 0;
    end
end
i = 0:si:t;
plot(i,ud,'LineWidth',2)
legend('Road Disturbance')
xlabel('Time(sec)'),ylabel('Displacemnt(m)')
%Simulation System Parameters
mb = 300;
mw = 60;
k1 = 16000;
k2 =  190000;
c = 1000;

%State Space Matrices

A = [0 1 0 0; -(k1/mb) -(c/mb) (k1/mb) (c/mb); 0 0 0 1; (k1/mw) (c/mw) -(k1+k2)/mw -(c/mw)];
B = [0 0; (1/mb) 0; 0 0; -(1/mw) (k2/mw)];
C = [1 0 0 0];
D = [0 0];
sys_ss = ss(A,B,C,D) 
%Simulation

tsim = 0:si:t;
uc = zeros(size(tsim));
u = [uc;ud];
x0 = [0,0,0,0];
y = lsim(sys_ss, u, tsim, x0);

i = 0:si:t;
plot(i,y,'c',i,ud,'k:','LineWidth',2)
legend('System Response','Road Disturbance')
xlabel('Time(sec)'),ylabel('Dispalcement(m)')
title('Car Body Mass')
