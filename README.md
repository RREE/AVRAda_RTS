# AVR-Ada runtime system
Minimal Run Time System (RTS) for AVR 8bit Controllers

## Usage

Edit your `alire.toml` file in your application crate and add the following elements:
- Add `avrada_rts` in the dependency list and set some configuration values,
i.e. the actual MCU in your project and the clock frequency.  The
typical Arduino boards have an atmeg328p running at 16MHz.  The
secondary stack permits some fancy Ada constructs like returning
unconstrained strings or class values.  The generated AVR object code
requires quite some space, however.  The reserved stack space are 63
bytes per default. If you generate bigger objects you can increase the
stack with the configuration value of `Sec_Stack_Size`.
```toml
   [configuration.values]
   avrada_rts.AVR_MCU = "atmega328p"
   avrada_rts.Clock_Frequency = 16000000
   avrada_rts.Sec_Stack_Size = 100
   
   [[depends-on]]
   avrada_rts = "*"
   ```

Then edit your project file to add the following elements:
 - "with" the run-time project file. With this, gprbuild will compile
   the run-time before your application
   ```ada
   with "avrada_rts.gpr";
   ```
 - Specify the `Target` and `Runtime` attributes:
   ```ada
      for Target use "avr";
      for Runtime ("Ada") use AVRAda_RTS'Runtime ("Ada");
   ```

It is highly recommended to also check out the crate
[`AVRAda_MCU`](https://github.com/RREE/AVRAda_MCU).  It contains port
and bit definitions for most MCUs released in the years around 2010 -
2015.  If you use the more modern atxmega or attiny MCUs you currently
(fall 2022) have write you own.

You can control most on-chip peripherals like timers, GPIOs,
AD-converters, etc. with the routines of
[`AVRAda_Lib`](https://github.com/RREE/AVRAda_Lib).  See the examples
in [`AVRAda_Examples`](https://github.com/RREE/AVRAda_Examples).
