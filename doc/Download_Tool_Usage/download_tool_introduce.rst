================
在线烧录工具使用
================
------------------
一、 烧录工具获取
------------------

 :download:`ls_download_tool<./ls_dowloard_tool.7z>`

----------------
二、 操作说明
----------------

++++++++++++
2.1 文件说明
++++++++++++

将压缩包解压后会得到以下5个文件,如果有丢失文件，请重新获取烧录软件，否则烧录会失败。

+-----------------------------------+
|     download.exe                  |
+-----------------------------------+
|     config.ini                    |
+-----------------------------------+
|     sbl.bin                       |
+-----------------------------------+
|     Execel2Bin.exe                |
+-----------------------------------+
| Microsoft.Office.Interop.Excel.dll|
+-----------------------------------+


++++++++++++
2.2 下载操作
++++++++++++
#. 断开所有连线，将uart串口工具的RXD Pin接芯片的PB00,TXD Pin接芯片的PB01,3.3V接芯片的VDD，GND接GND，再将芯片的PB14拉高；

#. 将串口工具连接电脑给芯片上电，必须在第一步的接线完成之后再给芯片上电；

#. 打开download.exe，选择固件，导入要下载的hex文件，如果不是天猫精灵的工程，则不需要导入三元码文件，对于天猫精灵的工程需要先将三元组的Excel文件通过Excel2Bin工具转换成bin文件，然后导入到三元码对应的选项框；

#. 下载工具界面选择相应的COM口，默认波特率为460800，也可改成其它，如果下载过程中一直出现校验出错的情况，可以降低波特率重新烧录；

#. 点击打开按钮，打开相应的COM口；

#. 烧录成功之后，下载的进度条为100%，下载状态显示下载完成；

#. 如果烧录失败，在串口工具不掉电的情况下，重新给芯片上电，或者通过拉低NRST pin复位芯片，上位机烧录软件不需要操作；在烧录软件打开串口后，串口工具意外断电，烧录软件上需要关闭串口后再重新打开串口；

#. 去掉PB14的拉高，重新上电或复位便可运行烧录的程序。

**注：**
  芯片刚启动的时候BootRom中会去检测PB14的状态，如果处于拉高，则会进入到UART download Mode，否则会去运行用户程序。