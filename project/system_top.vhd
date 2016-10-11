
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use ieee.numeric_std.all;

entity system_top is
    port(
  ddr_addr : inout std_logic_vector(14 downto 0);
  ddr_ba : inout std_logic_vector(2 downto 0);
  ddr_cas_n : inout std_logic;
  ddr_ck_n : inout std_logic;
  ddr_ck_p : inout std_logic;
  ddr_cke : inout std_logic;
  ddr_cs_n : inout std_logic;
  ddr_dm : inout std_logic_vector(3 downto 0);
  ddr_dq : inout std_logic_vector(31 downto 0);
  ddr_dqs_n : inout std_logic_vector(3 downto 0);
  ddr_dqs_p : inout std_logic_vector(3 downto 0);
  ddr_odt : inout std_logic;
  ddr_ras_n : inout std_logic;
  ddr_reset_n : inout std_logic;
  ddr_we_n : inout std_logic;

  fixed_io_ddr_vrn : inout std_logic;
  fixed_io_ddr_vrp : inout std_logic;
  fixed_io_mio : inout std_logic_vector(53 downto 0);
  fixed_io_ps_clk : inout std_logic;
  fixed_io_ps_porb : inout std_logic;
  fixed_io_ps_srstb :inout std_logic;

  gpio_bd : inout std_logic_vector(31 downto 0);
  otg_vbusoc : in std_logic);
end system_top;

architecture RTL of system_top is
	component system_wrapper
	  port (
	    ddr_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
	    ddr_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
	    ddr_cas_n : inout STD_LOGIC;
	    ddr_ck_n : inout STD_LOGIC;
	    ddr_ck_p : inout STD_LOGIC;
	    ddr_cke : inout STD_LOGIC;
	    ddr_cs_n : inout STD_LOGIC;
	    ddr_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
	    ddr_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
	    ddr_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
	    ddr_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
	    ddr_odt : inout STD_LOGIC;
	    ddr_ras_n : inout STD_LOGIC;
	    ddr_reset_n : inout STD_LOGIC;
	    ddr_we_n : inout STD_LOGIC;
	    fixed_io_ddr_vrn : inout STD_LOGIC;
	    fixed_io_ddr_vrp : inout STD_LOGIC;
	    fixed_io_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
	    fixed_io_ps_clk : inout STD_LOGIC;
	    fixed_io_ps_porb : inout STD_LOGIC;
	    fixed_io_ps_srstb : inout STD_LOGIC;
	    gpio_i : in STD_LOGIC_VECTOR ( 63 downto 0 );
	    gpio_o : out STD_LOGIC_VECTOR ( 63 downto 0 );
	    gpio_t : out STD_LOGIC_VECTOR ( 63 downto 0 );
	    hdl_clk : out STD_LOGIC;
	    otg_vbusoc : in STD_LOGIC;
	    ps_intr_00 : in STD_LOGIC;
	    ps_intr_01 : in STD_LOGIC;
	    ps_intr_02 : in STD_LOGIC;
	    ps_intr_03 : in STD_LOGIC;
	    ps_intr_04 : in STD_LOGIC;
	    ps_intr_05 : in STD_LOGIC;
	    ps_intr_06 : in STD_LOGIC;
	    ps_intr_07 : in STD_LOGIC;
	    ps_intr_08 : in STD_LOGIC;
	    ps_intr_09 : in STD_LOGIC;
	    ps_intr_10 : in STD_LOGIC;
	    ps_intr_11 : in STD_LOGIC;
	    ps_intr_12 : in STD_LOGIC;
	    ps_intr_13 : in STD_LOGIC;
	    ps_intr_14 : in STD_LOGIC;
	    ps_intr_15 : in STD_LOGIC
	  );
	end component;

	constant DATA_WIDTH : integer := 32;
	
	signal gpio_i : std_logic_vector(63 downto 0);
	signal gpio_o : std_logic_vector(63 downto 0);
	signal gpio_t : std_logic_vector(63 downto 0);
	signal ps_intr : std_logic_vector(15 downto 0);
	signal hdl_clk : std_logic;
begin
	
	IOBUF_GEN: for i in 0 to DATA_WIDTH-1 generate
		gpio_i(i) <= gpio_bd(i);
		gpio_bd(i) <= 'Z' when gpio_t(i) = '1' else gpio_o(i);
	end generate IOBUF_GEN;

	system_uut : system_wrapper
		port map(
		    ddr_addr => ddr_addr,
		    ddr_ba => ddr_ba,
		    ddr_cas_n => ddr_cas_n,
		    ddr_ck_n => ddr_ck_n,
		    ddr_ck_p => ddr_ck_p,
		    ddr_cke => ddr_cke,
		    ddr_cs_n => ddr_cs_n,
		    ddr_dm => ddr_dm,
		    ddr_dq => ddr_dq,
		    ddr_dqs_n => ddr_dqs_n,
		    ddr_dqs_p => ddr_dqs_p,
		    ddr_odt => ddr_odt,
		    ddr_ras_n => ddr_ras_n,
		    ddr_reset_n => ddr_reset_n,
		    ddr_we_n => ddr_we_n,
		    fixed_io_ddr_vrn => fixed_io_ddr_vrn,
		    fixed_io_ddr_vrp => fixed_io_ddr_vrp,
		    fixed_io_mio => fixed_io_mio,
		    fixed_io_ps_clk => fixed_io_ps_clk,
		    fixed_io_ps_porb => fixed_io_ps_porb,
		    fixed_io_ps_srstb => fixed_io_ps_srstb,
		    gpio_i => gpio_i,
		    gpio_o => gpio_o,
		    gpio_t => gpio_t,
		    hdl_clk => hdl_clk,
		    otg_vbusoc => otg_vbusoc,
		    ps_intr_00 => ps_intr(0),
		    ps_intr_01 => ps_intr(1),
		    ps_intr_02 => ps_intr(2),
		    ps_intr_03 => ps_intr(3),
		    ps_intr_04 => ps_intr(4),
		    ps_intr_05 => ps_intr(5),
		    ps_intr_06 => ps_intr(6),
		    ps_intr_07 => ps_intr(7),
		    ps_intr_08 => ps_intr(8),
		    ps_intr_09 => ps_intr(9),
		    ps_intr_10 => ps_intr(10),
		    ps_intr_11 => ps_intr(11),
		    ps_intr_12 => ps_intr(12),
		    ps_intr_13 => ps_intr(13),
		    ps_intr_14 => ps_intr(14),
		    ps_intr_15 => ps_intr(15));

end architecture;
