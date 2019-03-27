function CloseWindowsAndCleanup()
% Closes any windows opened by the Psychtoolbox Screen command, re-enables
% the keyboard, shows the cursor, and restores the video color lookup
% tables (cluts). This function is similar to "sca".
%
% It can be frustrating to have your program terminate, possibly due to an
% error, while a psychtoolbox window obscures the MATLAB Command Window.
% You can avoid that problem by planning ahead. Call onCleanup at the
% beginning of your main program to request a clean up whenever your
% program terminates, even by error or control-c.
%
% cleanup=onCleanup(@() CloseWindowsAndCleanup);
%
% The cleanup function you specify is called when the local variable
% "cleanup" is cleared, which occurs at termination (normal or abnormal) of
% the program that it's in.
%
% denis.pelli@nyu.edu, November 27, 2018
global ff isLastBlock skipScreenCalibration keepWindowOpen % Set this in your main program. True on last block.

if ~isempty(Screen('Windows')) && ~keepWindowOpen
    ffprintf(ff,'CloseWindowsAndCleanup. ... '); s=GetSecs;
    Screen('CloseAll'); % May take a minute.
    if ismac && isLastBlock && ~skipScreenCalibration
        AutoBrightness(0,1); % May take a minute.
        RestoreCluts;
    end
    ffprintf(ff,'Done (%.1f s)\n',GetSecs-s);
end
keepWindowOpen=false; % For safety we raise this flag only when needed.
% These are quick.
ListenChar;
ShowCursor;
end % function CloseWindowsAndCleanup()

