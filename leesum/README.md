# cva6
+ 内核配置：
  + cva6 是一个 RV64GC ISA、6-stage 顺序单发射，乱序执行，顺序写回 64bit CPU core，完全实现了 Volume I: User-Level ISA V 2.1 中指定的 I、M 和 C 扩展以及 draft privilege extension 1.10，且实现了三个特权级 M、S、U 以完全支持类Unix操作系统。在本次移植配置过程中，去除了浮点运算单元。
+ 总线：采用 Axi4 总线进行通讯，支持突发传输
+ TLB 和 Cache：
  + 10 项全相联 ITLB，如果 hit 当周期返回（组合逻辑电路）
  + 10 项全相联 DTLB，如果 hit 下一周期返回（组合逻辑电路+寄存器）
  + 4 路组相联 Icache，cacheline 128bit，Cache size 16K
  + 4 路组相联 Dcache，cacheline 128bit，Cache size 32K，（采用 wrtite though）
+ 流水线：六级六实现，分别为 pc_gen，inst_fetch，decode，issue，ex，commit
  + 采用 Scoreboard 技术和一个轻量级的寄存器重命名来实现 ex 阶段的乱序执行
  + 在前端采用 bth,htb,ras 技术来实现分支预测
+ 仓库位置：https://github.com/iEDA-Open-Source-Core-Project/cva6
+ 分支：leesum_v1
+ 贡献者：李子龙



