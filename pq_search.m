function [result,dists]=pq_search(testset,center_qc,center_rc,inverted_list)
    dim=size(testset,1);
    sample=size(testset,2);
    label=[];
    for i=1:sample
        dis=[];
        for k=1:size(center_qc,2)   %一个分组里面的所有类别
           dis=[dis,norm(testset(:,i)-center_qc(:,k))];
        end
        [~,which]=min(dis);
        label(i)=which;  %记录下每个x属于qc分类中的哪一类
    end
    rcx=rc(testset,center_qc,label);
    m=size(inverted_list{1,1},2)-1;   %组数
    each_dim=floor(dim/m);
    num_center_rc=size(center_rc{1},2); %每组类中心数，这里假设都是一样多的
    distance={};
    
    %计算d(uj(rx),cji)
    for i=1:sample
        x=rcx(:,i);%取出一个样本  计算rcx的每一部分到cji的距离
        for j=1:m
            uj=x((j-1)*each_dim+1:min(dim,j*each_dim));         %取出一个样本每组对应的维数
            for k=1:num_center_rc
                distance{i}(j,k)=norm(uj-center_rc{j}(:,k));    %记录下每一组和每个中心之间的距离，一行为一组
            end
        end
    end
    
    for i=1:sample        %对于每一个样本
        for j=1:size(inverted_list,2)   %对于所有的索引向量
            dis_each_k=[];
            for k=1:size(inverted_list{j},1)    %对于一个qcy下的所有数据向量
                sum=0;
                for t=1:m              %对于所有的组
                    sum=sum+distance{i}(t,inverted_list{j}(k,t+1));
                end
            dis_each_k=[dis_each_k,sum];    
            end
            [mindis(j),which_k]=min(dis_each_k);
            minwhich(j)=inverted_list{j}(which_k,1);
        
        end
        [dists_i,which_i]=min(mindis);
        dists(i)=dists_i;
        result(i)=minwhich(which_i);
        %fprintf('%d',i);
    end
    












end
