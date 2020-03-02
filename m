Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67306C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 380F921D56
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgCBNde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 08:33:34 -0500
Received: from mga18.intel.com ([134.134.136.126]:37841 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727883AbgCBNdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 08:33:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 05:33:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,507,1574150400"; 
   d="scan'208";a="286620798"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Mar 2020 05:33:28 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 64D19164; Mon,  2 Mar 2020 15:33:27 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 00/19] platform/x86: Rework intel_scu_ipc and intel_pmc_ipc drivers
Date:   Mon,  2 Mar 2020 16:33:08 +0300
Message-Id: <20200302133327.55929-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

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

This is on top of platform-driver-x86.git/for-next branch because there is
already some cleanup work queued that re-organizes Kconfig and Makefile
entries.

I have tested this on Intel Joule (Broxton-M) board.

Changes from v6:

  * Added Reviewed-by tag from Andy
  * Expanded PMC, IPC and IA acronyms
  * Drop TCO_DEVICE_NAME, PUNIT_DEVICE_NAME and TELEMETRY_DEVICE_NAME
  * Move struct intel_pmc_dev into include/linux/mfd/intel_pmc_bxt.h
  * Add PMC_DEVICE_MAX to the enum and use it
  * Add kernel-docs for simplecmd_store() and northpeak_store()
  * Use if (ret) return ret; over the ternary operator
  * Drop "This is index X" from comments
  * Use acpi_has_watchdog() to determine whether iTCO_wdt is added or not.
  * Rename intel_scu_ipc_pdata -> intel_scu_ipc_data to make it less
    confusing wrt. platform data for platform drivers.

Previous versions can be found:

  v6: https://www.spinics.net/lists/platform-driver-x86/msg20896.html
  v5: https://www.spinics.net/lists/platform-driver-x86/msg20841.html
  v4: https://www.spinics.net/lists/platform-driver-x86/msg20658.html
  v3: https://www.spinics.net/lists/platform-driver-x86/msg20583.html
  v2: https://www.spinics.net/lists/platform-driver-x86/msg20446.html
  v1: https://www.spinics.net/lists/platform-driver-x86/msg20359.html

Mika Westerberg (19):
  platform/x86: intel_scu_ipc: Split out SCU IPC functionality from the SCU driver
  platform/x86: intel_scu_ipc: Log more information if SCU IPC command fails
  platform/x86: intel_scu_ipc: Move legacy SCU IPC API to a separate header
  platform/x86: intel_scu_ipc: Introduce new SCU IPC API
  platform/x86: intel_mid_powerbtn: Convert to use new SCU IPC API
  watchdog: intel-mid_wdt: Convert to use new SCU IPC API
  platform/x86: intel_scu_ipcutil: Convert to use new SCU IPC API
  platform/x86: intel_scu_ipc: Add managed function to register SCU IPC
  platform/x86: intel_pmc_ipc: Start using SCU IPC
  mfd: intel_soc_pmic: Add SCU IPC member to struct intel_soc_pmic
  mfd: intel_soc_pmic_bxtwc: Convert to use new SCU IPC API
  mfd: intel_soc_pmic_mrfld: Convert to use new SCU IPC API
  platform/x86: intel_telemetry: Convert to use new SCU IPC API
  platform/x86: intel_pmc_ipc: Drop intel_pmc_ipc_command()
  x86/platform/intel-mid: Add empty stubs for intel_scu_devices_[create|destroy]()
  platform/x86: intel_pmc_ipc: Move PCI IDs to intel_scu_pcidrv.c
  platform/x86: intel_telemetry: Add telemetry_get_pltdata()
  platform/x86: intel_pmc_ipc: Convert to MFD
  MAINTAINERS: Update entry for Intel Broxton PMC driver

 .../ABI/obsolete/sysfs-driver-intel_pmc_bxt   |  22 +
 MAINTAINERS                                   |  23 +-
 arch/x86/Kconfig                              |   2 +-
 arch/x86/include/asm/intel-mid.h              |   9 +-
 arch/x86/include/asm/intel_pmc_ipc.h          |  59 --
 arch/x86/include/asm/intel_scu_ipc.h          | 114 ++-
 arch/x86/include/asm/intel_scu_ipc_legacy.h   |  91 ++
 arch/x86/include/asm/intel_telemetry.h        |   6 +-
 drivers/mfd/Kconfig                           |  20 +-
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/intel_pmc_bxt.c                   | 504 ++++++++++
 drivers/mfd/intel_soc_pmic_bxtwc.c            |  34 +-
 drivers/mfd/intel_soc_pmic_mrfld.c            |  10 +-
 drivers/platform/x86/Kconfig                  |  46 +-
 drivers/platform/x86/Makefile                 |   2 +-
 drivers/platform/x86/intel_mid_powerbtn.c     |  15 +-
 drivers/platform/x86/intel_pmc_ipc.c          | 949 ------------------
 drivers/platform/x86/intel_scu_ipc.c          | 447 +++++++--
 drivers/platform/x86/intel_scu_ipcutil.c      |  43 +-
 drivers/platform/x86/intel_scu_pcidrv.c       |  68 ++
 drivers/platform/x86/intel_telemetry_core.c   |  17 +-
 .../platform/x86/intel_telemetry_debugfs.c    |  15 +-
 drivers/platform/x86/intel_telemetry_pltdrv.c |  97 +-
 drivers/usb/typec/tcpm/Kconfig                |   2 +-
 drivers/watchdog/intel-mid_wdt.c              |  53 +-
 include/linux/mfd/intel_pmc_bxt.h             |  43 +
 include/linux/mfd/intel_soc_pmic.h            |  15 +
 27 files changed, 1402 insertions(+), 1305 deletions(-)
 create mode 100644 Documentation/ABI/obsolete/sysfs-driver-intel_pmc_bxt
 delete mode 100644 arch/x86/include/asm/intel_pmc_ipc.h
 create mode 100644 arch/x86/include/asm/intel_scu_ipc_legacy.h
 create mode 100644 drivers/mfd/intel_pmc_bxt.c
 delete mode 100644 drivers/platform/x86/intel_pmc_ipc.c
 create mode 100644 drivers/platform/x86/intel_scu_pcidrv.c
 create mode 100644 include/linux/mfd/intel_pmc_bxt.h

-- 
2.25.0

