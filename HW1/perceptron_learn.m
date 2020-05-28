function [ w, iterations ] = perceptron_learn( data_in )
%perceptron_learn Run PLA on the input data
%   Io[[nputs: data_in: Assumed to be a matrix with each row representing an
%                    (x,y) pair, with the x vector augmented with an
%                    initial 1, and the label (y) in the last column
%   Outputs: w: A weight vector (should linearly separate the data if it is
%               linearly separable)
%            iterations: The number of iterations the algorithm ran for
iterations=0;
[l,r]=size(data_in);
r=r-2;
w=zeros(1,r+1);
xn=find_example(data_in, w,l,r);
while size(xn)~=([0.0])
    iterations = iterations+1;
    w=w+xn(1,r+2)*(xn(1:r+1));
    xn=find_example(data_in, w,l,r);
end
end

function result = find_example(data_in, w,N,d)
for i=1:N
    xn = data_in(i, :);
    yn=xn(1,d+2);
    if sign((xn(1:d+1)*(w.'))) ~=yn
        result = xn;
        return
    end
end
result=[];
end