clc
clear

load subnetsgenesall_PI3K
load subnetall_P13K


COADsubnet1genes=subnetsgenesall;

COADsubnet1=subnetall;


BLCAcancergold=COADsubnet1;
BLCA_gene_ID=COADsubnet1genes;
for i=1:size(BLCAcancergold,1)
    for j=1:size(BLCAcancergold,2)
        for k=1:size(BLCA_gene_ID,1)
            if BLCAcancergold(i,j)==BLCA_gene_ID(k)
                BLCAcancergold_num(i,j)=k;
            end
        end
    end
end
BLCAcancergold_num(:,3)=ones(length(BLCAcancergold),1)
gene=BLCAcancergold_num;
load data
load gene
%%ԭʼ����

node=size(data,2);
sample_num=size(data,1);
figure
s=[];
t=[];
m=1;
DAG=zeros(node);
GGG=zeros(size(data,2));
edge_num=0;
for i=1:length(gene)
    if gene(i,3)~=0
        s(m)=gene(i,1);
        t(m)=gene(i,2);
        m=m+1;
        GGG(gene(i,1),gene(i,2))=1;
        edge_num=edge_num+1;
    end
end
GP=digraph(s,t);
plot(GP)
[data, mu2, sigma3]= standardizeCols(data);
% a=1:75;
% c=randperm(numel(a));
% b=a(c(1:30));
THCAsumcase=data;


THCAsumcase_target=THCAsumcase(1:75,:);
%    THCAsumcase_target=THCAsumcase(76:240,:);
%   THCAsumcase_target=THCAsumcase(241:271,:);
%    THCAsumcase_target=THCAsumcase(272:379,:);
%    THCAsumcase_target=THCAsumcase(380:443,:);

data=THCAsumcase_target;
G=zeros(node,node);
dagvalue=zeros(node,node);
sample_num=size(data,1);

data1=data';
for i=1:node
    for j=i+1:node
        kk=data1(i,:);
        hh=data1(j,:);
        pcc=corr(kk',hh');
        MI=-1/2*log(1-pcc^2);
        dagvalue(i,j)=MI;
        MI_ALL(i,j)=MI;
    end
end

[B,IX] = sort(MI_ALL(:),'descend');
aab=B(round(node*(node-1)/2*0.80));
aab=0.01;
G=zeros(node,node);
for i=1:node
    for j=i+1:node
        qq= MI_ALL(i,j);
        if qq>=aab
            G(i,j)=1;
            %G(j,i)=1;
        end
    end
end
result_DAG_PCB=zeros(node,node);



data2=data;
DD=G(:,:);
%DD=G(:,:)+G(:,:)';
nSamples = sample_num;    % the number of samples
nEvals = 20000;       % the maximum number of family evaluations
discrete = 0;         % set to 0 for continuous data
interv = 0;           % set to 0 for observational data
rand('state',0);        % generate data randomly
randn('state',0);
clamped=zeros(sample_num,node); %generate data
penalty = log(nSamples)/2;  % weight of free parameter term
penalty =1;  
[nSamples,numOfVar]=size(data2); % get the size of the data
DAG_PCB=zeros(numOfVar); % used to record the final network
result_DAG_PCB(:,:)= DAGSearch_test(data2,nEvals,0,penalty,discrete,clamped,DD);

sum(sum(result_DAG_PCB))

figure
s1=[];
t1=[];
N=node;
m=1;
DAG2=result_DAG_PCB(:,:);
DAG3=DAG2;
for i=1:N
    for j=1:N
        if DAG3(i,j)~=0
            s1(m)=i;
            t1(m)=j;
            m=m+1;
        end
    end
end
GP2=digraph(s1,t1);
plot(GP2)
point_num=N;
TP=0;
FP=0;
TN=0;
FN=0;
aaa=0;
bbb=0;
for i=1:point_num
    for j=1:point_num
        if GGG(i,j)==1 && DAG3(i,j)==1
            TP=TP+1;
        elseif GGG(i,j)==0 && DAG3(i,j)==1
            FP=FP+1;
        elseif GGG(i,j)==1 && DAG3(i,j)==-1
            aaa=aaa+1;
        elseif GGG(i,j)==-1 && DAG3(i,j)==1
            bbb=bbb+1;
        end
    end
end
    
fanxiang=aaa+bbb
TP
FN=sum(sum(GGG))-TP
FP
TN=point_num*(point_num-1)-sum(sum(GGG))-FP
Precision = TP/(TP+FP)
TPR = TP/(TP+FN)
FPR = FP/(FP+TN)
Specificity= TN/(FP+TN)
%= 1 - FPR 
Accuracy =(TP+TN)/(TP+TN+FP+FN)
error= (FP+FN)/(TP+TN+FP+FN)

P_XY_Z=TP/(TP+FN);
P_Z=(TP+FN)/(TP+TN+FP+FN);
P_XY=(TP+FP)/(TP+TN+FP+FN);
posterior_probability=(P_XY_Z*P_Z)/P_XY



numberTC=sum(DAG3(:)~=GGG(:))    
edge_num
AAAA(1)=TP;
AAAA(2)=FN ;
AAAA(3)=FP ;
AAAA(4)=TN ;
AAAA(5)=Precision ;
AAAA(6)=TPR ;
AAAA(7)=FPR ;
AAAA(8)=Specificity ;
AAAA(9)=Accuracy ;
AAAA(10)=error ;
AAAA(11)=posterior_probability;
sum(sum(result_DAG_PCB))