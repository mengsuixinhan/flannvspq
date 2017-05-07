function result=rc(dataset,center,label) 
    %该函数计算余量
    result=[];
    for i =1:size(dataset,2)
        which=label(i);
        result(:,i)=dataset(:,i)-center(:,which);
    end
end
