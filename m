Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEDBC33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 10:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 477C72071E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 10:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580292927;
	bh=G905JJcRTpDuEzyTKBwVJjiD0ozmjId0V6gY4H8U0MA=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=sW6lb+GVNiue9g7dRWyD4rRpYtt/dGUvh2k2QO56ICJfONATpFDvHmSTHPaIH8Im2
	 fcKRRSeEQI+izqSROzFUJ2SO2ML1X5cx9+ugI2xNld6YGaM0oa3V29d8O21ipXpMQt
	 X8I4VAo6qz+piAaNgsaE/eGE0Dckz/zUnYi5wW18=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgA2KP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 05:15:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:58714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbgA2KPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 05:15:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8D8020716;
        Wed, 29 Jan 2020 10:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580292925;
        bh=G905JJcRTpDuEzyTKBwVJjiD0ozmjId0V6gY4H8U0MA=;
        h=Date:From:To:Cc:Subject:From;
        b=ONJ+iwMEezVenMNOvpOYako3EScaj43EBUYn+5YY/9RUierO/qsu27MI+GB2NMrOP
         mHVwV0yLZP0twcoTVzCBaekf67Hcq/rUlDPfAK/ec12OYLdREO5azgDrf1KVNOM65m
         jRakEFrXmS63ncBSJ4qVHZTMOxOx7AUjPR6yYYsQ=
