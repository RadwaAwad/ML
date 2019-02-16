function [theta, Jold] = costAndGradFunction(theta,X,Y,alpha,noIter);
m = size(X,1);
X = [ones(m,1) X];
 
for i=1:noIter
h = sigmoid(X*theta);
thnorm = theta(2:length(theta),1);
Jold(i)= ((-1/m)*(sum(Y.*log(h) +((1-Y).*log(1-h)))))+((0.000001/2*m)*sum(thnorm.^2));
theta = theta - ((alpha/m)*X'*(h-Y));
end
 
end
