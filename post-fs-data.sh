# Meow's Debug Assistant
#
# A tool to collect extremely verbose debug log from the Android system.
# LICENSE: BSD 3-Clause by ThePedroo

SAVE_FOLDER=/data/local/tmp

function prepare_file() {
  local file_path="$SAVE_FOLDER/DebugAssistant$1.log"

  touch "$file_path"
  chown shell:shell "$file_path"
}

function log_watcher() {
  local file_path="$SAVE_FOLDER/DebugAssistant$2.log"
  if [[ $1 == "dmesg" ]]; then
    su -c "dmesg -w > \"$file_path\"" &
  elif [[ $1 == "logcat" ]]; then
    su -c "logcat -f \"$file_path\"" &
  else
    su -c "logcat -f \"$file_path\"" &
  fi
}

# Check if file exists
if [[ ! -f "$SAVE_FOLDER/DebugAssistant-LOGCAT-Boot1.log" || ! -r "$SAVE_FOLDER/DebugAssistant-DMESG-Boot1.log" ]]; then
  prepare_file "-LOGCAT-Boot1"
  prepare_file "-DMESG-Boot1"
  log_watcher "logcat" "-LOGCAT-Boot1"
  log_watcher "dmesg" "-DMESG-Boot1"
elif [[ ! -f "$SAVE_FOLDER/DebugAssistant-LOGCAT-Boot2.log" || ! -r "$SAVE_FOLDER/DebugAssistant-DMESG-Boot2.log" ]]; then
  prepare_file "-LOGCAT-Boot2"
  prepare_file "-DMESG-Boot2"
  log_watcher "logcat" "-LOGCAT-Boot2"
  log_watcher "dmesg" "-DMESG-Boot2"
elif [[ ! -f "$SAVE_FOLDER/DebugAssistant-LOGCAT-Boot3.log" || ! -r "$SAVE_FOLDER/DebugAssistant-DMESG-Boot3.log" ]]; then
  prepare_file "-LOGCAT-Boot3"
  prepare_file "-DMESG-Boot3"
  log_watcher "logcat" "-LOGCAT-Boot3"
  log_watcher "dmesg" "-DMESG-Boot3"
else
  rm $SAVE_FOLDER/DebugAssistant-LOGCAT-Boot1.log $SAVE_FOLDER/DebugAssistant-DMESG-Boot1.log
  rm $SAVE_FOLDER/DebugAssistant-LOGCAT-Boot2.log $SAVE_FOLDER/DebugAssistant-DMESG-Boot2.log
  rm $SAVE_FOLDER/DebugAssistant-LOGCAT-Boot3.log $SAVE_FOLDER/DebugAssistant-DMESG-Boot3.log

  prepare_file "-LOGCAT-Boot1"
  prepare_file "-DMESG-Boot1"
  log_watcher "logcat" "-LOGCAT-Boot1"
  log_watcher "dmesg" "-DMESG-Boot1"
fi
