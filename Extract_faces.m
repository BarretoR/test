function Faces = Extract_faces(file_vid, file_eye_pos)
    
    fileID = fopen(file_eye_pos);
    eye_pos = textscan(fileID, '%d %d %d %d %d', 'Delimiter', ',');
    vid = VideoReader(file_vid);
    face_detector = vision.CascadeObjectDetector;
    face_detector.ScaleFactor = 1.01;
    face_detector.MergeThreshold = 10;
    iframe = 0;
    Faces.flag = 0;
    
    while hasFrame(vid)
        iframe = iframe + 1;
        frame = readFrame(vid);
        
        %Face Align
        if (eye_pos{2}(iframe) ~= 0 && eye_pos{3}(iframe) ~= 0 && eye_pos{4}(iframe) ~= 0 && eye_pos{5}(iframe) ~= 0)
            opposite = double(eye_pos{5}(iframe) - eye_pos{3}(iframe));
            adjacent = double(eye_pos{4}(iframe) - eye_pos{2}(iframe));
            angle_rotation = atand(opposite/adjacent);
            frame = imrotate(frame, angle_rotation);
        end
        
        if iframe == 1
            
            face_detector.MinSize = [400 400];
            %face_detector.MaxSize = [800 800];
            temp = face_detector.step(frame);
            
            if ~isempty(temp)
                
                face_detector.MinSize = [temp(1,3)-10 temp(1,4)-10];
                %face_detector.MaxSize = [temp(1,3)+10 temp(1,4)+10];
                
            end
        end
        
        temp = face_detector.step(frame)
        
        if(~isempty(temp))
            
            Faces.flag = Faces.flag + 1;
            
            frame = imresize(imcrop(frame, temp(1,:)), [100 100]);
            Faces.data{iframe} = frame;
            Faces.exist{iframe} = 1;
        else
            Faces.exist{iframe} = 0;
        end
    end
    
    fclose(fileID);

end