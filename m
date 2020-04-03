Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9BBC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F6F206E9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585930297;
	bh=2Gfc7jS7Zs5oB7LivRZeNAabo1Vlaw9LDiEBrhNvVYc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=bFmTmXdcYnNlEDfNUASiYxGnQ0FjY8/NC794yFqPBrbQXZV0q3E/Gl1BRJmd8+Qk7
	 atTsYPszlN+kCAxkHzJiEQmosIzCRZs2Wh9E7v0otVXQvwotR1G6t64WXuGo6B/eUV
	 OE6j76D2ov63vLgTJIqnjr2ctxo685XAgQ9wWEl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404190AbgDCQLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 12:11:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:57614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404168AbgDCQLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 12:11:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2631206E9;
        Fri,  3 Apr 2020 16:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585930293;
        bh=2Gfc7jS7Zs5oB7LivRZeNAabo1Vlaw9LDiEBrhNvVYc=;
        h=Date:From:To:Cc:Subject:From;
        b=DnIf5zlxu/DzlRCGUfs1crDLuIWvO/Yfi51EogNW3yQ0nw4rpWJyYr2w+hqEGUy2P
         XTZwyZLe5wQsnFh1xWmWwU8f8pNhJGJz4sALyB+BSMDqhxmePmVAPRrwaeLlpAM+VX
         ykGw9VnhdUtzE37pBhlxlzblCiUlptE7EdawAE14=
