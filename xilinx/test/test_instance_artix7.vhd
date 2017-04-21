-- This file is part of the ethernet_mac project.
--
-- For the full copyright and license information, please read the
-- LICENSE.md file that was distributed with this source code.
--set_property IOSTANDARD LVCMOS33 [get_ports o_emdc]
--set_property IOSTANDARD LVCMOS33 [get_ports io_emdio]
--set_property IOSTANDARD LVCMOS33 [get_ports o_erstn]
--set_property IOSTANDARD LVCMOS33 [get_ports o_etx_en]
--set_property IOSTANDARD LVCMOS33 [get_ports o_erefclk]
--set_property IOSTANDARD LVCMOS33 [get_ports i_emdint]

-- Instantiate test_mirror and add Spartan 6-specific clock buffering

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.ethernet_types.all;
use work.test_common.all;

library unisim;
use unisim.vcomponents.all;

entity test_instance_artix7 is
	port(
		clk_p            : in  std_ulogic;
		rst_top          : in  std_ulogic;
		o_etxd           : out std_ulogic_vector(1 downto 0);
		i_erx_er         : in  std_ulogic;
		i_erx_dv         : in  std_ulogic;
		i_erxd           : in  std_ulogic_vector(1 downto 0);
		o_erefclk        : out std_ulogic;
		i_dip            : in  std_ulogic_vector(1 downto 0)
	);
end entity;

architecture rtl of test_instance_artix7 is
	signal clock_50             : std_ulogic;
	signal clock_125            : std_ulogic;
	signal clock_200            : std_ulogic;
	signal locked               : std_ulogic;
	signal reset                : std_ulogic;
	signal test_mode            : t_test_mode;
    signal mii_txd_o            : std_ulogic_vector(7 downto 0);
    signal mii_rxd_i            : std_ulogic_vector(7 downto 0);

component clk_wiz_0 is
  port (
    clk_in1 : in STD_LOGIC;
    clk_200 : out STD_LOGIC;
    clk_125 : out STD_LOGIC;
    clk_50  : out STD_LOGIC;
    locked  : out STD_LOGIC;
    resetn  : in STD_LOGIC
  );
END COMPONENT;

begin

    mii_rxd_i <= "000000" & i_erxd;
    o_etxd <= mii_txd_o(1 downto 0);
	reset                             <= (not rst_top) or (not locked);
	with i_dip select test_mode <=
		TEST_LOOPBACK when "01",
		TEST_TX_PADDING when "10",
		TEST_NOTHING when others;

    clk_wiz_inst: clk_wiz_0
     port map (
      clk_50 => clock_50,
      clk_125 => clock_125,
      clk_200 => clock_200,
      clk_in1 => clk_p,
      resetn => rst_top,
      locked => locked
    );

	test_instance_inst : entity work.test_instance
		port map(
			clock_125_i      => clock_125,
			user_clock_i     => clock_125,
			reset_i          => reset,
			mii_tx_clk_i     => clock_50,
			mii_tx_er_o      => open,
			mii_tx_en_o      => open,
			mii_txd_o        => mii_txd_o,
			mii_rx_clk_i     => clock_50,
			mii_rx_er_i      => i_erx_er,
			mii_rx_dv_i      => i_erx_dv,
			mii_rxd_i        => mii_rxd_i,
			gmii_gtx_clk_o   => o_erefclk,
			rgmii_tx_ctl_o   => open,
			rgmii_rx_ctl_i   => '0',
			speed_override_i => SPEED_100MBPS,
			test_mode_i      => test_mode
		);

end architecture;

