source common.sh

my_log="/tmp/error.log"

status_check(){
  if [ #? == 0 ];then
    echo "Success"
  else;
    echo "Check log file"
    exit
  fi
}