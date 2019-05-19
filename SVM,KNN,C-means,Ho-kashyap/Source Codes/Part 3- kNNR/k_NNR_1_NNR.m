clc;
clear all;

% Read training and testing data
train_data=fopen('train_case_1.dat');
training_set = cell2mat(textscan(train_data, '%f %f %f %f'));
fclose(train_data);

test_data=fopen('test_case_1.dat');
test_set = cell2mat(textscan(test_data, '%f %f %f %f'));
fclose(test_data);

% Filter test_case_1 data & Remove class 3 samples from test file
i=2;
 while (i<=15000)
     test_set(i,:)=0;
     i=i+6;
 end 
 j=4;
 while (j<=15000)
     test_set(j,:)=0;
     j=j+6;
 end
k=1;
while (k<=10000)
    if test_set(k,:)==0
        test_set(k,:)=[];
    end
    k=k+1;
end

% run knn for 1 neighbor ( k = 1)
training_set=training_set(1:10000,:);
s1 = knn_calculation(training_set, test_set, 1);

part3_data1=fopen('knn-result_1_NNR.txt');
part3_set1 = cell2mat(textscan(part3_data1, '%d'));
fclose(part3_data1);

truePred1=0;
c1=1;
%q=5001;
while (c1 <=10000)
    if part3_set1(c1)==2
        truePred1=truePred1+1;
    end
    c1=c1+1;
    if part3_set1(c1)==1
        truePred1=truePred1+1;
    end
    c1=c1+1;
    if part3_set1(c1)==1
        truePred1=truePred1+1;
    end
    c1=c1+1;
    if part3_set1(c1)==2
        truePred1=truePred1+1;
    end
    c1=c1+1;
     
end

gt3 = ones(10000,1);
i=1;
while (i<=10000)
    gt3(i,:)=2;
    i=i+1;
    gt3(i,:)=1;
    i=i+1;
    gt3(i,:)=1;
    i=i+1;
    gt3(i,:)=2;
    i=i+1;
end

conf1=confusionmat(gt3,double(part3_set1));
disp(conf1);
fprintf('Correctly classified in 1 NNR :%d\n', truePred1);
accuracy1=(truePred1/10000)*100;
fprintf('Accuracy for 1 NNR: %f\n', accuracy1);
fprintf('Probability of error for 1 NNR: %f\n', 100-accuracy1);

function [op1] = knn_calculation(training, testing, n)

    gTruth = zeros(10000, 1);
    gTruth(1:5000) = 1;
    gTruth(5001:10000) = 2;
   
    % open files for writing to
    file1 = fopen('knn-result_1_NNR.txt', 'w+');

    for i = 1:10000
        dist1 = zeros(10000, 1);
        
        q1 = 0; 
        q2 = 0;
         
        for j = 1:10000
            dist1(j) = norm(testing(i,:)-training(j,:)); % Eucliden distance
        end
        distances_computed = horzcat(dist1, gTruth);
        op1 = sortrows(distances_computed, 1);
        
        if n == 1
            fprintf(file1, '%d\n', op1(1,2)); %writing outputs to file 
        end
    end
    fclose(file1);
end
    