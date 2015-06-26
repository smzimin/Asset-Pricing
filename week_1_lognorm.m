mu = 0.06;
sigma = 0.2;

T = 10;

R = exp(normrnd((mu-0.5*sigma^2)*T, T*sigma^2, 1, 1000000))';
pd = fitdist(R,'Lognormal');

x_pdf = min(R):0.01:max(R);
y = pdf(pd,x_pdf);
 
% figure
% %hist(R, 150)
% hold on
% scale = 10/max(y);
% plot((x_pdf),(y.*scale))
% hold off

[mean(R) median(R) mode(R)]
[exp(mu*T)  exp((mu-0.5*sigma^2)*T) exp((mu-1.5*sigma^2)*T)]

