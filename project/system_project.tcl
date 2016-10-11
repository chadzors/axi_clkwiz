


source scripts/adi_env.tcl
source scripts/adi_project.tcl
source scripts/adi_board.tcl

adi_project_create clkwiz_zed
adi_project_files clkwiz_zed [list \
  "system_top.vhd" \
  "constr/zed_system_constr.xdc" \
  ]

#adi_project_run adv7511_zed


