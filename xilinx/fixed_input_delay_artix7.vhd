-- This file is part of the ethernet_mac project.
--
-- For the full copyright and license information, please read the
-- LICENSE.md file that was distributed with this source code.

-- Apply a fixed delay to an input pin using IODELAY2

library ieee;
use ieee.std_logic_1164.all;

library unisim;
use unisim.vcomponents.all;

entity fixed_input_delay is
	generic(
		IDELAY_VALUE : natural range 0 to 255 := 0
	);
	port(
		pad_i     : in  std_ulogic;
		delayed_o : out std_ulogic
	);
end entity;

architecture artix_7 of fixed_input_delay is

    signal delayed: std_ulogic;
    
begin
    delayed_o <= delayed;
    
   -- IDELAYE2: Input Fixed or Variable Delay Element
   --           Artix-7
   -- Xilinx HDL Language Template, version 2015.4

   IDELAYE2_inst : IDELAYE2
   generic map (
      CINVCTRL_SEL => "FALSE",          -- Enable dynamic clock inversion (FALSE, TRUE)
      DELAY_SRC => "IDATAIN",           -- Delay input (IDATAIN, DATAIN)
      HIGH_PERFORMANCE_MODE => "FALSE", -- Reduced jitter ("TRUE"), Reduced power ("FALSE")
      IDELAY_TYPE => "FIXED",           -- FIXED, VARIABLE, VAR_LOAD, VAR_LOAD_PIPE
      IDELAY_VALUE => IDELAY_VALUE,     -- Input delay tap setting (0-31)
      PIPE_SEL => "FALSE",              -- Select pipelined mode, FALSE, TRUE
      REFCLK_FREQUENCY => 200.0,        -- IDELAYCTRL clock input frequency in MHz (190.0-210.0, 290.0-310.0).
      SIGNAL_PATTERN => "DATA"          -- DATA, CLOCK input signal
   )
   port map (
      CNTVALUEOUT => open,        -- 5-bit output: Counter value output
      DATAOUT => delayed,         -- 1-bit output: Delayed data output
      C => '0',                   -- 1-bit input: Clock input
      CE => '0',                  -- 1-bit input: Active high enable increment/decrement input
      CINVCTRL => '0',            -- 1-bit input: Dynamic clock inversion input
      CNTVALUEIN => "00000",      -- 5-bit input: Counter value input
      DATAIN => delayed,          -- 1-bit input: Internal delay data input
      IDATAIN => pad_i,           -- 1-bit input: Data input from the I/O
      INC => '0',                 -- 1-bit input: Increment / Decrement tap delay input
      LD => '0',                  -- 1-bit input: Load IDELAY_VALUE input
      LDPIPEEN => '0',            -- 1-bit input: Enable PIPELINE register to load data input
      REGRST => '0'               -- 1-bit input: Active-high reset tap-delay input
   );

end architecture;

