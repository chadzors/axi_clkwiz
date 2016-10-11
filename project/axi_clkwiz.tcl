create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:5.1 clk_wiz_0
set_property -dict [list CONFIG.USE_DYN_RECONFIG {true}] [get_bd_cells clk_wiz_0]
connect_bd_net -net [get_bd_nets sys_cpu_resetn] [get_bd_pins clk_wiz_0/s_axi_aresetn] [get_bd_pins sys_rstgen/peripheral_aresetn]
connect_bd_net -net [get_bd_nets sys_200m_clk] [get_bd_pins clk_wiz_0/clk_in1] [get_bd_pins sys_ps7/FCLK_CLK1]

ad_connect  clk_wiz_0/clk_out1  hdl_clk
ad_cpu_interconnect 0x43000000 clk_wiz_0
