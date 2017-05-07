function [center,label]=pq(dataset,m)            %m为划分的组数
    %将数据分组用kmeans求中心
    %划分数据
    kk=64;
    result=[];
    dists=[];
    dimension=size(dataset,1); %维数
    sample=size(dataset,2);
    each_dim=floor(dimension/m);
    center={};
    label={};
    for i=1:m
        learn=[];
        learn=dataset((i-1)*each_dim+1:min(dimension,i*each_dim),:);
        [center{i},label{i}]=kkmeans(learn,kk,1);    
        %记录下来中心点数据以及learn数据分别属于类别，
        %当输入一个test样本时，先根据中心点分类，然后记录下该类的所有样本
    end
%     sample_test=size(testset,2);
%     label_test={};
%     for i=1:sample_test %所有样本
%         label_test{i}=[];
%         for j=1:m       %所有分组
%             dis=[];
%             for k=1:kk   %一个分组里面的所有类别
%                 dis=[dis,norm(testset((j-1)*each_dim+1:min(dimension,j*each_dim),i)'-center{j}(:,k))];
%             end
%             [~,which]=min(dis);
%             label_test{i}=[label_test{i},find(label{j}==which)];  %记录下所有相近的类别中的样本号
%         end
%         A=unique(label_test{i},'stable');  %去除所有重复的部分
%         A
%         dis_t=[];
%         for t=1:size(A,2) %所有相近的样本
%             dis_t=[dis_t,norm(testset(:,i)-dataset(:,A(t)))];
%         end
%         [mindis_t,which_t]=min(dis_t);
%         result=[result,A(which_t)];
%         dists=[dists,mindis_t];
%     end
end
