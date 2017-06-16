-- This file is part of the ethernet_mac project.
--
-- For the full copyright and license information, please read the
-- LICENSE.md file that was distributed with this source code.

-- Configurable input buffer forced into the IO block

library ieee;
use ieee.std_logic_1164.all;

library unisim;
use unisim.vcomponents.all;

entity input_buffer is
	generic(
		-- If TRUE, fixed_input_delay is inserted between the pad and the flip-flop
		HAS_DELAY    : boolean                := FALSE;
		IDELAY_VALUE : natural range 0 to 255 := 0
	);
	port(
		-- Connect to pad or IBUF
		pad_i    : in  std_ulogic;
		-- Connect to user logic
		buffer_o : out std_ulogic;

		-- Capture clock
		clock_i  : in  std_ulogic
	);
end entity;

architecture artix_7 of input_buffer is

begin

	process(clock_i) begin
    if rising_edge(clock_i) then
        buffer_o <= pad_i;
		end if;
	end process;

end architecture;
