function [svm_model] = svm_code_rbf()
  % Reading training data
  testing_data=fopen('train_case_1.dat');
  train_dataset = cell2mat(textscan(testing_data, '%f %f %f %f'));
  fclose(testing_data);
  
  % Inverting dataset and considering only 10000 vectors
  train_dataset = train_dataset';
  train_dataset = train_dataset(:,1:10000);
  
  % Labeling the dataset with +1 and -1
  label_vector_train = [ones(1, 5000) -ones(1, 5000)];
  label_vector_train = label_vector_train';
  features = train_dataset(:,1:10000);
  features = features';
  sparse_feat = sparse(features); % Instance matrix for training data
  libsvmwrite('results_libsvm.train', label_vector_train, sparse_feat);
  %fprintf('Done\n');
  
  labels_svm(1, 1);
  %Read the data in svm format
  [label_vector_train, inst] = libsvmread('results_libsvm.train');
  [label2, inst2] = libsvmread('results_libsvm.test');
  
  %model = svmtrain(label, inst, '-t 0 -b 1 -h 0'); % Linear Model 72.26% accuracy 
  svm_model = svmtrain(label_vector_train, inst, '-c 30 -g 0.009 -b 1'); % RBF Model 89% accuracy
  
  svm_model
  [predict_label, accuracy, prob_estimates] = svmpredict(label2, inst2, svm_model, '-b 1');

  w = svm_model.sv_coef' * full (svm_model.SVs)
  bias = -svm_model.rho
 
end
  
function [label] = labels_svm(~, ~)

  % Read testing data
  testing_data=fopen('test_case_1.dat');
  test_dataset = cell2mat(textscan(testing_data, '%f %f %f %f'));
  fclose(testing_data);
  
  j = 1;
  
  %Assigning +1 and -1 to the vectors corresponding to class 1 & 2 in test dataset
  for i=1:15000
      if (mod (i, 6) == 3) || (mod (i, 6) == 5)
          label(j)=1;
          dataset2(j, :) = test_dataset(i, :);
          i=i+1;
          j = j + 1;
      elseif ((mod (i, 6)) == 1)
          label(j)=-1;
          dataset2(j, :) = test_dataset(i, :);
          i = i + 1;
          j = j + 1;
      elseif (mod (i, 6) == 0)
          label (j)=-1;
          dataset2(j, :) = test_dataset(i, :);
          i = i + 1;
          j = j + 1;
      end
  end
  label = label';
  feat_sparse = sparse(dataset2); % Instance matrix for testing data
  
  libsvmwrite('results_libsvm.test', label, feat_sparse);
end