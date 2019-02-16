function Jcv = cost(X,Y,theta)
m = size(X,1);
X = [ones(m,1) X];
h= sigmoid(X*theta);
thnorm = theta(2:length(theta),1);
Jcv= ((-1/m)*(sum(Y.*log(h) +((1-Y).*log(1-h)))))+((0.000001/2*m)*sum(thnorm.^2));
end 