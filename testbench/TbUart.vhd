--
--  File Name:         TbUart.vhd
--  Design Unit Name:  TbUart
--  OSVVM Release:     OSVVM MODELS STANDARD VERSION
--
--  Maintainer:        Jim Lewis      email:  jim@synthworks.com
--  Contributor(s):
--     Jim Lewis      jim@synthworks.com
--
--
--  Description:
--    Testbench that connects UartTx and UartRx
--
--
--  Developed by:
--        SynthWorks Design Inc.
--        VHDL Training Classes
--        http://www.SynthWorks.com
--
--  Revision History:
--    Date      Version    Description
--    1999      1999.00    Developed for SynthWorks' Advanced VHDL Testbenches and Verification Class
--    05/2019   2019.05    Updated for OSVVM public release
--    01/2020   2020.01    Updated license notice
--
--
--  This file is part of OSVVM.
--
--  Copyright (c) 1999 - 2020 by SynthWorks Design Inc.
--
--  Licensed under the Apache License, Version 2.0 (the "License");
--  you may not use this file except in compliance with the License.
--  You may obtain a copy of the License at
--
--      https://www.apache.org/licenses/LICENSE-2.0
--
--  Unless required by applicable law or agreed to in writing, software
--  distributed under the License is distributed on an "AS IS" BASIS,
--  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--  See the License for the specific language governing permissions and
--  limitations under the License.
--

library ieee ;
  use ieee.std_logic_1164.all ;
  use ieee.numeric_std.all ;

  use std.textio.all ;

library osvvm ;
  context osvvm.OsvvmContext ;

  library osvvm_uart ;
  context osvvm_uart.UartContext ;

entity TbUart is 
end TbUart ;

architecture TestHarness of TbUart is

  constant tpd          : time := 2 ns ;

  -- Uart Interface
  signal SerialData     : std_logic ;

  ------------------------------------------------------------
  component TestCtrl 
  -- Stimulus generation and synchronization
  ------------------------------------------------------------
  port (
    UartTxRec          : InOut UartRecType ;
    UartRxRec          : InOut UartRecType
  ) ;
  end component ;

  signal UartTxRec           : UartRecType ;
  signal UartRxRec           : UartRecType ;



begin

  ------------------------------------------------------------
  UartTx_1 : UartTx 
  ------------------------------------------------------------
  generic map (
    DEFAULT_BAUD        => UART_BAUD_PERIOD_115200
  )
  port map (
    TransRec            => UartTxRec,
    SerialDataOut       => SerialData   
  ) ;


  ------------------------------------------------------------
  UartRx_1 : UartRx 
  ------------------------------------------------------------
  generic map (
    DEFAULT_BAUD        => UART_BAUD_PERIOD_115200
  )
  port map (
    TransRec            => UartRxRec,
    SerialDataIn        => SerialData 
  ) ;


  ------------------------------------------------------------
  TestCtrl_1 : TestCtrl 
  -- Stimulus generation and synchronization
  ------------------------------------------------------------
  port map (
    UartTxRec             => UartTxRec,
    UartRxRec             => UartRxRec
  ) ;

end TestHarness ;