Date:   Fri, 3 Apr 2020 18:11:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver patches for 5.7-rc1
Message-ID: <20200403161127.GA4104105@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 16fbf79b0f83bc752cee8589279f1ebfe57b3b6e:

  Linux 5.6-rc7 (2020-03-22 18:31:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.7-rc1

for you to fetch changes up to 885a64715fd81e6af6d94a038556e0b2e6deb19c:

  Revert "driver core: platform: Initialize dma_parms for platform devices" (2020-04-01 08:06:54 +0200)

----------------------------------------------------------------
Char/Misc driver patches for 5.7-rc1

Here is the big set of char/misc/other driver patches for 5.7-rc1.

Lots of things in here, and it's later than expected due to some reverts
to resolve some reported issues.  All is now clean with no reported
problems in linux-next.

Included in here is:
	- interconnect updates
	- mei driver updates
	- uio updates
	- nvmem driver updates
	- soundwire updates
	- binderfs updates
	- coresight updates
	- habanalabs updates
	- mhi new bus type and core
	- extcon driver updates
	- some Kconfig cleanups
	- other small misc driver cleanups and updates

As mentioned, all have been in linux-next for a while, and with the last
two reverts, all is calm and good.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Kapshuk (1):
      ver_linux: Query ld cache for versions of libc/libcpp run-time

Alexander Popov (1):
      lkdtm/stackleak: Make the test more verbose

Alexander Shishkin (2):
      intel_th: Disallow multi mode on devices where it's broken
      intel_th: msu: Make stopping the trace optional

Alexander Usyskin (2):
      mei: fix CNL itouch device number to match the spec.
      mei: me: add cedar fork device ids

Alexandru Ardelean (2):
      uio: add resource managed devm_uio_register_device() function
      uio: uio_pdrv_genirq: use new devm_uio_register_device() function

Anson Huang (3):
      firmware: imx: add COMPILE_TEST support
      nvmem: imx-ocotp: Drop unnecessary initializations
      nvmem: mxs-ocotp: Use devm_add_action_or_reset() for cleanup

Arnd Bergmann (2):
      rtc/ia64: remove legacy efirtc driver
      rtc/alpha: remove legacy rtc driver

Baolin Wang (1):
      nvmem: sprd: Determine double data programming from device data

Bard Liao (2):
      soundwire: stream: only prepare stream when it is configured.
      soundwire: bus: provide correct return value on error

Bartosz Golaszewski (3):
      nvmem: remove a stray newline in nvmem_register()
      nvmem: add a newline for readability
      nvmem: fix memory leak in error path

Chanwoo Choi (1):
      extcon: Remove unneeded extern keyword from extcon-provider.h

Christian Borntraeger (1):
      Documentation: provide IBM contacts for embargoed hardware

Christian Brauner (4):
      binderfs: port to new mount api
      binderfs: port tests to test harness infrastructure
      binderfs_test: switch from /dev to a unique per-test mountpoint
      binderfs: add stress test for binderfs binder devices

Christine Gharzuzi (1):
      habanalabs: provide historical maximum of various sensors

Dafna Hirschfeld (1):
      dt-bindings: extcon: usbc-cros-ec: convert extcon-usbc-cros-ec.txt to yaml format

David Dai (5):
      dt-bindings: interconnect: Convert qcom,sdm845 to DT schema
      dt-bindings: interconnect: Add YAML schemas for QCOM bcm-voter
      dt-bindings: interconnect: Update Qualcomm SDM845 DT bindings
      interconnect: qcom: Consolidate interconnect RPMh support
      interconnect: qcom: sdm845: Split qnodes into their respective NoCs

Eugene Syromiatnikov (1):
      coresight: do not use the BIT() macro in the UAPI header

Freeman Liu (2):
      nvmem: sprd: Fix the block lock operation
      nvmem: sprd: Optimize the block lock operation

Greg Kroah-Hartman (10):
      dynamic_debug: allow to work if debugfs is disabled
      Merge 5.6-rc3 into char-misc-next
      Merge 5.6-rc5 into char-misc-next
      Merge tag 'icc-5.7-rc1' of https://git.linaro.org/people/georgi.djakov/linux into char-misc-next
      Merge 5.6-rc7 into char-misc-next
      Merge tag 'soundwire-5.7-rc1' of git://git.kernel.org/.../vkoul/soundwire into char-misc-next
      Merge tag 'misc-habanalabs-next-2020-03-24' of git://people.freedesktop.org/~gabbayo/linux into char-misc-next
      Merge tag 'extcon-next-for-5.7' of git://git.kernel.org/.../chanwoo/extcon into char-misc-next
      Revert "amba: Initialize dma_parms for amba devices"
      Revert "driver core: platform: Initialize dma_parms for platform devices"

Gustavo A. R. Silva (5):
      misc: vexpress: Replace zero-length array with flexible-array member
      mei: bus: replace zero-length array with flexible-array member
      char: virtio: Replace zero-length array with flexible-array member
      misc: Replace zero-length array with flexible-array member
      char: mspec: Replace zero-length array with flexible-array member

H. Nikolaus Schaller (2):
      nvmem: jz4780-efuse: fix build warnings on ARCH=x86_64 or riscv
      extcon: palmas: Hide error messages if gpio returns -EPROBE_DEFER

Hans de Goede (1):
      extcon: axp288: Add wakeup support

Huang Zijiang (1):
      misc: Use kzalloc() instead of kmalloc() with flag GFP_ZERO.

Joe Perches (1):
      virt: vbox: Use fallthrough;

Jules Irenge (2):
      habanalabs: Add missing annotation for goya_hw_queues_lock()
      habanalabs: Add missing annotation for goya_hw_queues_unlock()

Kees Cook (2):
      ppdev: Distribute switch variables for initialization
      pcmcia: Distribute switch variables for initialization

Khouloud Touil (1):
      nvmem: release the write-protect pin

Manivannan Sadhasivam (17):
      docs: Add documentation for MHI bus
      bus: mhi: core: Add support for registering MHI controllers
      bus: mhi: core: Add support for registering MHI client drivers
      bus: mhi: core: Add support for creating and destroying MHI devices
      bus: mhi: core: Add support for ringing channel/event ring doorbells
      bus: mhi: core: Add support for PM state transitions
      bus: mhi: core: Add support for basic PM operations
      bus: mhi: core: Add support for downloading firmware over BHIe
      bus: mhi: core: Add support for downloading RDDM image during panic
      bus: mhi: core: Add support for processing events from client device
      bus: mhi: core: Add support for data transfer
      bus: mhi: core: Add uevent support for module autoloading
      MAINTAINERS: Add entry for MHI bus
      bus: mhi: core: Pass module owner during client driver registration
      bus: mhi: core: Add support for reading MHI info from device
      bus: mhi: core: Initialize bhie field in mhi_cntrl for RDDM capture
      bus: mhi: core: Drop the references to mhi_dev in mhi_destroy_device()

Mayank Rana (1):
      extcon: Mark extcon_get_edev_name() function as exported symbol

Mike Leach (12):
      coresight: cti: Initial CoreSight CTI Driver
      coresight: cti: Add sysfs coresight mgmt register access
      coresight: cti: Add sysfs access to program function registers
      coresight: cti: Add sysfs trigger / channel programming API
      dt-bindings: arm: Adds CoreSight CTI hardware definitions
      coresight: cti: Add device tree support for v8 arch CTI
      coresight: cti: Add device tree support for custom CTI
      coresight: cti: Enable CTI associated with devices
      coresight: cti: Add connection information to sysfs
      docs: coresight: Update documentation for CoreSight to cover CTI
      docs: sysfs: coresight: Add sysfs ABI documentation for CTI
      Update MAINTAINERS to add reviewer for CoreSight

Moti Haimovski (3):
      habanalabs: add debugfs write64/read64
      habanalabs: support temperature offset via sysfs
      habanalabs: modify the return values of hl_read/write routines

Nicholas Johnson (1):
      nvmem: check for NULL reg_read and reg_write before dereferencing

Oded Gabbay (5):
      habanalabs: removing extra ;
      habanalabs: ratelimit error prints of IRQs
      habanalabs: update goya firmware register map
      habanalabs: show unsupported message for GAUDI
      habanalabs: fix pm manual->auto in GOYA

Odelu Kukatla (2):
      dt-bindings: interconnect: Add Qualcomm SC7180 DT bindings
      interconnect: qcom: Add SC7180 interconnect provider driver

Omer Shpigelman (4):
      habanalabs: use the user CB size as a default job size
      habanalabs: split the host MMU properties
      habanalabs: fix DDR bar address setting
      habanalabs: add print upon clock change

Pawel Piskorski (1):
      habanalabs: flush only at the end of the map/unmap

Peng Fan (1):
      nvmem: imx: ocotp: add i.MX8MP support

Pierre-Louis Bossart (26):
      soundwire: stream: update state machine and add state checks
      soundwire: stream: do not update parameters during DISABLED-PREPARED transition
      soundwire: intel: rename res field as link_res
      soundwire: intel: free all resources on hw_free()
      soundwire: bus: fix race condition with probe_complete signaling
      soundwire: bus: fix race condition with enumeration_complete signaling
      soundwire: bus: fix race condition with initialization_complete signaling
      soundwire: bus: add PM/no-PM versions of read/write functions
      soundwire: bus: write Slave Device Number without runtime_pm
      soundwire: bus: add helper to clear Slave status to UNATTACHED
      soundwire: bus: disable pm_runtime in sdw_slave_delete
      soundwire: bus: don't treat CMD_IGNORED as error on ClockStop
      soundwire: cadence: remove useless prototypes
      soundwire: add helper macros for devID fields
      soundwire: cadence: s/update_config/config_update
      soundwire: cadence: handle error cases with CONFIG_UPDATE
      soundwire: cadence: mask Slave interrupt before stopping clock
      soundwire: cadence: merge routines to clear/set bits
      soundwire: cadence: move clock/SSP related inits to dedicated function
      soundwire: cadence: make SSP interval programmable
      soundwire: cadence: reorder MCP_CONFIG settings
      soundwire: cadence: enable NORMAL operation in cdns_init()
      soundwire: cadence: remove PREQ_DELAY assignment
      soundwire: cadence: remove automatic command retries
      soundwire: cadence: commit changes in the exit_reset() sequence
      soundwire: cadence: multi-link support

PrasannaKumar Muralidharan (3):
      Bindings: nvmem: add bindings for JZ4780 efuse
      nvmem: add driver for JZ4780 efuse
      Documentation: ABI: nvmem: add documentation for JZ4780 efuse ABI

Qiang Su (1):
      UIO: fix up inapposite whiteplace in uio head file

Rander Wang (11):
      soundwire: stream: fix support for multiple Slaves on the same link
      soundwire: stream: don't program ports when a stream that has not been prepared
      soundwire: intel: add prepare support in sdw dai driver
      soundwire: intel: add trigger support in sdw dai driver
      soundwire: intel: add sdw_stream_setup helper for .startup callback
      soundwire: bus: fix io error when processing alert event
      soundwire: bus: add clock stop helpers
      soundwire: cadence: simplifiy cdns_init()
      soundwire: cadence: add interface to check clock status
      soundwire: cadence: add clock_stop/restart routines
      soundwire: cadence: fix a io timeout issue in S3 test

Randy Dunlap (4):
      char: group dev configs togther
      tty: source all tty Kconfig files in one place
      tty: reorganize tty & serial menus
      bus/mhi: fix printk format for size_t

Richard Gong (2):
      firmware: intel_stratix10_service: add depend on agilex
      firmware: stratix10-svc: add the compatible value for intel agilex

Sibi Sankar (5):
      interconnect: qcom: Allow icc node to be used across icc providers
      dt-bindings: interconnect: Add OSM L3 DT bindings
      interconnect: qcom: Add OSM L3 interconnect provider support
      dt-bindings: interconnect: Add OSM L3 DT binding on SC7180
      interconnect: qcom: Add OSM L3 support on SC7180

Srinivas Kandagatla (8):
      soundwire: stream: use sdw_write instead of update
      nvmem: core: validate nvmem config before parsing
      soundwire: stream: Add read_only_wordlength flag to port properties
      soundwire: qcom: add support for get_sdw_stream()
      nvmem: core: add root_only member to nvmem device struct
      nvmem: core: use device_register and device_unregister
      nvmem: core: use is_bin_visible for permissions
      nvmem: core: remove nvmem_sysfs_get_groups()

Takashi Iwai (1):
      misc: mic: Use scnprintf() for avoiding potential buffer overflow

Tomas Winkler (2):
      mei: limit number of bytes in mei header.
      mei: remove unused includes from pci-{me,txe}.c

Tomer Tayar (3):
      habanalabs: Modify CS jobs counter to u16
      habanalabs: Avoid running restore chunks if no execute chunks
      habanalabs: Remove unused parse_cnt variable

Ulf Hansson (2):
      driver core: platform: Initialize dma_parms for platform devices
      amba: Initialize dma_parms for amba devices

Vinod Koul (2):
      Merge branch 'topic/asoc' into next
      Merge branch 'topic/ro_wordlength' into next

Yangtao Li (2):
      nvmem: core: add nvmem_cell_read_common
      nvmem: core: add nvmem_cell_read_u64

YueHaibing (1):
      misc: rtsx: set correct pcr_ops for rts522A

Zhenzhong Duan (3):
      misc: cleanup minor number definitions in c file into miscdevice.h
      misc: move FLASH_MINOR into miscdevice.h and fix conflicts
      speakup: misc: Use dynamic minor numbers for speakup devices

randerwang (1):
      soundwire: cadence: clear FIFO to avoid pop noise issue on playback start

 .../ABI/testing/debugfs-driver-habanalabs          |   14 +
 .../ABI/testing/sysfs-bus-coresight-devices-cti    |  241 +++
 .../ABI/testing/sysfs-bus-intel_th-devices-msc     |    8 +
 .../ABI/testing/sysfs-driver-jz4780-efuse          |   16 +
 Documentation/admin-guide/dynamic-debug-howto.rst  |    3 +
 .../devicetree/bindings/arm/coresight-cti.yaml     |  336 +++++
 .../devicetree/bindings/arm/coresight.txt          |    7 +
 .../bindings/extcon/extcon-usbc-cros-ec.txt        |   24 -
 .../bindings/extcon/extcon-usbc-cros-ec.yaml       |   56 +
 .../bindings/interconnect/qcom,bcm-voter.yaml      |   45 +
 .../bindings/interconnect/qcom,osm-l3.yaml         |   62 +
 .../bindings/interconnect/qcom,sc7180.yaml         |   85 ++
 .../bindings/interconnect/qcom,sdm845.txt          |   24 -
 .../bindings/interconnect/qcom,sdm845.yaml         |   74 +
 .../bindings/nvmem/ingenic,jz4780-efuse.yaml       |   45 +
 Documentation/driver-api/soundwire/stream.rst      |   61 +-
 Documentation/index.rst                            |    1 +
 Documentation/mhi/index.rst                        |   18 +
 Documentation/mhi/mhi.rst                          |  218 +++
 Documentation/mhi/topology.rst                     |   60 +
 .../process/embargoed-hardware-issues.rst          |    3 +-
 Documentation/trace/coresight/coresight-ect.rst    |  222 +++
 Documentation/trace/coresight/coresight.rst        |   13 +
 MAINTAINERS                                        |   13 +
 arch/alpha/configs/defconfig                       |    3 +-
 arch/arm/include/asm/nwflash.h                     |    1 -
 arch/ia64/configs/bigsur_defconfig                 |    3 +-
 arch/ia64/configs/generic_defconfig                |    3 +-
 arch/ia64/configs/gensparse_defconfig              |    3 +-
 arch/ia64/configs/tiger_defconfig                  |    3 +-
 arch/ia64/configs/zx1_defconfig                    |    3 +-
 arch/um/drivers/random.c                           |    4 +-
 drivers/android/binderfs.c                         |  200 +--
 drivers/auxdisplay/charlcd.c                       |    2 -
 drivers/auxdisplay/panel.c                         |    2 -
 drivers/bus/Kconfig                                |    1 +
 drivers/bus/Makefile                               |    3 +
 drivers/bus/mhi/Kconfig                            |   14 +
 drivers/bus/mhi/Makefile                           |    2 +
 drivers/bus/mhi/core/Makefile                      |    3 +
 drivers/bus/mhi/core/boot.c                        |  507 +++++++
 drivers/bus/mhi/core/init.c                        | 1293 +++++++++++++++++
 drivers/bus/mhi/core/internal.h                    |  687 +++++++++
 drivers/bus/mhi/core/main.c                        | 1529 ++++++++++++++++++++
 drivers/bus/mhi/core/pm.c                          |  969 +++++++++++++
 drivers/char/Kconfig                               |  165 +--
 drivers/char/Makefile                              |    5 -
 drivers/char/applicom.c                            |    1 -
 drivers/char/efirtc.c                              |  366 -----
 drivers/char/mspec.c                               |    2 +-
 drivers/char/nwbutton.h                            |    1 -
 drivers/char/nwflash.c                             |    2 +-
 drivers/char/pcmcia/cm4000_cs.c                    |    4 +-
 drivers/char/ppdev.c                               |   20 +-
 drivers/char/rtc.c                                 | 1311 -----------------
 drivers/char/toshiba.c                             |    2 -
 drivers/char/virtio_console.c                      |    2 +-
 drivers/extcon/extcon-axp288.c                     |   32 +
 drivers/extcon/extcon-palmas.c                     |    8 +-
 drivers/extcon/extcon.c                            |    1 +
 drivers/firmware/Kconfig                           |    2 +-
 drivers/firmware/imx/Kconfig                       |    4 +-
 drivers/firmware/stratix10-svc.c                   |    1 +
 drivers/hwtracing/coresight/Kconfig                |   21 +
 drivers/hwtracing/coresight/Makefile               |    3 +
 .../hwtracing/coresight/coresight-cti-platform.c   |  485 +++++++
 drivers/hwtracing/coresight/coresight-cti-sysfs.c  | 1206 +++++++++++++++
 drivers/hwtracing/coresight/coresight-cti.c        |  745 ++++++++++
 drivers/hwtracing/coresight/coresight-cti.h        |  235 +++
 drivers/hwtracing/coresight/coresight-platform.c   |   20 +
 drivers/hwtracing/coresight/coresight-priv.h       |   15 +
 drivers/hwtracing/coresight/coresight.c            |   86 +-
 drivers/hwtracing/intel_th/intel_th.h              |    2 +
 drivers/hwtracing/intel_th/msu.c                   |   49 +-
 drivers/hwtracing/intel_th/pci.c                   |    8 +-
 drivers/interconnect/qcom/Kconfig                  |   25 +
 drivers/interconnect/qcom/Makefile                 |    8 +
 drivers/interconnect/qcom/bcm-voter.c              |  366 +++++
 drivers/interconnect/qcom/bcm-voter.h              |   27 +
 drivers/interconnect/qcom/icc-rpmh.c               |  150 ++
 drivers/interconnect/qcom/icc-rpmh.h               |  149 ++
 drivers/interconnect/qcom/osm-l3.c                 |  276 ++++
 drivers/interconnect/qcom/sc7180.c                 |  641 ++++++++
 drivers/interconnect/qcom/sc7180.h                 |  151 ++
 drivers/interconnect/qcom/sdm845.c                 | 1055 +++++---------
 drivers/interconnect/qcom/sdm845.h                 |  142 ++
 drivers/macintosh/ans-lcd.c                        |    2 +-
 drivers/macintosh/ans-lcd.h                        |    2 -
 drivers/macintosh/via-pmu.c                        |    3 -
 drivers/misc/cardreader/rts5227.c                  |    1 +
 drivers/misc/habanalabs/command_submission.c       |   51 +-
 drivers/misc/habanalabs/debugfs.c                  |   92 +-
 drivers/misc/habanalabs/device.c                   |    2 +-
 drivers/misc/habanalabs/goya/goya.c                |  204 ++-
 drivers/misc/habanalabs/goya/goya_coresight.c      |    4 +-
 drivers/misc/habanalabs/goya/goya_hwmgr.c          |    2 +-
 drivers/misc/habanalabs/habanalabs.h               |   62 +-
 drivers/misc/habanalabs/habanalabs_drv.c           |   11 +-
 drivers/misc/habanalabs/hwmon.c                    |  106 +-
 drivers/misc/habanalabs/include/armcp_if.h         |   20 +-
 .../habanalabs/include/goya/goya_async_events.h    |    4 +
 .../misc/habanalabs/include/goya/goya_reg_map.h    |   39 +-
 drivers/misc/habanalabs/include/hl_boot_if.h       |   39 +-
 drivers/misc/habanalabs/memory.c                   |  222 ++-
 drivers/misc/habanalabs/mmu.c                      |  110 +-
 drivers/misc/lkdtm/stackleak.c                     |   25 +-
 drivers/misc/mei/bus-fixup.c                       |    4 +-
 drivers/misc/mei/client.c                          |    4 +-
 drivers/misc/mei/hw-me-regs.h                      |    6 +-
 drivers/misc/mei/hw.h                              |    5 +-
 drivers/misc/mei/mei_dev.h                         |    2 +-
 drivers/misc/mei/pci-me.c                          |   17 +-
 drivers/misc/mei/pci-txe.c                         |    5 +-
 drivers/misc/mic/host/mic_boot.c                   |    2 +-
 drivers/misc/mic/host/mic_x100.c                   |    4 +-
 drivers/misc/sgi-gru/grulib.h                      |    2 +-
 drivers/misc/sgi-gru/grutables.h                   |    2 +-
 drivers/misc/vexpress-syscfg.c                     |    2 +-
 drivers/nvmem/Kconfig                              |   12 +
 drivers/nvmem/Makefile                             |    5 +-
 drivers/nvmem/core.c                               |  365 ++++-
 drivers/nvmem/imx-ocotp.c                          |   29 +-
 drivers/nvmem/jz4780-efuse.c                       |  239 +++
 drivers/nvmem/mxs-ocotp.c                          |   30 +-
 drivers/nvmem/nvmem-sysfs.c                        |  263 ----
 drivers/nvmem/nvmem.h                              |   64 -
 drivers/nvmem/sprd-efuse.c                         |   27 +-
 drivers/sbus/char/envctrl.c                        |    2 -
 drivers/sbus/char/flash.c                          |    4 +-
 drivers/sbus/char/uctrl.c                          |    2 -
 drivers/soundwire/bus.c                            |  537 ++++++-
 drivers/soundwire/bus.h                            |    9 +
 drivers/soundwire/bus_type.c                       |    5 +
 drivers/soundwire/cadence_master.c                 |  282 +++-
 drivers/soundwire/cadence_master.h                 |   17 +-
 drivers/soundwire/intel.c                          |  200 ++-
 drivers/soundwire/qcom.c                           |    8 +
 drivers/soundwire/slave.c                          |    4 +
 drivers/soundwire/stream.c                         |  115 +-
 drivers/staging/speakup/devsynth.c                 |   10 +-
 drivers/staging/speakup/speakup_soft.c             |   14 +-
 drivers/tty/Kconfig                                |  173 +--
 drivers/tty/hvc/Kconfig                            |    3 -
 drivers/tty/serial/Kconfig                         |    4 -
 drivers/uio/uio.c                                  |   38 +
 drivers/uio/uio_pdrv_genirq.c                      |   34 +-
 drivers/video/fbdev/pxa3xx-gcu.c                   |    7 +-
 drivers/virt/vboxguest/vboxguest_core.c            |    2 +-
 drivers/virt/vboxguest/vboxguest_utils.c           |    2 +-
 include/dt-bindings/arm/coresight-cti-dt.h         |   37 +
 include/dt-bindings/interconnect/qcom,osm-l3.h     |   12 +
 include/dt-bindings/interconnect/qcom,sc7180.h     |  161 +++
 include/dt-bindings/interconnect/qcom,sdm845.h     |  263 ++--
 include/linux/coresight.h                          |   27 +
 include/linux/extcon-provider.h                    |   28 +-
 include/linux/extcon.h                             |    5 +
 include/linux/mhi.h                                |  700 +++++++++
 include/linux/miscdevice.h                         |   14 +-
 include/linux/mod_devicetable.h                    |   13 +
 include/linux/nvmem-consumer.h                     |    7 +
 include/linux/soundwire/sdw.h                      |   49 +
 include/linux/uio_driver.h                         |   33 +-
 include/uapi/linux/coresight-stm.h                 |    6 +-
 kernel/power/user.c                                |    2 -
 lib/Kconfig.debug                                  |    7 +-
 lib/dynamic_debug.c                                |   28 +-
 scripts/mod/devicetable-offsets.c                  |    3 +
 scripts/mod/file2alias.c                           |   10 +
 scripts/ver_linux                                  |   24 +-
 .../selftests/filesystems/binderfs/Makefile        |    4 +-
 .../selftests/filesystems/binderfs/binderfs_test.c |  498 +++++--
 171 files changed, 16152 insertions(+), 4019 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-cti
 create mode 100644 Documentation/ABI/testing/sysfs-driver-jz4780-efuse
 create mode 100644 Documentation/devicetree/bindings/arm/coresight-cti.yaml
 delete mode 100644 Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.txt
 create mode 100644 Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml
 delete mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm845.yaml
 create mode 100644 Documentation/devicetree/bindings/nvmem/ingenic,jz4780-efuse.yaml
 create mode 100644 Documentation/mhi/index.rst
 create mode 100644 Documentation/mhi/mhi.rst
 create mode 100644 Documentation/mhi/topology.rst
 create mode 100644 Documentation/trace/coresight/coresight-ect.rst
 create mode 100644 drivers/bus/mhi/Kconfig
 create mode 100644 drivers/bus/mhi/Makefile
 create mode 100644 drivers/bus/mhi/core/Makefile
 create mode 100644 drivers/bus/mhi/core/boot.c
 create mode 100644 drivers/bus/mhi/core/init.c
 create mode 100644 drivers/bus/mhi/core/internal.h
 create mode 100644 drivers/bus/mhi/core/main.c
 create mode 100644 drivers/bus/mhi/core/pm.c
 delete mode 100644 drivers/char/efirtc.c
 delete mode 100644 drivers/char/rtc.c
 create mode 100644 drivers/hwtracing/coresight/coresight-cti-platform.c
 create mode 100644 drivers/hwtracing/coresight/coresight-cti-sysfs.c
 create mode 100644 drivers/hwtracing/coresight/coresight-cti.c
 create mode 100644 drivers/hwtracing/coresight/coresight-cti.h
 create mode 100644 drivers/interconnect/qcom/bcm-voter.c
 create mode 100644 drivers/interconnect/qcom/bcm-voter.h
 create mode 100644 drivers/interconnect/qcom/icc-rpmh.c
 create mode 100644 drivers/interconnect/qcom/icc-rpmh.h
 create mode 100644 drivers/interconnect/qcom/osm-l3.c
 create mode 100644 drivers/interconnect/qcom/sc7180.c
 create mode 100644 drivers/interconnect/qcom/sc7180.h
 create mode 100644 drivers/interconnect/qcom/sdm845.h
 create mode 100644 drivers/nvmem/jz4780-efuse.c
 delete mode 100644 drivers/nvmem/nvmem-sysfs.c
 delete mode 100644 drivers/nvmem/nvmem.h
 create mode 100644 include/dt-bindings/arm/coresight-cti-dt.h
 create mode 100644 include/dt-bindings/interconnect/qcom,osm-l3.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sc7180.h
 create mode 100644 include/linux/mhi.h
