table = readtable('house_prices_data_training_data.csv');
m = 17999;
dim = 18;
X = table{1:m, 4:21} ;
%for w=1:size(X,2)
 %   if max(abs(X(:,w)))~=0;
 %   X(:,w)=(X(:,w)-mean((X(:,w))))./std(X(:,w));
 %   end
%end

Corr_x = corr(X);
y = table{1:m, 3};
%y=y/mean(y);
x_cov = cov(X);
[U S V] = svd(x_cov);
k=1;
up =0;
R=1

while R == 1
   for i=1:k 
       up = up+S(i,i);
   end 
   down = sum(sum(S));
   alpha = 1 - (up/down)
   
   if alpha < 0.001
       R=0;
       k = k-1;
   end                   
   k=k+1;
end 

Reduced_data = U(:,1:k)'*X';   %2x17999
Approx =U(:,1:k)* Reduced_data; %17999x2  2x18 = 17999x18
error = (1/m) * (sum(X - transpose(Approx)));

red = Reduced_data';
errorLinear = regression(0.001, red,y);
figure(1)
plot(errorLinear)

% ---------------------- kMeansClustering ------------------------- %

J = zeros(10,1);
for d=1:10 
    [i,m,j] = KmeansClustering(d,X)
    J(d) = j;
end
figure(2) 
plot(1:10, J)
xlabel('Number of clusters - X')
ylabel('Distortion')
title('Elbow Method')


reducedT = transpose(Reduced_data);
J2 = zeros(10,1);
for d=1:10 
    [ii,mm,jj] = KmeansClustering(d,reducedT)
    J2(d) = jj;
end
figure(3) 
plot(1:10, J2)
xlabel('Number of clusters - Reduced Data')
ylabel('Distortion')
title('Elbow Method')

% ------------------ Anomaly Detection ------------------------ %

