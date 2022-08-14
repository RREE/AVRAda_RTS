# AVR-Ada runtime system
Minimal run time system (RTS) for AVR 8bit controllers

## Usage

First edit you `alire.toml` file and add the following elements:
 - Add `avrada_rts` in the dependency list:
   ```toml
   [[depends-on]]
   avrada_rts = "*"
   ```
 - Set the AVR architecture, we use avr5 as an example here as it is
   the architecture of the original Arduino board:
   ```toml
   [gpr-set-externals]
   ARCH = "avr5"
   ```

Then edit your project file to add the following elements:
 - "with" the run-time project file. With this, gprbuild will compile the run-time before your application
   ```ada
   with "avrada_rts.gpr";
   ```
 - Specify the `Target` and `Runtime` attributes:
   ```ada
      for Target use "avr";
      for Runtime ("Ada") use AVRAda_RTS'Runtime ("Ada");
   ```
