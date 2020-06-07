Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884CFC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 13:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3718620723
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 13:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591536553;
	bh=ZP/li90k8QvbcUK8wGOl3jlQj2025p0TYFsgoViMoMU=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=T0XDDbQBP6O+9JZ/vKCLJyRO9mQkS0SpXRt2Joa3+aqQgVGmpohs/76P1HLU6PTxB
	 +2vraRihsX1zTqo6WWdvo6AP5CKkXPRrNybgldIN+9W59IrYTAepAgx1BlpJEA4yWY
	 I4G9ZHsQzrPG1/WzNzk4LOKMB01LNHQAJw8JaSxA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgFGN3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 09:29:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:46776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbgFGN3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 09:29:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFE7220723;
        Sun,  7 Jun 2020 13:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591536546;
        bh=ZP/li90k8QvbcUK8wGOl3jlQj2025p0TYFsgoViMoMU=;
        h=Date:From:To:Cc:Subject:From;
        b=1CYvqv8svrhepiqvdQNvl51JSSZRNdy/ACdIGoIOFYzSs+mONG2Hl387C7YGfNvf0
         gcmRrJFUcdSHvb3icyuKpFmasdgab/y21759sfkWHqT+TfA/3trBbO3kZz2M1fvQ/U
         RWOWHn93BQ8XGWsywXpFyQPbxdDOjqzytE1kG50o=
