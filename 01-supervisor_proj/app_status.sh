#!/bin/bash
#
# Func: Get Process Status In process.cfg

# Define Variables
HOME_DIR="/root/workspace/shellscript"
CONFIG_FILE="process.cfg"
this_pid=$$

# 返回进程组列表字符串
function get_all_groups
{
	# G_LIST=$(sed -n '/\[Group_LIST\]/,/\[.*\]/p' $HOME_DIR/$CONFIG_FILE | grep -v "^$"  | grep -v "\[.*\]")
	G_LIST=$(sed -n '/\[Group_LIST\]/,/\[.*\]/p' $HOME_DIR/$CONFIG_FILE | grep -E -v "(^$|\[.*\])")
	echo "$G_LIST"
}

# 等同于groups=$(get_all_groups)
# for group in $(get_all_groups)
# do
#	echo $group
# done

# 返回进程名称字符串 "nginx httpd mysql datanode"
function get_all_process
{
	for group in $(get_all_groups)
	do
		P_LIST=$(sed -n "/\[$group\]/,/\[.*\]/p" $HOME_DIR/$CONFIG_FILE | grep -E -v "(^$|\[.*\])")
		echo "$P_LIST"
	done
}

# 获取pid通过进程名
function get_process_pid_by_name
{
    if [ "$#" -ne "1" ];then
		return 1
	else
		pids=$(ps -ef | grep "$1" | grep -v grep | grep -v "$0" | awk '{print $2}')
		echo "$pids"
    fi
}

# 获取进程信息通过pid
function get_process_info_by_pid
{
    if [ "$(ps -ef | awk -v pid="$1" '$2==pid{print}' | wc -l)" -eq 1 ];then
		pro_status="running"
    else
		pro_status="stoped"
    fi
	
    pro_cpu=$(ps -aux | awk -v pid="$1" '$2==pid{print $3}')
    pro_memory=$(ps -aux | awk -v pid="$1" '$2==pid{print $4}')
    pro_start_time=$(ps -p "$1" -o lstart | grep -v STARTED)
    # echo "$pro_status $pro_cpu $pro_memory $pro_start_time"
}

function is_group_in_config
{
    for groupname in $(get_all_groups)
    do
        if [ "$groupname" == "$1" ];then
        	return
        fi
    done
    return 1
}

function is_process_in_config
{
    for processname in $(get_all_process)
    do
        if [ "$processname" == "$1" ];then
        	return
        fi
    done
    echo "Process $1 is not in process.cfg"
    return 1
}

# 返回进程组内所有进程名称列表字符串
function get_all_process_by_group
{
	is_group_in_config "$1"
	if [ $? -eq "0" ];then
		p_list=$(sed -n "/\[$1\]/,/\[.*\]/p" $HOME_DIR/$CONFIG_FILE | egrep -v "(^$|^#|\[.*\])")
		echo "$p_list"
	else
        echo "Groupname $1 is not exist....please check"
	fi
}

# 通过进程名称,返回组名称
function get_group_by_process_name
{
    for groupname in $(get_all_groups)
    do
        for processname in $(get_all_process_by_group "$groupname")
        do
        	if [ "$processname" == "$1" ];then
        		echo "$groupname"
        	fi
        done
    done
}

# 格式化输出     
# 参数：进程名称  与组名称
function format_print
{
    ps -ef | grep "$1" | grep -v grep | grep -v $this_pid &> /dev/null
    if [ "$?" -eq "0" ];then
    	pids=$(get_process_pid_by_name $1)
    	for pid in $pids
    	do
    		get_process_info_by_pid $pid
    		awk -v p_name="$1" \
    		    -v g_name="$2" \
    		    -v p_pid="$pid" \
    		    -v p_status="$pro_status" \
    		    -v p_cpu="$pro_cpu" \
    		    -v p_mem="$pro_memory" \
    		    -v p_start_time="$pro_start_time" \
    		    'BEGIN{printf "%-16s%-16s%-8s%-10s%-7s%-10s%-20s\n", \
    		    p_name, g_name, p_pid, p_status, p_cpu, p_mem, p_start_time }'
    	done
    else
    	awk -v p_name="$1" \
    		-v g_name="$2" \
    		'BEGIN{printf "%-16s%-16s%-8s%-10s%-7s%-10s%-20s\n", \
    		p_name, g_name, "NULL", "NULL", "NULL", "NULL", "NULL" }'
    fi
}



if [ ! -e $HOME_DIR/$CONFIG_FILE ];then
	echo "$CONFIG_FILE is not exist... Please Check.."
	exit 1
fi

awk 'BEGIN{printf "%-16s%-16s%-8s%-10s%-7s%-10s%-20s\n", \
	"ProcessName-----","GroupName-------","Pid-----","Status----","Cpu----","Memory----","StartTime---"}'

if [ "$#" -gt "0" ];then
    if [ "$1" == "-g" ];then
        shift
        for groupname in "$@"
        do
			for processname in $(get_all_process_by_group "$groupname")
			do
			    is_process_in_config "$processname" && format_print "$processname" "$groupname"
			done
        done
    else
		for processname in "$@"
		do
			groupname=$(get_group_by_process_name "$processname")
			is_process_in_config "$processname" && format_print "$processname" "$groupname"
		done
    fi
else
    for processname in $(get_all_process)
    do
    	groupname=$(get_group_by_process_name "$processname")
		is_process_in_config "$processname" && format_print "$processname" "$groupname"
    done
fi
