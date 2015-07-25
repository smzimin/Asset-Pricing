clear
load 'coursera_gmm_data.txt'

dc = coursera_gmm_data(:,2);
rmrf = coursera_gmm_data(:,3);
smb = coursera_gmm_data(:,4);
hml = coursera_gmm_data(:,5);
rf = coursera_gmm_data(:,6);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% disp(mean(100*[dc rmrf smb hml]))
% disp(corr(100*[dc rmrf smb hml]))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% g = (0:0.01:200)';
% g_rmrf = zeros(size(g));
% g_smb = zeros(size(g));
% g_hml = zeros(size(g));
% 
% for i = 1:length(g)
%     g_rmrf(i) = mean((dc.^-g(i)).*rmrf);
%     g_smb(i) = mean((dc.^-g(i)).*smb);
%     g_hml(i) = mean((dc.^-g(i)).*hml);
% end
% 
% plot(g, g_rmrf, 'r', 'LineWidth', 1.5, 'LineSmoothing', 'on'); hold on;
% plot(g, g_smb, 'g', 'LineWidth', 1.5, 'LineSmoothing', 'on');
% plot(g, g_hml, 'LineWidth', 1.5, 'LineSmoothing', 'on');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% g = (88:0.01:90)';
% g_objective = zeros(size(g));
% 
% for i = 1:length(g)
%     S = cov([(dc.^-g(i)).*rmrf (dc.^-g(i)).*hml]);
%     G = [mean((dc.^-g(i)).*rmrf); mean((dc.^-g(i)).*hml)];
%     g_objective(i) = G' * S^-1 * G;
% end
% 
% plot(g, g_objective, 'r', 'LineWidth', 1.5, 'LineSmoothing', 'on'); hold on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% g = 80.9;
% g = 78.3;
% d = -[mean(log(dc).*(dc.^-g).*rmrf); mean(log(dc).*(dc.^-g).*hml)];
% S = cov([(dc.^-g).*rmrf (dc.^-g).*hml]);
% a = d'*S^-1;
% 
% 
% std_b = sqrt((a*d)^-1*a*S*a'*((a*d)^-1)' / 63);
% 
% g_opt = [mean((dc.^-g).*rmrf); mean((dc.^-g).*hml)]
% var_g = sqrt((S - d*(d'*S^-1*d)^-1*d') / 63)
% EtRe = [mean(rmrf); mean(hml)];
% 
% G = [mean((dc.^-g).*rmrf); mean((dc.^-g).*hml)];
% JT = 63 * G' * S^-1 * G

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% plot(rmrf, 'r', 'LineWidth', 1.5, 'LineSmoothing', 'on'); hold on;
% plot(smb, 'g', 'LineWidth', 1.5, 'LineSmoothing', 'on');
% plot(hml, 'LineWidth', 1.5, 'LineSmoothing', 'on');
% plot(dc.^-g, 'k', 'LineWidth', 1.5, 'LineSmoothing', 'on');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

g = 78.3;
d = -mean(log(dc).*(dc.^-g).*rmrf);
S = cov((dc.^-g).*rmrf);
a = d'*S^-1;


std_b = sqrt((a*d)^-1*a*S*a'*((a*d)^-1)' / 63);

g_opt = [mean((dc.^-g).*rmrf); mean((dc.^-g).*hml)]
var_g = sqrt((S - d*(d'*S^-1*d)^-1*d') / 63)
EtRe = [mean(rmrf); mean(hml)];

G = [mean((dc.^-g).*rmrf); mean((dc.^-g).*hml)];
JT = 63 * G' * S^-1 * G