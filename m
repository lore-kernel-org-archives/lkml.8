Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2452EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 17:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEFD5207FC
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 17:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596562617;
	bh=7VOadDP7HeOyYk+J6hZywf6lEzBnC7kM0pLcpXCAnMA=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=v9y9oR2YDR/qH6Di0e/DG6UFRRwty/Tn4i+58ZVb0FnxVUTbElKHCtNSEcqz4EWPX
	 rSiac9r0bSdM8jVR7mf9ihKYaGt1hTf9PyAMsKfU6tE2giuuQfxaivgZGPe0d+zX76
	 0MIhts92q5dh+6navfaDD6JfWAkF+3XC4oQF6ngI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729986AbgHDRgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 13:36:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:40592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729061AbgHDRgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 13:36:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F437207FC;
        Tue,  4 Aug 2020 17:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596562612;
        bh=7VOadDP7HeOyYk+J6hZywf6lEzBnC7kM0pLcpXCAnMA=;
        h=Date:From:To:Cc:Subject:From;
        b=XtzduG+tWtegAQ9NS3q/LI5JN26PDIr+vCtNvdrvOkYJp7oRlXVqQXUAREHBtvCsY
         XR80A1mqR/wkvjpaPP5AD0Bge9+X0xMGgpb1d9waz7hrBApvq8AveNMC42OzrsnbCW
         YH1VJQgdajsdVolIZtbgJ7djKZmYVo/DboG3ABhU=
