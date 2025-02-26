clc

% ensure in right directory
myDir = fileparts(mfilename('fullpath'));
cd(myDir);

isWin    = strcmp(computer,'PCWIN') || strcmp(computer,'PCWIN64') || ~isempty(strfind(computer, 'mingw32')); %#ok<STREMP>
isLinux  = strcmp(computer,'GLNX86') || strcmp(computer,'GLNXA64') || ~isempty(strfind(computer, 'linux-gnu')); %#ok<STREMP>
isOctave = ismember(exist('OCTAVE_VERSION', 'builtin'), [102, 5]);  % If the built-in variable OCTAVE_VERSION exists, then we are running under GNU/Octave, otherwise not.
is64Bit = ~isempty(strfind(computer, '64')); %#ok<STREMP>
assert(is64Bit,'only 64-bit builds are supported');
platform = 'Windows';
if isLinux
    platform = 'Linux';
end

if isOctave
    inpArgs = {'-v'
        '-O'
        '-ffunction-sections'
        '-fdata-sections'
        '-flto'
        '--output'
        fullfile(myDir,'TittaMex','64',platform,sprintf('TittaMex_.%s',mexext))
        '-DBUILD_FROM_SCRIPT'
        '-DIS_OCTAVE'
        sprintf('-I%s',fullfile(myDir,'deps','include'))
        sprintf('-I%s',myDir)
        sprintf('-I%s',fullfile(myDir,'TittaMex'))
        fullfile(myDir,'TittaMex','TittaMex_.cpp')
        fullfile(myDir,'src','Titta.cpp')
        fullfile(myDir,'src','types.cpp')
        fullfile(myDir,'src','utils.cpp')
        '-ltobii_research'}.';

    if isLinux
        inpArgs = [inpArgs {
            sprintf('-L%s',fullfile(myDir,'TittaMex','64','Linux'))
            '-lc'
            '-lrt'
            '-ldl'}.'];

    elseif isWin
        inpArgs = [inpArgs {
            sprintf('-L%s',fullfile(myDir,'deps','lib'))}];

        % i need to switch path to bindir or mex/mkoctfile fails because
        % gcc not found. Find proper solution for that later.
        tdir=eval('__octave_config_info__("bindir")');  % eval because invalid syntax for matlab, would cause whole file not to run
        cd(tdir);
    end
    % get cppflags, add to it what we need
    flags = regexprep(mkoctfile('-p','CXXFLAGS'),'\r|\n','');   % strip newlines
    if isempty(strfind(flags,'-std=c++2a')) %#ok<STREMP>
        setenv('CXXFLAGS',[flags ' -std=c++2a']);
    end
    % get linker flags, add to it what we need
    flags = regexprep(mkoctfile('-p','LDFLAGS'),'\r|\n','');   % strip newlines
    flags = [flags ' -Wl,--gc-sections -flto'];
    if isLinux
        flags = [flags ' -Wl,-rpath,''$ORIGIN'''];
    end
    setenv('LDFLAGS',flags);
    mex(inpArgs{:});
    cd(myDir);
    if isLinux
        % PTB does it, so we uses their code to do this too
        striplibsfrommexfile(fullfile(myDir,'TittaMex','64',platform,sprintf('TittaMex_.%s',mexext)));
    end
else
    inpArgs = {'-R2017b'    % needed on R2019a and later to make sure we build a lib that runs on MATLABs as old as at least R2015b
        '-v'
        '-O'
        '-outdir'
        fullfile(myDir,'TittaMex','64',platform)
        '-DBUILD_FROM_SCRIPT'
        sprintf('-I%s',fullfile(myDir,'deps','include'))
        sprintf('-I%s',myDir)
        sprintf('-I%s',fullfile(myDir,'Titta'))
        fullfile('TittaMex','TittaMex_.cpp')
        fullfile('src','*.cpp')}.';

    if isWin
        inpArgs = [inpArgs {
            'COMPFLAGS="$COMPFLAGS /std:c++latest /Gy /Oi /GL /permissive-"'
            sprintf('-L%s',fullfile(myDir,'deps','lib'))
            'LINKFLAGS="$LINKFLAGS /LTCG /OPT:REF /OPT:ICF"'}.'];
    elseif isLinux
        inpArgs = [inpArgs {
            'CXXFLAGS="$CXXFLAGS -std=c++2a -ffunction-sections -fdata-sections -flto"'
            'LDFLAGS="$LDFLAGS -Wl,-rpath,''$ORIGIN'' -Wl,--gc-sections -flto"'
            sprintf('-L%s',fullfile(myDir,'TittaMex','64','Linux'))
            '-ltobii_research'}.'];
    end
    mex(inpArgs{:});
end
