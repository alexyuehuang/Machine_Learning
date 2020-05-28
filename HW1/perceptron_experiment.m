function [ num_iters, bounds] = perceptron_experiment ( N, d, num_samples )
%perceptron_experiment Code for running the perceptron experiment in HW1
%   Inputs: N is the number of training examples
%           d is the dimensionality of each example (before adding the 1)
%           num_samples is the number of times to repeat the experiment
%   Outputs: num_iters is the # of iterations PLA takes for each sample
%            bounds is the theoretical bound on the # of iterations
%              for each sample
%      (both the outputs should be num_samples long)
star = zeros(1,d+1);
num_iters=zeros(1,num_samples);
bounds=zeros(1,num_samples);
plot2=zeros(1,num_samples);
for nm=1:num_samples
rBig=0;
rho=intmax;
for e=2:d+1
    star(1,e) = rand;
end
bigX = zeros(N, d+2);
for b=1:N
    xn = zeros(1,d+2);
    for k = 2:(d+1)
        randv = -1+2*rand;
        xn(1,k)=randv;
    end
    y= sign(xn(1:d+1)*(star.'));
    if norm(xn(1:d+1))>rBig
        rBig = norm(xn(1:d+1));
    end
    if abs(xn(1:d+1)*(star.'))<rho
        rho=abs(xn(1:d+1)*(star.'));
    end
    xn(1,d+2) = y;
    bigX(b,:)=xn;
end
[~,iteration]=perceptron_learn(bigX);
num_iters(1,nm)=iteration;
bounds(1,nm)=log((rBig*norm(star)/rho)^2);
plot2(1,nm)=(log((rBig*norm(star)/rho)^2-iteration));

end
figure(1);
histogram(num_iters);
title('histogram on PLA learning iterations')
ylabel('times') 
xlabel('PLA iterations') 
figure(2);
histogram(plot2);
title('histogram comparing iterations PLA took with theoretical bound')
ylabel('times') 
xlabel('bound-iterations, in log scale') 
end
