function [ oobErr ] = BaggedTrees( X, Y, numBags )
%BAGGEDTREES Returns out-of-bag classification error of an ensemble of
%numBags CART decision trees on the input dataset, and also plots the error
%as a function of the number of bags from 1 to numBags
%   Inputs:
%       X : Matrix of training data
%       Y : Vector of classes of the training examples
%       numBags : Number of trees to learn in the ensemble
%
%   You may use "fitctree" but do not use "TreeBagger" or any other inbuilt
%   bagging function

[N, ~]=size(X);
ooberrors=zeros(1, numBags);
predictions=zeros(N,numBags);

for i=1:numBags
    S=N;
    randN=randi(N, N,1);
    newArr = zeros(size(X));
    newY=zeros(size(Y));
    isUsed=zeros(N,1);
    for j=1:N
        isUsed(randN(j,1),1)=1;
        newY(j,1)=Y(randN(j,1),1);
        newArr(j,:)=X(randN(j,1),:);
    end
    tc=fitctree(newArr,newY);
    for j=1:N
        if isUsed(j,1)==0
            predictions(j,i)=predict(tc,X(j,:));
        end
    end
    for j=1:N
        [a,b]=size(nonzeros(predictions(j,:)));
        if a*b==0
            S=S-1;
            continue;
        end
        if mode(nonzeros(predictions(j,:)))~= Y(j,1)
            ooberrors(1,i)=ooberrors(1,i)+1;
        end
    end
    ooberrors(1,i)=ooberrors(1,i)/S;
end

oobErr=ooberrors(1,numBags);
figure;
plot(1:numBags,ooberrors);
title('plot of error versus number of bags')
ylabel('out of bag error') 
xlabel('number of bags') 
end


% train = readtable('zip.train.txt', 'HeaderLines',1);
% test = readtable('zip.test.txt', 'HeaderLines',1);
% train =table2array(train);
% test=table2array(test);
% xtrain = train(:, 1:end-1);
% ytrain = train(:, end);
% ytrain(ytrain==0)=-1;
% xtest =test(:, 1:end-1);
% ytest = test(:, end);
% ytest(ytest==0)=-1;
% myvec=zscore*(w.');
% mysign =sign(myvec.*ytest);
% sum(mysign(:)==-1)/145