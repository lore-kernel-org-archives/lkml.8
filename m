Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08287C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D200D24125
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbgAUQBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 11:01:21 -0500
Received: from mga17.intel.com ([192.55.52.151]:15566 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727817AbgAUQBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 11:01:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 08:01:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,346,1574150400"; 
   d="scan'208";a="228885431"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 21 Jan 2020 08:01:15 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id A3B631AD; Tue, 21 Jan 2020 18:01:14 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Brown <broonie@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/38] platform/x86: Rework intel_scu_ipc and intel_pmc_ipc drivers
Date:   Tue, 21 Jan 2020 19:00:36 +0300
Message-Id: <20200121160114.60007-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Currently both intel_scu_ipc.c and intel_pmc_ipc.c implement the same SCU
IPC communications with minor differences. This duplication does not make
much sense so this series reworks the two drivers so that there is only a
single implementation of the SCU IPC. In addition to that the API will be
updated to take SCU instance pointer as an argument, and most of the
callers will be converted to this new API. The old API is left there but
the plan is to get rid the callers and then the old API as well (this is
something we are working with Andy Shevchenko).

The intel_pmc_ipc.c is then moved under MFD which suits better for this
kind of a driver that pretty much sets up the SCU IPC and then creates a
bunch of platform devices for the things sitting behind the PMC. The driver
is renamed to intel_pmc_bxt.c which should follow the existing conventions
under drivers/mfd (and it is only meant for Intel Broxton derivatives).

Previous version of the series:

  v3: https://www.spinics.net/lists/platform-driver-x86/msg20583.html
  v2: https://www.spinics.net/lists/platform-driver-x86/msg20446.html
  v1: https://www.spinics.net/lists/platform-driver-x86/msg20359.html

Changes from v3:

  * Rename intel_scu_ipc_probe() to intel_scu_ipc_register() and _remove()
    to _unregister() accordingly.
  * Make intel_scu_ipc_register() to perform handle resource request and
    ioremap itself.
  * Add devm_intel_scu_ipc_register().
  * Improve kernel-docs of struct intel_soc_pmic.
  * Add Documentation/ABI/obsolete/sysfs-driver-intel_pmc_bxt to document the
    two sysfs attributes the driver exposes.
  * Fix typos in the MFD driver
  * Drop gcr_data_readq() wrapper
  * No need to check for !pmcdev.gcr_mem_base in the MFD accessors
  * Allocate PMC instance dynamically and pass this from the callers
    (telemetry) as well
  * Take the lock in intel_pmc_s0ix_counter_read() to be consistent with other
    register accessors (and serialize them).
  * Use kstrtoul() return value directly (new patch)
  * Use static const MFD cell and resources where possible. Take a copy of
    these before they get populated and passed to the MFD code.
  * Use module_platform_driver() in the MFD driver
  * Drop dev_dbg() prints.
  * Return -EINVAL instead of -ENXIO when platform_get_resource() for
    mandatory resources.
  * Clarify "residency" in intel_pmc_s0ix_counter_read().

Did not convert to use regmap because register access is 64-bit and it
looks like regmap read/write API does not support this.

I also dropped Andy's reviewed-by tag from the MFD patch (37/38) because it
changed quite much from the previous version.

Changes from v2:

  * Added review tags from Andy
  * Patch 12: Put intel_scu_ipc_probe() prototype and implementation in one line
  * Patch 12: Correct wording in Kconfig description.
  * Patch 12: Put devm_request_irq() in one line.
  * Patch 14: Add blank line before intel_scu_ipc_dev_update() in header.
  * Patch 14: intel_scu_ipc_dev_update() move 'u8 data' to the next line in header.
  * Patch 14: Drop outlen check in intel_scu_ipc_dev_command_with_size().
  * Patch 16: Added Guenter's ack.
  * Patch 25: Put intel_scu_ipc_dev_command() call in one line.
  * Patch 25: Put intel_scu_ipc_dev_simple_command() call in one line.
  * Patch 32: Drop X86_INTEL_MID dependency from INTEL_SCU_PCI.
  * Patch 34: Split MFD_INTEL_PMC_BXT dependencies one per line.
  * Patch 35: Reorder to happen before patch 34.
  * Patch 35: Drop comma from terminating line.

Changes from v1:

  * Update changelog of patch 16 according to what the patch actually does.
  * Add kernel-doc for struct intel_soc_pmic.
  * Move octal permission patch to be before MFD conversion.
  * Convert the intel_pmc_bxt.c to MFD APIs whilst it is being moved under
    drivers/mfd.

I would prefer this to be merged through platform/x86 or MFD trees assuming
there are no objections.

I have tested this on Intel Edison (Merrifield) and Joule (Broxton-M).

