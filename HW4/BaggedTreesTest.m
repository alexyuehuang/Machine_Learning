function [ oneErr, hundredErr ] = BaggedTreesTest( X, Y,Xtest, Ytest, numBags )
%BAGGEDTREESTEST Returns testing eror from a test and training dataset,
%which is generated in the command line. 

[N, ~]=size(X);
[Ntest,~]=size(Xtest);
predictions=zeros(Ntest,numBags);
tr=fitctree(X,Y);
for i=1:numBags
    randN=randi(N, N,1);
    newArr = zeros(size(X));
    newY=zeros(size(Y));
    for j=1:N
        newY(j,1)=Y(randN(j,1),1);
        newArr(j,:)=X(randN(j,1),:);
    end
    tc=fitctree(newArr,newY);
    for j=1:Ntest
        predictions(j,i)=predict(tc,Xtest(j,:));
    end
end
oneErr=0;
hundredErr=0;
for j=1:Ntest
    if mode(predictions(j,:))~=Ytest(j,1)
        hundredErr=hundredErr+1;
    end
    if predict(tr,Xtest(j,:))~=Ytest(j,1)
        oneErr=oneErr+1;
    end
end
oneErr=oneErr/Ntest;
hundredErr=hundredErr/Ntest;
display(oneErr);
display(hundredErr);
end