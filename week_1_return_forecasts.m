clear;
load ps1_data.txt;

dates = ps1_data(:,1);
ret = ps1_data(:,2);
dp = ps1_data(:,3);
d_growth = ps1_data(1:end,4);
t_bill_ret = ps1_data(:,5);

clear ps1_data;

% k = 17;
% R = zeros(k,1);
% B = zeros(k,1);
% DP = R;
% ret = ret + ones(87,1);
% t_bill_ret = t_bill_ret + ones(87,1);
% 
% for i = 1:k
%     p = 1+5*(i-1);
%     R(i) = ret(p+1)*ret(p+2)*ret(p+3)*ret(p+4)*ret(p+5);
%     B(i) = t_bill_ret(p+1)*t_bill_ret(p+2)*t_bill_ret(p+3)*t_bill_ret(p+4)*t_bill_ret(p+5);
%     DP(i) = dp(p);
% end
% 
% fitlm(DP, R-B)
% 
% b = regress(R-B, [ones(21,1) DP]);
% mean([ones(k,1) DP] * b);
% std([ones(k,1) DP] * b);
% 
% plot(R); hold on; plot([ones(21,1) DP] * b, 'r');

% R = zeros(82,1);
% B = zeros(82,1);
% ret = ret + ones(87,1);
% t_bill_ret = t_bill_ret + ones(87,1);
% 
% for i = 1:82
%     R(i) = ret(i+1)*ret(i+2)*ret(i+3)*ret(i+4)*ret(i+5);
%     B(i) = t_bill_ret(i+1)*t_bill_ret(i+2)*t_bill_ret(i+3)*t_bill_ret(i+4)*t_bill_ret(i+5);
% end
% 
%  fitlm(dp(1:end-5), R-B)
% 
% b = regress(R-B, [ones(82,1) dp(1:end-5)]);
% mean([ones(82,1) dp(1:end-5)] * b)
% std([ones(82,1) dp(1:end-5)] * b)
% 
% plot(R-B); hold on; plot([ones(82,1) dp(1:end-5)] * b, 'r');


%[mean(ret) mean(t_bill_ret) mean(ret-t_bill_ret) std(ret) std(t_bill_ret) std(ret-t_bill_ret)] * 100;
%mean(ret-t_bill_ret) / std(ret-t_bill_ret);
% plot(dates, ret); hold on; plot(dates, dp,'r'); plot(dates, t_bill_ret,'g');

% fitlm(ret(1:end-1), ret(2:end))
% 
ecxess = ret-t_bill_ret;
[b,bint,r,rint,stats] = regress(ecxess(2:end), [ones(length(dp)-1,1) dp(1:end-1)]);
fitlm(dp(1:end-1), ecxess(2:end))
mean([ones(length(dp)-1,1) dp(1:end-1)] * b)
std([ones(length(dp)-1,1) dp(1:end-1)] * b)