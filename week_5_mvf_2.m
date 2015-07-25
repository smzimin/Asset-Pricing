sel = assetpricingdataff25(:,1) <= 198912;
sel2 = assetpricingdataff25(:,1) > 198912;

ff25 = assetpricingdataff25(sel, 2:26);
ff25_2 = assetpricingdataff25(sel2, 2:26);
rf = assetpricingdatafffactors(sel, 5);
rf_2 = assetpricingdatafffactors(sel2, 5);
Mkt_RF = assetpricingdatafffactors(sel2, 2);
SMB = assetpricingdatafffactors(sel2, 3);
HML = assetpricingdatafffactors(sel2, 4);

ff25_exess = zeros(size(ff25));


for i = 1:length(ff25(:,1))
    ff25_exess(i,:) = ff25(i,:) - rf(i);
end

cov_matrix = cov(ff25_exess);
w = cov_matrix^-1 * mean(ff25_exess)';


ff25_exess_2 = zeros(size(ff25_2));
Remv = zeros(length(ff25_2(:,1)),1);
for i = 1:length(ff25_2(:,1))
    ff25_exess_2(i,:) = ff25_2(i,:) - rf_2(i);
    Remv(i) = ff25_exess_2(i,:)*w;
end
% mean(Remv)
% std(Remv)
% (mean(Remv)/std(Remv))


second_moments = zeros(25,25);
for i = 1:25
    for k = i:25
        second_moments(i,k) = ff25_exess(:,i)'*ff25_exess(:,k) / length(ff25(:,1));
        second_moments(k,i) = second_moments(i,k);
    end
end

Re0 = (mean(ff25_exess) * second_moments^-1 * ff25_exess_2')';
% mean(Re0)
% std(Re0)
% (mean(Re0)/std(Re0))
% 
% s = -15:0.01:15;
% msemv = zeros(size(s));
% stdsemv = zeros(size(s));
% mse0 = zeros(size(s));
% stds0 = zeros(size(s));
% 
% for i = 1:length(s)
%     msemv(i) = mean(s(i)*Remv);
%     stdsemv(i) = std(s(i)*Remv);
%     
%     mse0(i) = mean(s(i)*Re0);
%     stds0(i) = std(s(i)*Re0);
% end
% 
% plot(stdsemv, msemv, 'r', 'LineWidth', 1.5, 'LineSmoothing', 'on'); hold on;
% plot(stds0, mse0, 'LineWidth', 1.5, 'LineSmoothing', 'on');
% 
% 
% plot(std(Remv), mean(Remv),'g*')
% plot(std(Re0), mean(Re0),'y*')
% 
% plot(std(SMB), mean(SMB),'c*')
% plot(std(HML), mean(HML),'c*')
% plot(std(Mkt_RF), mean(Mkt_RF),'c*')
% 
% for i =1:25
%     plot(std(ff25_exess_2(:,i)), mean(ff25_exess_2(:,i)),'k*')
% end

rmeans = zeros(25,1);
betas = zeros(25,1);

for i = 1:25
    temp = regress(ff25_exess_2(:,i),[ones(size(ff25_exess_2(:,i))) Re0]);
    betas(i) = temp(2);
    rmeans(i) = mean([ones(size(ff25_exess_2(:,i))) Re0] * temp);
end

scatter([betas; 0], [rmeans; 0])

% mean(Re0'*ff25_exess(:,1))
% mean(ff25_exess(:,1))