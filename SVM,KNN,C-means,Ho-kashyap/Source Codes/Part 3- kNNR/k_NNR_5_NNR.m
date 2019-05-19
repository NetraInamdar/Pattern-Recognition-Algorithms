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

% run knn for 5 neighbors (K = 5)
training_set=training_set(1:10000,:);
s5 = knn_calculation(training_set, test_set, 5);

part3_data5=fopen('knn-result_5_NNR.txt');
part3_set5 = cell2mat(textscan(part3_data5, '%d'));
fclose(part3_data5);

truePred5=0;
c5=1;
%q=5001;
while (c5 <=10000)
    if part3_set5(c5)==2
        truePred5=truePred5+1;
    end
    c5=c5+1;
    if part3_set5(c5)==1
        truePred5=truePred5+1;
    end
    c5=c5+1;
    if part3_set5(c5)==1
        truePred5=truePred5+1;
    end
    c5=c5+1;
    if part3_set5(c5)==2
        truePred5=truePred5+1;
    end
    c5=c5+1;
     
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

conf5=confusionmat(gt3,double(part3_set5));
disp(conf5);
fprintf('Correctly classified in 5 NNR :%d\n', truePred5);
accuracy5=(truePred5/10000)*100;
fprintf('Accuracy for 3 NNR: %f\n', accuracy5);
fprintf('Probability of error for 5 NNR: %f\n', 100-accuracy5);

function [op5] = knn_calculation(training, testing, n)

    gTruth = zeros(10000, 1); %ground truths
    gTruth(1:5000) = 1;
    gTruth(5001:10000) = 2;
    
    % open files for writing to
    file5 = fopen('knn-result_5_NNR.txt', 'w+');

    for i = 1:10000
        dist3 = zeros(10000, 1);
        
        q1 = 0;
        q2 = 0;
         
        for j = 1:10000
            dist3(j) = norm(testing(i,:)-training(j,:)); % Eucliden distance
        end
        distances_computed = horzcat(dist3, gTruth);
        op5 = sortrows(distances_computed, 1);
        
        if n == 5
            for k = 1:5
                if op5(k,2) == 1
                    q1 = q1 + 1;
                elseif op5(k,2) == 2
                    q2 = q2 + 1;
                end
            end
            
            if q1 > q2 
                fprintf(file5, '%d\n', 1);
            elseif q2 > q1 
                fprintf(file5, '%d\n', 2);
            end            
        end      
    end
    fclose(file5);
end
