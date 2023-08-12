<center> Lab 3 实验报告</center>
<center>521030910087 吴舒文</center>

​    

1. 实验目的
   1. 掌握不同类型指令在数据通路中的执行路径。
   2. 掌握Vivado 仿真方式。
   
2. 设计思路
   1. 从前序实验中导入已完成的各个模块本次实验中所需完成的模块，并完成指令rom 和数据 ram 的例化
   
      ![image-20230503220619970](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20230503220619970.png)
   
   2. 实现sc_cpu.v
   
      1. ![image-20230503221230837](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20230503221230837.png)寄存器 ![image-20230503221210743](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20230503221210743.png)
   
      2. 用aluimm决定alub
   
         ![image-20230503221313603](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20230503221313603.png)![image-20230503221342526](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20230503221342526.png)
   
      3. alu
   
         ![image-20230503221411439](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20230503221411439.png)![image-20230503221441227](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20230503221441227.png)
   
      4. 三个加法器 分别计算分支/跳转/顺序情况下的下一条指令地址、
   
         ![image-20230503221512846](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20230503221512846.png)![image-20230503221525584](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20230503221525584.png)![image-20230503221602549](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20230503221602549.png)
   
      5. 四路选择器 根据 pcsource 给出下一条指令地址
   
         ![image-20230503221624957](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20230503221624957.png)![image-20230503221720413](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20230503221720413.png)
   
      6. 两个二路选择器 根据 m2reg 和 pcsource[1]决定写回寄存器的内容
   
         ![image-20230503221743316](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20230503221743316.png)![image-20230503221817955](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20230503221817955.png)
   
   3. 进行仿真
   
      将仿真时长调至1600ns，得到如下结果
   
      由此得出1515ns指令执行结束，最后的指令地址为0000007c；最后一条指令为0000006f；此时x18寄存器的值为0001ffff，与指导书结果一致。
   
      790ns后，寄存器x19的值为0000000a，说明sw,lw执行正确
   
      ![image-20230503232259582](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20230503232259582.png)
   
      ![image-20230503223320721](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20230503223320721.png)
   
      ![image-20230503225335459](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20230503225335459.png)![image-20230503225419071](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20230503225419071.png)
   
      ![image-20230503222137356](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20230503222137356.png)![image-20230503222313799](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20230503222313799.png)
   
   4. 拓展思考：对比Ripes软件生成的框架图，本次完成的数据通路其实使用了许多不必要的 FPGA 资源 ，考虑尽量减少使用硬件资源，用于产生branchpc 和jalrpc 地址的加法器是可以省掉的，同样使用ALU来计算目标地址，这样也能省掉四选一多路选择器。最终我们仅使用二选一多路选择器即可完成完整的数据通路。
   
      Ripes使用的是二路选择器来完成数据通路，用于用于产生branchpc 和jalrpc 地址的加法器也省掉了。
   
      ![image-20230503225526359](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20230503225526359.png)