Date:   Sun, 7 Jun 2020 15:29:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver patches for 5.8-rc1
Message-ID: <20200607132904.GA168539@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2ef96a5bb12be62ef75b5828c0aab838ebb29cb8:

  Linux 5.7-rc5 (2020-05-10 15:16:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.8-rc1

for you to fetch changes up to 05c8a4fc44a916dd897769ca69b42381f9177ec4:

  habanalabs: correctly cast u64 to void* (2020-06-01 09:08:10 +0200)

----------------------------------------------------------------
Char/Misc driver patches for 5.8-rc1

Here is the large set of char/misc driver patches for 5.8-rc1

Included in here are:
	- habanalabs driver updates, loads
	- mhi bus driver updates
	- extcon driver updates
	- clk driver updates (approved by the clock maintainer)
	- firmware driver updates
	- fpga driver updates
	- gnss driver updates
	- coresight driver updates
	- interconnect driver updates
	- parport driver updates (it's still alive!)
	- nvmem driver updates
	- soundwire driver updates
	- visorbus driver updates
	- w1 driver updates
	- various misc driver updates

In short, loads of different driver subsystem updates along with the
drivers as well.

All have been in linux-next for a while with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Adam Aharon (1):
      habanalabs: enable trace data compression (profiler)

Akash Asthana (1):
      interconnect: Add devm_of_icc_get() as exported API for users

Akira Shimahara (9):
      w1_therm: adding code comments and code reordering
      w1_therm: fix reset_select_slave during discovery
      w1_therm: adding sysfs-driver-w1_therm doc
      w1_therm: adding ext_power sysfs entry
      w1_therm: adding resolution sysfs entry
      w1_therm: adding eeprom sysfs entry
      w1_therm: optimizing temperature read timings
      w1_therm: adding alarm sysfs entry
      w1_therm: adding bulk read support to trigger multiple conversion on bus

Angelo Dureghello (1):
      w1: ds2430: fix eeprom size in driver description

Anson Huang (1):
      nvmem: imx-ocotp: Improve logic to save many code lines

Anurag Koul (1):
      coresight: etm4x: Add support for Neoverse N1 ETM

Bard Liao (2):
      soundwire: bus: add unique bus id
      soundwire: master: add runtime pm support

Bhaumik Bhatt (4):
      bus: mhi: core: Handle firmware load using state worker
      bus: mhi: core: Return appropriate error codes for AMSS load failure
      bus: mhi: core: Improve debug logs for loading firmware
      bus: mhi: core: Ensure non-zero session or sequence ID values are used

Bjorn Helgaas (6):
      misc: rtsx: Remove unused pcr_ops
      misc: rtsx: Removed unused dev_aspm_mode
      misc: rtsx: Use ASPM_MASK_NEG instead of hard-coded value
      misc: rtsx: Use pcie_capability_clear_and_set_word() for PCI_EXP_LNKCTL
      misc: rtsx: Simplify rtsx_comm_set_aspm()
      misc: rtsx: Remove unnecessary rts5249_set_aspm(), rts5260_set_aspm()

Christine Gharzuzi (1):
      habanalabs: support hwmon_reset_history attribute

Christophe JAILLET (2):
      firmware: xilinx: Fix an error handling path in 'zynqmp_firmware_probe()'
      extcon: adc-jack: Fix an error handling path in 'adc_jack_probe()'

Chuhong Yuan (1):
      uio_hv_generic: add missed sysfs_remove_bin_file

Colin Ian King (4):
      binderfs: remove redundant assignment to pointer ctx
      drivers: uio: remove redundant assignment to variable retval
      w1_therm: remove redundant assignments to variable ret
      extcon: remove redundant assignment to variable idx

Dan Carpenter (1):
      w1_therm: Free the correct variable

Dan Williams (1):
      /dev/mem: Revoke mappings when a driver claims the region

Daniel Vetter (1):
      habanalabs: don't set default fence_ops->wait

Dinghao Liu (1):
      extcon: arizona: Fix runtime PM imbalance on error

Dominic Chen (1):
      fpga: dfl: afu: support debug access to memory-mapped afu regions

Dotan Barak (1):
      habanalabs: print all CB handles as hex numbers

Georgi Djakov (3):
      interconnect: Add helpers for enabling/disabling a path
      interconnect: Add of_icc_get_by_index() helper function
      Merge branch 'icc-get-by-index' into icc-next

Greg Kroah-Hartman (9):
      Merge 5.7-rc3 into char-misc-next
      Merge 5.7-rc5 into char-misc-next
      Merge tag 'fpga-for-5.8' of git://git.kernel.org/.../mdf/linux-fpga into char-misc-next
      Merge tag 'misc-habanalabs-next-2020-05-19' of git://people.freedesktop.org/~gabbayo/linux into char-misc-next
      Merge tag 'icc-5.8-rc1' of https://git.linaro.org/people/georgi.djakov/linux into char-misc-next
      Merge tag 'soundwire-5.8-rc1' of git://git.kernel.org/.../vkoul/soundwire into char-misc-next
      Merge tag 'misc-habanalabs-next-2020-05-25' of git://people.freedesktop.org/~gabbayo/linux into char-misc-next
      Merge tag 'extcon-next-for-5.8' of git://git.kernel.org/.../chanwoo/extcon into char-misc-next
      Merge tag 'gnss-5.8-rc1' of https://git.kernel.org/.../johan/gnss into char-misc-next

Guennadi Liakhovetski (2):
      soundwire: (cosmetic) remove multiple superfluous "else" statements
      soundwire: intel: (cosmetic) remove multiple superfluous "else" statements

Gustavo A. R. Silva (4):
      lkdtm: bugs: Fix spelling mistake
      fpga: dfl.h: Replace zero-length array with flexible-array member
      greybus: Replace zero-length array with flexible-array
      gnss: replace zero-length array with flexible-array

H. Nikolaus Schaller (4):
      w1: omap-hdq: cleanup to add missing newline for some dev_dbg
      w1: omap-hdq: fix return value to be -1 if there is a timeout
      w1: omap-hdq: fix interrupt handling which did show spurious timeouts
      w1: omap-hdq: print dev_err if irq flags are not cleared

Harshal Chaudhari (1):
      misc: xilinx-sdfec: convert to module_platform_driver()

Hemant Kumar (9):
      bus: mhi: core: Refactor mhi queue APIs
      bus: mhi: core: Cache intmod from mhi event to mhi channel
      bus: mhi: core: Add range check for channel id received in event ring
      bus: mhi: core: Read transfer length from an event properly
      bus: mhi: core: Remove the system error worker thread
      bus: mhi: core: Handle disable transitions in state worker
      bus: mhi: core: Skip handling BHI irq if MHI reg access is not allowed
      bus: mhi: core: Do not process SYS_ERROR if RDDM is supported
      bus: mhi: core: Handle write lock properly in mhi_pm_m0_transition

Hu Haowen (1):
      misc: mic: correct a typo

Jason Yan (5):
      sgi-xp: make some symbols static in xpnet.c
      sgi-xp: make some symbols static in xpc_main.c
      uio: remove unneeded variable "ret" in uio_dmem_genirq_open
      coresight: cti: Make some symbols static
      coresight: etb10: Make coresight_etb_groups static

Jeffrey Hugo (1):
      bus: mhi: core: Handle syserr during power_up

Joe Perches (8):
      parport: fix if-statement empty body warnings
      parport: Convert printk(KERN_<LEVEL> to pr_<level>(
      parport: Use more comon logging styles
      parport: daisy: Convert DPRINTK to pr_debug
      parport_amiga: Convert DPRINTK to pr_debug
      parport_mfc3: Convert DPRINTK to pr_debug
      parport_pc: Convert DPRINTK to pr_debug
      parport: Standardize use of printmode

John Hubbard (5):
      drivers/mic/scif: convert get_user_pages() --> pin_user_pages()
      genwqe: convert get_user_pages() --> pin_user_pages()
      misc: xilinx-sdfec: improve get_user_pages_fast() error handling
      misc: xilinx-sdfec: cleanup return value in xsdfec_table_write()
      misc: xilinx-sdfec: convert get_user_pages() --> pin_user_pages()

Jordan Crouse (1):
      interconnect: Remove unused module exit code from core

Kuninori Morimoto (1):
      soundwire: intel: use asoc_rtd_to_cpu() / asoc_rtd_to_codec() macro for DAI pointer

Lad Prabhakar (1):
      misc: pci_endpoint_test: Add Device ID for RZ/G2E PCIe controller

Leonard Crestez (5):
      dt-bindings: interconnect: Add bindings for imx8m noc
      interconnect: Add imx core driver
      interconnect: imx: Add platform driver for imx8mm
      interconnect: imx: Add platform driver for imx8mq
      interconnect: imx: Add platform driver for imx8mn

Madhuparna Bhowmik (1):
      drivers: char: tlclk.c: Avoid data race between init and interrupt handler

Manivannan Sadhasivam (1):
      bus: mhi: core: Add support for MHI suspend and resume

Marek Szyprowski (1):
      extcon: max14577: Add proper dt-compatible strings

Mauro Carvalho Chehab (1):
      docs: trace: coresight-ect.rst: Fix a build warning

Michael Auchter (1):
      nvmem: ensure sysfs writes handle write-protect pin

Mike Leach (6):
      coresight: Add generic sysfs link creation functions
      coresight: cti: Add in sysfs links to other coresight devices
      coresight: docs: Add information about the topology representations
      coresight: etmv4: Update default filter and initialisation
      coresight: cti: Add CPU Hotplug handling to CTI driver
      coresight: cti: Add CPU idle pm notifer to CTI devices

Nathan Chancellor (1):
      firmware: xilinx: Export zynqmp_pm_fpga_{get_status,load}

Nishad Kamdar (1):
      drivers: visorbus: Use the correct style for SPDX License Identifier

Oded Gabbay (19):
      habanalabs: don't wait for ASIC CPU after reset
      habanalabs: unify and improve device cpu init
      habanalabs: print warning when reset is requested
      habanalabs: increase timeout during reset
      habanalabs: update firmware definitions
      habanalabs: retrieve DMA mask indication from firmware
      habanalabs: handle barriers in DMA QMAN streams
      habanalabs: leave space for 2xMSG_PROT in CB
      habanalabs: update F/W register map
      habanalabs: add missing MODULE_DEVICE_TABLE
      habanalabs: set PM profile to auto only for goya
      habanalabs: support clock gating enable/disable
      habanalabs: add gaudi asic registers header files
      uapi: habanalabs: add gaudi defines
      habanalabs: add gaudi asic-dependent code
      habanalabs: add hwmgr module for gaudi
      habanalabs: enable gaudi code in driver
      habanalabs: GAUDI does not support soft-reset
      habanalabs: correctly cast u64 to void*

Ofir Bitton (2):
      habanalabs: load CPU device boot loader from host
      habanalabs: move event handling to common firmware file

Omer Shpigelman (15):
      habanalabs: remove stop-on-error flag from DMA
      habanalabs: re-factor H/W queues initialization
      uapi: habanalabs: add signal/wait operations
      habanalabs: define ASIC-dependent interface for signal/wait
      habanalabs: handle the h/w sync object
      habanalabs: add signal/wait to CS IOCTL operations
      habanalabs: check if CoreSight is supported
      habanalabs: add dedicated define for hard reset
      habanalabs: get card type, location from F/W
      habanalabs: add gaudi security module
      habanalabs: add gaudi profiler module
      habanalabs: improve MMU cache invalidation code
      habanalabs: add print for soft reset due to event
      habanalabs: don't allow hard reset with open processes
      habanalabs: handle MMU cache invalidation timeout

Pierre-Louis Bossart (11):
      soundwire: qcom: fix error handling in probe
      Documentation: SoundWire: clarify TDM mode support
      soundwire: slave: don't init debugfs on device registration error
      soundwire: debugfs: clarify SDPX license with GPL-2.0-only
      soundwire: bus: reduce verbosity on enumeration
      soundwire: bus: rename sdw_bus_master_add/delete, add arguments
      soundwire: bus_type: introduce sdw_slave_type and sdw_master_type
      soundwire: bus_type: add sdw_master_device support
      soundwire: disco: s/ch/channels/
      soundwire: master: add sysfs support
      soundwire: add Slave sysfs support

Rachel Stahl (1):
      habanalabs: update patched_cb_size for Wreg32

Rajan Vaja (26):
      firmware: xilinx: Remove eemi ops for get_api_version
      firmware: xilinx: Remove eemi ops for get_chipid
      firmware: xilinx: Remove eemi ops for query_data
      firmware: xilinx: Remove eemi ops for clock_enable
      firmware: xilinx: Remove eemi ops for clock_disable
      firmware: xilinx: Remove eemi ops for clock_getstate
      firmware: xilinx: Remove eemi ops for clock_setdivider
      firmware: xilinx: Remove eemi ops for clock_getdivider
      firmware: xilinx: Remove eemi ops for clock set/get rate
      firmware: xilinx: Remove eemi ops for clock set/get parent
      firmware: xilinx: Use APIs instead of IOCTLs
      firmware: xilinx: Remove eemi ops for reset_assert
      firmware: xilinx: Remove eemi ops for reset_get_status
      firmware: xilinx: Remove eemi ops for init_finalize
      firmware: xilinx: Remove eemi ops for set_suspend_mode
      firmware: xilinx: Remove eemi ops for request_node
      firmware: xilinx: Remove eemi ops for release_node
      firmware: xilinx: Remove eemi ops for set_requirement
      firmware: xilinx: Remove eemi ops for aes engine
      firmware: xilinx: Remove eemi ops for fpga related APIs
      firmware: xilinx: Add APIs to read/write GGS/PGGS registers
      firmware: xilinx: Add sysfs interface
      firmware: xilinx: Add system shutdown API interface
      firmware: xilinx: Add sysfs to set shutdown scope
      firmware: xilinx: Add sysfs and API to set boot health status
      crypto: xilinx: Handle AES PM API return status

Rander Wang (1):
      soundwire: intel: use a single module

Richard Gong (6):
      firmware: fpga: replace the error codes with the standard ones
      dt-bindings: fpga: add compatible value to Stratix10 SoC FPGA manager binding
      arm64: dts: agilex: correct FPGA manager driver's compatible value
      fpga: stratix10-soc: add compatible property value for intel agilex
      dt-bindings, firmware: add compatible value Intel Stratix10 service layer binding
      arm64: dts: agilex: correct service layer driver's compatible value

Rui Feng (1):
      misc: rtsx: Improve compatibility for rts5261

Sai Prakash Ranjan (3):
      coresight: etm4x: Add support for Qualcomm SC7180 SoC
      coresight: etm4x: Replace ETM PIDs with UCI IDs for Kryo385
      coresight: tmc: Fix TMC mode read in tmc_read_prepare_etb()

Samuel Zou (2):
      soundwire: qcom: Use IRQF_ONESHOT
      nvmem: jz4780-efuse: Use PTR_ERR_OR_ZERO() to simplify code

Saravana Kannan (2):
      slimbus: core: Set fwnode for a device when setting of_node
      slimbus: core: Fix mismatch in of_node_get/put

Sergiu Cuciurean (2):
      fpga: ice40-spi: Use new structure for SPI transfer delays
      fpga: machxo2-spi: Use new structure for SPI transfer delays

Souptick Joarder (2):
      VMCI: Avoid extra check for access_ok()
      fpga: dfl: afu: Corrected error handling levels

Srinivas Kandagatla (6):
      slimbus: ngd: get drvdata from correct device
      slimbus: ngd: remove redundant assignment
      nvmem: core: cleanup old eeprom compat entry attributes
      misc: fastrpc: Fix an incomplete memory release in fastrpc_rpmsg_probe()
      misc: fastrpc: fix potential fastrpc_invoke_ctx leak
      nvmem: qfprom: remove incorrect write support

Stephen Boyd (5):
      coresight: Mark some functions static
      coresight: Don't initialize variables unnecessarily
      coresight: Initialize arg in sparse friendly way
      coresight: Include required headers in C files
      coresight: Avoid casting void pointers

Sudip Mukherjee (3):
      parport: Add comments for parport_register_dev_model()
      parport: remove unused parport_register_device()
      parport: remove use of devmodel

Suzuki K Poulose (5):
      coresight: Pass coresight_device for coresight_release_platform_data
      coresight: Add return value for fixup connections
      coresight: Expose device connections via sysfs
      coresight: Fix support for sparsely populated ports
      coresight: etm4x: Fix use-after-free of per-cpu etm drvdata

Tang Bin (2):
      binderfs: Fix binderfs.c selftest compilation warning
      dca: Use PTR_ERR_OR_ZERO() to simplify code

Tomer Tayar (4):
      habanalabs: Add INFO IOCTL opcode for time sync information
      habanalabs: Allow access to TPC LFSR register
      habanalabs: Align protection bits configuration of all TPCs
      habanalabs: initialize variable to default value

Vinod Koul (2):
      soundwire: fix trailing line in sysfs_slave.c
      soundwire: fix spelling mistake

Viresh Kumar (1):
      interconnect: Disallow interconnect core to be built as a module

Wei Yongjun (2):
      interconnect: imx: Fix return value check in imx_icc_node_init_qos()
      gnss: sirf: fix error return code in sirf_probe()

Wu Hao (1):
      fpga: dfl: fme: add performance reporting support

Xu Yilun (2):
      Documentation: fpga: dfl: add description for performance reporting support
      fpga: dfl: support multiple opens on feature device node.

YueHaibing (1):
      crypto: xilinx - Remove set but not used variable 'drv_ctx'

Zenyu Sy (1):
      greybus: fix typos in GREYBUS/GREYBUS_ES2 help text

Zou Wei (1):
      misc: xilinx_sdfec: Use memdup_user() as a cleanup

kbuild test robot (1):
      habanalabs: hl_pci_set_dma_mask() can be static

 .../ABI/stable/sysfs-driver-firmware-zynqmp        |  103 +
 .../ABI/testing/debugfs-driver-habanalabs          |   17 +
 .../testing/sysfs-bus-event_source-devices-dfl_fme |  104 +
 .../ABI/testing/sysfs-bus-soundwire-master         |   23 +
 .../ABI/testing/sysfs-bus-soundwire-slave          |   91 +
 Documentation/ABI/testing/sysfs-driver-habanalabs  |   17 +
 Documentation/ABI/testing/sysfs-driver-w1_therm    |  116 +
 .../bindings/firmware/intel,stratix10-svc.txt      |    2 +-
 .../bindings/fpga/intel-stratix10-soc-fpga-mgr.txt |    3 +-
 .../bindings/interconnect/fsl,imx8m-noc.yaml       |  101 +
 Documentation/driver-api/soundwire/stream.rst      |   89 +-
 Documentation/driver-api/soundwire/summary.rst     |    7 +-
 Documentation/fpga/dfl.rst                         |   84 +
 Documentation/trace/coresight/coresight-ect.rst    |    6 +-
 Documentation/trace/coresight/coresight.rst        |   85 +
 Documentation/w1/slaves/w1_therm.rst               |   50 +-
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi      |    4 +-
 drivers/android/binderfs.c                         |    4 +-
 drivers/bus/mhi/core/boot.c                        |   75 +-
 drivers/bus/mhi/core/init.c                        |    8 +-
 drivers/bus/mhi/core/internal.h                    |    9 +-
 drivers/bus/mhi/core/main.c                        |  197 +-
 drivers/bus/mhi/core/pm.c                          |  229 +-
 drivers/char/mem.c                                 |  101 +-
 drivers/char/tlclk.c                               |   17 +-
 drivers/clk/zynqmp/clk-gate-zynqmp.c               |    9 +-
 drivers/clk/zynqmp/clk-mux-zynqmp.c                |    6 +-
 drivers/clk/zynqmp/clkc.c                          |   17 +-
 drivers/clk/zynqmp/divider.c                       |   12 +-
 drivers/clk/zynqmp/pll.c                           |   29 +-
 drivers/crypto/xilinx/zynqmp-aes-gcm.c             |   22 +-
 drivers/dca/dca-sysfs.c                            |    4 +-
 drivers/extcon/extcon-adc-jack.c                   |    3 +-
 drivers/extcon/extcon-arizona.c                    |   17 +-
 drivers/extcon/extcon-max14577.c                   |   10 +
 drivers/extcon/extcon.c                            |    2 +-
 drivers/firmware/stratix10-rsu.c                   |   10 +-
 drivers/firmware/stratix10-svc.c                   |   62 +-
 drivers/firmware/xilinx/zynqmp-debug.c             |    5 +-
 drivers/firmware/xilinx/zynqmp.c                   |  607 +-
 drivers/fpga/Kconfig                               |    2 +-
 drivers/fpga/Makefile                              |    1 +
 drivers/fpga/dfl-afu-dma-region.c                  |    4 +-
 drivers/fpga/dfl-afu-main.c                        |   35 +-
 drivers/fpga/dfl-fme-main.c                        |   23 +-
 drivers/fpga/dfl-fme-perf.c                        | 1020 +++
 drivers/fpga/dfl-fme.h                             |    2 +
 drivers/fpga/dfl.c                                 |   15 +-
 drivers/fpga/dfl.h                                 |   39 +-
 drivers/fpga/ice40-spi.c                           |   10 +-
 drivers/fpga/machxo2-spi.c                         |   12 +-
 drivers/fpga/stratix10-soc.c                       |   28 +-
 drivers/fpga/zynqmp-fpga.c                         |   14 +-
 drivers/gnss/serial.h                              |    2 +-
 drivers/gnss/sirf.c                                |    8 +-
 drivers/greybus/Kconfig                            |    6 +-
 drivers/greybus/arpc.h                             |    2 +-
 drivers/hwtracing/coresight/Makefile               |    3 +-
 .../hwtracing/coresight/coresight-cti-platform.c   |   11 +-
 drivers/hwtracing/coresight/coresight-cti-sysfs.c  |   16 +-
 drivers/hwtracing/coresight/coresight-cti.c        |  232 +-
 drivers/hwtracing/coresight/coresight-cti.h        |    8 +-
 drivers/hwtracing/coresight/coresight-etb10.c      |    2 +-
 drivers/hwtracing/coresight/coresight-etm3x.c      |    2 +-
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    |    2 +-
 drivers/hwtracing/coresight/coresight-etm4x.c      |   33 +-
 drivers/hwtracing/coresight/coresight-platform.c   |   91 +-
 drivers/hwtracing/coresight/coresight-priv.h       |   21 +-
 drivers/hwtracing/coresight/coresight-sysfs.c      |  204 +
 drivers/hwtracing/coresight/coresight-tmc-etf.c    |   16 +-
 drivers/hwtracing/coresight/coresight-tmc.c        |    2 +-
 drivers/hwtracing/coresight/coresight.c            |   82 +-
 drivers/interconnect/Kconfig                       |    3 +-
 drivers/interconnect/Makefile                      |    1 +
 drivers/interconnect/core.c                        |  143 +-
 drivers/interconnect/imx/Kconfig                   |   17 +
 drivers/interconnect/imx/Makefile                  |    9 +
 drivers/interconnect/imx/imx.c                     |  284 +
 drivers/interconnect/imx/imx.h                     |   61 +
 drivers/interconnect/imx/imx8mm.c                  |  105 +
 drivers/interconnect/imx/imx8mn.c                  |   94 +
 drivers/interconnect/imx/imx8mq.c                  |  103 +
 drivers/interconnect/internal.h                    |    2 +
 drivers/misc/cardreader/rts5249.c                  |   29 -
 drivers/misc/cardreader/rts5260.c                  |   26 -
 drivers/misc/cardreader/rts5261.c                  |   47 +-
 drivers/misc/cardreader/rtsx_pcr.c                 |   43 +-
 drivers/misc/cardreader/rtsx_pcr.h                 |    1 -
 drivers/misc/fastrpc.c                             |   13 +-
 drivers/misc/genwqe/card_utils.c                   |   42 +-
 drivers/misc/habanalabs/Makefile                   |    3 +
 drivers/misc/habanalabs/command_buffer.c           |   28 +-
 drivers/misc/habanalabs/command_submission.c       |  385 +-
 drivers/misc/habanalabs/context.c                  |    8 -
 drivers/misc/habanalabs/debugfs.c                  |  116 +
 drivers/misc/habanalabs/device.c                   |   53 +-
 drivers/misc/habanalabs/firmware_if.c              |  297 +-
 drivers/misc/habanalabs/gaudi/Makefile             |    5 +
 drivers/misc/habanalabs/gaudi/gaudi.c              | 6748 +++++++++++++++
 drivers/misc/habanalabs/gaudi/gaudiP.h             |  261 +
 drivers/misc/habanalabs/gaudi/gaudi_coresight.c    |  884 ++
 drivers/misc/habanalabs/gaudi/gaudi_hwmgr.c        |  121 +
 drivers/misc/habanalabs/gaudi/gaudi_security.c     | 9090 ++++++++++++++++++++
 drivers/misc/habanalabs/goya/goya.c                |  345 +-
 drivers/misc/habanalabs/goya/goyaP.h               |   12 +-
 drivers/misc/habanalabs/goya/goya_coresight.c      |    2 +-
 drivers/misc/habanalabs/goya/goya_security.c       |  100 +-
 drivers/misc/habanalabs/habanalabs.h               |  187 +-
 drivers/misc/habanalabs/habanalabs_drv.c           |   14 +-
 drivers/misc/habanalabs/habanalabs_ioctl.c         |   21 +
 drivers/misc/habanalabs/hw_queue.c                 |  118 +-
 drivers/misc/habanalabs/hwmon.c                    |   75 +
 drivers/misc/habanalabs/include/armcp_if.h         |   43 +-
 .../include/gaudi/asic_reg/cpu_if_regs.h           |  174 +
 .../include/gaudi/asic_reg/dma0_core_masks.h       |  348 +
 .../include/gaudi/asic_reg/dma0_core_regs.h        |  156 +
 .../include/gaudi/asic_reg/dma0_qm_masks.h         |  800 ++
 .../include/gaudi/asic_reg/dma0_qm_regs.h          |  834 ++
 .../include/gaudi/asic_reg/dma1_core_regs.h        |  156 +
 .../include/gaudi/asic_reg/dma1_qm_regs.h          |  834 ++
 .../include/gaudi/asic_reg/dma2_core_regs.h        |  156 +
 .../include/gaudi/asic_reg/dma2_qm_regs.h          |  834 ++
 .../include/gaudi/asic_reg/dma3_core_regs.h        |  156 +
 .../include/gaudi/asic_reg/dma3_qm_regs.h          |  834 ++
 .../include/gaudi/asic_reg/dma4_core_regs.h        |  156 +
 .../include/gaudi/asic_reg/dma4_qm_regs.h          |  834 ++
 .../include/gaudi/asic_reg/dma5_core_regs.h        |  156 +
 .../include/gaudi/asic_reg/dma5_qm_regs.h          |  834 ++
 .../include/gaudi/asic_reg/dma6_core_regs.h        |  156 +
 .../include/gaudi/asic_reg/dma6_qm_regs.h          |  834 ++
 .../include/gaudi/asic_reg/dma7_core_regs.h        |  156 +
 .../include/gaudi/asic_reg/dma7_qm_regs.h          |  834 ++
 .../gaudi/asic_reg/dma_if_e_n_down_ch0_regs.h      |  896 ++
 .../gaudi/asic_reg/dma_if_e_n_down_ch1_regs.h      |  896 ++
 .../include/gaudi/asic_reg/dma_if_e_n_regs.h       |  860 ++
 .../gaudi/asic_reg/dma_if_e_s_down_ch0_regs.h      |  896 ++
 .../gaudi/asic_reg/dma_if_e_s_down_ch1_regs.h      |  896 ++
 .../include/gaudi/asic_reg/dma_if_e_s_regs.h       |  860 ++
 .../gaudi/asic_reg/dma_if_w_n_down_ch0_regs.h      |  896 ++
 .../gaudi/asic_reg/dma_if_w_n_down_ch1_regs.h      |  896 ++
 .../include/gaudi/asic_reg/dma_if_w_n_regs.h       |  860 ++
 .../gaudi/asic_reg/dma_if_w_s_down_ch0_regs.h      |  896 ++
 .../gaudi/asic_reg/dma_if_w_s_down_ch1_regs.h      |  896 ++
 .../include/gaudi/asic_reg/dma_if_w_s_regs.h       |  860 ++
 .../include/gaudi/asic_reg/gaudi_blocks.h          | 4974 +++++++++++
 .../habanalabs/include/gaudi/asic_reg/gaudi_regs.h |  299 +
 .../include/gaudi/asic_reg/mme0_ctrl_regs.h        | 1456 ++++
 .../include/gaudi/asic_reg/mme0_qm_masks.h         |  800 ++
 .../include/gaudi/asic_reg/mme0_qm_regs.h          |  834 ++
 .../include/gaudi/asic_reg/mme1_ctrl_regs.h        | 1456 ++++
 .../include/gaudi/asic_reg/mme2_ctrl_regs.h        | 1456 ++++
 .../include/gaudi/asic_reg/mme2_qm_regs.h          |  834 ++
 .../include/gaudi/asic_reg/mme3_ctrl_regs.h        | 1456 ++++
 .../include/gaudi/asic_reg/mmu_up_regs.h           |   72 +
 .../include/gaudi/asic_reg/nif_rtr_ctrl_0_regs.h   |  896 ++
 .../include/gaudi/asic_reg/nif_rtr_ctrl_1_regs.h   |  896 ++
 .../include/gaudi/asic_reg/nif_rtr_ctrl_2_regs.h   |  896 ++
 .../include/gaudi/asic_reg/nif_rtr_ctrl_3_regs.h   |  896 ++
 .../include/gaudi/asic_reg/nif_rtr_ctrl_4_regs.h   |  896 ++
 .../include/gaudi/asic_reg/nif_rtr_ctrl_5_regs.h   |  896 ++
 .../include/gaudi/asic_reg/nif_rtr_ctrl_6_regs.h   |  896 ++
 .../include/gaudi/asic_reg/nif_rtr_ctrl_7_regs.h   |  896 ++
 .../include/gaudi/asic_reg/psoc_etr_regs.h         |  114 +
 .../gaudi/asic_reg/psoc_global_conf_masks.h        |  502 ++
 .../include/gaudi/asic_reg/psoc_global_conf_regs.h | 1062 +++
 .../include/gaudi/asic_reg/psoc_hbm_pll_regs.h     |  114 +
 .../include/gaudi/asic_reg/psoc_pci_pll_regs.h     |  114 +
 .../include/gaudi/asic_reg/psoc_timestamp_regs.h   |   56 +
 .../include/gaudi/asic_reg/sif_rtr_ctrl_0_regs.h   |  896 ++
 .../include/gaudi/asic_reg/sif_rtr_ctrl_1_regs.h   |  896 ++
 .../include/gaudi/asic_reg/sif_rtr_ctrl_2_regs.h   |  896 ++
 .../include/gaudi/asic_reg/sif_rtr_ctrl_3_regs.h   |  896 ++
 .../include/gaudi/asic_reg/sif_rtr_ctrl_4_regs.h   |  896 ++
 .../include/gaudi/asic_reg/sif_rtr_ctrl_5_regs.h   |  896 ++
 .../include/gaudi/asic_reg/sif_rtr_ctrl_6_regs.h   |  896 ++
 .../include/gaudi/asic_reg/sif_rtr_ctrl_7_regs.h   |  896 ++
 .../habanalabs/include/gaudi/asic_reg/stlb_regs.h  |   82 +
 .../include/gaudi/asic_reg/tpc0_cfg_masks.h        | 2578 ++++++
 .../include/gaudi/asic_reg/tpc0_cfg_regs.h         | 1226 +++
 .../include/gaudi/asic_reg/tpc0_qm_masks.h         |  800 ++
 .../include/gaudi/asic_reg/tpc0_qm_regs.h          |  834 ++
 .../include/gaudi/asic_reg/tpc1_cfg_regs.h         | 1226 +++
 .../include/gaudi/asic_reg/tpc1_qm_regs.h          |  834 ++
 .../include/gaudi/asic_reg/tpc2_cfg_regs.h         | 1226 +++
 .../include/gaudi/asic_reg/tpc2_qm_regs.h          |  834 ++
 .../include/gaudi/asic_reg/tpc3_cfg_regs.h         | 1226 +++
 .../include/gaudi/asic_reg/tpc3_qm_regs.h          |  834 ++
 .../include/gaudi/asic_reg/tpc4_cfg_regs.h         | 1226 +++
 .../include/gaudi/asic_reg/tpc4_qm_regs.h          |  834 ++
 .../include/gaudi/asic_reg/tpc5_cfg_regs.h         | 1226 +++
 .../include/gaudi/asic_reg/tpc5_qm_regs.h          |  834 ++
 .../include/gaudi/asic_reg/tpc6_cfg_regs.h         | 1226 +++
 .../include/gaudi/asic_reg/tpc6_qm_regs.h          |  834 ++
 .../include/gaudi/asic_reg/tpc7_cfg_regs.h         | 1226 +++
 .../include/gaudi/asic_reg/tpc7_qm_regs.h          |  834 ++
 drivers/misc/habanalabs/include/gaudi/gaudi.h      |   59 +
 .../habanalabs/include/gaudi/gaudi_async_events.h  |  310 +
 .../include/gaudi/gaudi_async_ids_map_extended.h   |  694 ++
 .../habanalabs/include/gaudi/gaudi_coresight.h     |  367 +
 .../misc/habanalabs/include/gaudi/gaudi_fw_if.h    |   36 +
 .../misc/habanalabs/include/gaudi/gaudi_masks.h    |  458 +
 .../misc/habanalabs/include/gaudi/gaudi_packets.h  |  212 +
 .../misc/habanalabs/include/gaudi/gaudi_reg_map.h  |   27 +
 .../habanalabs/include/goya/asic_reg/goya_masks.h  |    3 +-
 .../habanalabs/include/goya/asic_reg/goya_regs.h   |    1 +
 .../include/goya/asic_reg/psoc_timestamp_regs.h    |   56 +
 .../misc/habanalabs/include/goya/goya_reg_map.h    |   43 +-
 drivers/misc/habanalabs/include/hl_boot_if.h       |   58 +-
 .../habanalabs/include/hw_ip/mmu/mmu_general.h     |    2 +-
 .../misc/habanalabs/include/hw_ip/mmu/mmu_v1_1.h   |   16 +
 drivers/misc/habanalabs/memory.c                   |   37 +-
 drivers/misc/habanalabs/pci.c                      |   63 +-
 drivers/misc/habanalabs/sysfs.c                    |   17 +-
 drivers/misc/lkdtm/bugs.c                          |    2 +-
 drivers/misc/mic/scif/scif_nodeqp.c                |    2 +-
 drivers/misc/mic/scif/scif_rma.c                   |   26 +-
 drivers/misc/pci_endpoint_test.c                   |    4 +
 drivers/misc/sgi-xp/xpc_main.c                     |   10 +-
 drivers/misc/sgi-xp/xpnet.c                        |    8 +-
 drivers/misc/vmw_vmci/vmci_host.c                  |    2 -
 drivers/misc/xilinx_sdfec.c                        |   61 +-
 drivers/mmc/host/sdhci-of-arasan.c                 |   38 +-
 drivers/nvmem/core.c                               |  104 +-
 drivers/nvmem/imx-ocotp.c                          |    9 +-
 drivers/nvmem/jz4780-efuse.c                       |    4 +-
 drivers/nvmem/qfprom.c                             |   14 -
 drivers/nvmem/zynqmp_nvmem.c                       |   11 +-
 drivers/parport/daisy.c                            |   29 +-
 drivers/parport/ieee1284.c                         |   94 +-
 drivers/parport/ieee1284_ops.c                     |   70 +-
 drivers/parport/parport_amiga.c                    |   22 +-
 drivers/parport/parport_atari.c                    |    2 +-
 drivers/parport/parport_cs.c                       |    6 +-
 drivers/parport/parport_gsc.c                      |   25 +-
 drivers/parport/parport_gsc.h                      |   21 +-
 drivers/parport/parport_ip32.c                     |  117 +-
 drivers/parport/parport_mfc3.c                     |   21 +-
 drivers/parport/parport_pc.c                       |  263 +-
 drivers/parport/parport_sunbpp.c                   |    2 +-
 drivers/parport/probe.c                            |   34 +-
 drivers/parport/procfs.c                           |    6 +-
 drivers/parport/share.c                            |  292 +-
 drivers/reset/reset-zynqmp.c                       |   26 +-
 drivers/slimbus/core.c                             |    6 +-
 drivers/slimbus/qcom-ngd-ctrl.c                    |    5 +-
 drivers/soc/xilinx/zynqmp_pm_domains.c             |   26 +-
 drivers/soc/xilinx/zynqmp_power.c                  |   17 +-
 drivers/soundwire/Makefile                         |    8 +-
 drivers/soundwire/bus.c                            |   71 +-
 drivers/soundwire/bus.h                            |    4 +
 drivers/soundwire/bus_type.c                       |   22 +-
 drivers/soundwire/cadence_master.c                 |    8 +-
 drivers/soundwire/debugfs.c                        |    2 +-
 drivers/soundwire/intel.c                          |   13 +-
 drivers/soundwire/intel_init.c                     |    4 +-
 drivers/soundwire/master.c                         |  172 +
 drivers/soundwire/mipi_disco.c                     |   11 +-
 drivers/soundwire/qcom.c                           |   34 +-
 drivers/soundwire/slave.c                          |   10 +-
 drivers/soundwire/sysfs_local.h                    |   14 +
 drivers/soundwire/sysfs_slave.c                    |  214 +
 drivers/soundwire/sysfs_slave_dpn.c                |  300 +
 drivers/spi/spi-zynqmp-gqspi.c                     |    5 -
 drivers/uio/uio.c                                  |    2 +-
 drivers/uio/uio_dmem_genirq.c                      |    3 +-
 drivers/uio/uio_hv_generic.c                       |    1 +
 drivers/visorbus/controlvmchannel.h                |    2 +-
 drivers/visorbus/vbuschannel.h                     |    2 +-
 drivers/visorbus/visorbus_private.h                |    2 +-
 drivers/w1/masters/omap_hdq.c                      |   82 +-
 drivers/w1/slaves/w1_ds2430.c                      |    2 +-
 drivers/w1/slaves/w1_therm.c                       | 1668 +++-
 include/dt-bindings/interconnect/imx8mm.h          |   50 +
 include/dt-bindings/interconnect/imx8mn.h          |   41 +
 include/dt-bindings/interconnect/imx8mq.h          |   48 +
 include/linux/coresight.h                          |   32 +-
 include/linux/cpuhotplug.h                         |    1 +
 include/linux/firmware/intel/stratix10-smc.h       |   49 +-
 .../linux/firmware/intel/stratix10-svc-client.h    |   71 +-
 include/linux/firmware/xlnx-zynqmp.h               |  237 +-
 include/linux/greybus/greybus_protocols.h          |   44 +-
 include/linux/interconnect.h                       |   25 +
 include/linux/ioport.h                             |    6 +
 include/linux/mhi.h                                |   23 +-
 include/linux/parport.h                            |   16 +-
 include/linux/rtsx_pci.h                           |   25 -
 include/linux/soundwire/sdw.h                      |   32 +-
 include/linux/soundwire/sdw_type.h                 |    9 +-
 include/uapi/linux/magic.h                         |    1 +
 include/uapi/misc/habanalabs.h                     |  245 +-
 kernel/resource.c                                  |    5 +
 291 files changed, 98768 insertions(+), 2655 deletions(-)
 create mode 100644 Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
 create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-dfl_fme
 create mode 100644 Documentation/ABI/testing/sysfs-bus-soundwire-master
 create mode 100644 Documentation/ABI/testing/sysfs-bus-soundwire-slave
 create mode 100644 Documentation/ABI/testing/sysfs-driver-w1_therm
 create mode 100644 Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
 create mode 100644 drivers/fpga/dfl-fme-perf.c
 create mode 100644 drivers/hwtracing/coresight/coresight-sysfs.c
 create mode 100644 drivers/interconnect/imx/Kconfig
 create mode 100644 drivers/interconnect/imx/Makefile
 create mode 100644 drivers/interconnect/imx/imx.c
 create mode 100644 drivers/interconnect/imx/imx.h
 create mode 100644 drivers/interconnect/imx/imx8mm.c
 create mode 100644 drivers/interconnect/imx/imx8mn.c
 create mode 100644 drivers/interconnect/imx/imx8mq.c
 create mode 100644 drivers/misc/habanalabs/gaudi/Makefile
 create mode 100644 drivers/misc/habanalabs/gaudi/gaudi.c
 create mode 100644 drivers/misc/habanalabs/gaudi/gaudiP.h
 create mode 100644 drivers/misc/habanalabs/gaudi/gaudi_coresight.c
 create mode 100644 drivers/misc/habanalabs/gaudi/gaudi_hwmgr.c
 create mode 100644 drivers/misc/habanalabs/gaudi/gaudi_security.c
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/cpu_if_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma0_core_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma0_core_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma0_qm_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma0_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma1_core_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma1_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma2_core_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma2_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma3_core_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma3_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma4_core_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma4_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma5_core_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma5_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma6_core_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma6_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma7_core_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma7_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma_if_e_n_down_ch0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma_if_e_n_down_ch1_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma_if_e_n_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma_if_e_s_down_ch0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma_if_e_s_down_ch1_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma_if_e_s_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma_if_w_n_down_ch0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma_if_w_n_down_ch1_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma_if_w_n_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma_if_w_s_down_ch0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma_if_w_s_down_ch1_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma_if_w_s_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/gaudi_blocks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/gaudi_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/mme0_ctrl_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/mme0_qm_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/mme0_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/mme1_ctrl_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/mme2_ctrl_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/mme2_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/mme3_ctrl_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/mmu_up_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nif_rtr_ctrl_0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nif_rtr_ctrl_1_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nif_rtr_ctrl_2_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nif_rtr_ctrl_3_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nif_rtr_ctrl_4_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nif_rtr_ctrl_5_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nif_rtr_ctrl_6_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nif_rtr_ctrl_7_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/psoc_etr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/psoc_global_conf_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/psoc_global_conf_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/psoc_hbm_pll_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/psoc_pci_pll_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/psoc_timestamp_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/sif_rtr_ctrl_0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/sif_rtr_ctrl_1_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/sif_rtr_ctrl_2_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/sif_rtr_ctrl_3_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/sif_rtr_ctrl_4_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/sif_rtr_ctrl_5_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/sif_rtr_ctrl_6_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/sif_rtr_ctrl_7_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/stlb_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/tpc0_cfg_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/tpc0_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/tpc0_qm_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/tpc0_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/tpc1_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/tpc1_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/tpc2_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/tpc2_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/tpc3_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/tpc3_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/tpc4_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/tpc4_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/tpc5_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/tpc5_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/tpc6_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/tpc6_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/tpc7_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/tpc7_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/gaudi.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/gaudi_async_events.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/gaudi_async_ids_map_extended.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/gaudi_coresight.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/gaudi_fw_if.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/gaudi_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/gaudi_packets.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/gaudi_reg_map.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/psoc_timestamp_regs.h
 create mode 100644 drivers/misc/habanalabs/include/hw_ip/mmu/mmu_v1_1.h
 create mode 100644 drivers/soundwire/master.c
 create mode 100644 drivers/soundwire/sysfs_local.h
 create mode 100644 drivers/soundwire/sysfs_slave.c
 create mode 100644 drivers/soundwire/sysfs_slave_dpn.c
 create mode 100644 include/dt-bindings/interconnect/imx8mm.h
 create mode 100644 include/dt-bindings/interconnect/imx8mn.h
 create mode 100644 include/dt-bindings/interconnect/imx8mq.h
