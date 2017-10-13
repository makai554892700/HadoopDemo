#Hadoop Hellow world 项目
# hadoop官网: http://hadoop.apache.org/
# jdk官网: http://www.oracle.com/technetwork/java/javase/downloads/index.html
* 测试 hellow world (仅CENTOS7下有效)
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
            hadoop jar HadoopDemo_main.jar com/mayousheng/www/WordCount "hdfs://localhost:9000/test/temp.txt" "hdfs://localhost:9000/test/result"
            hadoop fs -copyToLocal /result /test/result
            ll /result
        * 此时列出的结果即为运行结果文件，不出意外demo运行完成
        
* 测试 hellow world (仅aws emr下有效)
    * 创建emr机器(aws官网有细节，且不复杂)(记得关联s3)
    * 将当前项目打成jar包并上传至emr根目录
    * 上传resource文件夹下的temp.txt至s3,下面假设上传的文件路径为 s3://emrs3host/temp.txt
    * 登陆emr机器，同时于根目录运行
    
            hadoop jar HadoopDemo_main.jar com/mayousheng/www/WordCount "s3://emrs3host/temp.txt" "s3://emrs3host/result"
        * 不出意外demo运行完成(其中s3://emrs3host/temp.txt为temp.txt文件s3路径，s3://emrs3host/result为需要输出的s3路径)
* main方法本地跑报 Failed to set permissions of path: \tmp\hadoop******错误的问题
    * 网上很多的方案都是给出jar包，或者自己改源码重新打包。第一种方案使用别人给出的jar包，始终有种不安全的感觉。第二种方案又觉得非常麻烦，所以这里提供个人的解决方案。
        * 找到源码的org.apache.hadoop.fs.FileUtils文件(org.apache.hadoop:hadoop-core:1.2.1的ja包下)。
        * 在项目java目录下创建org.apache.hadoop.fs文件夹，将源码文件复制至此目录。
        * 更改复制过来的FileUtils类的checkReturnValue(boolean rv, File p, FsPermission permission)方法实现体，同时如果有两处IOUtils.closeStream(contents);报错的直接注释掉，因为往源码上面阅读会发现contents已经被置空(个人理解)。
        
