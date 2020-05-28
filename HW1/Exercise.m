v1 = zeros(1,1000);
v2 = zeros(1,1000);
v3 = zeros(1,1000);
for b = 1:100000
myM = randi(2,1000,10);
vec = sum(myM, 2);
vec = vec./10-1;
v1(b) = vec(1);
end
figure(1)
h1= histogram(v1,'Normalization','probability');
title('histogram on the distributions of v1')
ylabel('probability value') 
xlabel('v1 value') 

for b = 1:100000
myM = randi(2,1000,10);
vec = sum(myM, 2);
vec = vec./10-1;
v2(b) = vec(randi([1,1000],1));
end
figure(2)
h2= histogram(v2,'Normalization','probability');
title('histogram on the distributions of vrand')
ylabel('probability value') 
xlabel('vrand value') 
for b = 1:100000
myM = randi(2,1000,10);
vec = sum(myM, 2);
vec = vec./10-1;
v3(b) = min(vec);
end
figure(3)
h3= histogram(v3,'Normalization','probability');
title('histogram on the distributions of vmin')
ylabel('probability value') 
xlabel('vmin value') 
x = 0:0.001:1;
z= (-20)*(x.*x);
y = 2*exp(z);
y1 = zeros(1,1001);
y2 = zeros(1,1001);
y3 = zeros(1,1001);
index= 1;
for z = x
    y1(index) = sum(v1<(0.5-z))+sum(v1>(0.5+z));
    y2(index) = sum(v2<(0.5-z))+sum(v2>(0.5+z));
    y3(index) = sum(v3<(0.5-z))+sum(v3>(0.5+z));
    index = index+1;
end
y1=y1/100000;
y2=y2/100000;
y3=y3/100000;
figure(4)
plot(x, y1)
hold on
plot(x, y2)
plot(x, y3)
plot(x,y)
hold off
grid
title('Hoeffding bound vs experimental data')
ylabel('probability value') 
xlabel('epsilon value') 
legend({'line for v1','line for vrand', 'line for vmin', 'Hoeffding'},'Location','northeast')




