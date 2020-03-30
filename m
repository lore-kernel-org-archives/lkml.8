Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB510C2D0E9
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 10:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A2B72072E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 10:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585565128;
	bh=aALAEY1iuBvxD0fduvCRnitAjm3jmYW16Yvf6OK/WwY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=I97wkI9zUUYi0h7fZd+kQqCcYmQzQLJN3J6r+AZ1MjbnIWvlKw/GPOoJuLPMwUptn
	 cNaF3FGHaE9qVmAoI+yYpjAeVSTNdOIPWQrmrsHSlMxlDG+CeavdKm2UpF43tNZnaK
	 LYcVnWsyotkToBo7kJm3ABNoPGKs5VeFyHa5aaXw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbgC3Kp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 06:45:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:49920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729095AbgC3Kp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 06:45:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B828220716;
        Mon, 30 Mar 2020 10:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585565122;
        bh=aALAEY1iuBvxD0fduvCRnitAjm3jmYW16Yvf6OK/WwY=;
        h=Date:From:To:Cc:Subject:From;
        b=u390IJoNin0ujOZZefpkYKoxGa1o1izBCtPDbiAl6blgkRqKzJ1g20ZoAjNCT+5H5
         13n/YeLY2H73ldvbgcg4vr8dL79qlO2kL4oIMBxed/+yZwfaPiQFFtaVjgrHzH/i94
         yZmFmpjeTfxXUMQ6VoEILldf3dOhzZCzXHoFvQBg=
