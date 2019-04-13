table = readtable('house_prices_data_training_data.csv');
m = 17999;
X = table{1:m, 4:21} ;
y = table{1:m, 3};

[m n] = size(X);
mu = mean(X);
sd = std(X);
cov_x = cov(X);

prb= zeros(size(X,1),1)

for i=1:m 
     x = X(i,:);
     brckt = ((2*pi).^(n/2)) * (det(cov_x).^(1/2));
     expopower = (-1/2)*((x-mu)/(cov_x))*transpose(x-mu);
     prb(i) = (1/brckt)* exp(expopower);
end
 
epsilon = 10^(-70);
result = zeros(m,1);
bo = find(prb < epsilon);
for i=1:length(bo)
    index = bo(i);
    result(index) = 1;
    
end 





