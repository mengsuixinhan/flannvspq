function [results_pq,dists_pq,results_flann,dists_flann]=main()

clear;
path_sift_base='./sift/sift_base.fvecs';
path_sift_learn='./sift/sift_learn.fvecs';
path_sift_query='./sift/sift_query.fvecs';
v_sift_base=fvecs_read(path_sift_base);
v_sift_learn=fvecs_read(path_sift_learn);
v_sift_query=fvecs_read(path_sift_query);
params.algorithm = 'kdtree';
params.trees = 8;
params.checks = 64;
[results_flann,dists_flann]=flann_search(v_sift_learn,v_sift_query,5,params);
fprintf('next');
dataset=v_sift_learn;
testset=v_sift_query;

[center_qc,label_qc]=kkmeans(dataset,256,11);  %粗分类为256类
rcy=rc(dataset,center_qc,label_qc);             %求余量
[center_rc,label_rc]=pq(rcy,8);                 %对于余量进行乘积量化,分成8组
inverted_list=inverted(center_qc,label_qc,center_rc,label_rc);  %建立倒排索引表
fprintf('next');
[results_pq,dists_pq]=pq_search(testset,center_qc,center_rc,inverted_list); %进行搜索
end
