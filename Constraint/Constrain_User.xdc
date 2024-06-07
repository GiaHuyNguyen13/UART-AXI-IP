#LED
set_property -dict {PACKAGE_PIN AG14 IOSTANDARD LVCMOS33} [get_ports led_8bits_tri_o[0]] #GPIO_LED_0
set_property -dict {PACKAGE_PIN AF13 IOSTANDARD L¥CMOS33} [get_ports led_8bits_tri_o[1]] #GPIO_LED_1
set_property -dict {PACKAGE_PIN AE13 IOSTANDARD LVCMOS33} [get_ports led_8bits_tri_o[2]] #GPIO_LED_2
set_property -dict {PACKAGE_PIN AJ14 IOSTANDARD LYCMOS33} [get_ports led_8bits_tri_o[3]] #GPIO_LED_3
set_property -dict {PACKAGE_PIN AJ15 IOSTANDARD LVCMOS33} [get_ports led_8bits_tri_o[4]] #GPIo LED_4
set_property -dict {PACKAGE_PIN AH13 IOSTANDARD LVCMOS33} [get_ports led_8bits_tri_o[5]] #GPIO LED_5
set_property -dict {PACKAGE_PIN AH14 IOSTANDARD LVCM0S33} [get_ports led_8bits_tri_o[6]] #GPIO_LED_6
set_property -dict {PACKAGE_PIN AL12 IOSTANDARD LYCMOS33} [get_ports led_8bits_tri_o[7]] #GPIO_LED_7
#UART
set_property -dict {PACKAGE_PIN E13 IOSTANDARD LVCMOS33} [get_ports uart2_pl_rxd[0]] #rx
set_property -dict {PACKAGE_PIN F13 IOSTANDARD LVCMOS33} [get_ports uart2_pl_txd[0]] #tx
#? Ignore Error when the Design hes eny Pin not assigned
set_property BITSTREAM.GENERAL.UNCONSTRAINEDPINS Allow [current_design]
set_property SEVERITY {Warning} [get_drc_checks NSTD-l]
set_property SEVERITY {Warning} [get_drc_checks UCIO-1]
