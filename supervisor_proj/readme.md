
(1) supervisor脚本工具功能概述：
1. 实现一个脚本工具，该脚本提供类似supervisor功能，可以对进程进行管理
2. 一键查看所有进程运行状态
3. 单个或批量启动进程，单个或批量停止进程
4. 提供进程分组功能，可以按组查看进程运行状态，可以按组启动或停止该组内所有进程

(2) 拆分脚本功能，抽象函数
1. function get_all_process     返回进程名称字符串  "nginx httpd mysql datanode"
2. function get_all_group       返回进程组列表字符串
3. function get_process_info    返回进程详细信息列表字符串
   详细信息包括：运行状态，pid，cpu，memory，start_time
   注：该函数可以接收一个参数，参数为进程名称
4. function get_all_process_by_group        返回进程组内所有进程名称列表字符串
   例子：DB组 ---> mysql   postgresql   oracle

(3) 程序主流程设计：
1. 无参数          列出配置文件中所有进程的运行信息
2. -g GroupName   列出GroupName组内的所有进程
3. process_name   列出指定进程的运行信息

(4) 函数说明
1. function get_all_groups
说明: 参数：无
     返回值:配置文件中所有的组信息 

2. function get_all_process
说明: 参数：无
     返回值:配置文件中所有的进程信息 

3. function get_process_pid_by_name
说明: 参数：进程名称  
     返回值:进程pid列表,可能有一个或多个

4. function get_process_info_by_pid
说明: 参数：pid
     返回值:进程运行信息列表,包含运行状态 cpu 内存 运行时间信息 

5. function is_group_in_config
说明: 参数：组名称
     返回值:0表示该组在配置文件，1表示该组不在配置文件中

6. function get_all_process_by_group
说明: 参数：组名称
     返回值:0表示该组在配置文件，对应组内的所有进程名称列表

7. function get_group_by_process_name
说明: 参数：进程名称
     返回值:返回组名称
 
8. format_print
说明: 参数：进程名称  组名称
     返回值:针对每一个进程pid,打印运行信息
