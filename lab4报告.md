1. 实验目的

   1. 掌握CPU 的外设I/O 模块的设计方法。理解 I/O 地址空间的译码设计方法。
   2. 掌握Vivado 仿真、实现、板级验证方式。
   3. 通过扩展新指令的实现，深入理解CPU对指令的译码、执行原理和实现方式。

2. 实验平台及器材

   1. 计算机 1 台 ( 尽可能达到 8G 及以上内存 ) ；
   2. Xilinx 的 Vivado 开发套件 (2020.2 版本 ) ；
   3. Xilinx 的 EGO1 FPGA 开发板。

3. 实验任务

   1. 本次实验的主要任务是在实验三完成的单周期 CPU 核基础上进行外设拓展，增加 CPU 对 I/O 口的读写支持，以及对新指令的功能支持，并在 EGO1 实验板上完成板级测试验证。

   2. 文件树

      ![image-20230513215605017](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20230513215605017.png)

      ![image-20230513215710766](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20230513215710766.png)

   3.  I/O模块代码

      按框架图连接模块

      ![image-20230513222309638](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20230513222309638.png)

      1. 在 sc_datamem 模块中完成子模块 io_input 和 io_output 的例化

         ![image-20230513222257650](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20230513222257650.png)

      2. 在软核顶层 sc_computer_main 模块中例化 sc_instmem 和 sc_datamem 两个存储器模块

         需注意其中dmem_clock,imem_clock的传参，因为实验使用个独立的时钟生成模块 clock_and_mem_clock 为指令存储器和数据存储器分别生成时间

         ![image-20230513222443057](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20230513222443057.png)

      3. 在整个项目的顶层文件 sc_cpu_iotest 中例化 sc_computer_main 等下层模块

         本实验模块层级较多，且部分变量会反复作为输入/输出被传递，例化时应特别注意不同文

         件中定义的变量名可能不同，要准确对应

         ![image-20230513222713232](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20230513222713232.png)

         

   4. 扩展指令

      先要求扩展 ALU 模块功能，使其支持求两个 32 比特数的汉明距离的操作。为此，我们自定义该操作为R-type 指令 hamd rd, rs1, rs2 ，其编码中 func3=111 ， func7=0100000 ， op=0110011 ，则hamd x16, x14, x15 的指令码为 0100000|01111|01110|111|10000|0110011 = 40f77833

      1. sc_cu 模块中为新指令（hamd ）定义控制变量i_hamd ，并为其分配不相冲突的 aluc 代码1111 

         ![image-20230513223628685](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20230513223628685.png)

      2.  alu 模块增添汉明距离运算操作

         循环语句应使用 always 过程赋值，且变量类型相应更改为 reg 类型

         与之前assign对应wire不同

         ![image-20230513223819698](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20230513223819698.png)

   5. 仿真

      400 ns时，正确完成第一轮循环， out_port0 和 out_port1 正确显示了in_port0 和 in_port1 的数据，并在 out_port2 中正确得到了二者加和的结果

      ![image-20230513224442293](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20230513224442293.png)

      程序正确完成循环， out_port0 和 out_port1 正确显示了 in_port0 和in_port1 的数据，并在 out_port2 中正确得到了二者求汉明距离的结果

      ![image-20230513224248263](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20230513224248263.png)

6. 板上验证

   ![img](https://static.cnmooc.org/repositry/umeditor/i/2304/15/780292fda9b3412bb3863cca7fb6c611.jpg)![img](https://static.cnmooc.org/repositry/umeditor/i/2304/15/55d71c9aac094119addb245d1ed99407.jpg)

   汉明距离正确

   ![微信图片_20230513232218](F:\计组\微信图片_20230513232218.jpg)