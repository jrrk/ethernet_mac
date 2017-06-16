-- This file is part of the ethernet_mac project.
--
-- For the full copyright and license information, please read the
-- LICENSE.md file that was distributed with this source code.

-- Simple testbench for playing around with the CRC calculation code

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.framing_common.all;
use work.crc32.all;
use work.utility.all;

entity crc32_tb is

  port(
	-- Signals as isim cannot trace variables
	crc            : out t_crc32;
	oldcrc         : in t_crc32;
	data           : in std_ulogic_vector(7 downto 0);
	fcs            : out std_ulogic_vector(31 downto 0);
        tx_frame_check_sequence    : in t_crc32
        );
  
end entity;

architecture behavioral of crc32_tb is

	constant WAIT_PERIOD : time := 40 ns;
begin
	test_crc32 : process(oldcrc, data, tx_frame_check_sequence)

	begin
          crc            <= update_crc32(oldcrc, data);
          fcs(7 downto 0) <= fcs_output_byte(tx_frame_check_sequence, 0);
          fcs(15 downto 8) <= fcs_output_byte(tx_frame_check_sequence, 1);
          fcs(23 downto 16) <= fcs_output_byte(tx_frame_check_sequence, 2);
          fcs(31 downto 24) <= fcs_output_byte(tx_frame_check_sequence, 3);
	end process;

end architecture;

