clear all
close all
clc
%%
files_path_in = {'../Train_files/'}
files_path_out = {'../Train_inputs/'}
%%

for i = 1:numel(files_path_in)
    files = dir([files_path_in{i},'*.avi'])
    for j = 1:numel(files)
        j
        [pathstr, name, ext] = fileparts(files(j).name);
        if ~exist(strcat(files_path_out{i},name,'.mat'), 'file')
            video_file = [files_path_in{i}, name, '.avi'];
            eye_position_file = [files_path_in{i}, name, '.txt'];
            vid = VideoReader(video_file);
            face_detector = vision.CascadeObjectDetector;
            face_detector.MinSize = [400 400];
            %face_detector.MaxSize = [800 800];
            iframe = 0;
            bbox = zeros(vid.FrameRate*vid.Duration, 4);

            while hasFrame(vid)
                iframe = iframe + 1;
                frame = readFrame(vid);
                temp = face_detector.step(frame);
                if isempty(temp)
                    bbox(iframe,:) = [0 0 0 0];
                else
                    bbox(iframe,:) = face_detector.step(frame);
                end
               % 
            end
            save(strcat(files_path_out{i},name),'bbox');
        end
    end
end