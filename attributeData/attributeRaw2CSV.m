% Yijie Wang (yijiewang@gatech.edu)

%% Loads raw data

load rawData/attributeLabels_continuous.mat
load rawData/attributes.mat
load rawData/images.mat

%% Makes attributes binary

threshold = 0.5;
labels_cv = (labels_cv > threshold);

%% Process image names

for i = 1:numel(images)
    slashPos = strfind(images{i}, '/');
    imageName = images{i}(slashPos(numel(slashPos))+1:numel(images{i}));
    dotPos = strfind(imageName, '.');
    imageHash = imageName(1:dotPos(1)-1);
    images{i} = imageHash;
end

%% Process headers

headers = cell(numel(attributes) + 1, 1);
headers{1} = 'image_hash';
headers(2:numel(attributes) + 1) = attributes;

%% Stores the data into csv format

outputFileName = 'attributeData.csv';
fid = fopen(outputFileName, 'w');
for i = 1:numel(headers)
    if i ~= numel(headers)
        fprintf(fid, '%s,', headers{i});
    else
        fprintf(fid, '%s\n', headers{i});
    end
end
for i = 1:numel(images)
    fprintf(fid, '%s', images{i});
    for j=1:numel(attributes)
        fprintf(fid, ',%d', labels_cv(i, j));
    end
    fprintf(fid, '\n');
end
fclose(fid);
