warning off
global vtt_resumeFromInd_00 vtt_lastObj_00 vtt_vr2o_00
warning on
showLast = get(handles.showLastCB, 'Value');
I = PhysTrack.read2(vtt_vr2o_00, vtt_resumeFromInd_00, false, get(handles.forceRGBCB, 'Value'));
if islogical(I)
    I = uint8(I) * 255;
end
if showLast
    I = insertShape(I, 'Rectangle', vtt_lastObj_00, 'LineWidth', 2, 'Color', [255, 0, 0]);
end
strs = [];
if exist('vtt_obs_00')
    totalObs = size(vtt_obs_00, 1);
else
    totalObs = 0;
end
for ii = 1:totalObs
    rectDf = vtt_obs_00(ii, :);
    rectDf(1:2) = rectDf(1:2) - 2;
    rectDf(3:4) = rectDf(3:4) + 4;
    I = insertShape(I, 'Rectangle', rectDf, 'LineWidth', 2, 'Color', [0, 0, 0]);
    I = insertShape(I, 'Rectangle', [vtt_obs_00(ii, 1:2) - 1, vtt_obs_00(ii, 3:4) + 2], 'LineWidth', 2, 'Color', [170, 170, 170]);
    strs = [strs, ';', [num2str(ii), ': ', num2str(round(vtt_obs_00(ii, 1) + vtt_obs_00(ii, 3) / 2)),', ', num2str(round(vtt_obs_00(ii, 2) + vtt_obs_00(ii, 4) / 2))]];
end
if length(strs) > 0
    strs = strsplit(strs, ';');
    strs(strcmp('',strs)) = [];
    set(handles.obsList, 'String', strs);
end

axis(handles.mainAxis);
imshow(I);
drawnow;