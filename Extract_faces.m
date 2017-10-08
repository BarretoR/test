function Faces = Extract_faces(file_vid, file_eye_pos)
    fileID = fopen(file_eye_pos);
    eye_pos = textscan(fileID, '%d %d %d %d %d', 'Delimiter', ',');
    vid = VideoReader(file_vid);
    face_detector = vision.CascadeObjectDetector;
    face_detector.MinSize = [450 450];
    iframe = 0;
    
    while hasFrame(vid)
        iframe = iframe + 1;
        frame = readFrame(vid);
        
        %Face Align
        opposite = double(eye_pos{5}(iframe) - eye_pos{3}(iframe));
        adjacent = double(eye_pos{4}(iframe) - eye_pos{2}(iframe));
        angle_rotation = atand(opposite/adjacent);
        frame = imrotate(frame, angle_rotation);
        
        temp = face_detector.step(frame);
        if(~isempty(temp))
            frame = imcrop(frame, temp);
            Faces.data{iframe} = frame;
            Faces.exist{iframe} = 1;
        end
        
    end
fclose(fileID);
end