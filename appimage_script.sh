#!/bin/bash
# this is meant to be executed by Program.cs during the build process on linux
if [[ -z "${STAGING_PATH}" ]]
then
    echo "ERROR, please don't execute this directly."
    exit 1
fi

# add ffmpeg and its licence to the AppDir
mv $STAGING_PATH/readme.txt $STAGING_PATH/ffmpeg-static_licence.txt
cat $STAGING_PATH/GPLv3.txt >> $STAGING_PATH/ffmpeg-static_licence.txt
mkdir $STAGING_PATH/osu.AppDir/usr/share/
mv $STAGING_PATH/ffmpeg-static_licence.txt $STAGING_PATH/osu.AppDir/usr/share/ffmpeg-static_licence.txt
rm $STAGING_PATH/GPLv3.txt
mv $STAGING_PATH/ffmpeg $STAGING_PATH/osu.AppDir/usr/bin/ffmpeg
mv $STAGING_PATH/ffprobe $STAGING_PATH/osu.AppDir/usr/bin/ffprobe
mv $STAGING_PATH/qt-faststart $STAGING_PATH/osu.AppDir/usr/bin/qt-faststart
mkdir $STAGING_PATH/osu.AppDir/usr/local/
mkdir $STAGING_PATH/osu.AppDir/usr/local/share/
mv $STAGING_PATH/model/ $STAGING_PATH/osu.AppDir/usr/local/share/model/

# build appimage
cd $WORKING_DIRECTORY
if [[ ! -z "${GITHUB_UPLOAD}" ]]
then
    $WORKING_DIRECTORY/tools/appimagetool-x86_64.AppImage -n -u "gh-releases-zsync|"$GITHUB_USERNAME"|"$GITHUB_REPONAME"|latest|osu-*x86_64.AppImage.zsync" $STAGING_PATH/osu.AppDir/
    mv $WORKING_DIRECTORY/osu*.AppImage.zsync $RELEASES_PATH/
else
    $WORKING_DIRECTORY/tools/appimagetool-x86_64.AppImage -n $STAGING_PATH/osu.AppDir
fi
mv $WORKING_DIRECTORY/osu*.AppImage $RELEASES_PATH/
