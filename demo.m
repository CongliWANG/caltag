clc;clear;close all;

I = cell(2,1);
for i=1:2
    I{i} = imread(['./test/test' '1.png']);
end

% estimate 
[wPt,iPt] = cellfun(@(I) caltag(I, './GeneratePattern/output.mat', false),I,'un',0);
wPt = wPt{1};
iPt = cat(3, iPt{:});

% estimate camera parameters
imageSize = [size(I{1},1) size(I{1},2)];
[params, ~, estimationErrors] = estimateCameraParameters(iPt, wPt, 'ImageSize', imageSize);

% show results
figure; showExtrinsics(params, 'CameraCentric');
figure; showExtrinsics(params, 'PatternCentric');
figure; showReprojectionErrors(params);
displayErrors(estimationErrors, params);
