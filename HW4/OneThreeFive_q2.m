load zip.train;
load TEST.test;
fprintf('Working on the one-vs-three problem...\n\n');
subsample = zip(find(zip(:,1)==3 | zip(:,1) == 1),:);
subsamplettest=TEST(find(TEST(:,1)==1 | TEST(:,1) == 3),:);
for i=1:length(subsample)
    for j=1:length(subsample(1))
        if subsample(i,j)==3 
            subsample(i,j)=-1;
        else
            subsample(i,j)=1;
        end
    end
end
for i=1:length(subsamplettest)
    for j=1:length(subsamplettest(1))
        if subsamplettest(i,j)==3
            subsamplettest(i,j)=-1;
        
        else
            subsamplettest(i,j)=1;
        end
    end
end


Y = subsample(:,1);
X = subsample(:,2:257);
YTEST=subsamplettest(:,1);
XTEST=subsamplettest(:,2:257);
n_trees=200;
trainErr=ones(n_trees,1);
testErr=zeros(n_trees,1);

for i=1:n_trees
    
    [trainErr(i,1), testErr(i,1)]=AdaBoost(X,Y,XTEST,YTEST,i);
    
end
figure(1)
plot(trainErr);
hold on;
plot(testErr);
legend('trainErr','testErr');
title('AdaBoost 1-vs-3');
xlabel('Number of Weak Learners');
ylabel('Binary Classification Error');
hold off;

fprintf('Working on the three-vs-five problem...\n\n');
subsample2 = zip(find(zip(:,1)==3 | zip(:,1) == 5),:);
subsamplettest2=TEST(find(TEST(:,1)==5 | TEST(:,1) == 3),:);
for i=1:length(subsample2)
    for j=1:length(subsample2(1))
        if subsample2(i,j)==3
            subsample2(i,j)=-1;
        else
            subsample2(i,j)=1;
        end
    end
end
for i=1:length(subsamplettest2)
    for j=1:length(subsamplettest2(1))
        if subsamplettest2(i,j)==3
            subsamplettest2(i,j)=-1;
        
        else
            subsamplettest2(i,j)=1;
        end
    end
end


Y = subsample2(:,1);
X = subsample2(:,2:257);
YTEST=subsamplettest2(:,1);
XTEST=subsamplettest2(:,2:257);
n_trees=200;
trainErr2=ones(n_trees,1);
testErr2=zeros(n_trees,1);

for i=1:n_trees
    
    [trainErr2(i,1), testErr2(i,1)]=AdaBoost(X,Y,XTEST,YTEST,i);
    
end
figure(2);
plot(trainErr2);
hold on;
plot(testErr2);
legend('trainErr','testErr');
title('AdaBoost 3-vs-5');
xlabel('Number of Weak Learners');
ylabel('Binary Classification Error');
hold off;
