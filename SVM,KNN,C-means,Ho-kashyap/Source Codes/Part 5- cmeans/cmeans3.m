function [train_dataset] = cmeans3 (clusters)
  clear all;
  clusters=3;
  train_data=fopen('train_case_1.dat');
  train_dataset = cell2mat(textscan(train_data, '%f %f %f %f'));
  fclose(train_data);
  
 
  for i=1:clusters
    index(i) = rand();
  end
  index = mod(int16(index * 1000),10000)
  i = 1;
  
  prior_mean(1,:) = train_dataset(index(1));
  prior_mean(2,:) = train_dataset(index(2));
  prior_mean(3,:) = train_dataset(index(3));
  cluster1 = 1;
  cluster2 = 2;
  cluster3 = 3;
  
  err = 100;
  while (abs(err) > 0.000001)
    %clear('cluster1', 'cluster2', 'cluster3');
    cluster1 = [];
    cluster2 = [];
    cluster3 = [];
    i1 = 1;
    i2 = 1;
    i3 = 1;
    for i=1:15000
    % Euclidean distance
      for j=1:clusters
        v=train_dataset(i,:)- prior_mean(j,:);
        
        %dist(j) = sum(abs(v)); %manhattan distance 
        dist(j) = norm(v,2); % Euclidean distance 
        
      end
      [g, min_index] = min(dist);
        min_index;
      if (min_index == 1)
        cluster1(i1,:) = train_dataset(i,:);
        i1 = i1 + 1;
      elseif (min_index == 2)
       cluster2(i2,:) = train_dataset(i,:);
       i2 = i2 + 1;
      elseif (min_index == 3)
       cluster3(i3,:) = train_dataset(i,:);
       i3 = i3 + 1;
      end
    end
    err = sum (abs(prior_mean(1,:) - mean(cluster1) + prior_mean(2,:) - mean(cluster2) + prior_mean(3,:) - mean(cluster3) ))
    prior_mean= [mean(cluster1);mean(cluster2);mean(cluster3)]
    i1
    i2
    i3
  end
end