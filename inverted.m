function result=inverted(center_qc,label_qc,center_rc,label_rc)
    %qc_center为粗糙量化的类中心，center_rc,label_rc为余量rc分组量化的结果,后两个是元胞数组
    result={};
    num_of_center_qc=size(center_qc,2);
    num_of_center_rc=size(center_rc,2);
    for i=1:num_of_center_qc
        data=find(label_qc==i);%找出该类所有点的坐标,样本号
        for j=1:size(data,2)
            result{i}(j,1)=data(j); %记录下样本号
            for k=1:num_of_center_rc  %遍历所有分组
               result{i}(j,k+1)=label_rc{k}(data(j));
            end
        end
    end
end
