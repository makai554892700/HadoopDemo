#Hadoop Hellow world 项目
# hadoop官网: http://hadoop.apache.org/
# jdk官网: 
* 测试 hellow world (仅CENTOS7下有小)
    * 创建虚拟机(细节可自行百度)
    * 下载 hadoop-3.0.0-beta1.tar.gz 文件 (wget https://mirrors.tuna.tsinghua.edu.cn/apache/hadoop/common/hadoop-3.0.0-beta1/hadoop-3.0.0-beta1.tar.gz)
    * 下载 jdk-8u141-linux-x64.tar.gz 文件 (由于官网限制，需自行注册账号下载)
    * 复制下载好的文件及resources下的所有文件至虚拟机某目录(install.sh文件可能存在编码问题，如果可以，可以重载一遍)
    * 于文件目录运行 
    
            bash install.sh
    * 此时的环境变量可能没有完全生效(java -version或者hadoop -help 命令无效)，此时可运行 
    
            source /etc/profile
    * 运行jps 若结果包含 SecondaryNameNode/NameNode/NodeManager/ResourceManager/DataNode 则表示安装启动成功
    * 将当前项目打成jar包(打jar包方式自行百度)同样放置至同一目录
    * 依次运行
    
            hadoop fs -mkdir /test
            hadoop fs -copyFromLocal  ~/temp.txt /test/
            hadoop jar HadoopDemo_main.jar com/mayousheng/www/WordCount
            hadoop fs -copyToLocal /result /test/result
            ll /result
        * 此时列出的结果即为运行结果文件，不出意外demo运行完成
