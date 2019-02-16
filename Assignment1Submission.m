clear all
ds = tabularTextDatastore('house_prices_data_training_data.csv','TreatAsMissing','NA',.....
    'MissingValue',0,'ReadSize',25000);
T = read(ds);
size(T);
Alpha=.00001;
;
ss = 10800
m=length(T{1:10800,1});
U0=T{1:10800,2}
U=T{1:10800,4:19};

U1=T{1:10800,20:21};
U2=U.^2;
%X=[ones(m,1) U U1 U.^2 U.^3];

X = U(:, 1:2);
X = [X U(:,5)];


n=length(X(1,:));
for w=1:n
    if max(abs(X(:,w)))~=0
    X(:,w)=(X(:,w)-mean((X(:,w))))./std(X(:,w));
    end
end
 
X1 = [ones(m,1) X ];
n1 = length(X1(1,:));
Theta1=zeros(n1,1);

X2 =[ones(m,1) X X.^2 ];
n2 = length(X2(1,:));
Theta2 = zeros(n2,1);


X3 = [ones(m,1) X X.^2 X.^3];
n3 = length(X3(1,:));
Theta3 = zeros(n3,1);

X4 = [ones(m,1) X.^2 X.^3 X.^4];
n4 = length(X4(1,:));
Theta4 = zeros(n4,1);


Y=T{1:10800,3}/mean(T{1:10800,3});


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
k1=1;
E1(k1)=(1/(2*m))*sum((X1*Theta1-Y).^2);

R=1;
while R==1
Alpha=0.0001*1;
Theta1=Theta1-(Alpha/m)*X1'*(X1*Theta1-Y);
k1=k1+1
E1(k1)=(1/(2*m))*sum((X1*Theta1-Y).^2);
if E1(k1-1)-E1(k1)<0
    break
end 
q=(E1(k1-1)-E1(k1))./E1(k1-1);
if q <.00001;
    R=0;
end
end
figure(1)
plot(E1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
k2=1;
E2(k2)=(1/(2*m))*sum((X2*Theta2-Y).^2);

R=1;
while R==1
Alpha=0.001*1;
Theta2=Theta2-(Alpha/m)*X2'*(X2*Theta2-Y);
k2=k2+1
E2(k2)=(1/(2*m))*sum((X2*Theta2-Y).^2);
if E2(k2-1)-E2(k2)<0
    break
end 
q=(E2(k2-1)-E2(k2))./E2(k2-1);
if q <.0001;
    R=0;
end
end
figure(2)
plot(E2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

k3=1;
E3(k3)=(1/(2*m))*sum((X3*Theta3-Y).^2);

R=1;
while R==1
Alpha=0.0001*1;
Theta3=Theta3-(Alpha/m)*X3'*(X3*Theta3-Y);
k3=k3+1
E3(k3)=(1/(2*m))*sum((X3*Theta3-Y).^2);
if E3(k3-1)-E3(k3)<0
    break
end 
q=(E3(k3-1)-E3(k3))./E3(k3-1);
if q <.00001;
    R=0;
end
end
figure(3)
plot(E3)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
k4=1;
E4(k4)=(1/(2*m))*sum((X4*Theta4-Y).^2);

R=1;
while R==1
Alpha=0.0001*1;
Theta4=Theta4-(Alpha/m)*X4'*(X4*Theta4-Y);
k4=k4+1
E4(k4)=(1/(2*m))*sum((X4*Theta4-Y).^2);
if E4(k4-1)-E4(k4)<0
    break
end 
q=(E4(k4-1)-E4(k4))./E4(k4-1);
if q <.00001;
    R=0;
end
end
figure(4)
plot(E4)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

validationData = T{10801:14401, 4:5};
validationData = [validationData T{10801:14401, 8}];
Yv=T{10801:14401,3}/mean(T{10801:14401,3});

nvd=length(validationData(1,:));
for w=1:nvd
    if max(abs(validationData(:,w)))~=0
    validationData(:,w)=(validationData(:,w)-mean((validationData(:,w))))./std(validationData(:,w));
    end
end
X1val = [ones(3601,1) validationData];
X2val = [ones(3601,1) validationData validationData.^2];
X3val = [ones(3601,1) validationData validationData.^2 validationData.^3];
X4val = [ones(3601,1) validationData.^2 validationData.^3 validationData.^4];
E1val = (1/(2*3601))*sum((X1val*Theta1-Yv).^2);
E2val = (1/(2*3601))*sum((X2val*Theta2-Yv).^2);
E3val = (1/(2*3601))*sum((X3val*Theta3-Yv).^2);
E4val = (1/(2*3601))*sum((X4val*Theta4-Yv).^2);
Evalid = [E1val E2val E3val E4val];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
testData = T{14402:17999, 4:5};
testData= [testData T{14402:17999, 8}];
Ytest=T{14402:17999,3}/mean(T{14402:17999,3});

ntest=length(testData(1,:));
for w=1:ntest
    if max(abs(testData(:,w)))~=0
    testData(:,w)=(testData(:,w)-mean((testData(:,w))))./std(testData(:,w));
    end
end
Xtest =[ones(3598,1) testData];
testError = (1/(2*3598))*sum((Xtest*Theta1-Ytest).^2);