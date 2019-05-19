clc;

% Assessing classification results from takehome 1

% CASE 1:  Equal apriori probabilities for 3 classes
file1=fopen('takehome1_case_1.txt');
result1=cell2mat(textscan(file1,'%f'));
fclose(file1);

% Check if test set pattern is : 2-3-1-3-1-2 in case 1 predicted output
truePrediction1=0;
c=1;
while (c <=15000)
    if result1(c)==2
        truePrediction1=truePrediction1+1;
    end
    c=c+1;
    if result1(c)==3
        truePrediction1=truePrediction1+1;
    end
    c=c+1;
    if result1(c)==1
        truePrediction1=truePrediction1+1;
    end
    c=c+1;
    if result1(c)==3
        truePrediction1=truePrediction1+1;
    end
    c=c+1;
    if result1(c)==1
        truePrediction1=truePrediction1+1;
    end
    c=c+1;
    if result1(c)==2
        truePrediction1=truePrediction1+1;
    end
    c=c+1;
end    
    
groundTruth1=zeros(15000,1);
j=1;

% Ground truth for case 1 : 2-3-1-3-1-2
while(j<=15000)
    groundTruth1(j)=2;
    j=j+1;
    groundTruth1(j)=3;
    j=j+1;
    groundTruth1(j)=1;
    j=j+1;
    groundTruth1(j)=3;
    j=j+1;
    groundTruth1(j)=1;
    j=j+1;
    groundTruth1(j)=2;
    j=j+1;
end

% Confusion Matrix for case 1
confMatrix1= confusionmat(groundTruth1, result1);
% Calculate accuracy and probability of error
fprintf('Correctly classified in case 1 :%d\n', truePrediction1);
accuracy1=(truePrediction1/15000)*100;
fprintf('Accuracy for case 1: %f\n', accuracy1);
fprintf('Probability of error for case 1: %f\n', 100-accuracy1);
fprintf('Confusion matrix for case 1 is: \n');
disp(confMatrix1);



% CASE 2:  Unequal apriori probabilities for 3 classes
file2=fopen('takehome1_case_2.txt');
result2=cell2mat(textscan(file2,'%f'));
fclose(file2);

% Check if test set pattern is : 2-3-1-1-1-2 in case 2 predicted output
truePrediction2=0;
c=1;
while (c <=15000)
    if result2(c)==2
        truePrediction2=truePrediction2+1;
    end
    c=c+1;
    if result2(c)==3
        truePrediction2=truePrediction2+1;
    end
    c=c+1;
    if result2(c)==1
        truePrediction2=truePrediction2+1;
    end
    c=c+1;
    if result2(c)==1
        truePrediction2=truePrediction2+1;
    end
    c=c+1;
    if result2(c)==1
        truePrediction2=truePrediction2+1;
    end
    c=c+1;
    if result2(c)==2
        truePrediction2=truePrediction2+1;
    end
    c=c+1;
end    
    
groundTruth2=zeros(15000,1);
j=1;

% Ground truth for case 2 : 2-3-1-1-1-2
while(j<=15000)
    groundTruth2(j)=2;
    j=j+1;
    groundTruth2(j)=3;
    j=j+1;
    groundTruth2(j)=1;
    j=j+1;
    groundTruth2(j)=1;
    j=j+1;
    groundTruth2(j)=1;
    j=j+1;
    groundTruth2(j)=2;
    j=j+1;
end

% Confusion Matrix for Case 2
confMatrix2= confusionmat(groundTruth2, result2);

% Calculate accuracy and probability of error
fprintf('Correctly classified in case 2 :%d\n', truePrediction2);
accuracy2=(truePrediction2/15000)*100;
fprintf('Accuracy for case 2: %f\n', accuracy2);
fprintf('Probability of error for case 2: %f\n', 100-accuracy2);
fprintf('Confusion matrix for case 2 is: \n');
disp(confMatrix2);
