function [iterations,mins,J] = KmeansClustering(k, X)
[m n] = size(X);
% initialize random centroids 
index = randperm(m, k); %k unique integers from 1 to n   1xk
dist = zeros(m,k);
cent = X(index,:); %k x n 
iterations =0;
mins = zeros(m,1);
R=1;

while R==1
    oldCent = cent;
    
    %calculate all distances for each point to all centroids (k clusters) 
    for i=1:m                  %each row is a point each col is a k 
        for j =1:k
            dist(i,j) = norm(X(i,:) - cent(j,:));
        end
    end
    
    %find the k with min distance for all points
    for i=1:m
        mins(i) = find(dist(i,:)==min(dist(i,:))); 
    end
    
    for i =1:k
        %find(mins==i) return index in mins that is equal to k 
        % new centroid of k is equal to the mean of points
        c = X(find(mins==i), :);
        cent(i,:) = mean(c);
    end
    
    if(cent == oldCent)
        break;
    end
    
    iterations = iterations +1;
end

J = 0;
for i = 1:m
clus = mins(i);
u = cent(clus,:);
x = X(i,:);
    J = J + norm(x-u);
end
J = J/m;


end
