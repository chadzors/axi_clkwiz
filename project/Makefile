####################################################################################
####################################################################################
## Copyright 2011(c) Analog Devices, Inc.
## Auto-generated, do not modify!
####################################################################################
####################################################################################

M_DEPS += system_top.v
M_DEPS += system_project.tcl
M_DEPS += system_bd.tcl
M_DEPS += scripts/adi_project.tcl
M_DEPS += scripts/adi_env.tcl
M_DEPS += scripts/adi_board.tcl
M_DEPS += constr/zed_system_constr.xdc
M_DEPS += zed_system_bd.tcl
#M_DEPS += vivado/axi_clkgen.xpr
#M_DEPS += ../../../library/axi_hdmi_tx/axi_hdmi_tx.xpr

M_VIVADO := vivado -mode batch -source

M_FLIST := *.cache
M_FLIST += *.data
M_FLIST += *.xpr
M_FLIST += *.log
M_FLIST += *.jou
M_FLIST +=  xgui
M_FLIST += *.runs
M_FLIST += *.srcs
M_FLIST += *.sdk
M_FLIST += .Xil
M_FLIST += *.hw
M_FLIST += *.sim
M_FLIST += *pid*.zip
M_FLIST += vivado


.PHONY: all lib clean clean-all
all: lib vivado/clkwiz_zed.sdk/system_top.hdf


clean: 
	rm -rf $(M_FLIST)


clean-all:clean
	#make -C ../../../library/axi_hdmi_tx clean


vivado/clkwiz_zed.sdk/system_top.hdf: $(M_DEPS)
	rm -rf $(M_FLIST)
	$(M_VIVADO) system_project.tcl >> clkwiz_zed_vivado.log 2>&1


lib:
	#make -C ../../../library/axi_clkgen

####################################################################################
####################################################################################
