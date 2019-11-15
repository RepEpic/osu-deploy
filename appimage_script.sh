#!/bin/bash
# this is meant to be executed by Program.cs during the build process on linux

cd $WORKING_DIRECTORY
$WORKING_DIRECTORY/tools/appimagetool-x86_64.AppImage $STAGING_PATH/osu.AppDir
if [ ! $? -eq 0 ]
then
    echo "error, please don't execute this directly"
    exit 1
fi
mv $WORKING_DIRECTORY/osu*.AppImage $RELEASES_PATH/
exit 0