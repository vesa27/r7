clc; clear; close all;

Pt = [20; 10]; Gt = [45; 35]; f = [14; 12]; d = 36000; Gr = [30; 40]; L = 2;
N = -125; CN_req = 10;
mg = @(Pr) Pr - N - CN_req;

EIRP = 10*log10(Pt) + Gt - L;
FSL  = 92.45 + 20*log10(f) + 20*log10(d);
Pr   = EIRP - FSL + Gr;
CN   = Pr - N;
M    = CN - CN_req;

fprintf('\n             Uplink    Downlink\n');
fprintf('EIRP (dBW):  %7.2f   %7.2f\n', EIRP);
fprintf('FSL (dB):    %7.2f   %7.2f\n', FSL);
fprintf('Pr (dBW):    %7.2f   %7.2f\n', Pr);
fprintf('C/N (dB):    %7.2f   %7.2f\n', CN);
fprintf('Margin (dB): %7.2f   %7.2f\n', M);

d_r    = linspace(30000, 45000, 200);
EIRP_r = linspace(30, 75, 200);
Gr_r   = linspace(20, 50, 200);
FSL_r  = linspace(200, 212, 200);

Pr_d   = EIRP - (92.45 + 20*log10(f) + 20*log10(d_r)) + Gr;
M_EIRP = mg(EIRP_r - FSL + Gr);
M_Gr   = mg(EIRP - FSL + Gr_r);
M_FSL  = mg(EIRP - FSL_r + Gr);

figure;

subplot(2,2,1); plot(d_r, Pr_d(1,:), 'b', d_r, Pr_d(2,:), 'r'); grid on;
xlabel('Distance (km)'); ylabel('Received Power (dBW)'); title('Received Power vs. Distance');
legend('Uplink','Downlink');

subplot(2,2,2); plot(EIRP_r, M_EIRP(1,:), 'b', EIRP_r, M_EIRP(2,:), 'r'); grid on;
yline(0, 'k');
xlabel('EIRP (dBW)'); ylabel('Link Margin (dB)'); title('Link Margin vs. EIRP');
legend('Uplink','Downlink');

subplot(2,2,3); plot(Gr_r, M_Gr(1,:), 'b', Gr_r, M_Gr(2,:), 'r'); grid on;
yline(0, 'k');
xlabel('Receiver Gain (dB)'); ylabel('Link Margin (dB)'); title('Link Margin vs. Receiver Gain');
legend('Uplink','Downlink');

subplot(2,2,4); plot(FSL_r, M_FSL(1,:), 'b', FSL_r, M_FSL(2,:), 'r'); grid on;
yline(0, 'k');
xlabel('Free Space Loss (dB)'); ylabel('Link Margin (dB)'); title('Link Margin vs. Free Space Loss');
legend('Uplink','Downlink');
