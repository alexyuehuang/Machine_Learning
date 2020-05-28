function [ w, e_in ] = logistic_reg( X, y, w_init, max_its, eta, lambda )
%LOGISTIC_REG Learn logistic regression model using gradient descent
%   Inputs:
%       X : data matrix (without an initial column of 1s)
%       y : data labels (plus or minus 1)
%       w_init: initial value of the w vector (d+1 dimensional)
%       max_its: maximum number of iterations to run for
%       eta: learning rate
    
%   Outputs:
%       w : weight vector
%       e_in : in-sample error (the cross-entropy error as defined in LFD)
ites = 0;
tic;
k1 = size(y);
k2=size(X);
k3=ones(k2(1,1),1);
X=[k3, X];
k2=size(X);
d = k2(1,2);
N = k1(1,1);
w=w_init;
while true
    ites=ites+1;
    nabla=zeros(1,d);
    for i=1:N
        up = y(i,1)*X(i, :);
        down = 1+exp(y(i,1)*((w)*(X(i, :).')));
        up = (-1)*up./down;
        up=up./N;
        nabla = nabla+up;
    end
    absN = norm(nabla);
    eta_t = eta.*absN;
    v_t= (-1)*nabla./absN;
    w=w*(1-2*eta*lambda)+eta_t*v_t;
%     sign = w;
%     for i=1:14
%         if w(1,i)>0
%         sign(1, i)=1;
%         end
%         if w(1,i)<0
%         sign(1, i)=-1;
%         end
%         if w(1,i)==0
%         sign(1, i)=0;
%         end
%     end
%     wprime = w+eta_t*v_t;
%     for i=1:14
%         if (wprime(1,i)-eta*lambda*sign(1,i))*w(1,i)>=0
%             w(1,i)=wprime(1,i)-eta*lambda*sign(1,i);
%         else
%             w(1,i)=0;
%         end
%     end
    ifSmaller = abs(nabla)>= 0.000001;
    if ites>=max_its
        display(ites);
        break;
    end
    if sum(ifSmaller)==0
        display(ites);
        break;
    end
    
end
e_in=find_test_error(w, X, y);
toc;
end

% 
% train = readtable('clevelandtrain.csv', 'HeaderLines',1);
% test = readtable('clevelandtest.csv', 'HeaderLines',1);
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