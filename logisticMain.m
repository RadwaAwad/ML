datas = tabularTextDatastore('heart_ddd.csv','TreatAsMissing','NA',.....
    'MissingValue',0,'ReadSize',25000);
dset = read(datas);
%random_dset = dset(randperm(size(dset, 1)), :);
Target = dset{1:200,14};
noIter = 100000;
alpha = 0.0001;
n=length(dset{1,:});
for w=1:n
    if max(abs(dset{:,w}))~=0
   dset{:,w}=(dset{:,w})./mean((dset{:,w}));
    end
end
input = dset{1:200, 1};
input = [input dset{1:200,4:5}]; %age,tresbps,chol
 
input1 = [input input.^2];
[r c] = size(input1);
Theta1= zeros((c+1),1);
[tht, J] = costAndGradFunction(Theta1, input1, Target,alpha,noIter);
 
 
input2 = [input.^2 input.^3];
[r1 c2] = size(input2);
Theta2 = zeros((c2+1),1);
[tht2, J2] = costAndGradFunction(Theta2, input2, Target,alpha,noIter);
 
input3 = [input input.^2 input.^4];
[r3 c3] = size(input3);
Theta3 = zeros((c3+1),1);
[tht3, J3] = costAndGradFunction(Theta3, input3, Target,alpha,noIter);
 
input4 = [input input.^2 input.^3 input.^4];
[r4 c4] = size(input4);
Theta4 = zeros((c4+1),1);
[tht4, J4] = costAndGradFunction(Theta4, input4, Target,alpha,noIter);
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
cvData = dset{201:225, 1};
cvData = [cvData dset{201:225,4:5}];
cvTarget = dset{201:225,14};
 
cvData1 = [cvData cvData.^2];
 JCv1 = cost(cvData1,cvTarget,tht);
 
cvData2 = [cvData.^2 cvData.^3];
 JCv2 = cost(cvData2,cvTarget,tht2);
 
cvData3 = [cvData cvData.^2 cvData.^4];
 JCv3 = cost(cvData3,cvTarget,tht3);
 
cvData4 = [cvData cvData.^2 cvData.^3 cvData.^4];
 JCv4 = cost(cvData4,cvTarget,tht4);
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
testData = dset{226:250, 1};
testData = [testData dset{226:250,4:5}];
testTarget = dset{226:250,14};
tData = [testData testData.^2 testData.^3 testData.^4];
testError = cost(tData, testTarget,tht4);
 
