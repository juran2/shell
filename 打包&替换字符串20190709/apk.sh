#!/bin/bash

#######  自动打包机说明  ########

# 脚本执行： ./Package.sh args1 args2 args3 ...
# args[n]是需要打包的打包机名，如zzqpPackage
# 可打一个包，也可打多个包，多个包时依照输入次序

for args in $@
do
    #cd
    #cd ./PackageMachine
    if [ -d $args ];then
        cd ./$args/app
        echo -e \\033[34m"$args-进入打包状态..." \\033[0m
	gradle clean
	echo -e \\033[32m"$args-工程清理完成!" \\033[0m
        gradle assembleRelease
        echo -e \\033[32m"$args-打包完成！" \\033[0m  
    else
        echo -e \\033[31m"$args-没有找到打包机" \\033[0m  
    fi
done