Date:   Mon, 30 Mar 2020 12:45:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Staging/IIO driver patches for 5.7-rc1
Message-ID: <20200330104519.GA739551@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 16fbf79b0f83bc752cee8589279f1ebfe57b3b6e:

  Linux 5.6-rc7 (2020-03-22 18:31:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.7-rc1

for you to fetch changes up to e681bb287f40e7a9dbcb04cef80fd87a2511ab86:

  staging: vt6656: Use DIV_ROUND_UP macro instead of specific code (2020-03-27 10:05:52 +0100)

----------------------------------------------------------------
Staging/IIO driver patches for 5.7-rc1

Here is the big staging and IIO driver pull request for 5.7-rc1.

We again end up deleting more code than we added here, thanks to finally
getting rid of the old and obsolete wireless USB stuff, and the exfat
code (which is coming in again through the vfs tree in a much cleaner
version).  But some code does come back, with the octeon drivers being
found to actually be used in the wild, so those deletions are now
reverted.

Other than those major things, just loads and loads of tiny checkpatch
cleanups all over the place, along with new IIO drivers and fixes.

All have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Ajay Singh (21):
      staging: wilc1000: refactor SPI read/write commands handling API's
      staging: wilc1000: remove use of vendor specific IE for p2p handling
      staging: wilc1000: directly fetch 'priv' handler from 'vif' instance
      staging: wilc1000: refactor p2p action frames handling API's
      staging: wilc1000: make use of FIELD_GET/_PREP macro
      staging: wilc1000: remove use of MAX_NUN_INT_THRPT_ENH2 macro
      staging: wilc1000: refactor interrupt handling for sdio
      staging: wilc1000: make use of ALIGN macro
      staging: wilc1000: use commmon function to set SDIO block size
      staging: wilc1000: define macros for different register address for SDIO
      staging: wilc1000: use short name for hif local variable in chip_wakeup()
      staging: wilc1000: define macros to replace magic number values
      staging: wilc1000: avoid double unlocking of 'wilc->hif_cs' mutex
      staging: wilc1000: use YAML schemas for DT binding documentation
      staging: wilc1000: use correct data for memcpy in wilc_hif_pack_sta_param()
      staging: wilc1000: remove unnecessary always true 'if' conditions
      staging: wilc1000: use flexible-array member instead of zero-length array
      staging: wilc1000: use 'interrupts' property instead of 'irq-gpio'
      staging: wilc1000: modified 'clock-names' and 'compatible' property
      staging: wilc1000: updated DT binding documentation
      staging: wilc1000: remove label from examples in DT binding documentation

Alexandru Ardelean (11):
      iio: imu: adis16480: initialize adis_data statically
      iio: imu: adis16400: initialize adis_data statically
      iio: gyro: adis16136: initialize adis_data statically
      iio: imu: adis: add unlocked __adis_initial_startup()
      iio: imu: adis: add support product ID check in adis_initial_startup
      iio: imu: adis: add doc-string for 'adis' struct
      iio: imu: adis: update 'adis_data' struct doc-string
      iio: imu: adis: add a note better explaining state_lock
      iio: potentiostat: lmp9100: fix iio_triggered_buffer_{predisable,postenable} positions
      iio: light: gp2ap020a00f: fix iio_triggered_buffer_{predisable,postenable} positions
      iio: dac: Kconfig: sort symbols alphabetically

Alexandru Tachici (9):
      iio: adc: ad7124: add 3db filter
      staging: iio: adc: ad7192: fail probe on get_voltage
      staging: iio: adc: ad7192: modify iio_chan_spec array
      staging: iio: adc: ad7192: removed spi_device_id
      Documentation: ABI: testing: ad7192: update sysfs docs
      staging: iio: adc: ad7192: move out of staging
      iio: dac: ad5770r: Add AD5770R support
      dt-bindings: iio: dac: Add docs for AD5770R DAC
      iio: industrialio-core: Fix debugfs read

Andre Pinto (1):
      staging: rtl8188eu: fix typo s/informations/information

Andreas Klinger (2):
      dt-bindings: devantech-srf04.yaml: add pm feature
      iio: srf04: add power management feature

Andy Shevchenko (1):
      iio: accel: st_accel: Use st_sensors_dev_name_probe()

Beniamin Bia (3):
      iio: core: Handle 'dB' suffix in core
      iio: amplifiers: ad8366: Add write_raw_get_fmt function
      MAINTAINERS: add entry for hmc425a driver.

Briana Oursler (1):
      staging: vt6655: Break up function call with long line.

Camylla Goncalves Cantanheide (3):
      staging: rtl8192u: Replaces symbolic permissions with octal permissions
      staging: rtl8192u: Using function name as string
      staging: rtl8192u: Corrects 'Avoid CamelCase' for variables

Carlos Henrique Lima Melara (1):
      staging: qlge: Fix WARNING: Missing a blank line after declarations

Chris Packham (6):
      Revert "staging: octeon-usb: delete the octeon usb host controller driver"
      Revert "staging: octeon: delete driver"
      MIPS: octeon: remove typedef declaration for cvmx_wqe
      MIPS: octeon: remove typedef declaration for cvmx_helper_link_info
      MIPS: octeon: remove typedef declaration for cvmx_pko_command_word0
      Revert "staging/octeon: Mark Ethernet driver as BROKEN"

Christian Gromm (3):
      staging: most: move core files out of the staging area
      staging: most: Documentation: update ABI description
      staging: most: Documentation: move ABI description files out of staging area

Colin Ian King (7):
      iio: ad5755: fix spelling mistake "to" -> "too" and grammar plus formatting
      iio: st_sensors: handle memory allocation failure to fix null pointer dereference
      staging: rtl8192e: remove redundant initialization of variable init_status
      staging: rtl8723bs: remove temporary variable CrystalCap
      staging: rtl8188eu: remove redundant assignment to cond
      staging: rtl8723bs: core: remove redundant zero'ing of counter variable k
      staging: speakup: remove redundant initialization of pointer p_key

Dan Carpenter (1):
      staging: kpc2000: prevent underflow in cpld_reconfigure()

Daniel Junho (1):
      dt-bindings: iio: adc: ad7923: Add binding documentation for AD7928

David Heidelberg (7):
      dt-bindings: iio: light: add support for Dyna-Image AL3320A
      dt-bindings: iio: light: add support for Dyna-Image AL3010
      iio: light: al3320a slightly improve code formatting
      iio: light: add Dyna-Image AL3010 driver
      iio: light: al3320a implement suspend support
      iio: light: al3320a implement devm_add_action_or_reset
      iio: light: al3320a allow module autoload and polish

Deepak R Varma (15):
      staging: comedi: dt282x: remove old unused code
      staging: comedi: ni_tio: Reformat function call arguments
      staging: comedi: rtd520: Resolve multiline dereference
      staging: comedi: s626: Reformat function arguments
      staging: comedi: ni_mio_common: Code reformat and re-indentation
      staging: comedi: ni_atmio16d: remove commented code blocks
      staging: comedi: dt3000: Reformat multiple line dereference
      staging: fbtft: Reformat line over 80 characters
      staging: fbtft: Reformat long macro definitions
      staging: fbtft: simplify array index computation
      staging: fbtft: Avoid potential precedence issues
      staging: media: imgu: Remove extra type detail
      staging: iio: adc: ad7192: Re-indent enum labels
      staging: iio: adc: ad7280a: Add comments to clarify stringified arguments
      staging: comedi: ni_labpc_common: Reformat multiple line dereference

Derek Robson (1):
      staging: rtl8192e: style fix - Prefer using '"%s...", __func__'

Fabrice Gasnier (6):
      dt-bindings: iio: adc: stm32-adc: convert bindings to json-schema
      counter: stm32-timer-cnt: add power management support
      counter: stm32-timer-cnt: remove iio headers
      iio: trigger: stm32-timer: enable clock when in master mode
      iio: trigger: stm32-timer: rename enabled flag
      iio: trigger: stm32-timer: add power management support

Geert Uytterhoeven (3):
      staging: pi433: overlay: Fix Broadcom vendor prefix
      staging: pi433: overlay: Fix reg-related warnings
      staging: pi433: overlay: Convert to sugar syntax

George Spelvin (1):
      staging: wilc1000: Use crc7 in lib/ rather than a private copy

Gokce Kuler (3):
      staging: wilc1000: rearrange line exceeding 80 characters
      staging: rtl8712: Remove unnecessary braces
      staging: mt7621-dma: quoted string split across lines

Greg Kroah-Hartman (6):
      Staging: remove wusbcore and UWB from the kernel tree.
      Merge 5.6-rc3 into staging-next
      staging: exfat: remove staging version of exfat filesystem
      Merge tag 'iio-5.7a' of git://git.kernel.org/.../jic23/iio into staging-next
      Merge 5.6-rc7 into staging-next
      staging: remove hp100 driver

Gregor Riepl (1):
      iio: light: Simplify the current to lux LUT

Guido Günther (2):
      iio: vcnl4000: Use a single return when getting IIO_CHAN_INFO_RAW
      iio: vcnl4000: Enable runtime pm for vcnl4200/4040

Gustavo A. R. Silva (3):
      staging: unisys: visorinput: Replace zero-length array with flexible-array member
      staging: greybus: Replace zero-length array with flexible-array member
      staging: Replace zero-length array with flexible-array member

Ian Abbott (4):
      staging: comedi: ni_routes: Refactor ni_find_valid_routes()
      staging: comedi: ni_routes: Allow alternate board name for routes
      staging: comedi: ni_mio_common: Allow alternate board name for routes
      staging: comedi: ni_pcimio: add routes for NI PCIe-6251 and PCIe-6259

Jean-Baptiste Maneyrol (20):
      iio: imu: inv_mpu6050: cleanup of/acpi support
      iio: imu: inv_mpu6050: add support of ICM20609 & ICM20689
      iio: imu: inv_mpu6050: add support of IAM20680
      iio: imu: inv_mpu6050: add support of ICM20690
      iio: imu: inv_mpu6050: update LPF bandwidth settings
      dt-bindings: add description for new supported chips
      iio: imu: inv_mpu6050: enable i2c aux mux bypass only once
      iio: imu: inv_mpu6050: delete useless check
      iio: imu: inv_mpu6050: set power on/off only once during all init
      iio: imu: inv_mpu6050: simplify polling magnetometer
      iio: imu: inv_mpu6050: early init of chip_config for use at setup
      iio: imu: inv_mpu6050: add all signal path resets at init
      iio: imu: inv_mpu6050: reduce sleep time when turning regulators on
      iio: imu: inv_mpu6050: rewrite power and engine management
      iio: imu: inv_mpu6050: fix data polling interface
      iio: imu: inv_mpu6050: factorize fifo enable/disable
      iio: imu: inv_mpu6050: dynamic sampling rate change
      iio: imu: inv_mpu6050: use runtime pm with autosuspend
      iio: imu: inv_mpu6050: temperature only work with accel/gyro
      iio: pressure: icp10100: add driver for InvenSense ICP-101xx

JieunKim (2):
      staging: exfat: Replace printk with pr_info
      iio: imu: st_lsm6dsx: Fix mismatched comments

John B. Wyatt IV (2):
      staging: wlan-ng: Fix line going over 80 characters
      staging: wlan-ng: Fix third argument going over 80 characters

Jonathan Cameron (1):
      dt-bindings: iio: adc: max1363 etc i2c ADC binding conversion

Kaaira Gupta (20):
      staging: gasket: unify multi-line string
      staging: exfat: remove exfat_fat_sync()
      staging: qlge: add braces on all arms of if-else
      staging: qlge: add braces around macro arguments
      staging: qlge: emit debug and dump at same level
      staging: octeon: add space around '+' and parentheses
      staging: octeon: add blank line after union
      staging: octeon: match parentheses alignment
      staging: exfat: remove sync_alloc_bitmap()
      staging: exfat: remove exfat_buf_sync()
      staging: wfx: data_rx.c: remove space after cast
      staging: wfx: change 1 to bool
      staging: wfx: dat_tx.c: remove space after a cast
      staging: wfx: data_tx.h: remove space after cast
      staging: wfx: remove variable declaration
      staging: wfx: remove unused structure
      staging: media: allegro: align with parenthesis
      staging: media: imx: remove temporary variable
      staging: media: imx: remove parentheses
      staging: media: hantro: remove parentheses

Larry Finger (1):
      staging: rtl8188eu: Add ASUS USB-N10 Nano B1 to device table

Linus Walleij (2):
      iio: light: Add DT bindings for GP2AP002
      iio: light: Add a driver for Sharp GP2AP002x00F

Lorenzo Bianconi (1):
      iio: imu: st_lsm6dsx: check return value from st_lsm6dsx_sensor_set_enable

Lourdes Pedrajas (12):
      staging: greybus: i2c.c: remove commented out function
      staging: exfat: exfat_super.c: remove commented out function
      staging: hp: remove commented out code
      staging: vt6655: power.c: Remove setting ATIM Window in PSvEnablePowerSaving()
      staging: vt6655: power.c: code reformatting for improved readability
      staging: greybus: i2c: remove unused pointers
      staging: wfx: remove unneeded spaces
      staging: qlge: qlge_dbg: remove unneeded spaces
      staging: qlge: qlge_main: remove unused code
      staging: speakup: main: switch multiple assignment for one assignment per line
      staging: rtl8192u: r8192U_wx: use netdev_warn() instead of printk()
      staging: gdm724x: use netdev_err() instead of pr_err()

Lukasz Szczesny (1):
      staging: rtl8723bs: Fix spacing issues

Malcolm Priestley (13):
      staging: vt6656: Disable and remove fall back rates from driver.
      staging: vt6656: Fix return for unsupported cipher modes.
      staging: vt6656: Remove fall back functions and headers.
      staging: vt6656: Use mac80211 duration for tx headers
      staging: vt6656: Remove STATUS enums from TX path
      staging: vt6656: use vnt_vt3184_agc array directly
      staging: vt6656: vnt_vt3184_init remove stack copy to array.
      staging: vt6656: vnt_int_start_interrupt remove spin lock.
      staging: vt6656: Remove function vnt_int_process_data.
      staging: vt6656: Delete int.c/h file and move functions to usbpipe
      staging: vt6656: Move vnt_rx_data to usbpipe.c
      staging: vt6656: Remove vnt_interrupt_buffer in_use flag.
      staging: vt6656: struct vnt_rcb remove unused in_use.

Marcelo Diop-Gonzalez (6):
      staging: vc04_services: remove unused function
      staging: vc04_services: remove unneeded parentheses
      staging: vc04_services: fix indentation alignment in a few places
      staging: vc04_services: use kref + RCU to reference count services
      staging: vc04_services: don't increment service refcount when it's not needed
      staging: vc04_services: Fix wrong early return in next_service_by_instance()

Marek Szyprowski (1):
      iio: adc: exynos: Silence warning about regulators during deferred probe

Matt Ranostay (3):
      iio: chemical: atlas-sensor: allow probe without interrupt line
      iio: chemical: atlas-sensor: add DO-SM module support
      dt-bindings: iio: chemical: consolidate atlas-sensor docs

Maxime Roussin-Bélanger (1):
      iio: si1133: read 24-bit signed integer for measurement

Michael Hennerich (2):
      iio: amplifiers: hmc425a: Add support for HMC425A attenuator
      dt-bindings: iio: amplifiers: Add docs for HMC425A Step Attenuator

Michael Straube (4):
      staging: rtl8188eu: remove unnecessary RETURN label
      staging: rtl8188eu: rename variable pnetdev -> netdev
      staging: rtl8188eu: remove some 5 GHz code
      staging: rtl8188eu: cleanup long line in odm.c

Michał Mirosław (6):
      staging: wfx: fix init/remove vs IRQ race
      staging: wfx: annotate nested gc_list vs tx queue locking
      staging: wfx: add proper "compatible" string
      staging: wfx: follow compatible = vendor,chip format
      staging: wfx: use sleeping gpio accessors
      staging: wfx: use more power-efficient sleep for reset

Mircea Caprioru (1):
      iio: adc: ad7124: Add direct reg access

Mohana Datta Yelugoti (2):
      staging: qlge: remove spaces at the start of a line
      staging: qlge: qlge_main.c: fix style issues

Nicolas Saenz Julienne (21):
      staging: vc04_services: Remove unused variables in struct vchiq_arm_state
      staging: vc04_services: Get rid of resume_blocked in struct vchiq_arm_state
      staging: vc04_services: Get rid of resume_blocker completion in struct vchiq_arm_state
      staging: vc04_services: get rid of blocked_blocker completion in struct vchiq_arm_state
      staging: vc04_services: Delete blocked_count in struct vchiq_arm_state
      staging: vc04_services: get rid of vchiq_platform_use_suspend_timer()
      staging: vc04_services: Get rid of vchiq_platform_paused/resumed()
      staging: vc04_services: Get rid of vchiq_platform_suspend/resume()
      staging: vc04_services: Get rid of vchiq_platform_videocore_wanted()
      staging: vc04_services: Get rid of vchiq_platform_handle_timeout()
      staging: vc04_services: Get rid of vchiq_on_remote_use_active()
      staging: vc04_services: Get rid of vchiq_arm_vcsuspend()
      staging: vc04_services: Get rid of vchiq_check_resume()
      staging: vc04_services: Delete vc_suspend_complete completion
      staging: vc04_services: Get rid of unused suspend/resume states
      staging: vc04_services: Get of even more suspend/resume states
      staging: vc04_services: Get rid of the rest of suspend/resume state handling
      staging: vc04_services: Get rid of USE_TYPE_SERVICE_NO_RESUME
      staging: vc04_services: Delete vchiq_platform_check_suspend()
      staging: vc04_services: Get rid of vchiq_arm_vcresume()'s signature
      staging: vc04_services: vchiq_arm: Get rid of unused defines

Nishad Kamdar (2):
      staging: netlogic: Use the correct style for SPDX License Identifier
      staging: pi433: Use the correct style for SPDX License Identifier

Nuno Sá (4):
      iio: imu: adis: Add self_test_reg variable
      iio: imu: adis: Refactor adis_initial_startup
      iio: adis16480: Make use of __adis_initial_startup
      iio: adis16460: Make use of __adis_initial_startup

Oscar Carter (6):
      staging: vt6656: Remove unnecessary local variables initialization
      staging: vt6656: Use BIT_ULL() macro instead of bit shift operation
      staging: vt6656: Use ARRAY_SIZE instead of hardcoded size
      staging: vt6656: Use BIT() macro instead of hex value
      staging: vt6656: Use BIT() macro in vnt_mac_reg_bits_* functions
      staging: vt6656: Use DIV_ROUND_UP macro instead of specific code

Payal Kshirsagar (15):
      staging: vt6656: remove blank line
      staging: vt6655: alignment should match open parenthesis
      staging: qlge: remove blank line
      staging: qlge: qlge.h: remove spaces before tabs and align code
      staging: qlge: qlge.h: add spaces around operators
      staging: qlge: qlge.h: remove excess newlines
      staging: wfx: alignment should match open parenthesis
      staging: wfx: remove blank line
      staging: ks7010: remove line over 80 characters
      staging: exfat: alignment should match open parenthesis
      staging: qlge: qlge_main.c: remove an unneeded variable
      staging: qlge: qlge_mpi.c: remove an unneeded variable
      staging: qlge: qlge_dbg.c: remove an unneeded variable
      staging: qlge: qlge_ethtool.c: remove an unneeded variable
      staging: rtl8723bs: remove unneeded variables

Pragat Pandya (16):
      staging: exfat: Remove unused struct 'part_info_t'
      staging: exfat: Remove unused struct 'dev_info_t'
      staging: exfat: Rename variable 'Year' to 'year'
      staging: exfat: Rename variable 'Month' to 'month'
      staging: exfat: Rename variable 'Day' to 'day'
      staging: exfat: Rename variable 'Hour' to 'hour'
      staging: exfat: Rename variable 'Minute' to 'minute'
      staging: exfat: Rename variable 'Second' to 'second'
      staging: exfat: Rename variable 'MilliSecond' to 'millisecond'
      staging: exfat: Rename variable 'Name' to 'name'
      staging: exfat: Rename variable 'ShortName' to 'short_name'
      staging: exfat: Rename variable 'Attr' to 'attr'
      staging: exfat: Rename variable 'NumSubdirs' to 'num_subdirs'
      staging: exfat: Rename variable 'CreateTimestamp' to 'create_timestamp'
      staging: exfat: Rename variable 'ModifyTimestamp' to 'modify_timestamp'
      staging: exfat: Rename variable 'AccessTimestamp' to 'access_timestamp'

Qiujun Huang (2):
      staging: wlan-ng: fix ODEBUG bug in prism2sta_disconnect_usb
      staging: wlan-ng: fix use-after-free Read in hfa384x_usbin_callback

R Veera Kumar (19):
      staging: rtl8712: Fixes for simple typos in C comments
      staging: unisys: Documentation: Correct a long line in doc
      staging: rtl8712: Correct a typo in a comment
      staging: rtl8192u: ieee80211: Correct a typo in a comment
      staging: rtl8188eu: include: Correct a typo in a comment
      staging: rtl8188eu: core: Correct a typo in a comment
      staging: rtl8712: Fix for long lines in Kconfig help
      staging: sm750fb: Fix of long line in makefile variable
      staging: rts5208: shorten long line in func call
      staging: rtl8723bs: os_dep: Correct typo in comments
      staging: rtl8723bs: hal: Correct multi-line comments as per coding style
      staging: rtl8723bs: hal: Correct typos in comments
      staging: vc04_services: interface: vchi: Correct long line comments and make them C89 style
      staging: rtl8723bs: os_dep: Remove commented out code lines
      staging: rtl8723bs: os_dep: Correct long line comments
      staging: rtl8723bs: os_dep: Remove whitespace characters in code line
      staging: rtl8723bs: core: Correct typos in comments
      staging: rtl8723bs: os_dep: Correct typos in comments
      staging: rtl8723bs: hal: Correct typos in comments

Rohit Sarkar (2):
      staging: iio: update TODO
      iio: add a TODO

Sam Muhammed (16):
      Staging: qlge: Add a blank line after variable
      Staging: hp: Use netdev_warn().
      Staging: speakup: Use pr_warn() defined in <linux/printk.h>.
      Staging: speakup: Use sizeof(*var) in kmalloc().
      Staging: speakup: Add identifier name to function declaration arguments.
      Staging: kpc2000: kpc_dma: Remove comparison to NULL.
      Staging: kpc2000: kpc_dma: Use sizeof(*var) in kzalloc().
      Staging: kpc2000: kpc_dma: Remove unnecessary braces.
      Staging: kpc2000: kpc_dma: Include the preferred header.
      Staging: kpc2000: kpc_dma: Use the SPDK comment style.
      Staging: kpc2000: kpc_dma: Use kcalloc over kzalloc.
      Staging: kpc2000: kpc_dma: Use spaces around operators.
      Staging: rtl8192u: ieee80211: Use netdev_dbg() for debug messages.
      Staging: rtl8192u: ieee80211: Use netdev_warn() for network devices.
      Staging: rtl8192u: ieee80211: Use netdev_info() with network devices.
      Staging: rtl8192u: ieee80211: Use netdev_alert().

Sandesh Kenjana Ashok (1):
      staging: fsl-dpaa2: ethsw: ethsw.c: Fix line over 80 characters

Saurav Girepunje (1):
      staging: rtl8723bs: hal: fix condition with no effect

Sergio Paracuellos (24):
      staging: mt7621-pci: simplify 'mt7621_pcie_init_virtual_bridges' function
      staging: mt7621-pci: enable clock bit for each port
      staging: mt7621-pci: use gpios for properly reset
      staging: mt7621-pci: change value for 'PERST_DELAY_MS'
      staging: mt7621-dts: make use of 'reset-gpios' property for pci
      staging: mt7621-pci: bindings: update doc accordly to last changes
      staging: mt7621-pci: release gpios after pci initialization
      staging: mt7621-pci: delete no more needed 'mt7621_reset_port'
      staging: mt7621-pci-phy: add 'mt7621_phy_rmw' to simplify code
      staging: mt7621-pci: fix io space and properly set resource limits
      staging: mt7621-pci: fix register to set up virtual bridges
      staging: mt7621-pci: don't return if get gpio fails
      staging: mt7621-pci-phy: avoid to create to different phys for a dual port one
      staging: mt7621-dts: set up only two pcie phys
      staging: mt7621-pci: use only two phys from device tree
      staging: mt7621-pci: change variable to print for slot
      staging: mt7621-pci: be sure gpio descriptor is null on fails
      staging: mt7621-pci: avoid to poweroff the phy for slot one
      staging: mt7621-dts: gpio 8 and 9 are vendor specific
      staging: mt7621-pci: delete release gpios related code
      staging: mt7621-pci: use builtin_platform_driver()
      staging: mt7621-pci-phy: use builtin_platform_driver()
      staging: mt7621-pci-phy: re-do 'xtal_mode' detection
      staging: mt7621-pci: avoid to set 'iomem_resource' addresses

Sergiu Cuciurean (8):
      iio: amplifiers: ad8366: add support for HMC1119 Attenuator
      iio: adc: ad9292: Use new structure for SPI transfer delays
      iio: adc: max1118: Use new structure for SPI transfer delays
      iio: adc: mcp320x: Use new structure for SPI transfer delays
      iio: adc: ti-tlc4541: Use new structure for SPI transfer delays
      iio: imu: adis_buffer: Use new structure for SPI transfer delays
      staging: kpc2000: kpc2000_spi: Use new structure for SPI transfer delays
      staging: wilc1000: spi: Use new structure for SPI transfer delays

Shreeya Patel (7):
      Staging: rtl8723bs: Remove comparison to true
      Staging: rtl8188eu: Add space around operator
      Staging: rtl8188eu: rtw_mlme: Add space around operators
      Staging: rtl8723bs: rtw_mlme: Remove unnecessary conditions
      Staging: rtl8723bs: sdio_halinit: Remove unnecessary conditions
      Staging: wilc1000: cfg80211: Use kmemdup instead of kmalloc and memcpy
      Staging: rtl8188eu: hal: Add space around operators

Simon Fong (1):
      Staging: vt6655: device_main: cleanup long line

Simran Singhal (10):
      staging: greybus: tools: Fix braces {} style
      staging: rtl8723bs: Remove unnecessary braces for single statements
      staging: rtl8723bs: Remove multiple assignments
      staging: rtl8723bs: Add line after variable declarations
      staging: rtl8723bs: Remove blank line before '}' brace
      staging: rtl8723bs: rtw_efuse: Compress lines for immediate return
      staging: rtl8723bs: rtw_cmd: Compress lines for immediate return
      staging: rtl8723bs: hal: Compress return logic
      staging: rtl8723bs: hal: Remove unnecessary cast on void pointer
      staging: rtl8723bs: hal: Remove NULL check before kfree

Soumyajit Deb (10):
      staging: hp100: Remove space after * in pointer declarations
      staging: hp100: Add space around operator +
      staging: hp100: Remove extra blank lines
      staging: hp100: Correct typo in the comment
      Staging: hp100: Add space after "," in function arguments.
      staging: hp100: Remove space after opening parenthesis "("
      staging: hp100: Add space between while keyword and open parenthesis
      staging: hp100: Add spaces in if statement.
      staging: hp100: Add space around operator
      staging: hp100: Properly indent the multiline comments.

Stefan Wahren (2):
      staging: bcm2835-camera: Drop unused ignore_errors flag
      staging: bcm2835-camera: Use designators to init V4L2 controls

Sumera Priyadarsini (1):
      staging: rtl8192u: Add space to fix style issue

Takashi Iwai (5):
      staging: most: core: Use scnprintf() for avoiding potential buffer overflow
      staging: rtl8188eu: Use scnprintf() for avoiding potential buffer overflow
      staging: rtl8192e: Use scnprintf() for avoiding potential buffer overflow
      staging: rtl8723bs: Use scnprintf() for avoiding potential buffer overflow
      staging: vc04_services: Use scnprintf() for avoiding potential buffer overflow

Tetsuhiro Kohada (9):
      staging: exfat: remove 'vol_type' variable.
      staging: exfat: remove DOSNAMEs.
      staging: exfat: dedicate count_entries() to sub-dir counting.
      staging: exfat: remove symlink feature.
      staging: exfat: remove symlink feature
      staging: exfat: rename buf_cache_t's 'flag' to 'locked'
      staging: exfat: remove 'file creation modes'
      staging: exfat: clean up d_entry rebuilding.
      staging: exfat: remove redundant if statements

Thomas Gleixner (1):
      staging: greybus: Fix the irq API abuse

Tomer Maimon (2):
      dt-binding: iio: add NPCM ADC reset support
      iio: adc: modify NPCM reset support

Uwe Kleine-König (4):
      dt-bindings: iio: ltc2632: expand for ltc2636 support
      iio: dac: ltc2632: drop some duplicated data
      iio: dac: ltc2632: add support for LTC2636 family
      iio: dac: ltc2632: remove some unused defines

William Breathitt Gray (2):
      counter: 104-quad-8: Support Filter Clock Prescaler
      counter: 104-quad-8: Support Differential Encoder Cable Status

YueHaibing (1):
      staging: wfx: remove set but not used variable 'tx_priv'

Zhenzhong Duan (1):
      staging: speakup: Fix a typo error print for softsynthu device

vivek m (1):
      Staging: exfat: fixed a long line coding style issue

 .../ABI/testing/configfs-most                      |    8 -
 .../ABI/testing/sysfs-bus-counter-104-quad-8       |   25 +
 Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192 |   24 +-
 .../ABI/testing/sysfs-bus-most                     |   24 +-
 .../devicetree/bindings/iio/adc/adi,ad7923.yaml    |   65 +
 .../devicetree/bindings/iio/adc/max1363.txt        |   63 -
 .../devicetree/bindings/iio/adc/maxim,max1238.yaml |   76 +
 .../devicetree/bindings/iio/adc/maxim,max1363.yaml |   50 +
 .../bindings/iio/adc/nuvoton,npcm-adc.txt          |    2 +
 .../devicetree/bindings/iio/adc/st,stm32-adc.txt   |  149 -
 .../devicetree/bindings/iio/adc/st,stm32-adc.yaml  |  458 +++
 .../bindings/iio/amplifiers/adi,hmc425a.yaml       |   49 +
 .../bindings/iio/chemical/atlas,ec-sm.txt          |   21 -
 .../bindings/iio/chemical/atlas,orp-sm.txt         |   21 -
 .../bindings/iio/chemical/atlas,ph-sm.txt          |   21 -
 .../bindings/iio/chemical/atlas,sensor.yaml        |   53 +
 .../devicetree/bindings/iio/dac/adi,ad5770r.yaml   |  185 +
 .../devicetree/bindings/iio/dac/ltc2632.txt        |    8 +-
 .../devicetree/bindings/iio/imu/inv_mpu6050.txt    |    5 +
 .../bindings/iio/light/dynaimage,al3010.yaml       |   43 +
 .../bindings/iio/light/dynaimage,al3320a.yaml      |   43 +
 .../bindings/iio/light/sharp,gp2ap002.yaml         |   85 +
 .../bindings/iio/proximity/devantech-srf04.yaml    |   18 +
 .../devicetree/bindings/vendor-prefixes.yaml       |    2 +
 MAINTAINERS                                        |   41 +-
 .../cavium-octeon/executive/cvmx-helper-board.c    |    4 +-
 .../cavium-octeon/executive/cvmx-helper-rgmii.c    |    6 +-
 .../cavium-octeon/executive/cvmx-helper-sgmii.c    |    8 +-
 .../mips/cavium-octeon/executive/cvmx-helper-spi.c |    6 +-
 .../cavium-octeon/executive/cvmx-helper-xaui.c     |    6 +-
 arch/mips/cavium-octeon/executive/cvmx-helper.c    |   10 +-
 arch/mips/include/asm/octeon/cvmx-helper-board.h   |    2 +-
 arch/mips/include/asm/octeon/cvmx-helper-rgmii.h   |    4 +-
 arch/mips/include/asm/octeon/cvmx-helper-sgmii.h   |    4 +-
 arch/mips/include/asm/octeon/cvmx-helper-spi.h     |    4 +-
 arch/mips/include/asm/octeon/cvmx-helper-util.h    |    2 +-
 arch/mips/include/asm/octeon/cvmx-helper-xaui.h    |    4 +-
 arch/mips/include/asm/octeon/cvmx-helper.h         |    8 +-
 arch/mips/include/asm/octeon/cvmx-pko.h            |   10 +-
 arch/mips/include/asm/octeon/cvmx-pow.h            |   22 +-
 arch/mips/include/asm/octeon/cvmx-wqe.h            |   16 +-
 drivers/Kconfig                                    |    1 +
 drivers/Makefile                                   |    1 +
 drivers/counter/104-quad-8.c                       |  136 +-
 drivers/counter/stm32-timer-cnt.c                  |   66 +-
 drivers/iio/TODO                                   |   19 +
 drivers/iio/accel/adis16201.c                      |    1 +
 drivers/iio/accel/adis16209.c                      |    1 +
 drivers/iio/accel/st_accel_i2c.c                   |    5 +-
 drivers/iio/adc/Kconfig                            |   12 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/ad7124.c                           |   99 +-
 drivers/{staging => }/iio/adc/ad7192.c             |  156 +-
 drivers/iio/adc/ad7292.c                           |    5 +-
 drivers/iio/adc/exynos_adc.c                       |    6 +-
 drivers/iio/adc/max1118.c                          |   10 +-
 drivers/iio/adc/mcp320x.c                          |    3 +-
 drivers/iio/adc/npcm_adc.c                         |   30 +-
 drivers/iio/adc/ti-tlc4541.c                       |    3 +-
 drivers/iio/amplifiers/Kconfig                     |   10 +
 drivers/iio/amplifiers/Makefile                    |    1 +
 drivers/iio/amplifiers/ad8366.c                    |   30 +
 drivers/iio/amplifiers/hmc425a.c                   |  248 ++
 drivers/iio/chemical/atlas-sensor.c                |   97 +-
 drivers/iio/common/st_sensors/st_sensors_core.c    |    4 +
 drivers/iio/dac/Kconfig                            |   71 +-
 drivers/iio/dac/Makefile                           |    1 +
 drivers/iio/dac/ad5755.c                           |   22 +-
 drivers/iio/dac/ad5770r.c                          |  695 ++++
 drivers/iio/dac/ltc2632.c                          |  102 +-
 drivers/iio/gyro/adis16136.c                       |   62 +-
 drivers/iio/gyro/adis16260.c                       |    1 +
 drivers/iio/imu/adis.c                             |   68 +-
 drivers/iio/imu/adis16400.c                        |  140 +-
 drivers/iio/imu/adis16460.c                        |   40 +-
 drivers/iio/imu/adis16480.c                        |  197 +-
 drivers/iio/imu/adis_buffer.c                      |    3 +-
 drivers/iio/imu/inv_mpu6050/Kconfig                |   12 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |  651 +++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c          |  111 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |   58 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c         |   49 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h         |    5 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c         |   57 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c          |   74 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c      |  160 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |    4 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c       |    5 +-
 drivers/iio/industrialio-core.c                    |   54 +-
 drivers/iio/light/Kconfig                          |   21 +
 drivers/iio/light/Makefile                         |    2 +
 drivers/iio/light/al3010.c                         |  242 ++
 drivers/iio/light/al3320a.c                        |   72 +-
 drivers/iio/light/gp2ap002.c                       |  720 ++++
 drivers/iio/light/gp2ap020a00f.c                   |   23 +-
 drivers/iio/light/si1133.c                         |   37 +-
 drivers/iio/light/vcnl4000.c                       |  144 +-
 drivers/iio/potentiostat/lmp91000.c                |   18 +-
 drivers/iio/pressure/Kconfig                       |   11 +
 drivers/iio/pressure/Makefile                      |    1 +
 drivers/iio/pressure/icp10100.c                    |  658 ++++
 drivers/iio/proximity/srf04.c                      |   96 +-
 drivers/iio/trigger/stm32-timer-trigger.c          |  161 +-
 drivers/most/Kconfig                               |   15 +
 drivers/most/Makefile                              |    4 +
 drivers/{staging => }/most/configfs.c              |    3 +-
 drivers/{staging => }/most/core.c                  |    9 +-
 drivers/staging/Kconfig                            |   11 +-
 drivers/staging/Makefile                           |    6 +-
 drivers/staging/comedi/drivers/dt282x.c            |   30 +-
 drivers/staging/comedi/drivers/dt3000.c            |    5 +-
 drivers/staging/comedi/drivers/ni_660x.c           |    2 +-
 drivers/staging/comedi/drivers/ni_atmio16d.c       |   10 -
 drivers/staging/comedi/drivers/ni_labpc_common.c   |   13 +-
 drivers/staging/comedi/drivers/ni_mio_common.c     |   55 +-
 drivers/staging/comedi/drivers/ni_pcimio.c         |    2 +
 drivers/staging/comedi/drivers/ni_routes.c         |   63 +-
 drivers/staging/comedi/drivers/ni_routes.h         |    1 +
 drivers/staging/comedi/drivers/ni_stc.h            |    1 +
 drivers/staging/comedi/drivers/ni_tio.c            |    8 +-
 drivers/staging/comedi/drivers/rtd520.c            |    5 +-
 drivers/staging/comedi/drivers/s626.c              |    3 +-
 drivers/staging/exfat/Kconfig                      |   41 -
 drivers/staging/exfat/Makefile                     |   10 -
 drivers/staging/exfat/TODO                         |   69 -
 drivers/staging/exfat/exfat.h                      |  824 -----
 drivers/staging/exfat/exfat_blkdev.c               |  136 -
 drivers/staging/exfat/exfat_cache.c                |  555 ---
 drivers/staging/exfat/exfat_core.c                 | 2582 -------------
 drivers/staging/exfat/exfat_nls.c                  |  212 --
 drivers/staging/exfat/exfat_super.c                | 3883 --------------------
 drivers/staging/exfat/exfat_upcase.c               |  740 ----
 drivers/staging/fbtft/fbtft-core.c                 |    4 +-
 drivers/staging/fbtft/fbtft-sysfs.c                |    6 +-
 drivers/staging/fbtft/fbtft.h                      |   18 +-
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c            |    3 +-
 drivers/staging/gasket/gasket_core.c               |    9 +-
 drivers/staging/gdm724x/gdm_lte.c                  |    2 +-
 drivers/staging/gdm724x/gdm_mux.h                  |    2 +-
 drivers/staging/gdm724x/hci_packet.h               |    6 +-
 drivers/staging/gdm724x/netlink_k.c                |    7 +-
 drivers/staging/gdm724x/netlink_k.h                |    3 +-
 drivers/staging/greybus/audio_apbridgea.h          |    2 +-
 drivers/staging/greybus/gpio.c                     |   15 +-
 drivers/staging/greybus/i2c.c                      |   16 -
 drivers/staging/greybus/raw.c                      |    2 +-
 drivers/staging/greybus/tools/loopback_test.c      |    3 +-
 drivers/staging/hp/Kconfig                         |   30 -
 drivers/staging/hp/Makefile                        |    6 -
 drivers/staging/hp/hp100.c                         | 3034 ---------------
 drivers/staging/hp/hp100.h                         |  611 ---
 .../staging/iio/Documentation/sysfs-bus-iio-ad7192 |   20 -
 drivers/staging/iio/TODO                           |    8 +-
 drivers/staging/iio/accel/adis16203.c              |    1 +
 drivers/staging/iio/accel/adis16240.c              |    1 +
 drivers/staging/iio/adc/Kconfig                    |   12 -
 drivers/staging/iio/adc/Makefile                   |    1 -
 drivers/staging/iio/adc/ad7280a.c                  |    4 +
 drivers/staging/kpc2000/kpc2000/core.c             |    4 +-
 drivers/staging/kpc2000/kpc2000_spi.c              |    4 +-
 drivers/staging/kpc2000/kpc_dma/dma.c              |    9 +-
 drivers/staging/kpc2000/kpc_dma/fileops.c          |   49 +-
 drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c   |    9 +-
 drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.h   |    4 +-
 drivers/staging/ks7010/ks7010_sdio.c               |    3 +-
 drivers/staging/ks7010/ks_hostif.h                 |    4 +-
 drivers/staging/media/allegro-dvt/allegro-core.c   |   14 +-
 drivers/staging/media/hantro/hantro_postproc.c     |   12 +-
 drivers/staging/media/imx/imx6-mipi-csi2.c         |    9 +-
 drivers/staging/media/imx/imx7-mipi-csis.c         |    2 +-
 drivers/staging/media/ipu3/ipu3-mmu.c              |    4 +-
 drivers/staging/most/Kconfig                       |    6 +-
 drivers/staging/most/Makefile                      |    3 -
 drivers/staging/most/cdev/cdev.c                   |    3 +-
 drivers/staging/most/dim2/dim2.c                   |    3 +-
 drivers/staging/most/i2c/i2c.c                     |    3 +-
 drivers/staging/most/net/net.c                     |    3 +-
 drivers/staging/most/sound/sound.c                 |    3 +-
 drivers/staging/most/usb/usb.c                     |    3 +-
 drivers/staging/most/video/video.c                 |    3 +-
 drivers/staging/mt7621-dma/mtk-hsdma.c             |    3 +-
 drivers/staging/mt7621-dts/gbpc1.dts               |    4 +
 drivers/staging/mt7621-dts/mt7621.dtsi             |   15 +-
 drivers/staging/mt7621-pci-phy/pci-mt7621-phy.c    |  304 +-
 drivers/staging/mt7621-pci/mediatek,mt7621-pci.txt |    7 +-
 drivers/staging/mt7621-pci/pci-mt7621.c            |  261 +-
 drivers/staging/netlogic/platform_net.h            |    4 +-
 drivers/staging/netlogic/xlr_net.h                 |    4 +-
 drivers/staging/octeon-usb/Kconfig                 |   11 +
 drivers/staging/octeon-usb/Makefile                |    2 +
 drivers/staging/octeon-usb/TODO                    |    8 +
 drivers/staging/octeon-usb/octeon-hcd.c            | 3737 +++++++++++++++++++
 drivers/staging/octeon-usb/octeon-hcd.h            | 1847 ++++++++++
 drivers/staging/octeon/Kconfig                     |   15 +
 drivers/staging/octeon/Makefile                    |   19 +
 drivers/staging/octeon/TODO                        |    9 +
 drivers/staging/octeon/ethernet-defines.h          |   40 +
 drivers/staging/octeon/ethernet-mdio.c             |  178 +
 drivers/staging/octeon/ethernet-mdio.h             |   28 +
 drivers/staging/octeon/ethernet-mem.c              |  154 +
 drivers/staging/octeon/ethernet-mem.h              |    9 +
 drivers/staging/octeon/ethernet-rgmii.c            |  158 +
 drivers/staging/octeon/ethernet-rx.c               |  538 +++
 drivers/staging/octeon/ethernet-rx.h               |   31 +
 drivers/staging/octeon/ethernet-sgmii.c            |   30 +
 drivers/staging/octeon/ethernet-spi.c              |  226 ++
 drivers/staging/octeon/ethernet-tx.c               |  717 ++++
 drivers/staging/octeon/ethernet-tx.h               |   14 +
 drivers/staging/octeon/ethernet-util.h             |   47 +
 drivers/staging/octeon/ethernet.c                  |  992 +++++
 drivers/staging/octeon/octeon-ethernet.h           |  107 +
 drivers/staging/octeon/octeon-stubs.h              | 1434 ++++++++
 .../Documentation/devicetree/pi433-overlay.dts     |   73 +-
 drivers/staging/pi433/pi433_if.h                   |    4 +-
 drivers/staging/pi433/rf69.h                       |    4 +-
 drivers/staging/pi433/rf69_enum.h                  |    4 +-
 drivers/staging/pi433/rf69_registers.h             |    4 +-
 drivers/staging/qlge/qlge.h                        |   69 +-
 drivers/staging/qlge/qlge_dbg.c                    |   64 +-
 drivers/staging/qlge/qlge_ethtool.c                |   22 +-
 drivers/staging/qlge/qlge_main.c                   |   34 +-
 drivers/staging/qlge/qlge_mpi.c                    |    9 +-
 drivers/staging/rtl8188eu/core/rtw_cmd.c           |    2 +-
 drivers/staging/rtl8188eu/core/rtw_debug.c         |   16 +-
 drivers/staging/rtl8188eu/core/rtw_ieee80211.c     |   10 +-
 drivers/staging/rtl8188eu/core/rtw_mlme.c          |   42 +-
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c      |    2 +-
 drivers/staging/rtl8188eu/hal/hal_com.c            |   22 +-
 drivers/staging/rtl8188eu/hal/odm.c                |   50 +-
 drivers/staging/rtl8188eu/hal/odm_hwconfig.c       |   54 +-
 drivers/staging/rtl8188eu/hal/phy.c                |  138 +-
 drivers/staging/rtl8188eu/hal/pwrseqcmd.c          |    2 +-
 drivers/staging/rtl8188eu/hal/rf.c                 |   60 +-
 drivers/staging/rtl8188eu/hal/rf_cfg.c             |    6 +-
 drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c       |   42 +-
 drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c  |   44 +-
 drivers/staging/rtl8188eu/hal/rtl8188e_rxdesc.c    |    2 +-
 drivers/staging/rtl8188eu/hal/rtl8188eu_xmit.c     |   32 +-
 drivers/staging/rtl8188eu/include/rtw_xmit.h       |    2 +-
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c     |    4 +-
 drivers/staging/rtl8188eu/os_dep/osdep_service.c   |   20 +-
 drivers/staging/rtl8188eu/os_dep/usb_intf.c        |    1 +
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c     |   10 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c     |   36 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_cam.c        |    6 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c       |   26 +-
 drivers/staging/rtl8192e/rtl819x_BAProc.c          |   14 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c          |    2 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c          |    2 +-
 drivers/staging/rtl8192e/rtllib.h                  |   30 +-
 drivers/staging/rtl8192e/rtllib_rx.c               |    4 +-
 drivers/staging/rtl8192e/rtllib_tx.c               |    2 +-
 drivers/staging/rtl8192e/rtllib_wx.c               |    8 +-
 drivers/staging/rtl8192u/ieee80211/ieee80211.h     |   28 +-
 .../rtl8192u/ieee80211/ieee80211_crypt_tkip.c      |   19 +-
 .../staging/rtl8192u/ieee80211/ieee80211_module.c  |    3 +-
 .../staging/rtl8192u/ieee80211/ieee80211_softmac.c |   30 +-
 .../rtl8192u/ieee80211/ieee80211_softmac_wx.c      |    4 +-
 drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c  |   26 +-
 drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c  |    7 +-
 .../staging/rtl8192u/ieee80211/rtl819x_TSProc.c    |    2 +-
 drivers/staging/rtl8192u/r8192U_core.c             |   64 +-
 drivers/staging/rtl8192u/r8192U_wx.c               |    2 +-
 drivers/staging/rtl8192u/r819xU_phy.c              |    2 +-
 drivers/staging/rtl8712/Kconfig                    |    7 +-
 drivers/staging/rtl8712/ieee80211.h                |    4 +-
 drivers/staging/rtl8712/rtl871x_cmd.h              |    2 +-
 drivers/staging/rtl8712/rtl871x_mp.c               |    4 +-
 drivers/staging/rtl8712/rtl871x_mp_ioctl.h         |    4 +-
 drivers/staging/rtl8712/rtl871x_mp_phy_regdef.h    |    2 +-
 drivers/staging/rtl8712/rtl871x_recv.h             |    4 +-
 drivers/staging/rtl8723bs/core/rtw_ap.c            |    2 +-
 drivers/staging/rtl8723bs/core/rtw_cmd.c           |   19 +-
 drivers/staging/rtl8723bs/core/rtw_efuse.c         |   19 +-
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c     |    2 +-
 drivers/staging/rtl8723bs/core/rtw_io.c            |    9 +-
 drivers/staging/rtl8723bs/core/rtw_ioctl_set.c     |    2 +-
 drivers/staging/rtl8723bs/core/rtw_mlme.c          |   11 +-
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c      |   15 +
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c       |    9 +-
 drivers/staging/rtl8723bs/core/rtw_recv.c          |   10 +-
 drivers/staging/rtl8723bs/core/rtw_security.c      |    8 -
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c     |   16 +-
 drivers/staging/rtl8723bs/core/rtw_xmit.c          |    4 +-
 drivers/staging/rtl8723bs/hal/Hal8723BReg.h        |   14 +-
 drivers/staging/rtl8723bs/hal/HalBtc8723b1Ant.c    |    2 +-
 drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c    |   10 +-
 drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h       |    6 +-
 drivers/staging/rtl8723bs/hal/HalPhyRf.c           |    4 +-
 drivers/staging/rtl8723bs/hal/HalPwrSeqCmd.c       |    2 +-
 drivers/staging/rtl8723bs/hal/hal_com.c            |    5 +-
 drivers/staging/rtl8723bs/hal/hal_com_phycfg.c     |    4 +-
 drivers/staging/rtl8723bs/hal/hal_intf.c           |    2 +-
 drivers/staging/rtl8723bs/hal/odm.h                |    2 +-
 drivers/staging/rtl8723bs/hal/odm_CfoTracking.c    |    9 +-
 drivers/staging/rtl8723bs/hal/odm_HWConfig.c       |    6 +-
 drivers/staging/rtl8723bs/hal/odm_debug.h          |    4 +-
 drivers/staging/rtl8723bs/hal/odm_types.h          |    2 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c       |   62 +-
 drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c     |   14 +-
 drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c     |    2 +-
 drivers/staging/rtl8723bs/hal/sdio_halinit.c       |   16 +-
 drivers/staging/rtl8723bs/include/HalVerDef.h      |   32 +-
 drivers/staging/rtl8723bs/include/cmd_osdep.h      |    4 +-
 drivers/staging/rtl8723bs/include/drv_types.h      |   10 +-
 drivers/staging/rtl8723bs/include/hal_com.h        |   98 +-
 drivers/staging/rtl8723bs/include/hal_com_h2c.h    |    8 +-
 drivers/staging/rtl8723bs/include/hal_com_phycfg.h |    2 +-
 drivers/staging/rtl8723bs/include/hal_com_reg.h    |   14 +-
 drivers/staging/rtl8723bs/include/hal_intf.h       |    2 +-
 drivers/staging/rtl8723bs/include/hal_phy.h        |    2 +-
 drivers/staging/rtl8723bs/include/hal_phy_cfg.h    |    4 +-
 drivers/staging/rtl8723bs/include/hal_pwr_seq.h    |    4 +-
 drivers/staging/rtl8723bs/include/ieee80211.h      |   22 +-
 drivers/staging/rtl8723bs/include/osdep_intf.h     |    2 +-
 drivers/staging/rtl8723bs/include/osdep_service.h  |   10 +-
 .../rtl8723bs/include/osdep_service_linux.h        |    2 +-
 drivers/staging/rtl8723bs/include/recv_osdep.h     |    4 +-
 drivers/staging/rtl8723bs/include/rtl8723b_cmd.h   |    2 +-
 drivers/staging/rtl8723bs/include/rtl8723b_rf.h    |    2 +-
 drivers/staging/rtl8723bs/include/rtl8723b_xmit.h  |    2 +-
 drivers/staging/rtl8723bs/include/rtw_byteorder.h  |    2 +-
 drivers/staging/rtl8723bs/include/rtw_cmd.h        |  112 +-
 drivers/staging/rtl8723bs/include/rtw_debug.h      |   28 +-
 drivers/staging/rtl8723bs/include/rtw_eeprom.h     |    2 +-
 drivers/staging/rtl8723bs/include/rtw_efuse.h      |    8 +-
 drivers/staging/rtl8723bs/include/rtw_event.h      |    2 +-
 drivers/staging/rtl8723bs/include/rtw_ht.h         |   12 +-
 drivers/staging/rtl8723bs/include/rtw_io.h         |    6 +-
 drivers/staging/rtl8723bs/include/rtw_mlme.h       |   66 +-
 drivers/staging/rtl8723bs/include/rtw_mlme_ext.h   |   40 +-
 drivers/staging/rtl8723bs/include/rtw_mp.h         |   16 +-
 drivers/staging/rtl8723bs/include/rtw_recv.h       |   18 +-
 drivers/staging/rtl8723bs/include/rtw_security.h   |   30 +-
 drivers/staging/rtl8723bs/include/rtw_xmit.h       |   26 +-
 drivers/staging/rtl8723bs/include/sta_info.h       |    8 +-
 drivers/staging/rtl8723bs/include/wifi.h           |    8 +-
 drivers/staging/rtl8723bs/include/xmit_osdep.h     |    4 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c  |  124 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c     |  288 +-
 drivers/staging/rtl8723bs/os_dep/mlme_linux.c      |    6 +-
 drivers/staging/rtl8723bs/os_dep/os_intfs.c        |   16 +-
 drivers/staging/rtl8723bs/os_dep/osdep_service.c   |    2 +-
 drivers/staging/rtl8723bs/os_dep/recv_linux.c      |   40 +-
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c       |   12 +-
 drivers/staging/rtl8723bs/os_dep/xmit_linux.c      |    6 +-
 drivers/staging/rts5208/rtsx_chip.c                |    3 +-
 drivers/staging/sm750fb/Makefile                   |    6 +-
 drivers/staging/speakup/keyhelp.c                  |    2 +-
 drivers/staging/speakup/main.c                     |    3 +-
 drivers/staging/speakup/speakup_soft.c             |    2 +-
 drivers/staging/speakup/spk_priv.h                 |    6 +-
 drivers/staging/speakup/spk_ttyio.c                |    2 +-
 drivers/staging/speakup/spk_types.h                |    2 +-
 drivers/staging/unisys/Documentation/overview.txt  |   12 +-
 drivers/staging/unisys/visorinput/visorinput.c     |    2 +-
 drivers/staging/uwb/Kconfig                        |   72 -
 drivers/staging/uwb/Makefile                       |   32 -
 drivers/staging/uwb/TODO                           |    8 -
 drivers/staging/uwb/address.c                      |  352 --
 drivers/staging/uwb/allocator.c                    |  374 --
 drivers/staging/uwb/beacon.c                       |  595 ---
 drivers/staging/uwb/driver.c                       |  143 -
 drivers/staging/uwb/drp-avail.c                    |  278 --
 drivers/staging/uwb/drp-ie.c                       |  305 --
 drivers/staging/uwb/drp.c                          |  842 -----
 drivers/staging/uwb/est.c                          |  450 ---
 drivers/staging/uwb/hwa-rc.c                       |  929 -----
 drivers/staging/uwb/i1480/Makefile                 |    2 -
 drivers/staging/uwb/i1480/dfu/Makefile             |   10 -
 drivers/staging/uwb/i1480/dfu/dfu.c                |  198 -
 drivers/staging/uwb/i1480/dfu/i1480-dfu.h          |  246 --
 drivers/staging/uwb/i1480/dfu/mac.c                |  496 ---
 drivers/staging/uwb/i1480/dfu/phy.c                |  190 -
 drivers/staging/uwb/i1480/dfu/usb.c                |  448 ---
 drivers/staging/uwb/i1480/i1480-est.c              |   85 -
 drivers/staging/uwb/ie-rcv.c                       |   42 -
 drivers/staging/uwb/ie.c                           |  366 --
 drivers/staging/uwb/include/debug-cmd.h            |   57 -
 drivers/staging/uwb/include/spec.h                 |  767 ----
 drivers/staging/uwb/include/umc.h                  |  192 -
 drivers/staging/uwb/include/whci.h                 |  102 -
 drivers/staging/uwb/lc-dev.c                       |  457 ---
 drivers/staging/uwb/lc-rc.c                        |  569 ---
 drivers/staging/uwb/neh.c                          |  606 ---
 drivers/staging/uwb/pal.c                          |  128 -
 drivers/staging/uwb/radio.c                        |  196 -
 drivers/staging/uwb/reset.c                        |  379 --
 drivers/staging/uwb/rsv.c                          | 1000 -----
 drivers/staging/uwb/scan.c                         |  120 -
 drivers/staging/uwb/umc-bus.c                      |  211 --
 drivers/staging/uwb/umc-dev.c                      |   94 -
 drivers/staging/uwb/umc-drv.c                      |   31 -
 drivers/staging/uwb/uwb-debug.c                    |  354 --
 drivers/staging/uwb/uwb-internal.h                 |  366 --
 drivers/staging/uwb/uwb.h                          |  817 ----
 drivers/staging/uwb/uwbd.c                         |  356 --
 drivers/staging/uwb/whc-rc.c                       |  467 ---
 drivers/staging/uwb/whci.c                         |  257 --
 .../vc04_services/bcm2835-camera/controls.c        |  458 ++-
 .../vc04_services/interface/vchi/vchi_common.h     |   36 +-
 .../interface/vchiq_arm/vchiq_2835_arm.c           |   43 -
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  |  542 +--
 .../vc04_services/interface/vchiq_arm/vchiq_arm.h  |   76 -
 .../vc04_services/interface/vchiq_arm/vchiq_core.c |  306 +-
 .../vc04_services/interface/vchiq_arm/vchiq_core.h |   35 +-
 .../vc04_services/interface/vchiq_arm/vchiq_if.h   |    2 -
 drivers/staging/vt6655/card.h                      |    2 +-
 drivers/staging/vt6655/device_main.c               |    8 +-
 drivers/staging/vt6655/power.c                     |   10 +-
 drivers/staging/vt6656/Makefile                    |    4 +-
 drivers/staging/vt6656/baseband.c                  |   46 +-
 drivers/staging/vt6656/card.c                      |    4 +-
 drivers/staging/vt6656/desc.h                      |   35 +-
 drivers/staging/vt6656/device.h                    |   21 +-
 drivers/staging/vt6656/dpc.c                       |  124 -
 drivers/staging/vt6656/dpc.h                       |   24 -
 drivers/staging/vt6656/int.c                       |  164 -
 drivers/staging/vt6656/int.h                       |   47 -
 drivers/staging/vt6656/key.c                       |    5 +-
 drivers/staging/vt6656/mac.h                       |  263 +-
 drivers/staging/vt6656/main_usb.c                  |   38 +-
 drivers/staging/vt6656/rxtx.c                      |  296 +-
 drivers/staging/vt6656/rxtx.h                      |   61 -
 drivers/staging/vt6656/usbpipe.c                   |  233 +-
 drivers/staging/vt6656/usbpipe.h                   |   23 +
 .../bindings/net/wireless/siliabs,wfx.txt          |   11 +-
 drivers/staging/wfx/bh.c                           |    8 +-
 drivers/staging/wfx/bus_sdio.c                     |   16 +-
 drivers/staging/wfx/bus_spi.c                      |   45 +-
 drivers/staging/wfx/data_rx.c                      |    3 +-
 drivers/staging/wfx/data_tx.c                      |   12 +-
 drivers/staging/wfx/data_tx.h                      |    2 +-
 drivers/staging/wfx/hif_api_cmd.h                  |    4 -
 drivers/staging/wfx/hwio.c                         |    2 +-
 drivers/staging/wfx/main.c                         |   23 +-
 drivers/staging/wfx/main.h                         |    1 -
 drivers/staging/wfx/queue.c                        |   20 +-
 drivers/staging/wfx/sta.c                          |    5 +-
 drivers/staging/wilc1000/Kconfig                   |    5 +
 drivers/staging/wilc1000/cfg80211.c                |  387 +-
 drivers/staging/wilc1000/hif.c                     |    5 +-
 .../staging/wilc1000/microchip,wilc1000,sdio.txt   |   38 -
 .../staging/wilc1000/microchip,wilc1000,spi.txt    |   34 -
 drivers/staging/wilc1000/microchip,wilc1000.yaml   |   71 +
 drivers/staging/wilc1000/mon.c                     |    2 +-
 drivers/staging/wilc1000/netdev.c                  |   32 +-
 drivers/staging/wilc1000/netdev.h                  |   10 -
 drivers/staging/wilc1000/sdio.c                    |  316 +-
 drivers/staging/wilc1000/spi.c                     |  861 ++---
 drivers/staging/wilc1000/wlan.c                    |  135 +-
 drivers/staging/wilc1000/wlan.h                    |   97 +-
 drivers/staging/wlan-ng/hfa384x.h                  |    4 +-
 drivers/staging/wlan-ng/hfa384x_usb.c              |   12 +-
 drivers/staging/wlan-ng/p80211types.h              |    4 +-
 drivers/staging/wlan-ng/prism2usb.c                |    1 +
 drivers/staging/wusbcore/Documentation/wusb-cbaf   |  130 -
 .../Documentation/wusb-design-overview.rst         |  457 ---
 drivers/staging/wusbcore/Kconfig                   |   39 -
 drivers/staging/wusbcore/Makefile                  |   28 -
 drivers/staging/wusbcore/TODO                      |    8 -
 drivers/staging/wusbcore/cbaf.c                    |  645 ----
 drivers/staging/wusbcore/crypto.c                  |  441 ---
 drivers/staging/wusbcore/dev-sysfs.c               |  124 -
 drivers/staging/wusbcore/devconnect.c              | 1085 ------
 drivers/staging/wusbcore/host/Kconfig              |   28 -
 drivers/staging/wusbcore/host/Makefile             |    3 -
 drivers/staging/wusbcore/host/hwa-hc.c             |  875 -----
 drivers/staging/wusbcore/host/whci/Makefile        |   14 -
 drivers/staging/wusbcore/host/whci/asl.c           |  376 --
 drivers/staging/wusbcore/host/whci/debug.c         |  153 -
 drivers/staging/wusbcore/host/whci/hcd.c           |  356 --
 drivers/staging/wusbcore/host/whci/hw.c            |   93 -
 drivers/staging/wusbcore/host/whci/init.c          |  177 -
 drivers/staging/wusbcore/host/whci/int.c           |   82 -
 drivers/staging/wusbcore/host/whci/pzl.c           |  404 --
 drivers/staging/wusbcore/host/whci/qset.c          |  831 -----
 drivers/staging/wusbcore/host/whci/whcd.h          |  202 -
 drivers/staging/wusbcore/host/whci/whci-hc.h       |  401 --
 drivers/staging/wusbcore/host/whci/wusb.c          |  210 --
 drivers/staging/wusbcore/include/association.h     |  151 -
 drivers/staging/wusbcore/include/wusb-wa.h         |  304 --
 drivers/staging/wusbcore/include/wusb.h            |  362 --
 drivers/staging/wusbcore/mmc.c                     |  303 --
 drivers/staging/wusbcore/pal.c                     |   45 -
 drivers/staging/wusbcore/reservation.c             |  110 -
 drivers/staging/wusbcore/rh.c                      |  426 ---
 drivers/staging/wusbcore/security.c                |  599 ---
 drivers/staging/wusbcore/wa-hc.c                   |   88 -
 drivers/staging/wusbcore/wa-hc.h                   |  467 ---
 drivers/staging/wusbcore/wa-nep.c                  |  289 --
 drivers/staging/wusbcore/wa-rpipe.c                |  539 ---
 drivers/staging/wusbcore/wa-xfer.c                 | 2927 ---------------
 drivers/staging/wusbcore/wusbhc.c                  |  490 ---
 drivers/staging/wusbcore/wusbhc.h                  |  487 ---
 include/linux/iio/iio.h                            |    2 +
 include/linux/iio/imu/adis.h                       |   51 +-
 {drivers/staging/most => include/linux}/most.h     |    0
 498 files changed, 20198 insertions(+), 47979 deletions(-)
 rename drivers/staging/most/Documentation/ABI/configfs-most.txt => Documentation/ABI/testing/configfs-most (94%)
 rename drivers/staging/most/Documentation/ABI/sysfs-bus-most.txt => Documentation/ABI/testing/sysfs-bus-most (92%)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/max1363.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max1238.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max1363.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,ec-sm.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,orp-sm.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,ph-sm.txt
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,sensor.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/light/dynaimage,al3010.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/light/dynaimage,al3320a.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/light/sharp,gp2ap002.yaml
 create mode 100644 drivers/iio/TODO
 rename drivers/{staging => }/iio/adc/ad7192.c (89%)
 create mode 100644 drivers/iio/amplifiers/hmc425a.c
 create mode 100644 drivers/iio/dac/ad5770r.c
 create mode 100644 drivers/iio/light/al3010.c
 create mode 100644 drivers/iio/light/gp2ap002.c
 create mode 100644 drivers/iio/pressure/icp10100.c
 create mode 100644 drivers/most/Kconfig
 create mode 100644 drivers/most/Makefile
 rename drivers/{staging => }/most/configfs.c (99%)
 rename drivers/{staging => }/most/core.c (99%)
 delete mode 100644 drivers/staging/exfat/Kconfig
 delete mode 100644 drivers/staging/exfat/Makefile
 delete mode 100644 drivers/staging/exfat/TODO
 delete mode 100644 drivers/staging/exfat/exfat.h
 delete mode 100644 drivers/staging/exfat/exfat_blkdev.c
 delete mode 100644 drivers/staging/exfat/exfat_cache.c
 delete mode 100644 drivers/staging/exfat/exfat_core.c
 delete mode 100644 drivers/staging/exfat/exfat_nls.c
 delete mode 100644 drivers/staging/exfat/exfat_super.c
 delete mode 100644 drivers/staging/exfat/exfat_upcase.c
 delete mode 100644 drivers/staging/hp/Kconfig
 delete mode 100644 drivers/staging/hp/Makefile
 delete mode 100644 drivers/staging/hp/hp100.c
 delete mode 100644 drivers/staging/hp/hp100.h
 delete mode 100644 drivers/staging/iio/Documentation/sysfs-bus-iio-ad7192
 create mode 100644 drivers/staging/octeon-usb/Kconfig
 create mode 100644 drivers/staging/octeon-usb/Makefile
 create mode 100644 drivers/staging/octeon-usb/TODO
 create mode 100644 drivers/staging/octeon-usb/octeon-hcd.c
 create mode 100644 drivers/staging/octeon-usb/octeon-hcd.h
 create mode 100644 drivers/staging/octeon/Kconfig
 create mode 100644 drivers/staging/octeon/Makefile
 create mode 100644 drivers/staging/octeon/TODO
 create mode 100644 drivers/staging/octeon/ethernet-defines.h
 create mode 100644 drivers/staging/octeon/ethernet-mdio.c
 create mode 100644 drivers/staging/octeon/ethernet-mdio.h
 create mode 100644 drivers/staging/octeon/ethernet-mem.c
 create mode 100644 drivers/staging/octeon/ethernet-mem.h
 create mode 100644 drivers/staging/octeon/ethernet-rgmii.c
 create mode 100644 drivers/staging/octeon/ethernet-rx.c
 create mode 100644 drivers/staging/octeon/ethernet-rx.h
 create mode 100644 drivers/staging/octeon/ethernet-sgmii.c
 create mode 100644 drivers/staging/octeon/ethernet-spi.c
 create mode 100644 drivers/staging/octeon/ethernet-tx.c
 create mode 100644 drivers/staging/octeon/ethernet-tx.h
 create mode 100644 drivers/staging/octeon/ethernet-util.h
 create mode 100644 drivers/staging/octeon/ethernet.c
 create mode 100644 drivers/staging/octeon/octeon-ethernet.h
 create mode 100644 drivers/staging/octeon/octeon-stubs.h
 delete mode 100644 drivers/staging/uwb/Kconfig
 delete mode 100644 drivers/staging/uwb/Makefile
 delete mode 100644 drivers/staging/uwb/TODO
 delete mode 100644 drivers/staging/uwb/address.c
 delete mode 100644 drivers/staging/uwb/allocator.c
 delete mode 100644 drivers/staging/uwb/beacon.c
 delete mode 100644 drivers/staging/uwb/driver.c
 delete mode 100644 drivers/staging/uwb/drp-avail.c
 delete mode 100644 drivers/staging/uwb/drp-ie.c
 delete mode 100644 drivers/staging/uwb/drp.c
 delete mode 100644 drivers/staging/uwb/est.c
 delete mode 100644 drivers/staging/uwb/hwa-rc.c
 delete mode 100644 drivers/staging/uwb/i1480/Makefile
 delete mode 100644 drivers/staging/uwb/i1480/dfu/Makefile
 delete mode 100644 drivers/staging/uwb/i1480/dfu/dfu.c
 delete mode 100644 drivers/staging/uwb/i1480/dfu/i1480-dfu.h
 delete mode 100644 drivers/staging/uwb/i1480/dfu/mac.c
 delete mode 100644 drivers/staging/uwb/i1480/dfu/phy.c
 delete mode 100644 drivers/staging/uwb/i1480/dfu/usb.c
 delete mode 100644 drivers/staging/uwb/i1480/i1480-est.c
 delete mode 100644 drivers/staging/uwb/ie-rcv.c
 delete mode 100644 drivers/staging/uwb/ie.c
 delete mode 100644 drivers/staging/uwb/include/debug-cmd.h
 delete mode 100644 drivers/staging/uwb/include/spec.h
 delete mode 100644 drivers/staging/uwb/include/umc.h
 delete mode 100644 drivers/staging/uwb/include/whci.h
 delete mode 100644 drivers/staging/uwb/lc-dev.c
 delete mode 100644 drivers/staging/uwb/lc-rc.c
 delete mode 100644 drivers/staging/uwb/neh.c
 delete mode 100644 drivers/staging/uwb/pal.c
 delete mode 100644 drivers/staging/uwb/radio.c
 delete mode 100644 drivers/staging/uwb/reset.c
 delete mode 100644 drivers/staging/uwb/rsv.c
 delete mode 100644 drivers/staging/uwb/scan.c
 delete mode 100644 drivers/staging/uwb/umc-bus.c
 delete mode 100644 drivers/staging/uwb/umc-dev.c
 delete mode 100644 drivers/staging/uwb/umc-drv.c
 delete mode 100644 drivers/staging/uwb/uwb-debug.c
 delete mode 100644 drivers/staging/uwb/uwb-internal.h
 delete mode 100644 drivers/staging/uwb/uwb.h
 delete mode 100644 drivers/staging/uwb/uwbd.c
 delete mode 100644 drivers/staging/uwb/whc-rc.c
 delete mode 100644 drivers/staging/uwb/whci.c
 delete mode 100644 drivers/staging/vt6656/dpc.c
 delete mode 100644 drivers/staging/vt6656/dpc.h
 delete mode 100644 drivers/staging/vt6656/int.c
 delete mode 100644 drivers/staging/vt6656/int.h
 delete mode 100644 drivers/staging/wilc1000/microchip,wilc1000,sdio.txt
 delete mode 100644 drivers/staging/wilc1000/microchip,wilc1000,spi.txt
 create mode 100644 drivers/staging/wilc1000/microchip,wilc1000.yaml
 delete mode 100644 drivers/staging/wusbcore/Documentation/wusb-cbaf
 delete mode 100644 drivers/staging/wusbcore/Documentation/wusb-design-overview.rst
 delete mode 100644 drivers/staging/wusbcore/Kconfig
 delete mode 100644 drivers/staging/wusbcore/Makefile
 delete mode 100644 drivers/staging/wusbcore/TODO
 delete mode 100644 drivers/staging/wusbcore/cbaf.c
 delete mode 100644 drivers/staging/wusbcore/crypto.c
 delete mode 100644 drivers/staging/wusbcore/dev-sysfs.c
 delete mode 100644 drivers/staging/wusbcore/devconnect.c
 delete mode 100644 drivers/staging/wusbcore/host/Kconfig
 delete mode 100644 drivers/staging/wusbcore/host/Makefile
 delete mode 100644 drivers/staging/wusbcore/host/hwa-hc.c
 delete mode 100644 drivers/staging/wusbcore/host/whci/Makefile
 delete mode 100644 drivers/staging/wusbcore/host/whci/asl.c
 delete mode 100644 drivers/staging/wusbcore/host/whci/debug.c
 delete mode 100644 drivers/staging/wusbcore/host/whci/hcd.c
 delete mode 100644 drivers/staging/wusbcore/host/whci/hw.c
 delete mode 100644 drivers/staging/wusbcore/host/whci/init.c
 delete mode 100644 drivers/staging/wusbcore/host/whci/int.c
 delete mode 100644 drivers/staging/wusbcore/host/whci/pzl.c
 delete mode 100644 drivers/staging/wusbcore/host/whci/qset.c
 delete mode 100644 drivers/staging/wusbcore/host/whci/whcd.h
 delete mode 100644 drivers/staging/wusbcore/host/whci/whci-hc.h
 delete mode 100644 drivers/staging/wusbcore/host/whci/wusb.c
 delete mode 100644 drivers/staging/wusbcore/include/association.h
 delete mode 100644 drivers/staging/wusbcore/include/wusb-wa.h
 delete mode 100644 drivers/staging/wusbcore/include/wusb.h
 delete mode 100644 drivers/staging/wusbcore/mmc.c
 delete mode 100644 drivers/staging/wusbcore/pal.c
 delete mode 100644 drivers/staging/wusbcore/reservation.c
 delete mode 100644 drivers/staging/wusbcore/rh.c
 delete mode 100644 drivers/staging/wusbcore/security.c
 delete mode 100644 drivers/staging/wusbcore/wa-hc.c
 delete mode 100644 drivers/staging/wusbcore/wa-hc.h
 delete mode 100644 drivers/staging/wusbcore/wa-nep.c
 delete mode 100644 drivers/staging/wusbcore/wa-rpipe.c
 delete mode 100644 drivers/staging/wusbcore/wa-xfer.c
 delete mode 100644 drivers/staging/wusbcore/wusbhc.c
 delete mode 100644 drivers/staging/wusbcore/wusbhc.h
 rename {drivers/staging/most => include/linux}/most.h (100%)
