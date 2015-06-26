clear;

n = 3*10^6;
sigma = [0.018; 0.18];
f = 0.94;
rho = -0.80756;

eps = [sigma(1) 0;
    rho*sigma(2) sigma(2)*sqrt(1-rho^2)] * normrnd(0,1,2,n);

x = zeros(1,n);
x(1) = 0;
r = x;

for i = 1:n-1
    x(i+1) = f*x(i) + eps(1,i);
end

for i = 1:n
    r(i) = x(i) + eps(2,i);
end

c = zeros(1,n);
for i = 1:n
    c(i) = var(r(1:i));
end

% R = zeros(1,n);
% 
% for i = 5:n
%     R(i) = sum(r(i-4:i));
% end

%b = regress(r', [ones(n-4,1) x']);
%fitlm(x(1:n-4)', R(5:n)')

fitlm(r(1:n-1)', r(2:n)')

% plot(x(1:100)); hold on; plot(r(1:100),'r'); figure();
% plot(R(5:104),'r'); hold on; plot([ones(100,1) x(1:100)'] * [-0.0003328; 4.4372]);
