a=rand(1,10000);
a=a*2-1;
b=rand(1,10000);
b=b*2-1;
xbar=0;
ybar=0;
for i =1:10000
    pt1= a(1,i);
    pt2=b(1,i);
    x=pt1+pt2;
    y=(-1)*pt1*pt2;
    xbar=xbar+x;
    ybar=ybar+y;
end
ybar =ybar/10000;
xbar=xbar/10000;
% x=-1:0.001:1;
% y1=x.^2;
% y2=xbar*x+ybar;
% figure(1);
% plot(x,y1,x,y2);
% title('plot of g average vs f')
% ylabel('y') 
% xlabel('x') 
% legend({'x^2','g average'},'Location','southwest')
eout =0;
bias =0;
var =0;
for i=1:10000
    newa = rand(1)*2-1;
    newb = rand(1)*2-1;
    cala = newa+newb;
    calb = (-1)*newa*newb;
    myeout = 0;
    myvar =0;
    mybias =0;
    for j=-1:0.001:1
        myeout=myeout+(j^2-cala*j-calb)^2;
        mybias=mybias+(j^2-xbar*j-ybar)^2;
        myvar=myvar+(xbar*j+ybar-cala*j-calb)^2;
    end
    eout=eout+myeout/2001;
    bias=bias+mybias/2001;
    var = var+myvar/2001;
end
eout =eout/10000;
var=var/10000;
bias=bias/10000;
eout
var 
bias