Date:   Wed, 29 Jan 2020 11:15:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver patches for 5.6-rc1
Message-ID: <20200129101523.GA3858602@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit def9d2780727cec3313ed3522d0123158d87224d:

  Linux 5.5-rc7 (2020-01-19 16:02:49 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.6-rc1

for you to fetch changes up to 0db4a15d4c2787b1112001790d4f95bd2c5fed6f:

  mei: me: add jasper point DID (2020-01-24 09:33:58 +0100)

----------------------------------------------------------------
Char/Misc driver changes for 5.6-rc1

Here is the big char/misc/whatever driver changes for 5.6-rc1

Included in here are loads of things from a variety of different driver
subsystems:
	- soundwire updates
	- binder updates
	- nvmem updates
	- firmware drivers updates
	- extcon driver updates
	- various misc driver updates
	- fpga driver updates
	- interconnect subsystem and driver updates
	- bus driver updates
	- uio driver updates
	- mei driver updates
	- w1 driver cleanups
	- various other small driver updates

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Anirudh Ghayal (1):
      nvmem: add QTI SDAM driver

Anson Huang (1):
      dt-bindings: imx-ocotp: Add i.MX8MP compatible

Arnd Bergmann (2):
      visorbus: fix uninitialized variable access
      vme: bridges: reduce stack usage

Arthur Heymans (2):
      firmware: google: Unregister driver_info on failure and exit in gsmi
      firmware: google: Probe for a GSMI handler in firmware

Bard Liao (4):
      soundwire: intel: update headers for interrupts
      soundwire: intel: add link_list to handle interrupts with a single thread
      soundwire: intel: fix factor of two in MCLK handling
      soundwire: intel: report slave_ids for each link to SOF driver

Bitan Biswas (1):
      nvmem: core: fix memory abort in cleanup path

Chanwoo Choi (1):
      extcon: Remove unneeded extern keyword from extcon.h

Charles Keepax (10):
      extcon: arizona: Correct clean up if arizona_identify_headphone fails
      extcon: arizona: Make rev A register sequences atomic
      extcon: arizona: Move pdata extraction to probe
      extcon: arizona: Clear jack status regardless of detection type
      extcon: arizona: Tidy up transition from mic to headphone detect
      extcon: arizona: Remove unnecessary sets of ACCDET_MODE
      extcon: arizona: Remove excessive WARN_ON
      extcon: arizona: Invert logic of check in arizona_hpdet_do_id
      extcon: arizona: Factor out microphone impedance into a function
      extcon: arizona: Factor out microphone and button detection

Chuhong Yuan (2):
      misc: isl29020: add missed pm_runtime_disable
      slimbus: qcom: add missed clk_disable_unprepare in remove

Colin Ian King (3):
      misc: pti: remove redundant assignments to retval
      misc: tsl2550: remove redundant initialization to variable r
      drivers/misc: ti-st: remove redundant assignment to variables i and flags

Ding Xiang (1):
      fpga: remove redundant dev_err message

Georgi Djakov (11):
      interconnect: Add a common helper for removing all nodes
      interconnect: qcom: Use the new common helper for node removal
      interconnect: Move internal structs into a separate file
      interconnect: Add a name to struct icc_path
      interconnect: Add basic tracepoints
      interconnect: Add a common standard aggregate function
      interconnect: qcom: Use the standard aggregate function
      interconnect: Print the tag in the debugfs summary
      interconnect: Check for valid path in icc_set_bw()
      dt-bindings: interconnect: Add Qualcomm MSM8916 DT bindings
      interconnect: qcom: Add MSM8916 interconnect provider driver

Greg Kroah-Hartman (6):
      Merge 5.5-rc6 into char-misc-next
      Merge tag 'extcon-next-for-5.6' of git://git.kernel.org/.../chanwoo/extcon into char-misc-next
      Merge tag 'soundwire-5.6-rc1' of git://git.kernel.org/.../vkoul/soundwire into char-misc-next
      Merge 5.5-rc7 into char-misc-next
      Merge tag 'fpga-for-5.6' of git://git.kernel.org/.../mdf/linux-fpga into char-misc-next
      Merge tag 'icc-5.6-rc1' of https://git.linaro.org/people/georgi.djakov/linux into char-misc-next

Gustavo A. R. Silva (1):
      char: hpet: Use flexible-array member

Hongbo Yao (1):
      misc: genwqe: fix compile warnings

Ioana Ciornei (1):
      bus: fsl-mc: properly empty-initialize structure

Jia-Ju Bai (1):
      uio: fix a sleep-in-atomic-context bug in uio_dmem_genirq_irqcontrol()

Julia Lawall (1):
      misc: cxl: use mmgrab

Leonard Crestez (1):
      interconnect: Add interconnect_graph file to debugfs

Luc Van Oostenryck (2):
      misc: xilinx_sdfec: add missing __user annotation
      misc: xilinx_sdfec: fix xsdfec_poll()'s return type

Martin Fuzzey (1):
      binder: fix log spam for existing debugfs file creation.

Nishad Kamdar (2):
      slimbus: Use the correct style for SPDX License Identifier
      siox: Use the correct style for SPDX License Identifier

Oscar Ravadilla (1):
      uio: uio_pdrv_genirq: Do not log an error when deferring probe routine.

Patrick Rudolph (1):
      firmware: google: Release devices before unregistering the bus

Peng Fan (3):
      nvmem: imx: scu: fix write SIP
      nvmem: imx: scu: correct the fuse word index
      nvmem: imx: ocotp: introduce ocotp_ctrl_reg

Peter Ujfalusi (1):
      slimbus: qcom-ngd-ctrl: Use dma_request_chan() instead dma_request_slave_channel()

Pierre-Louis Bossart (16):
      soundwire: sdw_slave: add probe_complete structure and new fields
      soundwire: sdw_slave: add enumeration_complete structure
      soundwire: sdw_slave: add initialization_complete definition
      soundwire: sdw_slave: track unattach_request to handle all init sequences
      soundwire: intel: update interfaces between ASoC and SoundWire
      soundwire: intel: add mutex for shared SHIM register access
      soundwire: intel: add clock stop quirks
      soundwire: stream: remove redundant pr_err traces
      soundwire: cadence_master: filter out bad interrupts
      soundwire: cadence_master: log more useful information during timeouts
      soundwire: cadence_master: handle multiple status reports per Slave
      soundwire: bus: check first if Slaves become UNATTACHED
      soundwire: cadence: update kernel-doc parameter descriptions
      soundwire: cadence: remove useless variable incrementation
      soundwire: bus: fix device number leak on errors
      soundwire: cadence: fix kernel-doc parameter descriptions

Rander Wang (4):
      soundwire: intel: update stream callbacks for hwparams/free stream operations
      soundwire: intel: add prototype for WAKEEN interrupt processing
      soundwire: cadence_master: clear interrupt status before enabling interrupt
      soundwire: cadence_master: remove config update for interrupt setting

Rhys Perry (1):
      misc: alcor_pci: Add AU6625 to list of supported PCI_IDs

Rui Feng (1):
      misc: rtsx: Fix impossible condition

Shubhrajyoti Datta (1):
      fpga: xilinx-pr-decoupler: Remove clk_get error message for probe defer

Shyam Kumar Thella (1):
      dt-bindings: nvmem: add binding for QTI SPMI SDAM

Srinivas Kandagatla (4):
      dt-bindings: soundwire: add bindings for Qcom controller
      soundwire: qcom: add support for SoundWire controller
      dt-bindings: SLIMBus: add slim devices optional properties
      dt-bindings: soundwire: fix example

Tianlin Li (1):
      drivers/misc: sram-exec: have the callers of set_memory_*() check the return value

Tomas Winkler (4):
      mei: bus: use simple sprintf for sysfs
      mei: hdcp: bind only with i915 on the same PCH
      mei: me: add comet point (lake) H device ids
      mei: me: add jasper point DID

Tony Lindgren (1):
      w1: omap-hdq: Simplify driver with PM runtime autosuspend

Vinod Koul (1):
      Merge branch 'topic/sdw_intel' into next

Xu Wang (2):
      extcon: sm5502: Remove unneeded semicolon
      mic: Remove unneeded NULL check

yu kuai (2):
      fpga: dfl: fme: remove set but not used variable 'fme'
      fpga: dfl: afu: remove set but not used variable 'afu'

zhengbin (1):
      firmware: stratix10-svc: Remove unneeded semicolon

zhenwei pi (2):
      misc: pvpanic: move bit definition to uapi header file
      misc: pvpanic: add crash loaded event

 .../bindings/interconnect/qcom,msm8916.yaml        |  77 ++
 .../devicetree/bindings/nvmem/imx-ocotp.txt        |   3 +-
 .../devicetree/bindings/nvmem/qcom,spmi-sdam.yaml  |  84 ++
 Documentation/devicetree/bindings/slimbus/bus.txt  |  10 +
 .../devicetree/bindings/soundwire/qcom,sdw.txt     | 167 ++++
 .../bindings/soundwire/soundwire-controller.yaml   |   2 +
 Documentation/driver-api/interconnect.rst          |  22 +
 drivers/android/binder.c                           |  37 +-
 drivers/bus/fsl-mc/fsl-mc-bus.c                    |   6 +-
 drivers/char/hpet.c                                |   2 +-
 drivers/extcon/extcon-arizona.c                    | 354 +++++----
 drivers/extcon/extcon-sm5502.c                     |  10 +-
 drivers/firmware/google/coreboot_table.c           |   7 +
 drivers/firmware/google/gsmi.c                     |  25 +
 drivers/firmware/stratix10-svc.c                   |   4 +-
 drivers/fpga/dfl-afu-main.c                        |   2 -
 drivers/fpga/dfl-fme-main.c                        |   2 -
 drivers/fpga/ts73xx-fpga.c                         |   4 +-
 drivers/fpga/xilinx-pr-decoupler.c                 |   3 +-
 drivers/interconnect/Makefile                      |   1 +
 drivers/interconnect/core.c                        | 168 +++-
 drivers/interconnect/internal.h                    |  42 +
 drivers/interconnect/qcom/Kconfig                  |   9 +
 drivers/interconnect/qcom/Makefile                 |   2 +
 drivers/interconnect/qcom/msm8916.c                | 554 +++++++++++++
 drivers/interconnect/qcom/msm8974.c                |  32 +-
 drivers/interconnect/qcom/qcs404.c                 |  32 +-
 drivers/interconnect/qcom/sdm845.c                 |  16 +-
 drivers/interconnect/trace.h                       |  88 +++
 drivers/misc/cardreader/alcor_pci.c                |   8 +-
 drivers/misc/cardreader/rts5261.c                  |  11 +-
 drivers/misc/cxl/context.c                         |   2 +-
 drivers/misc/genwqe/card_ddcb.c                    |   8 +-
 drivers/misc/isl29020.c                            |   1 +
 drivers/misc/mei/bus.c                             |  10 +-
 drivers/misc/mei/hdcp/mei_hdcp.c                   |  33 +-
 drivers/misc/mei/hw-me-regs.h                      |   6 +
 drivers/misc/mei/pci-me.c                          |   4 +
 drivers/misc/mic/card/mic_debugfs.c                |   3 -
 drivers/misc/mic/cosm/cosm_debugfs.c               |   3 -
 drivers/misc/mic/host/mic_debugfs.c                |   3 -
 drivers/misc/pti.c                                 |   4 +-
 drivers/misc/pvpanic.c                             |  12 +-
 drivers/misc/sram-exec.c                           |  21 +-
 drivers/misc/ti-st/st_core.c                       |   4 +-
 drivers/misc/tsl2550.c                             |  12 +-
 drivers/misc/xilinx_sdfec.c                        |  12 +-
 drivers/nvmem/Kconfig                              |   8 +
 drivers/nvmem/Makefile                             |   2 +
 drivers/nvmem/core.c                               |   8 +-
 drivers/nvmem/imx-ocotp-scu.c                      |  16 +-
 drivers/nvmem/imx-ocotp.c                          |  79 +-
 drivers/nvmem/qcom-spmi-sdam.c                     | 192 +++++
 drivers/siox/siox.h                                |   2 +-
 drivers/slimbus/qcom-ctrl.c                        |   2 +
 drivers/slimbus/qcom-ngd-ctrl.c                    |  20 +-
 drivers/slimbus/slimbus.h                          |   2 +-
 drivers/soundwire/Kconfig                          |   9 +
 drivers/soundwire/Makefile                         |   4 +
 drivers/soundwire/bus.c                            |  55 +-
 drivers/soundwire/cadence_master.c                 |  66 +-
 drivers/soundwire/intel.c                          |  23 +-
 drivers/soundwire/intel.h                          |  13 +-
 drivers/soundwire/intel_init.c                     |  32 +-
 drivers/soundwire/qcom.c                           | 861 +++++++++++++++++++++
 drivers/soundwire/stream.c                         |   8 -
 drivers/uio/uio_dmem_genirq.c                      |   6 +-
 drivers/uio/uio_pdrv_genirq.c                      |   2 +
 drivers/visorbus/visorchipset.c                    |  11 +-
 drivers/vme/bridges/vme_fake.c                     |  30 +-
 drivers/w1/masters/omap_hdq.c                      | 348 +++------
 include/dt-bindings/interconnect/qcom,msm8916.h    | 100 +++
 include/linux/alcor_pci.h                          |   1 +
 include/linux/extcon.h                             |  30 +-
 include/linux/interconnect-provider.h              |  14 +
 include/linux/soundwire/sdw.h                      |  23 +-
 include/linux/soundwire/sdw_intel.h                | 167 +++-
 include/uapi/misc/pvpanic.h                        |   9 +
 78 files changed, 3324 insertions(+), 741 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,msm8916.yaml
 create mode 100644 Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
 create mode 100644 Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
 create mode 100644 drivers/interconnect/internal.h
 create mode 100644 drivers/interconnect/qcom/msm8916.c
 create mode 100644 drivers/interconnect/trace.h
 create mode 100644 drivers/nvmem/qcom-spmi-sdam.c
 create mode 100644 drivers/soundwire/qcom.c
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8916.h
 create mode 100644 include/uapi/misc/pvpanic.h
