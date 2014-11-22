#!/usr/bin/env bash
killall -KILL rcd 2> /dev/null   # Stop any running processing.
backup_filename="rcd_backup_${VERSION}_`date "+%Y%m%d%H%M.%S"`"
rcd_path=/System/Library/CoreServices/rcd.app/Contents/MacOS
cp $rcd_path/rcd $rcd_path/$backup_filename
$1/edit_rcd_bin.py $rcd_path/rcd
if [[ $? -eq 0 ]]; then
  codesign -f -s - $rcd_path/rcd
	echo "Success"
else
	echo "Fail"
fi