Mika Westerberg (38):
  platform/x86: intel_mid_powerbtn: Take a copy of ddata
  platform/x86: intel_scu_ipcutil: Remove default y from Kconfig
  platform/x86: intel_scu_ipc: Add constants for register offsets
  platform/x86: intel_scu_ipc: Remove Lincroft support
  platform/x86: intel_scu_ipc: Drop intel_scu_ipc_i2c_cntrl()
  platform/x86: intel_scu_ipc: Fix interrupt support
  platform/x86: intel_scu_ipc: Sleeping is fine when polling
  platform/x86: intel_scu_ipc: Drop unused prototype intel_scu_ipc_fw_update()
  platform/x86: intel_scu_ipc: Drop unused macros
  platform/x86: intel_scu_ipc: Drop intel_scu_ipc_io[read|write][8|16]()
  platform/x86: intel_scu_ipc: Drop intel_scu_ipc_raw_command()
  platform/x86: intel_scu_ipc: Split out SCU IPC functionality from the SCU driver
  platform/x86: intel_scu_ipc: Reformat kernel-doc comments of exported functions
  platform/x86: intel_scu_ipc: Introduce new SCU IPC API
  platform/x86: intel_mid_powerbtn: Convert to use new SCU IPC API
  watchdog: intel-mid_wdt: Convert to use new SCU IPC API
  platform/x86: intel_scu_ipcutil: Convert to use new SCU IPC API
  platform/x86: intel_pmc_ipc: Make intel_pmc_gcr_update() static
  platform/x86: intel_pmc_ipc: Make intel_pmc_ipc_simple_command() static
  platform/x86: intel_pmc_ipc: Make intel_pmc_ipc_raw_cmd() static
  platform/x86: intel_pmc_ipc: Drop intel_pmc_gcr_read() and intel_pmc_gcr_write()
  platform/x86: intel_pmc_ipc: Drop ipc_data_readb()
  platform/x86: intel_pmc_ipc: Get rid of unnecessary includes
  platform/x86: intel_scu_ipc: Add managed function to register SCU IPC
  platform/x86: intel_pmc_ipc: Start using SCU IPC
  mfd: intel_soc_pmic: Add SCU IPC member to struct intel_soc_pmic
  mfd: intel_soc_pmic_bxtwc: Convert to use new SCU IPC API
  mfd: intel_soc_pmic_mrfld: Convert to use new SCU IPC API
  platform/x86: intel_telemetry: Convert to use new SCU IPC API
  platform/x86: intel_pmc_ipc: Drop intel_pmc_ipc_command()
  x86/platform/intel-mid: Add empty stubs for intel_scu_devices_[create|destroy]()
  platform/x86: intel_pmc_ipc: Move PCI IDs to intel_scu_pcidrv.c
  platform/x86: intel_pmc_ipc: Use octal permissions in sysfs attributes
  platform/x86: intel_pmc_ipc: Propagate error from kstrtoul()
  platform/x86: intel_pmc_ipc: Switch to use driver->dev_groups
  platform/x86: intel_telemetry: Add telemetry_get_pltdata()
  platform/x86: intel_pmc_ipc: Convert to MFD
  MAINTAINERS: Update entry for Intel Broxton PMC driver

 .../ABI/obsolete/sysfs-driver-intel_pmc_bxt   |   22 +
 MAINTAINERS                                   |   13 +-
 arch/x86/Kconfig                              |    2 +-
 arch/x86/include/asm/intel-mid.h              |    9 +-
 arch/x86/include/asm/intel_pmc_ipc.h          |   91 --
 arch/x86/include/asm/intel_scu_ipc.h          |  107 +-
 arch/x86/include/asm/intel_scu_ipc_legacy.h   |   76 ++
 arch/x86/include/asm/intel_telemetry.h        |    5 +
 drivers/mfd/Kconfig                           |   20 +-
 drivers/mfd/Makefile                          |    1 +
 drivers/mfd/intel_pmc_bxt.c                   |  496 ++++++++
 drivers/mfd/intel_soc_pmic_bxtwc.c            |   22 +-
 drivers/mfd/intel_soc_pmic_mrfld.c            |   10 +-
 drivers/platform/x86/Kconfig                  |   49 +-
 drivers/platform/x86/Makefile                 |    2 +-
 drivers/platform/x86/intel_mid_powerbtn.c     |   20 +-
 drivers/platform/x86/intel_pmc_ipc.c          | 1031 -----------------
 drivers/platform/x86/intel_scu_ipc.c          |  732 ++++++------
 drivers/platform/x86/intel_scu_ipcutil.c      |   43 +-
 drivers/platform/x86/intel_scu_pcidrv.c       |   68 ++
 drivers/platform/x86/intel_telemetry_core.c   |   12 +
 .../platform/x86/intel_telemetry_debugfs.c    |   12 +-
 drivers/platform/x86/intel_telemetry_pltdrv.c |  103 +-
 drivers/usb/typec/tcpm/Kconfig                |    2 +-
 drivers/watchdog/intel-mid_wdt.c              |   53 +-
 include/linux/mfd/intel_pmc_bxt.h             |   21 +
 include/linux/mfd/intel_soc_pmic.h            |   15 +
 27 files changed, 1348 insertions(+), 1689 deletions(-)
 create mode 100644 Documentation/ABI/obsolete/sysfs-driver-intel_pmc_bxt
 delete mode 100644 arch/x86/include/asm/intel_pmc_ipc.h
 create mode 100644 arch/x86/include/asm/intel_scu_ipc_legacy.h
 create mode 100644 drivers/mfd/intel_pmc_bxt.c
 delete mode 100644 drivers/platform/x86/intel_pmc_ipc.c
 create mode 100644 drivers/platform/x86/intel_scu_pcidrv.c
 create mode 100644 include/linux/mfd/intel_pmc_bxt.h

-- 
2.24.1

