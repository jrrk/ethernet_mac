-- This file is part of the ethernet_mac project.
--
-- For the full copyright and license information, please read the
-- LICENSE.md file that was distributed with this source code.

-- Utility functions

library ieee;
use ieee.std_logic_1164.all;

package utility is
	-- Return the reverse of the given vector
	function reverse_vector(vec : in std_ulogic_vector) return std_ulogic_vector;
	-- Extract a byte out of a vector
	function extract_byte(vec : in std_ulogic_vector(47 downto 0); byteno : in std_logic_vector(2 downto 0)) return std_ulogic_vector;
end package;

package body utility is
	function reverse_vector(vec : in std_ulogic_vector) return std_ulogic_vector is
		variable result : std_ulogic_vector(vec'range);
		alias rev_vec   : std_ulogic_vector(vec'reverse_range) is vec;
	begin
		for i in rev_vec'range loop
			result(i) := rev_vec(i);
		end loop;
		return result;
	end function;
	
	function extract_byte(vec : in std_ulogic_vector(47 downto 0); byteno : in std_logic_vector(2 downto 0)) return std_ulogic_vector is
	begin
    case byteno is
      when "000" => return vec(7 downto 0);
      when "001" => return vec(15 downto 8);
      when "010" => return vec(23 downto 16);
      when "011" => return vec(31 downto 24);
      when "100" => return vec(39 downto 32);
      when "101" => return vec(47 downto 40);
      when others => return "00000000";
    end case;
	end function;
	
end package body;