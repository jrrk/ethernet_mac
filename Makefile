# Set ISE_DIR to ISE installation directory. Example: .../14.7/ISE_DS/ISE

OPTS=--std=93c -g --ieee=synopsys -fexplicit --warn-no-vital-generic
# --no-vital-checks

all:
	ghdl -i --work=ethernet_mac --workdir=ghdl $(OPTS) *.vhd xilinx/*.vhd test/*.vhd xilinx/ipcore_dir/ethernet_mac_tx_fifo_xilinx_sim_netlist.vhdl
	ghdl -m --work=ethernet_mac --workdir=ghdl -Pghdl/unisim -Pghdl/xilinxcorelib $(OPTS) ethernet_mac_tb

check: all
	./ethernet_mac_tb --stack-max-size=20M --ieee-asserts=disable

prepare:
	mkdir -p ghdl/unisim ghdl/xilinxcorelib #ghdl/simprim
	ghdl -i --work=unisim --workdir=ghdl/unisim $(OPTS) $(XILINX_VIVADO)/data/vhdl/src/unisims/*.vhd
	ghdl -i --work=unisim --workdir=ghdl/unisim $(OPTS) $(XILINX_VIVADO)/data/vhdl/src/unisims/primitive/*.vhd
	ghdl -i --work=unisim --workdir=ghdl/unisim $(OPTS) $(XILINX_VIVADO)/data/vhdl/src/unisims/retarget/*.vhd
#	ghdl -i --work=XilinxCoreLib --workdir=ghdl/xilinxcorelib $(OPTS) $(ISE_DIR)/vhdl/src/XilinxCoreLib/*.vhd
#	ghdl -i --work=simprim --workdir=ghdl/simprim $(OPTS) $(ISE_DIR)/vhdl/src/simprims/simprim_Vcomponents.vhd $(ISE_DIR)/vhdl/src/simprims/simprim_Vpackage.vhd $(ISE_DIR)/vhdl/src/simprims/primitive/other/*.vhd

simv:	crc32_tb.vhd crc32.vhd crc.vhd ethernet_mac_tb.vhd ethernet_types.vhd ethernet.vhd ethernet_with_fifos.vhd framing_common.vhd framing.vhd mii_gmii_io.vhd mii_gmii.vhd miim_control.vhd miim_registers.vhd miim_types.vhd miim.vhd reset_generator.vhd rx_fifo.vhd single_signal_synchronizer.vhd tx_fifo_adapter.vhd utility.vhd xilinx/fixed_input_delay_artix7.vhd xilinx/input_buffer.vhd xilinx/mii_gmii_io_artix7.vhd xilinx/mii_gmii_io_artix7.vhd xilinx/output_buffer.vhd xilinx/single_signal_synchronizer_artix7.vhd xilinx/tx_fifo.vhd test/test_common.vhd test/test_instance.vhd xilinx/ipcore_dir/ethernet_mac_tx_fifo_xilinx_sim_netlist.vhdl
	mkdir -p vhdl/default/64
	vhdlan -full64 -q utility.vhd
	vhdlan -full64 -q crc.vhd
	vhdlan -full64 -q miim_types.vhd
	vhdlan -full64 -q ethernet_types.vhd
	vhdlan -full64 -q crc32.vhd
#	vhdlan -full64 -q xilinx/fixed_input_delay_artix7.vhd
	vhdlan -full64 -q framing_common.vhd
	vhdlan -full64 -q miim_registers.vhd
	vhdlan -full64 -q single_signal_synchronizer.vhd
	vhdlan -full64 -q mii_gmii_io.vhd
#	vhdlan -full64 -q xilinx/output_buffer.vhd
#	vhdlan -full64 -q xilinx/input_buffer.vhd
	vhdlan -full64 -q tx_fifo_adapter.vhd
	vhdlan -full64 -q framing.vhd
	vhdlan -full64 -q mii_gmii.vhd
	vhdlan -full64 -q reset_generator.vhd
	vhdlan -full64 -q miim_control.vhd
	vhdlan -full64 -q miim.vhd
#	vhdlan -full64 -q xilinx/mii_gmii_io_artix7.vhd
#	vhdlan -full64 -q xilinx/single_signal_synchronizer_artix7.vhd
	vhdlan -full64 -q rx_fifo.vhd
	vhdlan -full64 -q ethernet.vhd
	vhdlan -full64 -q xilinx/tx_fifo.vhd
	vhdlan -full64 -q test/test_common.vhd
	vhdlan -full64 -q ethernet_with_fifos.vhd
	vhdlan -full64 -q test/test_instance.vhd
#	vhdlan -full64 -q xilinx/test/test_instance_artix7.vhd
