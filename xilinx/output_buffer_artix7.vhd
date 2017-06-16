-- This file is part of the ethernet_mac project.
--
-- For the full copyright and license information, please read the
-- LICENSE.md file that was distributed with this source code.

-- Configurable output buffer forced into the IO block

library ieee;
use ieee.std_logic_1164.all;

library unisim;
use unisim.vcomponents.all;

entity output_buffer is
	port(
		-- Connect to pad or OBUF
		pad_o    : out std_ulogic;
		-- Connect to user logic
		buffer_i : in  std_ulogic;

		-- Capture clock
		clock_i  : in  std_ulogic
	);
end entity;

architecture artix_7 of output_buffer is

begin

	process(clock_i) begin
    if rising_edge(clock_i) then
        pad_o <= buffer_i;
		end if;
	end process;

end architecture;
