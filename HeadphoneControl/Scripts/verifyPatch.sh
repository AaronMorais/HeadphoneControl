#!/usr/bin/env bash
rcd_path=/System/Library/CoreServices/rcd.app/Contents/MacOS
calculated_rcd_md5=`md5 -q $rcd_path/rcd`
backup_count=`find $rcd_path -type f -maxdepth 1 -name rcd_backup_\* | wc -l`
if [[ $backup_count -ne 0 ]]; then
  echo "Patched"
  exit
fi
echo "Unpatched"