Date:   Tue, 4 Aug 2020 19:37:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver patches for 5.9-rc1
Message-ID: <20200804173711.GA513530@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 92ed301919932f777713b9172e525674157e983d:

  Linux 5.8-rc7 (2020-07-26 14:14:06 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.9-rc1

for you to fetch changes up to 22362aa30bad6f03b5bcbbeee3cdc61950d40086:

  habanalabs: remove unused but set variable 'ctx_asid' (2020-07-29 18:02:21 +0200)

----------------------------------------------------------------
Char/Misc driver patches for 5.9-rc1

Here is the large set of char and misc and other driver subsystem
patches for 5.9-rc1.  Lots of new driver submissions in here, and
cleanups and features for existing drivers.

Highlights are:
	- habanalabs driver updates
	- coresight driver updates
	- nvmem driver updates
	- huge number of "W=1" build warning cleanups from Lee Jones
	- dyndbg updates
	- virtbox driver fixes and updates
	- soundwire driver updates
	- mei driver updates
	- phy driver updates
	- fpga driver updates
	- lots of smaller individual misc/char driver cleanups and fixes

Full details are in the shortlog.

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Adam Aharon (1):
      habanalabs: calculate trace frequency from PLL

Alexander A. Klimov (3):
      mei: Replace HTTP links with HTTPS ones
      misc: Replace HTTP links with HTTPS ones
      char: Replace HTTP links with HTTPS ones

Alexander Usyskin (1):
      mei: add device kind to sysfs

Alim Akhtar (2):
      dt-bindings: phy: Document Samsung UFS PHY bindings
      phy: samsung-ufs: add UFS PHY driver for samsung SoC

Andreas Färber (2):
      nvmem: core: Grammar fixes for help text
      nvmem: core: Add nvmem_cell_read_u8()

Andy Shevchenko (2):
      mux: adgs1408: Add mod_devicetable.h and remove of_match_ptr
      coresight: Drop double check for ACPI companion device

Ansuel Smith (2):
      phy: qualcomm: add qcom ipq806x dwc usb phy driver
      devicetree: bindings: phy: Document ipq806x dwc3 qcom phy

Anurag Kumar Vulisha (2):
      dt-bindings: phy: Add DT bindings for Xilinx ZynqMP PSGTR PHY
      phy: zynqmp: Add PHY driver for the Xilinx ZynqMP Gigabit Transceiver

Artur Świgoń (3):
      interconnect: Export of_icc_get_from_provider()
      interconnect: Relax requirement in of_icc_get_from_provider()
      interconnect: Allow inter-provider pairs to be configured

Bard Liao (3):
      soundwire: bus: clock_stop: don't deal with UNATTACHED Slave devices
      soundwire: intel/cadence: merge Soundwire interrupt handlers/threads
      Soundwire: intel_init: save Slave(s) _ADR info in sdw_intel_ctx

Bjorn Helgaas (5):
      misc: rtsx: Use pcie_capability_clear_and_set_word() for PCI_EXP_LNKCTL
      misc: rtsx: Remove unused pcie_cap
      misc: rtsx: Remove rtsx_pci_read/write_config() wrappers
      misc: rtsx: Find L1 PM Substates capability instead of hard-coding
      misc: rtsx: Use standard PCI definitions

Christine Gharzuzi (1):
      habanalabs: extract cpu boot status lookup

Christophe JAILLET (2):
      misc: hpilo: switch from 'pci_' to 'dma_' API
      misc: hpilo: avoid a useless memset

Colin Ian King (3):
      ttyprintk: remove redundant initialization of variable ret
      char/mwave: remove redundant initialization of variable bRC
      phy: qualcomm: fix setting of tx_deamp_3_5db when device property read fails

Douglas Anderson (1):
      nvmem: Enforce nvmem stride in the sysfs interface

Esben Haabendal (1):
      uio_pdrv_genirq: Allow use with non-page-aligned memory resources

Freeman Liu (1):
      nvmem: sc27xx: add sc2730 efuse support

Georgi Djakov (1):
      interconnect: Mark all dummy functions as static inline

Greg Kroah-Hartman (11):
      Revert "cardreader/rtsx_pcr.c: use generic power management"
      Merge branch 'char-misc-linus' into 'char-misc-next'
      Merge v5.8-rc6 into char-misc-next
      Merge tag 'soundwire-5.9-rc1' of git://git.kernel.org/.../vkoul/soundwire into char-misc-next
      Merge tag 'fpga-for-5.9' of git://git.kernel.org/.../mdf/linux-fpga into char-misc-next
      Merge tag 'phy-for-5.9' of git://git.kernel.org/.../phy/linux-phy into char-misc-next
      Revert "mei: Avoid the use of one-element arrays"
      Merge tag 'icc-5.9-rc1' of https://git.linaro.org/people/georgi.djakov/linux into char-misc-next
      Merge tag 'misc-habanalabs-next-2020-07-24' of git://people.freedesktop.org/~gabbayo/linux into char-misc-next
      Merge 5.8-rc7 into char-misc-next
      habanalabs: fix up absolute include instructions

Grigore Popescu (1):
      bus: fsl-mc: probe the allocatable objects first

Guru Das Srinagesh (1):
      nvmem: qcom-spmi-sdam: Enable multiple devices

Gustavo A. R. Silva (6):
      fpga: dfl: Use struct_size() in kzalloc()
      hpilo: Replace one-element array with flexible-array member
      phy: samsung-ufs: Fix IS_ERR argument
      mei: hdcp: Replace one-element array with flexible-array member
      mei: Avoid the use of one-element arrays
      greybus: Use fallthrough pseudo-keyword

Hans de Goede (6):
      virt: vbox: Rename guest_caps struct members to set_guest_caps
      virt: vbox: Add vbg_set_host_capabilities() helper function
      virt: vbox: Add support for the new VBG_IOCTL_ACQUIRE_GUEST_CAPABILITIES ioctl
      virt: vbox: Add a few new vmmdev request types to the userspace whitelist
      virt: vbox: Log unknown ioctl requests as error
      virt: vbox: Fix some comments which talk about the "session spinlock"

Ioana Ciornei (1):
      bus: fsl-mc: add missing device types

Jann Horn (1):
      binder: Prevent context manager from incrementing ref 0

Jim Cromie (18):
      dyndbg-docs: eschew file /full/path query in docs
      dyndbg-docs: initialization is done early, not arch
      dyndbg: drop obsolete comment on ddebug_proc_open
      dyndbg: refine debug verbosity; 1 is basic, 2 more chatty
      dyndbg: rename __verbose section to __dyndbg
      dyndbg: fix overcounting of ram used by dyndbg
      dyndbg: fix a BUG_ON in ddebug_describe_flags
      dyndbg: fix pr_err with empty string
      dyndbg: prefer declarative init in caller, to memset in callee
      dyndbg: make ddebug_tables list LIFO for add/remove_module
      dyndbg: use gcc ?: to reduce word count
      dyndbg: refactor parse_linerange out of ddebug_parse_query
      dyndbg: accept 'file foo.c:func1' and 'file foo.c:10-100'
      dyndbg: accept query terms like file=bar and module=foo
      dyndbg: combine flags & mask into a struct, simplify with it
      dyndbg: allow anchored match on format query term
      dyndbg: shorten our logging prefix, drop __func__
      dyndbg: export ddebug_exec_queries

John Hubbard (1):
      fpga: dfl: afu: convert get_user_pages() --> pin_user_pages()

Jonathan Marek (3):
      phy: qcom-qmp: Allow different values for second lane
      phy: qcom-qmp: Add QMP V4 USB3 UNIPHY
      phy: qcom-qmp: Add QMP V4 USB3 PHY support for sm8250

Kees Cook (4):
      lkdtm: Avoid more compiler optimizations for bad writes
      lkdtm/heap: Avoid edge and middle of slabs
      selftests/lkdtm: Reset WARN_ONCE to avoid false negatives
      lkdtm: Make arch-specific tests always available

Krzysztof Kozlowski (1):
      phy: exynos: Rename Exynos to lowercase

Kunihiko Hayashi (1):
      dt-bindings: phy: uniphier: Fix incorrect clocks and clock-names for PXs3 usb3-hsphy

Lad Prabhakar (2):
      dt-bindings: phy: renesas,usb2-phy: Add r8a774e1 support
      dt-bindings: phy: renesas,usb3-phy: Add r8a774e1 support

Laurent Pinchart (1):
      dt-bindings: phy: zynqmp-psgtr: Fix example's numbers of cells in reg

Laurentiu Tudor (1):
      bus: fsl-mc: use raw spin lock to serialize mc cmds

Lee Jones (59):
      misc: c2port: core: Ensure source size does not equal destination size in strncpy()
      misc: ti-st: st_core: Tidy-up bespoke commentry
      misc: ti-st: st_kim: Tidy-up bespoke commentry
      misc: lkdtm: bugs: At least try to use popuated variable
      misc: eeprom: eeprom_93cx6: Repair function arg descriptions
      misc: mic: vop: vop_main: Remove set but unused variable 'ret'
      misc: cb710: sgbuf2: Add missing documentation for cb710_sg_dwiter_write_next_block()'s 'data' arg
      misc: habanalabs: irq: Add missing struct identifier for 'struct hl_eqe_work'
      misc: pti: Fix documentation for bit-rotted function pti_tty_driver_write()
      misc: pti: Repair kerneldoc formatting issues
      misc: pti: Remove unparsable empty line in function header
      misc: habanalabs: firmware_if: Add missing 'fw_name' and 'dst' entries to function header
      misc: habanalabs: pci: Fix a variety of kerneldoc issues
      misc: habanalabs: irq: Repair kerneldoc formatting issues
      misc: habanalabs: goya: Omit pointless check ensuring addr is >=0
      misc: habanalabs: pci: Scrub documentation for non-present function argument
      misc: habanalabs: goya: goya_coresight: Remove set but unused variable 'val'
      misc: habanalabs: gaudi: Remove ill placed asterisk from kerneldoc header
      misc: habanalabs: gaudi: gaudi_security: Repair incorrectly named function arg
      misc: enclosure: Fix some kerneldoc anomalies
      misc: lattice-ecp3-config: Remove set but clearly unused variable 'ret'
      misc: pch_phub: Provide descriptions for 'chip' argument
      misc: pch_phub: Remove superfluous descriptions to non-existent args 'offset_address'
      misc: enclosure: Update enclosure_remove_device() documentation to match reality
      misc: genwqe: card_base: Remove set but unused variable 'rc'
      misc: genwqe: card_base: Provide documentation for genwqe_recover_card()'s args
      misc: genwqe: card_base: Whole host of kerneldoc fixes
      misc: genwqe: card_dev: Whole host of kerneldoc fixes
      misc: genwqe: card_utils: Whole a plethora of documentation issues
      misc: genwqe: card_ddcb: Fix a variety of kerneldoc issues
      misc: genwqe: card_sysfs: Demote function/file headers from kerneldoc
      misc: genwqe: card_debugfs: Demote file header from kerneldoc
      misc: sgi-xp: xp_main: Staticify local functions xp_init() and xp_exit()
      misc: ibmasm: event: Demote function headers from kerneldoc
      misc: ibmasm: command: Demote function headers from kerneldoc
      misc: ibmasm: r_heartbeat: Demote function headers from kerneldoc
      misc: mic: host: mic_x100: Move declaration of mic_x100_intr_init[] into c-file
      misc: ibmasm: dot_command: Demote function headers from kerneldoc
      misc: mic: host: mic_intr: Properly document function arguments
      misc: mic: host: mic_x100: Add missing descriptions to kerneldoc headers
      misc: mic: card: mic_debugfs: Demote function headers from kerneldoc
      misc: mic: host: mic_debugfs: Demote function headers from kerneldoc
      misc: mic: cosm: cosm_main: Document 'force' function argument
      misc: mic: scif: scif_ports: Fix copy 'n' paste error
      misc: mic: cosm: cosm_debugfs: Demote function headers from kerneldoc
      misc: mic: scif: scif_api: Remove set but unused variable 'read_size'
      misc: mic: scif: scif_api: Demote scif_accept() function header
      misc: mic: scif: scif_epd: Describe missing 'scifdev' argument(s)
      misc: mic: scif: scif_nodeqp: Fix a bunch of kerneldoc issues
      misc: mic: scif: scif_nm: Supply various kerneldoc fix-ups
      misc: mic: scif: scif_dma: Fix a couple of kerneldoc issues
      misc: mic: scif: scif_fence: Fix a bunch of different documentation issues
      misc: mic: scif: scif_rma: Repair a bunch of kerneldoc issues
      misc: cxl: hcalls: Demote half-assed kerneldoc attempt
      misc: ocxl: config: Provide correct formatting to function headers
      misc: ibmvmc: Repair ill-named function argument descriptions
      misc: eeprom: at24: Tell the compiler that ACPI functions may not be used
      misc: cxl: flash: Remove unused variable 'drc_index'
      misc: vmw_vmci_defs: Mark 'struct vmci_handle VMCI_ANON_SRC_HANDLE' as __maybe_unused

Liao Pingfang (1):
      misc: mic: Remove the error message as the call will print it

Luca Ceresoli (5):
      dt-bindings: fpga: xilinx-slave-serial: valid for the 7 Series too
      fpga manager: xilinx-spi: valid for the 7 Series too
      fpga manager: xilinx-spi: remove unneeded, mistyped variables
      dt-bindings: fpga: xilinx-slave-serial: add optional INIT_B GPIO
      fpga manager: xilinx-spi: check INIT_B pin during write_init

Marek Szyprowski (1):
      phy: exynos5-usbdrd: Calibrating makes sense only for USB2.0 PHY

Masahiro Yamada (1):
      char: raw: do not leak CONFIG_MAX_RAW_DEVS to userspace

Matteo Croce (1):
      nvmem: update Kconfig description

Michael S. Tsirkin (1):
      vop: sparse warning fixup

Mike Leach (6):
      coresight: etmv4: Fix resource selector constant
      coresight: etmv4: Counter values not saved on disable
      coresight: Fix comment in main header file
      coresight: Add default sink selection to CoreSight base
      coresight: tmc: Update sink types for default selection
      coresight: etm: perf: Add default sink selection to etm perf

Moti Haimovski (1):
      habanalabs: check for DMA errors when clearing memory

Mrinal Pandey (5):
      drivers: android: Fix a variable declaration coding style issue
      drivers: android: Remove the use of else after return
      drivers: android: Remove braces for a single statement if-else block
      drivers: android: Fix a variable declaration coding style issue
      drivers: android: Fix the SPDX comment style

Oded Gabbay (10):
      habanalabs: remove rate limiters from GAUDI
      uapi/habanalabs: fix some comments
      habanalabs: align armcp_packet structure to 8 bytes
      habanalabs: rephrase error messages
      habanalabs: Extract ECC information from FW
      habanalabs: remove soft-reset support from GAUDI
      habanalabs: halt device CPU only upon certain reset
      habanalabs: create common folder
      habanalabs: update hl_boot_if.h from firmware
      habanalabs: enable device before hw_init()

Ofir Bitton (11):
      habanalabs: Use pending CS amount per ASIC
      habanalabs: sync stream generic functionality
      habanalabs: Use mask instead of shift in sync stream registers
      habanalabs: Increase queues depth
      habanalabs: Add dropped cs statistics info struct
      habanalabs: PCIe iATU refactoring
      habanalabs: configure maximum queues per asic
      habanalabs: use queue pi/ci in order to determine queue occupancy
      habanalabs: Assign each CQ with its own work queue
      habanalabs: verify queue can contain all cs jobs
      habanalabs: create internal CB pool

Omer Shpigelman (2):
      habanalabs: rephrase error message
      habanalabs: remove unused hash

Peter Chen (1):
      phy: cadence: salvo: fix wrong bit definition

Pierre-Louis Bossart (23):
      soundwire: intel: cleanups for indirections/logs
      soundwire: intel: clarify drvdata and remove more indirections
      soundwire: intel_init: remove useless test
      soundwire: intel_init: use devm_ allocation
      soundwire: intel_init: pass link information as platform data
      soundwire: intel: transition to 3 steps initialization
      soundwire: add definitions for 1.2 spec
      soundwire: bus_type: convert open-coded while() to for() loop
      soundwire: extend SDW_SLAVE_ENTRY
      soundwire: bus: initialize bus clock base and scale registers
      soundwire: intel: implement get_sdw_stream() operations
      soundwire: stream: add helper to startup/shutdown streams
      soundwire: intel: remove stream allocation/free
      soundwire: cadence: allocate/free dma_data in set_sdw_stream
      soundwire: intel: don't free dma_data in DAI shutdown
      soundwire: sdw.h: fix PRBS/Static_1 swapped definitions
      soundwire: sdw.h: fix indentation
      soundwire: intel: reuse code for wait loops to set/clear bits
      soundwire: intel: revisit SHIM programming sequences.
      soundwire: intel: introduce a helper to arm link synchronization
      soundwire: intel: introduce helper for link synchronization
      soundwire: intel_init: add implementation of sdw_intel_enable_irq()
      soundwire: intel_init: use EXPORT_SYMBOL_NS

Rander Wang (1):
      soundwire: intel: add wake interrupt support

Randy Dunlap (8):
      Documentation/driver-api: firmware/built-in-fw: drop doubled word
      Documentation/driver-api: firmware/firmware_cache: drop doubled word
      Documentation/driver-api: firmware/direct-fs-lookup: drop doubled word
      Documentation/driver-api: firmware/request_firmware: drop doubled word
      Documentation/driver-api: uio-howto: drop doubled word
      Documentation/driver-api: xillybus: drop doubled word
      misc: mic: <linux/mic_bus.h>: drop a duplicated word
      android: binder.h: drop a duplicated word

Ravi Kumar Bokka (3):
      dt-bindings: nvmem: qfprom: Convert to yaml
      dt-bindings: nvmem: Add properties needed for blowing fuses
      nvmem: qfprom: Add fuse blowing support

Richard Gong (5):
      firmware: stratix10-svc: correct reconfig flag and timeout values
      firmware: stratix10-svc: extend svc to support new RSU features
      firmware: stratix10-rsu: extend rsu driver for new features
      firmware: rsu: add device attributes to sysfs interface
      firmware: stratix10-rsu: fix warnings

Ricky Wu (1):
      misc: rtsx: Add support new chip rts5228 mmc: rtsx: Add support MMC_CAP2_NO_MMC

Rikard Falkeborn (7):
      soundwire: qcom: Constify static structs
      mic: vop: Constify static structs
      mei: hdcp: Constify struct mei_cl_device_id
      misc: genwqe: Constify struct pci_error_handlers
      misc: rtsx_usb: Constify struct usb_device_id
      phy: allwinner: phy-sun6i-mipi-dphy: Constify structs
      virtio_console: Constify some static variables

Russell King (2):
      dt: update Marvell Armada 38x COMPHY binding
      phy: armada-38x: fix NETA lockup when repeatedly switching speeds

Saheed O. Bolarinwa (1):
      cxl: Change PCIBIOS_SUCCESSFUL to 0

Sai Prakash Ranjan (6):
      coresight: replicator: Use CS_AMBA_ID macro for id table
      coresight: catu: Use CS_AMBA_ID macro for id table
      coresight: replicator: Reset replicator if context is lost
      dt-bindings: arm: coresight: Add optional property to replicators
      coresight: tmc: Add shutdown callback for TMC ETR
      coresight: tmc: Fix TMC mode read in tmc_read_unprepare_etb()

Sanyog Kale (1):
      MAINTAINERS: change SoundWire maintainer

Sivaprakash Murugesan (4):
      dt-bindings: phy: qcom,qmp: Add ipq8074 usb dt bindings
      dt-bindings: phy: qcom,qusb2: Add ipq8074 device compatible
      phy: qcom-qmp: Add USB QMP PHY support for IPQ8074
      phy: qcom-qusb2: Add ipq8074 device compatible

Srinivas Kandagatla (2):
      nvmem: core: add support to auto devid
      nvmem: qfprom: use NVMEM_DEVID_AUTO for multiple instances

Suren Baghdasaryan (1):
      MAINTAINERS: add Hridya and myself into Android driver maintainers list

Suzuki K Poulose (1):
      coresight: etm4x: Fix save/restore during cpu idle

Thommy Jakobsson (1):
      uio: disable lazy irq disable to avoid double fire

Tiezhu Yang (4):
      phy: Remove CONFIG_ARCH_* check for related subdir in Makefile
      phy: allwinner: Make PHY_SUN6I_MIPI_DPHY depend on COMMON_CLK
      nvmem: sprd: Fix return value of sprd_efuse_probe()
      MAINTAINERS: Add git tree for NVMEM FRAMEWORK

Tingwei Zhang (2):
      coresight: etm4x: Add support to skip trace unit power up
      dt-bindings: arm: coresight: Add support to skip trace unit power up

Tobias Klauser (1):
      phy: zynqmp: Fix unused-function compiler warning

Tom Rix (2):
      fpga: Fix dead store fpga-mgr.c
      fpga: Fix dead store in fpga-bridge.c

Tomas Winkler (12):
      mei: me: constify the device parameter to the probe quirk
      mei: me: make mei_me_fw_sku_sps_4() less cryptic
      mei: me: add kdoc for mei_me_fw_type_nm()
      mei: me: add MEI device for SPT with ITPS capability
      mei: me: add MEI device for KBP with ITPS capability
      mei: hbm: use sizeof of variable instead of struct type
      mei: ioctl: use sizeof of variable instead of struct type
      mei: bus: use sizeof of variable instead of struct type
      mei: client: use sizeof of variable instead of struct type
      mei: hw: use sizeof of variable instead of struct type
      mei: hw: don't use one element arrays
      MAINTAINERS: Fix maintainer entry for mei driver

Tomer Tayar (2):
      habanalabs: use no flags on MMU cache invalidation
      habanalabs: Fix memory leak in error flow of context initialization

Vaibhav Gupta (6):
      cb710/core.c: use generic power management
      cardreader/rtsx_pcr.c: use generic power management
      misc/tifm_7xx1.c: use generic power management
      misc/phantom.c: use generic power management
      misc/pch_phub.c: use generic power management
      cardreader/rtsx_pcr.c: use generic power management

Vinod Koul (15):
      soundwire: Replace 'objs' by 'y'
      phy: qcom: remove ufs qmp phy driver
      phy: core: fix code style in devm_of_phy_provider_unregister
      phy: core: Document function args
      phy: ti: dm816x: remove set but unused variable
      phy: ti-pipe3: remove set but unused variable
      phy-mvebu-a3700-utmi: correct typo in struct mvebu_a3700_utmi comments
      phy: mapphone-mdm6600: Add missing description for some structure fields
      phy: xgene: remove unsigned integer comparison with less than zero
      phy: rockchip-typec: use correct format for structure description
      phy: exynos5-usbdrd: use correct format for structure description
      phy: stm32: use NULL instead of zero
      soundwire: fix the kernel-doc comment
      phy: sun4i-usb: explicitly include gpio/consumer.h
      Merge branch 'fixes' into next

Wang Hai (1):
      cxl: Fix kobject memleak

Wei Yongjun (1):
      habanalabs: remove unused but set variable 'ctx_asid'

Wesley Cheng (2):
      phy: qcom-snps: Add runtime suspend and resume handlers
      phy: qcom-snps: Add a set mode callback

Xu Wang (1):
      coresight: Use devm_kcalloc() in coresight_alloc_conns()

Xu Yilun (8):
      fpga: dfl: parse interrupt info for feature devices on enumeration
      fpga: dfl: pci: add irq info for feature devices enumeration
      fpga: dfl: introduce interrupt trigger setting API
      fpga: dfl: afu: add interrupt support for port error reporting
      fpga: dfl: fme: add interrupt support for global error reporting
      fpga: dfl: afu: add AFU interrupt support
      Documentation: fpga: dfl: add descriptions for interrupt related interfaces.
      fpga: dfl: pci: add device id for Intel FPGA PAC N3000

Yangtao Li (1):
      dt-bindings: nvmem: SID: add binding for A100's SID controller

Yoshihiro Shimoda (2):
      phy: renesas: rcar-gen3-usb2: move irq registration to init
      phy: renesas: rcar-gen3-usb2: exit if request_irq() failed

Zhangfei Gao (1):
      uacce: remove uacce_vma_fault

kernel test robot (1):
      habanalabs: goya_ctx_init() can be static

Álvaro Fernández Rojas (2):
      dt-bindings: phy: add bcm63xx-usbh bindings
      phy: bcm63xx-usbh: Add BCM63xx USBH driver

 Documentation/ABI/testing/sysfs-class-mei          |  13 +
 .../testing/sysfs-devices-platform-stratix10-rsu   |  36 +
 Documentation/admin-guide/dynamic-debug-howto.rst  |  29 +-
 .../devicetree/bindings/arm/coresight.txt          |  13 +
 .../bindings/fpga/xilinx-slave-serial.txt          |  16 +-
 .../bindings/nvmem/allwinner,sun4i-a10-sid.yaml    |  19 +-
 .../devicetree/bindings/nvmem/qcom,qfprom.yaml     |  96 ++
 Documentation/devicetree/bindings/nvmem/qfprom.txt |  35 -
 .../bindings/phy/brcm,bcm63xx-usbh-phy.yaml        |  79 ++
 .../bindings/phy/phy-armada38x-comphy.txt          |  10 +-
 .../bindings/phy/qcom,ipq806x-usb-phy-hs.yaml      |  55 ++
 .../bindings/phy/qcom,ipq806x-usb-phy-ss.yaml      |  73 ++
 .../devicetree/bindings/phy/qcom,qmp-phy.yaml      |   2 +
 .../devicetree/bindings/phy/qcom,qusb2-phy.yaml    |   1 +
 .../devicetree/bindings/phy/renesas,usb2-phy.yaml  |   1 +
 .../devicetree/bindings/phy/renesas,usb3-phy.yaml  |   1 +
 .../devicetree/bindings/phy/samsung,ufs-phy.yaml   |  75 ++
 .../phy/socionext,uniphier-usb3hs-phy.yaml         |   8 +-
 .../devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml | 105 +++
 Documentation/driver-api/firmware/built-in-fw.rst  |   2 +-
 .../driver-api/firmware/direct-fs-lookup.rst       |   2 +-
 .../driver-api/firmware/firmware_cache.rst         |   2 +-
 .../driver-api/firmware/request_firmware.rst       |   2 +-
 Documentation/driver-api/soundwire/stream.rst      |  11 +-
 Documentation/driver-api/uio-howto.rst             |   2 +-
 Documentation/driver-api/xillybus.rst              |   2 +-
 Documentation/fpga/dfl.rst                         |  19 +
 MAINTAINERS                                        |  17 +-
 drivers/android/binder.c                           |  23 +-
 drivers/android/binder_alloc.c                     |   1 +
 drivers/android/binderfs.c                         |   3 +-
 drivers/bus/fsl-mc/dprc-driver.c                   |  57 +-
 drivers/bus/fsl-mc/fsl-mc-bus.c                    |  30 +
 drivers/bus/fsl-mc/mc-io.c                         |   2 +-
 drivers/bus/fsl-mc/mc-sys.c                        |   4 +-
 drivers/char/Kconfig                               |   6 +-
 drivers/char/mwave/smapi.c                         |   4 +-
 drivers/char/raw.c                                 |   8 +-
 drivers/char/ttyprintk.c                           |   2 +-
 drivers/char/virtio_console.c                      |   8 +-
 drivers/firmware/stratix10-rsu.c                   | 170 +++-
 drivers/firmware/stratix10-svc.c                   |  17 +
 drivers/fpga/dfl-afu-dma-region.c                  |  19 +-
 drivers/fpga/dfl-afu-error.c                       |  17 +
 drivers/fpga/dfl-afu-main.c                        |  32 +
 drivers/fpga/dfl-fme-error.c                       |  18 +
 drivers/fpga/dfl-fme-main.c                        |   6 +
 drivers/fpga/dfl-pci.c                             |  78 +-
 drivers/fpga/dfl.c                                 | 313 ++++++-
 drivers/fpga/dfl.h                                 |  63 +-
 drivers/fpga/fpga-bridge.c                         |   6 +-
 drivers/fpga/fpga-mgr.c                            |   4 +-
 drivers/fpga/xilinx-spi.c                          |  61 +-
 drivers/greybus/es2.c                              |   2 +-
 drivers/greybus/interface.c                        |   2 +-
 drivers/hwtracing/coresight/coresight-catu.c       |   5 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c   |  17 +-
 drivers/hwtracing/coresight/coresight-etm4x.c      |  49 +-
 drivers/hwtracing/coresight/coresight-etm4x.h      |   9 +-
 drivers/hwtracing/coresight/coresight-platform.c   |   5 +-
 drivers/hwtracing/coresight/coresight-priv.h       |   2 +
 drivers/hwtracing/coresight/coresight-replicator.c |  68 +-
 drivers/hwtracing/coresight/coresight-stm.c        |   2 -
 drivers/hwtracing/coresight/coresight-tmc-etf.c    |  13 +-
 drivers/hwtracing/coresight/coresight-tmc-etr.c    |   2 +-
 drivers/hwtracing/coresight/coresight-tmc.c        |  26 +-
 drivers/hwtracing/coresight/coresight-tmc.h        |   1 +
 drivers/hwtracing/coresight/coresight.c            | 166 ++++
 drivers/interconnect/core.c                        |  16 +-
 drivers/misc/Kconfig                               |   2 +-
 drivers/misc/c2port/core.c                         |   2 +-
 drivers/misc/cardreader/Makefile                   |   2 +-
 drivers/misc/cardreader/rtl8411.c                  |   8 +-
 drivers/misc/cardreader/rts5209.c                  |   5 +-
 drivers/misc/cardreader/rts5227.c                  |   5 +-
 drivers/misc/cardreader/rts5228.c                  | 747 ++++++++++++++++
 drivers/misc/cardreader/rts5228.h                  | 168 ++++
 drivers/misc/cardreader/rts5229.c                  |   5 +-
 drivers/misc/cardreader/rts5249.c                  |  28 +-
 drivers/misc/cardreader/rts5260.c                  |  23 +-
 drivers/misc/cardreader/rts5261.c                  |  32 +-
 drivers/misc/cardreader/rtsx_pcr.c                 | 129 +--
 drivers/misc/cardreader/rtsx_pcr.h                 |   5 +
 drivers/misc/cardreader/rtsx_usb.c                 |   2 +-
 drivers/misc/cb710/core.c                          |  28 +-
 drivers/misc/cb710/sgbuf2.c                        |   1 +
 drivers/misc/cxl/flash.c                           |   4 +-
 drivers/misc/cxl/hcalls.c                          |  42 +-
 drivers/misc/cxl/sysfs.c                           |   2 +-
 drivers/misc/cxl/vphb.c                            |   4 +-
 drivers/misc/echo/echo.c                           |   6 +-
 drivers/misc/eeprom/at24.c                         |   2 +-
 drivers/misc/eeprom/eeprom_93cx6.c                 |   4 +-
 drivers/misc/enclosure.c                           |   8 +-
 drivers/misc/genwqe/card_base.c                    |  32 +-
 drivers/misc/genwqe/card_ddcb.c                    |  20 +-
 drivers/misc/genwqe/card_debugfs.c                 |   2 +-
 drivers/misc/genwqe/card_dev.c                     |  24 +-
 drivers/misc/genwqe/card_sysfs.c                   |   8 +-
 drivers/misc/genwqe/card_utils.c                   |  30 +-
 drivers/misc/habanalabs/Makefile                   |  11 +-
 drivers/misc/habanalabs/common/Makefile            |   7 +
 drivers/misc/habanalabs/{ => common}/asid.c        |   0
 .../misc/habanalabs/{ => common}/command_buffer.c  |  82 +-
 .../habanalabs/{ => common}/command_submission.c   |  92 +-
 drivers/misc/habanalabs/{ => common}/context.c     |  39 +-
 drivers/misc/habanalabs/{ => common}/debugfs.c     |   2 +-
 drivers/misc/habanalabs/{ => common}/device.c      |  88 +-
 drivers/misc/habanalabs/{ => common}/firmware_if.c | 104 ++-
 drivers/misc/habanalabs/{ => common}/habanalabs.h  | 172 ++--
 .../misc/habanalabs/{ => common}/habanalabs_drv.c  |   1 -
 .../habanalabs/{ => common}/habanalabs_ioctl.c     |  24 +
 drivers/misc/habanalabs/{ => common}/hw_queue.c    | 165 ++--
 drivers/misc/habanalabs/{ => common}/hwmon.c       |   0
 drivers/misc/habanalabs/{ => common}/irq.c         |  38 +-
 drivers/misc/habanalabs/{ => common}/memory.c      |   5 +-
 drivers/misc/habanalabs/{ => common}/mmu.c         |   3 +-
 drivers/misc/habanalabs/{ => common}/pci.c         | 151 ++--
 drivers/misc/habanalabs/{ => common}/sysfs.c       |   3 +
 drivers/misc/habanalabs/gaudi/Makefile             |   2 -
 drivers/misc/habanalabs/gaudi/gaudi.c              | 909 +++++++------------
 drivers/misc/habanalabs/gaudi/gaudiP.h             |  24 +-
 drivers/misc/habanalabs/gaudi/gaudi_coresight.c    |  12 +-
 drivers/misc/habanalabs/gaudi/gaudi_hwmgr.c        |   2 +-
 drivers/misc/habanalabs/gaudi/gaudi_security.c     |   5 +-
 drivers/misc/habanalabs/goya/Makefile              |   2 -
 drivers/misc/habanalabs/goya/goya.c                | 196 ++--
 drivers/misc/habanalabs/goya/goyaP.h               |  24 +-
 drivers/misc/habanalabs/goya/goya_coresight.c      |  15 +-
 drivers/misc/habanalabs/goya/goya_security.c       |   2 +-
 .../habanalabs/include/{ => common}/armcp_if.h     |  14 +-
 .../habanalabs/include/{ => common}/hl_boot_if.h   |  14 +
 .../misc/habanalabs/include/{ => common}/qman_if.h |   0
 .../habanalabs/include/gaudi/asic_reg/gaudi_regs.h |  21 +-
 .../include/gaudi/asic_reg/psoc_cpu_pll_regs.h     | 114 +++
 .../misc/habanalabs/include/gaudi/gaudi_masks.h    |   3 +
 .../misc/habanalabs/include/gaudi/gaudi_packets.h  |   4 +-
 drivers/misc/hpilo.c                               |  11 +-
 drivers/misc/hpilo.h                               |  22 +-
 drivers/misc/ibmasm/command.c                      |   6 +-
 drivers/misc/ibmasm/dot_command.c                  |   6 +-
 drivers/misc/ibmasm/event.c                        |   4 +-
 drivers/misc/ibmasm/r_heartbeat.c                  |   2 +-
 drivers/misc/ibmvmc.c                              |   6 +-
 drivers/misc/lattice-ecp3-config.c                 |  19 +-
 drivers/misc/lkdtm/bugs.c                          |  53 +-
 drivers/misc/lkdtm/heap.c                          |   9 +-
 drivers/misc/lkdtm/lkdtm.h                         |   2 -
 drivers/misc/lkdtm/perms.c                         |  22 +-
 drivers/misc/lkdtm/usercopy.c                      |   7 +-
 drivers/misc/mei/Kconfig                           |   2 +-
 drivers/misc/mei/bus-fixup.c                       |  23 +-
 drivers/misc/mei/bus.c                             |   2 +-
 drivers/misc/mei/client.c                          |   8 +-
 drivers/misc/mei/hbm.c                             |  74 +-
 drivers/misc/mei/hdcp/mei_hdcp.c                   |   4 +-
 drivers/misc/mei/hdcp/mei_hdcp.h                   |   2 +-
 drivers/misc/mei/hw-me-regs.h                      |   4 +
 drivers/misc/mei/hw-me.c                           |  66 +-
 drivers/misc/mei/hw-me.h                           |   9 +-
 drivers/misc/mei/hw-txe.c                          |   5 +-
 drivers/misc/mei/hw.h                              |   8 +-
 drivers/misc/mei/main.c                            |  31 +-
 drivers/misc/mei/mei_dev.h                         |   4 +
 drivers/misc/mei/pci-me.c                          |  10 +-
 drivers/misc/mic/card/mic_debugfs.c                |  10 +-
 drivers/misc/mic/cosm/cosm_debugfs.c               |   4 +-
 drivers/misc/mic/cosm/cosm_main.c                  |   1 +
 drivers/misc/mic/host/mic_debugfs.c                |   8 +-
 drivers/misc/mic/host/mic_intr.c                   |   4 +-
 drivers/misc/mic/host/mic_main.c                   |   1 -
 drivers/misc/mic/host/mic_x100.c                   |  13 +
 drivers/misc/mic/host/mic_x100.h                   |   9 -
 drivers/misc/mic/scif/scif_api.c                   |   6 +-
 drivers/misc/mic/scif/scif_dma.c                   |   3 +-
 drivers/misc/mic/scif/scif_epd.c                   |   9 +
 drivers/misc/mic/scif/scif_fence.c                 |  34 +-
 drivers/misc/mic/scif/scif_nm.c                    |  17 +-
 drivers/misc/mic/scif/scif_nodeqp.c                |  18 +-
 drivers/misc/mic/scif/scif_ports.c                 |   9 +-
 drivers/misc/mic/scif/scif_rma.c                   |  12 +-
 drivers/misc/mic/vop/vop_main.c                    |   9 +-
 drivers/misc/ocxl/config.c                         |  18 +-
 drivers/misc/pch_phub.c                            |  57 +-
 drivers/misc/phantom.c                             |  20 +-
 drivers/misc/pti.c                                 |  16 +-
 drivers/misc/sgi-xp/xp_main.c                      |   4 +-
 drivers/misc/sram-exec.c                           |   2 +-
 drivers/misc/ti-st/st_core.c                       |  79 +-
 drivers/misc/ti-st/st_kim.c                        |  71 +-
 drivers/misc/tifm_7xx1.c                           |  30 +-
 drivers/misc/uacce/uacce.c                         |   9 -
 drivers/mmc/host/rtsx_pci_sdmmc.c                  |   2 +
 drivers/mux/adgs1408.c                             |   6 +-
 drivers/nvmem/Kconfig                              |   3 -
 drivers/nvmem/core.c                               |  43 +-
 drivers/nvmem/qcom-spmi-sdam.c                     |   4 +-
 drivers/nvmem/qfprom.c                             | 315 ++++++-
 drivers/nvmem/sc27xx-efuse.c                       |  27 +-
 drivers/nvmem/sprd-efuse.c                         |   4 +-
 drivers/phy/Kconfig                                |   1 +
 drivers/phy/Makefile                               |  17 +-
 drivers/phy/allwinner/Kconfig                      |   2 +-
 drivers/phy/allwinner/phy-sun4i-usb.c              |   3 +-
 drivers/phy/allwinner/phy-sun6i-mipi-dphy.c        |   4 +-
 drivers/phy/broadcom/Kconfig                       |   8 +
 drivers/phy/broadcom/Makefile                      |   1 +
 drivers/phy/broadcom/phy-bcm63xx-usbh.c            | 457 ++++++++++
 drivers/phy/cadence/phy-cadence-salvo.c            |   2 +-
 drivers/phy/marvell/phy-armada38x-comphy.c         |  45 +-
 drivers/phy/marvell/phy-mvebu-a3700-utmi.c         |   2 +-
 drivers/phy/motorola/phy-mapphone-mdm6600.c        |   3 +-
 drivers/phy/phy-core.c                             |   5 +-
 drivers/phy/phy-xgene.c                            |   2 +-
 drivers/phy/qualcomm/Kconfig                       |  34 +-
 drivers/phy/qualcomm/Makefile                      |   4 +-
 drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c        | 571 ++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.c                | 510 ++++++++++-
 drivers/phy/qualcomm/phy-qcom-qmp.h                |   7 +
 drivers/phy/qualcomm/phy-qcom-qusb2.c              |   3 +
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c      |  85 ++
 drivers/phy/qualcomm/phy-qcom-ufs-i.h              | 131 ---
 drivers/phy/qualcomm/phy-qcom-ufs-qmp-14nm.c       | 172 ----
 drivers/phy/qualcomm/phy-qcom-ufs-qmp-14nm.h       | 168 ----
 drivers/phy/qualcomm/phy-qcom-ufs-qmp-20nm.c       | 226 -----
 drivers/phy/qualcomm/phy-qcom-ufs-qmp-20nm.h       | 226 -----
 drivers/phy/qualcomm/phy-qcom-ufs.c                | 648 --------------
 drivers/phy/renesas/phy-rcar-gen3-usb2.c           |  63 +-
 drivers/phy/rockchip/phy-rockchip-typec.c          |   2 +-
 drivers/phy/samsung/Kconfig                        |  17 +-
 drivers/phy/samsung/Makefile                       |   1 +
 drivers/phy/samsung/phy-exynos-dp-video.c          |   4 +-
 drivers/phy/samsung/phy-exynos-mipi-video.c        |   4 +-
 drivers/phy/samsung/phy-exynos-pcie.c              |   2 +-
 drivers/phy/samsung/phy-exynos5-usbdrd.c           |  16 +-
 drivers/phy/samsung/phy-exynos7-ufs.h              |  81 ++
 drivers/phy/samsung/phy-samsung-ufs.c              | 366 ++++++++
 drivers/phy/samsung/phy-samsung-ufs.h              | 139 +++
 drivers/phy/samsung/phy-samsung-usb2.c             |   2 +-
 drivers/phy/st/phy-stm32-usbphyc.c                 |   4 +-
 drivers/phy/ti/phy-dm816x-usb.c                    |  11 +-
 drivers/phy/ti/phy-ti-pipe3.c                      |   5 +-
 drivers/phy/xilinx/Kconfig                         |  13 +
 drivers/phy/xilinx/Makefile                        |   3 +
 drivers/phy/xilinx/phy-zynqmp.c                    | 993 +++++++++++++++++++++
 drivers/soundwire/Makefile                         |  10 +-
 drivers/soundwire/bus.c                            | 130 ++-
 drivers/soundwire/bus_type.c                       |  19 +-
 drivers/soundwire/cadence_master.c                 |  70 +-
 drivers/soundwire/cadence_master.h                 |   4 +
 drivers/soundwire/intel.c                          | 549 ++++++++----
 drivers/soundwire/intel.h                          |  22 +
 drivers/soundwire/intel_init.c                     | 356 ++++++--
 drivers/soundwire/qcom.c                           |   4 +-
 drivers/soundwire/stream.c                         |  98 ++
 drivers/uio/uio_dmem_genirq.c                      |  19 +
 drivers/uio/uio_pdrv_genirq.c                      |  24 +-
 drivers/virt/vboxguest/vboxguest_core.c            | 266 +++++-
 drivers/virt/vboxguest/vboxguest_core.h            |  23 +-
 drivers/virt/vboxguest/vboxguest_utils.c           |   1 +
 include/asm-generic/vmlinux.lds.h                  |   6 +-
 include/dt-bindings/phy/phy.h                      |   1 +
 include/linux/coresight.h                          |   6 +-
 include/linux/dynamic_debug.h                      |   4 +-
 include/linux/firmware/intel/stratix10-smc.h       |  43 +
 .../linux/firmware/intel/stratix10-svc-client.h    |  17 +-
 include/linux/fsl/mc.h                             |  32 +-
 include/linux/interconnect-provider.h              |  16 +-
 include/linux/mic_bus.h                            |   2 +-
 include/linux/mod_devicetable.h                    |   2 +
 include/linux/nvmem-consumer.h                     |   1 +
 include/linux/nvmem-provider.h                     |   3 +
 include/linux/rtsx_pci.h                           |  33 +-
 include/linux/soundwire/sdw.h                      |  33 +-
 include/linux/soundwire/sdw_intel.h                |   2 +
 include/linux/soundwire/sdw_registers.h            | 117 ++-
 include/linux/vbox_utils.h                         |   1 +
 include/linux/vmw_vmci_defs.h                      |   2 +-
 include/uapi/linux/android/binder.h                |   2 +-
 include/uapi/linux/fpga-dfl.h                      |  82 ++
 include/uapi/linux/raw.h                           |   2 -
 include/uapi/linux/vbox_vmmdev_types.h             |   3 +
 include/uapi/linux/vboxguest.h                     |  24 +
 include/uapi/misc/habanalabs.h                     |  27 +-
 kernel/module.c                                    |   2 +-
 lib/dynamic_debug.c                                | 269 +++---
 scripts/headers_install.sh                         |   1 -
 scripts/mod/devicetable-offsets.c                  |   2 +
 scripts/mod/file2alias.c                           |   6 +-
 tools/testing/selftests/lkdtm/run.sh               |   6 +
 tools/testing/selftests/lkdtm/tests.txt            |   1 +
 291 files changed, 10369 insertions(+), 4128 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
 delete mode 100644 Documentation/devicetree/bindings/nvmem/qfprom.txt
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,ipq806x-usb-phy-hs.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,ipq806x-usb-phy-ss.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/samsung,ufs-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
 create mode 100644 drivers/misc/cardreader/rts5228.c
 create mode 100644 drivers/misc/cardreader/rts5228.h
 create mode 100644 drivers/misc/habanalabs/common/Makefile
 rename drivers/misc/habanalabs/{ => common}/asid.c (100%)
 rename drivers/misc/habanalabs/{ => common}/command_buffer.c (85%)
 rename drivers/misc/habanalabs/{ => common}/command_submission.c (92%)
 rename drivers/misc/habanalabs/{ => common}/context.c (84%)
 rename drivers/misc/habanalabs/{ => common}/debugfs.c (99%)
 rename drivers/misc/habanalabs/{ => common}/device.c (94%)
 rename drivers/misc/habanalabs/{ => common}/firmware_if.c (89%)
 rename drivers/misc/habanalabs/{ => common}/habanalabs.h (94%)
 rename drivers/misc/habanalabs/{ => common}/habanalabs_drv.c (99%)
 rename drivers/misc/habanalabs/{ => common}/habanalabs_ioctl.c (95%)
 rename drivers/misc/habanalabs/{ => common}/hw_queue.c (86%)
 rename drivers/misc/habanalabs/{ => common}/hwmon.c (100%)
 rename drivers/misc/habanalabs/{ => common}/irq.c (91%)
 rename drivers/misc/habanalabs/{ => common}/memory.c (99%)
 rename drivers/misc/habanalabs/{ => common}/mmu.c (99%)
 rename drivers/misc/habanalabs/{ => common}/pci.c (72%)
 rename drivers/misc/habanalabs/{ => common}/sysfs.c (99%)
 rename drivers/misc/habanalabs/include/{ => common}/armcp_if.h (98%)
 rename drivers/misc/habanalabs/include/{ => common}/hl_boot_if.h (84%)
 rename drivers/misc/habanalabs/include/{ => common}/qman_if.h (100%)
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/psoc_cpu_pll_regs.h
 create mode 100644 drivers/phy/broadcom/phy-bcm63xx-usbh.c
 create mode 100644 drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c
 delete mode 100644 drivers/phy/qualcomm/phy-qcom-ufs-i.h
 delete mode 100644 drivers/phy/qualcomm/phy-qcom-ufs-qmp-14nm.c
 delete mode 100644 drivers/phy/qualcomm/phy-qcom-ufs-qmp-14nm.h
 delete mode 100644 drivers/phy/qualcomm/phy-qcom-ufs-qmp-20nm.c
 delete mode 100644 drivers/phy/qualcomm/phy-qcom-ufs-qmp-20nm.h
 delete mode 100644 drivers/phy/qualcomm/phy-qcom-ufs.c
 create mode 100644 drivers/phy/samsung/phy-exynos7-ufs.h
 create mode 100644 drivers/phy/samsung/phy-samsung-ufs.c
 create mode 100644 drivers/phy/samsung/phy-samsung-ufs.h
 create mode 100644 drivers/phy/xilinx/Kconfig
 create mode 100644 drivers/phy/xilinx/Makefile
 create mode 100644 drivers/phy/xilinx/phy-zynqmp.c
