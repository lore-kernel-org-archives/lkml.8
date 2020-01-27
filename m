Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FED3C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 11:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0403F214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 11:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbgA0LXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 06:23:55 -0500
Received: from mga04.intel.com ([192.55.52.120]:30806 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729770AbgA0LXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 06:23:51 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jan 2020 03:23:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,369,1574150400"; 
   d="scan'208";a="221705589"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 27 Jan 2020 03:23:48 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iw2Uf-0003Fx-QI; Mon, 27 Jan 2020 13:23:49 +0200
Date:   Mon, 27 Jan 2020 13:23:49 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [GIT PULL] platform-drivers-x86 for 5.6-1
Message-ID: <20200127112349.GA12412@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

PDx86 changes for v5.6. There are two conflicts in Documentation, which should
be resolved as provided by this PR, i.e. in the first one the blank line should
be removed, in the second one all lines should be added. For your convenience
I have published test-pr-5.6-1 branch in our tree with example of resolution.

Besides that we are expecting merge conflicts with Christoph's Hellwig tree
to drop ioremap_nocache(). The resolution should be to move from
*ioremap_nocache*() calls to simple *ioremap*() ones where it applies.

We have duplicate commits:

 - 84abc5a1c924 platform/x86: intel-ips: Use the correct style for SPDX License Identifier
 - 3454eeeebd11 platform/mellanox: fix potential deadlock in the tmfifo driver
 - 01e28c1b2963 platform/x86: GPD pocket fan: Use default values when wrong modparams are given
 - eb518899c499 platform/x86: GPD pocket fan: Allow somewhat lower/higher temperature limits
 - 4d9ffa0b89fb platform/x86: intel_pmc_core: update Comet Lake platform driver
 - 26e66a0cf258 platform/x86: asus-wmi: Fix keyboard brightness cannot be set to 0
 - eea97b258fca Documentation/ABI: Fix documentation inconsistency for mlxreg-io sysfs interfaces
 - 74e56f5fde62 Documentation/ABI: Add missed attribute for mlxreg-io sysfs interfaces

that had been sent as fixes during v5.5 cycle.

Thanks,

With Best Regards,
Andy Shevchenko

The following changes since commit 02abbda105f25fb634207e7f23a8a4b51fe67ad4:

  platform/x86: pcengines-apuv2: Spelling fixes in the driver (2019-12-20 19:01:59 +0200)

are available in the Git repository at:

  git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v5.6-1

for you to fetch changes up to cf85e7c7f437cb4e378bddbdb366477096714819:

  platform/x86: intel_pmc_ipc: Switch to use driver->dev_groups (2020-01-22 18:52:27 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v5.6-1

* Enable thermal policy for ASUS TUF FX705DY/FX505DY
* Support left round button on ASUS N56VB
* Support new Mellanox platforms of basic class VMOD0009 and VMOD0010
* Intel Comet Lake, Tiger Lake and Elkhart Lake support in the PMC driver
* Big clean up to Intel PMC core, PMC IPC and SCU IPC drivers
* Touchscreen support for the PiPO W11 tablet

The following is an automated git shortlog grouped by driver:

asus-nb-wmi:
 -  Support left round button on N56VB

asus-wmi:
 -  Fix keyboard brightness cannot be set to 0
 -  Set throttle thermal policy to default
 -  Support throttle thermal policy

Documentation/ABI:
 -  Add new attribute for mlxreg-io sysfs interfaces
 -  Style changes
 -  Add missed attribute for mlxreg-io sysfs interfaces
 -  Fix documentation inconsistency for mlxreg-io sysfs interfaces

GPD pocket fan:
 -  Allow somewhat lower/higher temperature limits
 -  Use default values when wrong modparams are given

intel_atomisp2_pm:
 -  Spelling fixes
 -  Refactor timeout loop

intel_mid_powerbtn:
 -  Take a copy of ddata

intel_pmc_core:
 -  update Comet Lake platform driver
 -  Fix spelling of MHz unit
 -  Fix indentation in function definitions
 -  Put more stuff under #ifdef DEBUG_FS
 -  Respect error code of kstrtou32_from_user()
 -  Add Intel Elkhart Lake support
 -  Add Intel Tiger Lake support
 -  Make debugfs entry for pch_ip_power_gating_status conditional
 -  Create platform dependent bitmap structs
 -  Remove unnecessary assignments
 -  Clean up: Remove comma after the termination line

intel_pmc_ipc:
 -  Switch to use driver->dev_groups
 -  Propagate error from kstrtoul()
 -  Use octal permissions in sysfs attributes
 -  Get rid of unnecessary includes
 -  Drop ipc_data_readb()
 -  Drop intel_pmc_gcr_read() and intel_pmc_gcr_write()
 -  Make intel_pmc_ipc_raw_cmd() static
 -  Make intel_pmc_ipc_simple_command() static
 -  Make intel_pmc_gcr_update() static

intel_scu_ipc:
 -  Reformat kernel-doc comments of exported functions
 -  Drop intel_scu_ipc_raw_command()
 -  Drop intel_scu_ipc_io[read|write][8|16]()
 -  Drop unused macros
 -  Drop unused prototype intel_scu_ipc_fw_update()
 -  Sleeping is fine when polling
 -  Drop intel_scu_ipc_i2c_cntrl()
 -  Remove Lincroft support
 -  Add constants for register offsets
 -  Fix interrupt support

intel_scu_ipcutil:
 -  Remove default y from Kconfig

intel_telemetry_debugfs:
 -  Respect error code of kstrtou32_from_user()

intel_telemetry_pltdrv:
 -  use devm_platform_ioremap_resource()

mlx-platform:
 -  Add support for next generation systems
 -  Add support for new capability register
 -  Add support for new system type
 -  Set system mux configuration based on system type
 -  Add more definitions for system attributes
 -  Cosmetic changes

platform/mellanox:
 -  mlxreg-hotplug: Add support for new capability register
 -  fix potential deadlock in the tmfifo driver

tools/power/x86/intel-speed-select:
 -  Update version
 -  Change the order for clos disable
 -  Fix result display for turbo-freq auto mode
 -  Add support for core-power discovery
 -  Allow additional core-power mailbox commands
 -  Update MAINTAINERS for the intel uncore frequency control
 -  Add support for Uncore frequency control

touchscreen_dmi:
 -  Fix indentation in several places
 -  Add info for the PiPO W11 tablet

----------------------------------------------------------------
Andy Shevchenko (10):
      platform/x86: intel_pmc_core: Remove unnecessary assignments
      platform/x86: intel_telemetry_pltdrv: use devm_platform_ioremap_resource()
      platform/x86: intel_pmc_core: Respect error code of kstrtou32_from_user()
      platform/x86: intel_pmc_core: Put more stuff under #ifdef DEBUG_FS
      platform/x86: intel_pmc_core: Fix indentation in function definitions
      platform/x86: intel_pmc_core: Fix spelling of MHz unit
      platform/x86: intel_telemetry_debugfs: Respect error code of kstrtou32_from_user()
      platform/x86: touchscreen_dmi: Fix indentation in several places
      platform/x86: intel_atomisp2_pm: Refactor timeout loop
      platform/x86: intel_atomisp2_pm: Spelling fixes

Gayatri Kammela (5):
      platform/x86: intel_pmc_core: Clean up: Remove comma after the termination line
      platform/x86: intel_pmc_core: Create platform dependent bitmap structs
      platform/x86: intel_pmc_core: Make debugfs entry for pch_ip_power_gating_status conditional
      platform/x86: intel_pmc_core: Add Intel Tiger Lake support
      platform/x86: intel_pmc_core: Add Intel Elkhart Lake support

Hans de Goede (2):
      platform/x86: GPD pocket fan: Use default values when wrong modparams are given
      platform/x86: GPD pocket fan: Allow somewhat lower/higher temperature limits

Harry Pan (1):
      platform/x86: intel_pmc_core: update Comet Lake platform driver

Jian-Hong Pan (1):
      platform/x86: asus-wmi: Fix keyboard brightness cannot be set to 0

Leonid Maksymchuk (2):
      platform/x86: asus_wmi: Support throttle thermal policy
      platform/x86: asus_wmi: Set throttle thermal policy to default

Liming Sun (1):
      platform/mellanox: fix potential deadlock in the tmfifo driver

Mika Westerberg (21):
      platform/x86: intel_mid_powerbtn: Take a copy of ddata
      platform/x86: intel_scu_ipcutil: Remove default y from Kconfig
      platform/x86: intel_scu_ipc: Fix interrupt support
      platform/x86: intel_scu_ipc: Add constants for register offsets
      platform/x86: intel_scu_ipc: Remove Lincroft support
      platform/x86: intel_scu_ipc: Drop intel_scu_ipc_i2c_cntrl()
      platform/x86: intel_scu_ipc: Sleeping is fine when polling
      platform/x86: intel_scu_ipc: Drop unused prototype intel_scu_ipc_fw_update()
      platform/x86: intel_scu_ipc: Drop unused macros
      platform/x86: intel_scu_ipc: Drop intel_scu_ipc_io[read|write][8|16]()
      platform/x86: intel_scu_ipc: Drop intel_scu_ipc_raw_command()
      platform/x86: intel_scu_ipc: Reformat kernel-doc comments of exported functions
      platform/x86: intel_pmc_ipc: Make intel_pmc_gcr_update() static
      platform/x86: intel_pmc_ipc: Make intel_pmc_ipc_simple_command() static
      platform/x86: intel_pmc_ipc: Make intel_pmc_ipc_raw_cmd() static
      platform/x86: intel_pmc_ipc: Drop intel_pmc_gcr_read() and intel_pmc_gcr_write()
      platform/x86: intel_pmc_ipc: Drop ipc_data_readb()
      platform/x86: intel_pmc_ipc: Get rid of unnecessary includes
      platform/x86: intel_pmc_ipc: Use octal permissions in sysfs attributes
      platform/x86: intel_pmc_ipc: Propagate error from kstrtoul()
      platform/x86: intel_pmc_ipc: Switch to use driver->dev_groups

Nishad Kamdar (1):
      platform/x86: intel-ips: Use the correct style for SPDX License Identifier

Paul Cercueil (1):
      platform/x86: asus-nb-wmi: Support left round button on N56VB

Srinivas Pandruvada (7):
      platform/x86: Add support for Uncore frequency control
      MAINTAINERS: Update for the intel uncore frequency control
      platform/x86: ISST: Allow additional core-power mailbox commands
      tools/power/x86/intel-speed-select: Add support for core-power discovery
      tools/power/x86/intel-speed-select: Fix result display for turbo-freq auto mode
      tools/power/x86/intel-speed-select: Change the order for clos disable
      tools/power/x86/intel-speed-select: Update version

Tim Josten (1):
      platform/x86: touchscreen_dmi: Add info for the PiPO W11 tablet

Vadim Pasternak (11):
      platform/x86: mlx-platform: Cosmetic changes
      Documentation/ABI: Fix documentation inconsistency for mlxreg-io sysfs interfaces
      Documentation/ABI: Add missed attribute for mlxreg-io sysfs interfaces
      Documentation/ABI: Style changes
      platform/x86: mlx-platform: Add more definitions for system attributes
      Documentation/ABI: Add new attribute for mlxreg-io sysfs interfaces
      platform/x86: mlx-platform: Set system mux configuration based on system type
      platform/x86: mlx-platform: Add support for new system type
      platform/x86: mlx-platform: Add support for new capability register
      platform/mellanox: mlxreg-hotplug: Add support for new capability register
      platform/x86: mlx-platform: Add support for next generation systems

 Documentation/ABI/stable/sysfs-driver-mlxreg-io    |  92 +++-
 Documentation/ABI/testing/sysfs-platform-asus-wmi  |  10 +
 MAINTAINERS                                        |   6 +
 arch/x86/include/asm/intel_pmc_ipc.h               |  32 --
 arch/x86/include/asm/intel_scu_ipc.h               |  20 -
 arch/x86/include/asm/intel_telemetry.h             |   3 -
 drivers/platform/mellanox/mlxbf-tmfifo.c           |  19 +-
 drivers/platform/mellanox/mlxreg-hotplug.c         |  14 +
 drivers/platform/x86/Kconfig                       |  18 +-
 drivers/platform/x86/Makefile                      |   1 +
 drivers/platform/x86/asus-nb-wmi.c                 |   1 +
 drivers/platform/x86/asus-wmi.c                    | 132 ++++-
 drivers/platform/x86/gpd-pocket-fan.c              |  27 +-
 drivers/platform/x86/intel-uncore-frequency.c      | 437 ++++++++++++++++
 drivers/platform/x86/intel_atomisp2_pm.c           |  25 +-
 drivers/platform/x86/intel_ips.h                   |   2 +-
 drivers/platform/x86/intel_mid_powerbtn.c          |   5 +-
 drivers/platform/x86/intel_pmc_core.c              | 141 ++++--
 drivers/platform/x86/intel_pmc_core.h              |   6 +-
 drivers/platform/x86/intel_pmc_core_pltdrv.c       |   2 +
 drivers/platform/x86/intel_pmc_ipc.c               | 114 +----
 drivers/platform/x86/intel_scu_ipc.c               | 414 ++++-----------
 .../x86/intel_speed_select_if/isst_if_common.c     |   3 +
 drivers/platform/x86/intel_telemetry_debugfs.c     |  14 +-
 drivers/platform/x86/intel_telemetry_pltdrv.c      |  64 +--
 drivers/platform/x86/mlx-platform.c                | 564 ++++++++++++++++++++-
 drivers/platform/x86/touchscreen_dmi.c             |  82 +--
 include/linux/platform_data/mlxreg.h               |   2 +
 include/linux/platform_data/x86/asus-wmi.h         |   1 +
 tools/power/x86/intel-speed-select/isst-config.c   |  34 +-
 tools/power/x86/intel-speed-select/isst-core.c     |  55 ++
 tools/power/x86/intel-speed-select/isst-display.c  |  27 +-
 tools/power/x86/intel-speed-select/isst.h          |   6 +
 33 files changed, 1660 insertions(+), 713 deletions(-)
 create mode 100644 drivers/platform/x86/intel-uncore-frequency.c

-- 
With Best Regards,
Andy Shevchenko


