%% HMDGazeData
%
% Provides data for the HMD Gaze.
%
%   hmd_ gaze_data = HMDGazeData(device_time_stamp,...
%                system_time_stamp,...
%                left_gaze_direction_unit_vector,...
%                left_gaze_direction_validity,...
%                left_gaze_origin_position_in_hmd_coordinates, ...
%                left_gaze_origin_validity, ...
%                left_pupil_diameter, ...
%                left_pupil_validity, ...
%                left_pupil_position_position_in_tracking_area, ...
%                left_pupil_position_validity,...
%                right_gaze_direction_unit_vector,...
%                right_gaze_direction_validity,...
%                right_gaze_origin_position_in_hmd_coordinates, ...
%                right_gaze_origin_validity, ...
%                right_pupil_diameter, ...
%                right_pupil_validity, ...
%                right_pupil_position_position_in_tracking_area, ...
%                right_pupil_position_validity)
%
%%
classdef HMDGazeData 
    properties (SetAccess = protected)
        %% LeftEye
        % Gets the gaze data (<../Gaze/HMDEyeData.html EyeData>) for the left eye.
        %
        %   hmd_gaze_data.LeftEye
        %
        LeftEye
        %% RightEye
        % Gets the gaze data (<../Gaze/HMDEyeData.html EyeData>) for the right eye.
        %
        %   hmd_gaze_data.RightEye
        %
        RightEye
        %% DeviceTimeStamp
        % Gets the time stamp according to the eye trackers internal clock.
        %
        %   hmd_gaze_data.DeviceTimeStamp
        %
        DeviceTimeStamp
        %% SystemTimeStamp
        % Gets the time stamp according to the computers internal clock.
        %
        %   hmd_gaze_data.SystemTimeStamp
        %
        SystemTimeStamp
    end
    
    methods
        function hmd_gaze_data = HMDGazeData(device_time_stamp,...
                system_time_stamp,...
                left_gaze_direction_unit_vector,...
                left_gaze_direction_validity,...
                left_gaze_origin_position_in_hmd_coordinates, ...
                left_gaze_origin_validity, ...
                left_pupil_diameter, ...
                left_pupil_validity, ...
                left_pupil_position_position_in_tracking_area, ...
                left_pupil_position_validity,...
                right_gaze_direction_unit_vector,...
                right_gaze_direction_validity,...
                right_gaze_origin_position_in_hmd_coordinates, ...
                right_gaze_origin_validity, ...
                right_pupil_diameter, ...
                right_pupil_validity, ...
                right_pupil_position_position_in_tracking_area, ...
                right_pupil_position_validity)
            
            if nargin > 0
                hmd_gaze_data.DeviceTimeStamp = device_time_stamp;

                hmd_gaze_data.SystemTimeStamp = system_time_stamp;

                hmd_gaze_data.LeftEye = HMDEyeData(left_gaze_direction_unit_vector,...
                    left_gaze_direction_validity,...
                    left_gaze_origin_position_in_hmd_coordinates,...
                    left_gaze_origin_validity,...
                    left_pupil_diameter,...
                    left_pupil_validity,...
                    left_pupil_position_position_in_tracking_area,...
                    left_pupil_position_validity);

                hmd_gaze_data.RightEye = HMDEyeData(right_gaze_direction_unit_vector,...
                    right_gaze_direction_validity,...
                    right_gaze_origin_position_in_hmd_coordinates, ...
                    right_gaze_origin_validity, ...
                    right_pupil_diameter, ...
                    right_pupil_validity, ...
                    right_pupil_position_position_in_tracking_area, ...
                    right_pupil_position_validity);
            end
            
        end
    end
    
end

%% See Also
% <../Gaze/HMDEyeData.html HMDEyeData>

%% Version
% !version
%
% COPYRIGHT !year - PROPERTY OF TOBII AB
% Copyright !year TOBII AB - KARLSROVAGEN 2D, DANDERYD 182 53, SWEDEN - All Rights Reserved.
%
% Copyright NOTICE: All information contained herein is, and remains, the property of Tobii AB and its suppliers,
% if any. The intellectual and technical concepts contained herein are proprietary to Tobii AB and its suppliers and
% may be covered by U.S.and Foreign Patents, patent applications, and are protected by trade secret or copyright law.
% Dissemination of this information or reproduction of this material is strictly forbidden unless prior written
% permission is obtained from Tobii AB.
%