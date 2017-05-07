function [result,label]=kkmeans(learn,k,acc)      %learn为待分类数组
    sample=size(learn,2);%样本数
    ini=randperm(sample);
    center=[];
    for i=1:k                %初始选取k个类中心
        center(:,i)=learn(:,ini(i));
    end
    meanlast=0;
    while 1==1
        %分类
        for i=1:sample
            dis=[];
            for j=1:k
               dis=[dis,norm(learn(:,i)-center(:,j))];
            end
            [~,label(i)]=min(dis);
        end
        oldcenter=center;
        %重新找类中心
        dis_center=[];
        for j=1:k
            new=find(label==j);
            center(:,j)=mean(learn(:,new),2);
            dis_center=[dis_center,norm(center(:,j)-oldcenter(:,j))];
        end
        mean(dis_center)
        if(abs(meanlast-mean(dis_center))<acc)
            break;
        end
        meanlast=mean(dis_center);
        
    end
    result=center;
end
