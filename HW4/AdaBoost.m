function [ train_err, test_err ] = AdaBoost( X_tr, y_tr, X_te, y_te, n_trees )
%AdaBoost: Implement AdaBoost using decision stumps learned
%   using information gain as the weak learners.
%   X_tr: Training set
%   y_tr: Training set labels
%   X_te: Testing set
%   y_te: Testing set labels
%   n_trees: The number of trees to use
n=length(X_tr);
m=length(X_te);
weight=zeros(n,1);
weight(:)=1.0/n;
tr_output=zeros(n,1);
te_output = zeros(m,1);
for i=1:n_trees
    tree = fitctree(X_tr,y_tr, 'SplitCriterion','deviance','Weights',weight,'MaxNumSplits',1);
    labels = predict(tree,X_tr);
    te_labels=predict(tree,X_te);
    error = sum(weight.*(labels~=y_tr));
    alphat = (1/2)*log((1-error)/error);
    zt = 2*sqrt(error*(1-error));
    weight=weight.*exp(-alphat*y_tr.*labels)/zt;
        
    tr_output=tr_output+alphat*labels;
    te_output=te_output+alphat*te_labels;
end
train_err=sum(sign(tr_output)~=y_tr)/n;
test_err=sum(sign(te_output)~=y_te)/m;


