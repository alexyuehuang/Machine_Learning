function [ test_error ] = find_test_error( w, X, y )
% find_test_error: compute the test error of a linear classifier w. The
%  hypothesis is assumed to be of the form sign([1 x(n,:)] * w)
%  Inputs:
%		w: weight vector
%       X: data matrix (without an initial column of 1s)
%       y: data labels (plus or minus 1)
%     
%  Outputs:
%        test_error: binary classification error of w on the data set (X, y)
%        this should be between 0 and 1. 
test_error=0;
k =size(y);
for i=1:k(1,1)
    num = exp((-1)*y(i,1)*((w)*(X(i, :).')));
    num = num+1;
    num = log(num);
    test_error=test_error+num;
end
test_error=test_error/k(1,1);
end
