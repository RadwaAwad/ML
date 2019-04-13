function [ E ] = regression( Alpha,X,Y )
m=size(X,1);
X=[ones(m,1) X X.^(2)]
n=length(X(1,:));
for w=2:n
    if max(abs(X(:,w)))~=0
    X(:,w)=(X(:,w)-mean((X(:,w))))./std(X(:,w));
    end
end
Y=Y/mean(Y)
Theta=zeros(n,1);
k=1;

E(k)=(1/(2*m))*sum((X*Theta-Y).^2);
q=inf;
R=1;
while R==1
Alpha=Alpha*1;
Theta=Theta-(Alpha/m)*X'*(X*Theta-Y);
k=k+1
E(k)=(1/(2*m))*sum((X*Theta-Y).^2);
if E(k-1)-E(k)<0
    break
end 
q=(E(k-1)-E(k))./E(k-1);
if q <.000001;
    R=0;
end
end
plot(E)

end