在了解/etc/ld.so.conf.d/目录下文件的作用之前，先介绍下程序运行是加载动态库的几种方法：
第一种，通过ldconfig命令
    ldconfig命令的用途, 主要是在默认搜寻目录(/lib和/usr/lib)以及动态库配置文件/etc/ld.so.conf内所列的目录下, 搜索出可共享的动态链接库(格式如lib*.so*), 进而创建出动态装入程序(ld.so)所需的连接和缓存文件. 缓存文件默认为/etc/ld.so.cache, 此文件保存已排好序的动态链接库名字列表.
    这里面涉及到的关键内容有命令：ldconfig，配置文件目录：/etc/ld.so.conf.d，配置文件在/etc/ld.so.conf内容由用户编辑，缓冲文件/etc/ld.so.cache。下面举个例子，比如你在部署软件时，有些动态库安装在exe目录下，可以通过如下方法实现，
1）配置exe.conf文件，里面加一行～/exe，然后将该文件放到/etc/ld.so.conf.d目录下；
2）在/etc/ld.so.conf文件中增加一行include ld.so.conf.d/exe.conf
3）执行 ldconfig命令
之后程序运行时，会自动增加在exe目录中搜索动态库。
第二种，通过LD_LIBRARY_PATH环境变量
可以通过在.bashrc或者.cshrc中配置该环境变量，LD_LIBRARY_PATH的意思是告诉loader在哪些目录中可以找到共享库. 可以设置多个搜索目录, 这些目录之间用冒号分隔开.
同样是上面的例子，可以通过以上的方法来实现
在.bashrc或.cshrc中增加一行，export LD_LIBRARY_PATH = ～/exe：$LD_LIBRARY_PATH即可。

第三种，通过编译选项-Wl， -rpath指定动态搜索的路径
    -Wl选项告诉编译器将后面的参数传递给链接器。
    通过上面的介绍，对/etc/ld.so.conf.d/的作用就比较清晰了。
