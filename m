Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20ADEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 08:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E52D62077D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 08:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgFBIQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 04:16:16 -0400
Received: from mga18.intel.com ([134.134.136.126]:41919 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbgFBIQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 04:16:15 -0400
IronPort-SDR: D1LV+jvAbIH25KdRGaY7tgjamuH5vOyrbi5Ah6a84GBI/uJlEFLS7z9BE1cZaoLOeUkGZn5+cq
 Mn5LlqJYsPeg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 01:16:14 -0700
IronPort-SDR: W2iZ/xzkrcVBpVHMlrUHdniDd1FjrcZYxiVHFia6VhClJoIeCUPJfa0YAc8cYiTWnzV5LTb5Hf
 zlV2AZlENtSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,463,1583222400"; 
   d="scan'208";a="444605835"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005.jf.intel.com with ESMTP; 02 Jun 2020 01:16:12 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jg25n-00AO52-Up; Tue, 02 Jun 2020 11:16:15 +0300
Date:   Tue, 2 Jun 2020 11:16:15 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: [GIT PULL] platform-drivers-x86 for 5.8-1
Message-ID: <20200602081615.GA2475822@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Rather big pile of patches for PDx86 for v5.8. It includes three merges,
one is cross MFD-USB-PDx86, another is DriverCore-PDx86, and the last one
is established merge practice of Intel Speed Select tooling.

Nevertheless, no conflicts found during test merge with most recent contents
in your master.

Thanks,

With Best Regards,
Andy Shevchenko

The following changes since commit ae83d0b416db002fe95601e7f97f64b59514d936:

  Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)

are available in the Git repository at:

  git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v5.8-1

for you to fetch changes up to 47a94c551a7401a196cba881470dc9cb92573e82:

  platform/x86: dcdbas: Check SMBIOS for protected buffer address (2020-06-01 12:27:25 +0300)

----------------------------------------------------------------
platform-drivers-x86 for v5.8-1

* Add a support of  the media keys on the ASUS laptop UX325JA/UX425JA
* ASUS WMI driver can now handle 2-in-1 models T100TA, T100CHI, T100HA, T200TA
* Big refactoring of Intel SCU driver with Elkhart Lake support has been added
* Slim Bootloarder firmware update signaling WMI driver has been added
* Thinkpad ACPI driver can handle dual fan configuration on new P and X models
* Touchscreen DMI driver has been extended to support
  - MP-man MPWIN895CL tablet
  - ONDA V891 v5 tablet
  - techBite Arc 11.6
  - Trekstor Twin 10.1
  - Trekstor Yourbook C11B
  - Vinga J116
* Virtual Button driver got a few fixes to detect mode of 2-in-1 tablet models
* Intel Speed Select tools update
* Plenty of small cleanups here and there

The following is an automated git shortlog grouped by driver:

acerhdf:
 -  replace space by * in modalias

New drivers:
 - Add Elkhart Lake SCU/PMC support
 - Add Slim Bootloader firmware update signaling driver

asus-laptop:
 -  Drop duplicate check for led_classdev_unregister()

asus-nb-wmi:
 -  Revert "Do not load on Asus T100TA and T200TA"
 -  Do not load on Asus T100TA and T200TA

asus-wmi:
 -  Ignore WMI events with code 0x79
 -  Add support for SW_TABLET_MODE
 -  Move asus_wmi_input_init and _exit lower in the file
 -  Drop duplicate check for led_classdev_unregister()
 -  Reserve more space for struct bias_args
 -  remove redundant initialization of variable status

dcdbas:
 -  Check SMBIOS for protected buffer address

dell-laptop:
 -  don't register micmute LED if there is no token

dell-wmi:
 -  Ignore keyboard attached / detached events

device property:
 -  export set_secondary_fwnode() to modules

eeepc-laptop:
 -  Drop duplicate check for led_classdev_unregister()

hp-wmi:
 -  Introduce HPWMI_POWER_FW_OR_HW as convenient shortcut
 -  Convert simple_strtoul() to kstrtou32()
 -  Refactor postcode_store() to follow standard patterns

intel_cht_int33fe:
 -  Fix spelling issues
 -  Switch to use acpi_dev_hid_uid_match()
 -  Convert to use set_secondary_fwnode()
 -  Convert software node array to group

intel-hid:
 -  Add a quirk to support HP Spectre X2 (2015)

intel_mid_powerbtn:
 -  Convert to use new SCU IPC API

intel_pmc_core:
 -  avoid unused-function warnings
 -  Change Jasper Lake S0ix debug reg map back to ICL

intel_pmc_ipc:
 -  Convert to MFD
 -  Move PCI IDs to intel_scu_pcidrv.c
 -  Drop intel_pmc_ipc_command()
 -  Start using SCU IPC

intel_scu_ipc:
 -  Add managed function to register SCU IPC
 -  Introduce new SCU IPC API
 -  Move legacy SCU IPC API to a separate header
 -  Log more information if SCU IPC command fails
 -  Split out SCU IPC functionality from the SCU driver

intel_scu_ipcutil:
 -  Convert to use new SCU IPC API

intel-speed-select:
 -  Fix speed-select-base-freq-properties output on CLX-N

intel_telemetry:
 -  Add telemetry_get_pltdata()
 -  Convert to use new SCU IPC API

intel-vbtn:
 -  Only blacklist SW_TABLET_MODE on the 9 / "Laptop" chasis-type
 -  Detect switch position before registering the input-device
 -  Move detect_tablet_mode() to higher in the file
 -  Fix probe failure on devices with only switches
 -  Also handle tablet-mode switch on "Detachable" and "Portable" chassis-types
 -  Do not advertise switches to userspace if they are not there
 -  Split keymap into buttons and switches parts
 -  Use acpi_evaluate_integer()

ISST:
 -  Increase timeout

lg-laptop:
 -  Drop duplicate check for led_classdev_unregister()

MAINTAINERS:
 -  Add me as maintainer of Intel SCU drivers
 -  Update entry for Intel Broxton PMC driver

Merges of immutable branches:
 - Merge branch 'for-next'
 - Merge branch 'ib-mfd-x86-usb-watchdog-v5.7'
 - Merge branch 'ib-pdx86-properties'

mfd:
 -  intel_soc_pmic_mrfld: Convert to use new SCU IPC API
 -  intel_soc_pmic_bxtwc: Convert to use new SCU IPC API
 -  intel_soc_pmic: Add SCU IPC member to struct intel_soc_pmic

samsung-laptop:
 -  Drop duplicate check for led_classdev_unregister()

software node:
 -  Allow register and unregister software node groups

sony-laptop:
 -  Make resuming thermal profile safer
 -  SNC calls should handle BUFFER types

thinkpad_acpi:
 -  Replace custom approach by kstrtoint()
 -  Use strndup_user() in dispatch_proc_write()
 -  Replace next_cmd(&buf) with strsep(&buf, ",")
 -  Drop duplicate check for led_classdev_unregister()
 -  Remove always false 'value < 0' statement
 -  Add support for dual fan control

tools/power/x86/intel-speed-select:
 -  Fix invalid core mask
 -  Increase CPU count
 -  Fix json perf-profile output output
 -  Update version
 -  Enable clos for turbo-freq enable
 -  Fix CLX-N package information output
 -  Check support status before enable
 -  Change debug to error

toshiba_acpi:
 -  Drop duplicate check for led_classdev_unregister()

touchscreen_dmi:
 -  Update Trekstor Twin 10.1 entry
 -  Add info for the Trekstor Yourbook C11B
 -  Drop comma in terminator line
 -  add Vinga J116 touchscreen
 -  Add info for the ONDA V891 v5 tablet
 -  Add touchscreen info for techBite Arc 11.6.
 -  Add info for the MP-man MPWIN895CL tablet

usb:
 -  typec: mux: Convert the Intel PMC Mux driver to use new SCU IPC API

watchdog:
 -  iTCO: fix link error
 -  intel-mid_wdt: Convert to use new SCU IPC API

wmi:
 -  Describe function parameters
 -  Fix indentation in some cases
 -  Replace UUID redefinitions by their originals

x86/platform/intel-mid:
 -  Add empty stubs for intel_scu_devices_[create|destroy]()

----------------------------------------------------------------
Andrew Dunai (1):
      platform/x86: touchscreen_dmi: add Vinga J116 touchscreen

Andy Shevchenko (26):
      device property: export set_secondary_fwnode() to modules
      software node: Allow register and unregister software node groups
      platform/x86: intel_cht_int33fe: Convert software node array to group
      platform/x86: intel_cht_int33fe: Convert to use set_secondary_fwnode()
      platform/x86: intel_cht_int33fe: Switch to use acpi_dev_hid_uid_match()
      platform/x86: intel_cht_int33fe: Fix spelling issues
      Merge branch 'ib-pdx86-properties'
      platform/x86: wmi: Replace UUID redefinitions by their originals
      platform/x86: wmi: Fix indentation in some cases
      platform/x86: wmi: Describe function parameters
      Merge branch 'ib-mfd-x86-usb-watchdog-v5.7'
      platform/x86: touchscreen_dmi: Drop comma in terminator line
      platform/x86: asus-laptop: Drop duplicate check for led_classdev_unregister()
      platform/x86: asus-wmi: Drop duplicate check for led_classdev_unregister()
      platform/x86: eeepc-laptop: Drop duplicate check for led_classdev_unregister()
      platform/x86: lg-laptop: Drop duplicate check for led_classdev_unregister()
      platform/x86: samsung-laptop: Drop duplicate check for led_classdev_unregister()
      platform/x86: thinkpad_acpi: Drop duplicate check for led_classdev_unregister()
      platform/x86: toshiba_acpi: Drop duplicate check for led_classdev_unregister()
      platform/x86: thinkpad_acpi: Replace next_cmd(&buf) with strsep(&buf, ",")
      platform/x86: thinkpad_acpi: Use strndup_user() in dispatch_proc_write()
      platform/x86: thinkpad_acpi: Replace custom approach by kstrtoint()
      platform/x86: hp-wmi: Refactor postcode_store() to follow standard patterns
      platform/x86: hp-wmi: Convert simple_strtoul() to kstrtou32()
      platform/x86: hp-wmi: Introduce HPWMI_POWER_FW_OR_HW as convenient shortcut
      Merge branch 'for-next'

Archana Patni (1):
      platform/x86: intel_pmc_core: Change Jasper Lake S0ix debug reg map back to ICL

Arnd Bergmann (2):
      platform/x86: intel_pmc_core: avoid unused-function warnings
      watchdog: iTCO: fix link error

Bernhard Übelacker (1):
      platform/x86: touchscreen_dmi: Add info for the Trekstor Yourbook C11B

Chih-Wei Huang (1):
      platform/x86: acerhdf: replace space by * in modalias

Chris Chiu (1):
      platform/x86: asus_wmi: Reserve more space for struct bias_args

Colin Ian King (1):
      platform/x86: asus_wmi: remove redundant initialization of variable status

Hans de Goede (16):
      platform/x86: touchscreen_dmi: Add info for the MP-man MPWIN895CL tablet
      platform/x86: asus-nb-wmi: Do not load on Asus T100TA and T200TA
      platform/x86: intel-vbtn: Use acpi_evaluate_integer()
      platform/x86: intel-vbtn: Split keymap into buttons and switches parts
      platform/x86: intel-vbtn: Do not advertise switches to userspace if they are not there
      platform/x86: intel-vbtn: Also handle tablet-mode switch on "Detachable" and "Portable" chassis-types
      platform/x86: intel-vbtn: Fix probe failure on devices with only switches
      platform/x86: asus-nb-wmi: Revert "Do not load on Asus T100TA and T200TA"
      platform/x86: asus-wmi: Move asus_wmi_input_init and _exit lower in the file
      platform/x86: asus-wmi: Add support for SW_TABLET_MODE
      platform/x86: asus-wmi: Ignore WMI events with code 0x79
      platform/x86: intel-vbtn: Move detect_tablet_mode() to higher in the file
      platform/x86: intel-vbtn: Detect switch position before registering the input-device
      platform/x86: dell-wmi: Ignore keyboard attached / detached events
      platform/x86: touchscreen_dmi: Update Trekstor Twin 10.1 entry
      platform/x86: intel-vbtn: Only blacklist SW_TABLET_MODE on the 9 / "Laptop" chasis-type

Heikki Krogerus (1):
      usb: typec: mux: Convert the Intel PMC Mux driver to use new SCU IPC API

Jithu Joseph (1):
      platform/x86: Add Slim Bootloader firmware update signaling driver

Koba Ko (1):
      platform/x86: dell-laptop: don't register micmute LED if there is no token

Lars Hofhansl (1):
      platform/x86: thinkpad_acpi: Add support for dual fan control

Maksim Karasev (1):
      platform/x86: touchscreen_dmi: Add info for the ONDA V891 v5 tablet

Mattia Dongili (2):
      platform/x86: sony-laptop: SNC calls should handle BUFFER types
      platform/x86: sony-laptop: Make resuming thermal profile safer

Mika Westerberg (21):
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
      platform/x86: Add Elkhart Lake SCU/PMC support
      MAINTAINERS: Add me as maintainer of Intel SCU drivers

Nickolai Kozachenko (1):
      platform/x86: intel-hid: Add a quirk to support HP Spectre X2 (2015)

Prarit Bhargava (3):
      tools/power/x86/intel-speed-select: Fix CLX-N package information output
      intel-speed-select: Fix speed-select-base-freq-properties output on CLX-N
      tools/power/x86/intel-speed-select: Fix json perf-profile output output

Srinivas Pandruvada (7):
      tools/power/x86/intel-speed-select: Change debug to error
      tools/power/x86/intel-speed-select: Check support status before enable
      tools/power/x86/intel-speed-select: Enable clos for turbo-freq enable
      tools/power/x86/intel-speed-select: Update version
      tools/power/x86/intel-speed-select: Increase CPU count
      tools/power/x86/intel-speed-select: Fix invalid core mask
      platform/x86: ISST: Increase timeout

Stuart Hayes (1):
      platform/x86: dcdbas: Check SMBIOS for protected buffer address

Wiktor Ciurej (1):
      platform/x86: touchscreen_dmi: Add touchscreen info for techBite Arc 11.6.

Xiongfeng Wang (1):
      platform/x86: thinkpad_acpi: Remove always false 'value < 0' statement

 .../ABI/obsolete/sysfs-driver-intel_pmc_bxt        |  22 +
 .../testing/sysfs-platform-intel-wmi-sbl-fw-update |  12 +
 MAINTAINERS                                        |  36 +-
 arch/x86/Kconfig                                   |   2 +-
 arch/x86/include/asm/intel-mid.h                   |   9 +-
 arch/x86/include/asm/intel_pmc_ipc.h               |  59 --
 arch/x86/include/asm/intel_scu_ipc.h               | 114 +--
 arch/x86/include/asm/intel_scu_ipc_legacy.h        |  91 ++
 arch/x86/include/asm/intel_telemetry.h             |   6 +-
 drivers/base/core.c                                |   1 +
 drivers/base/swnode.c                              |  48 ++
 drivers/mfd/Kconfig                                |  20 +-
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/intel_pmc_bxt.c                        | 468 ++++++++++
 drivers/mfd/intel_soc_pmic_bxtwc.c                 |  34 +-
 drivers/mfd/intel_soc_pmic_mrfld.c                 |  10 +-
 drivers/platform/x86/Kconfig                       |  65 +-
 drivers/platform/x86/Makefile                      |   4 +-
 drivers/platform/x86/acerhdf.c                     |   2 +-
 drivers/platform/x86/asus-laptop.c                 |  25 +-
 drivers/platform/x86/asus-nb-wmi.c                 |   1 +
 drivers/platform/x86/asus-wmi.c                    | 117 +--
 drivers/platform/x86/dcdbas.c                      |  43 +-
 drivers/platform/x86/dell-laptop.c                 |  11 +-
 drivers/platform/x86/dell-wmi.c                    |  10 +
 drivers/platform/x86/eeepc-laptop.c                |   4 +-
 drivers/platform/x86/hp-wmi.c                      |  30 +-
 drivers/platform/x86/intel-hid.c                   |   7 +
 drivers/platform/x86/intel-uncore-frequency.c      |   2 +-
 drivers/platform/x86/intel-vbtn.c                  | 104 ++-
 drivers/platform/x86/intel-wmi-sbl-fw-update.c     | 145 ++++
 drivers/platform/x86/intel_cht_int33fe_typec.c     | 106 +--
 drivers/platform/x86/intel_mid_powerbtn.c          |  15 +-
 drivers/platform/x86/intel_pmc_core.c              |  24 +-
 drivers/platform/x86/intel_pmc_core.h              |   2 -
 drivers/platform/x86/intel_pmc_ipc.c               | 949 ---------------------
 drivers/platform/x86/intel_scu_ipc.c               | 447 +++++++---
 drivers/platform/x86/intel_scu_ipcutil.c           |  43 +-
 drivers/platform/x86/intel_scu_pcidrv.c            |  68 ++
 drivers/platform/x86/intel_scu_pltdrv.c            |  60 ++
 .../x86/intel_speed_select_if/isst_if_mbox_pci.c   |  11 +-
 drivers/platform/x86/intel_telemetry_core.c        |  17 +-
 drivers/platform/x86/intel_telemetry_debugfs.c     |  15 +-
 drivers/platform/x86/intel_telemetry_pltdrv.c      |  97 ++-
 drivers/platform/x86/lg-laptop.c                   |  18 +-
 drivers/platform/x86/samsung-laptop.c              |   3 +-
 drivers/platform/x86/sony-laptop.c                 |  60 +-
 drivers/platform/x86/surface3_power.c              |   4 +-
 drivers/platform/x86/thinkpad_acpi.c               | 175 ++--
 drivers/platform/x86/toshiba_acpi.c                |  26 +-
 drivers/platform/x86/touchscreen_dmi.c             | 113 ++-
 drivers/platform/x86/wmi.c                         |  45 +-
 drivers/platform/x86/xiaomi-wmi.c                  |   4 +-
 drivers/usb/typec/mux/Kconfig                      |   2 +-
 drivers/usb/typec/mux/intel_pmc_mux.c              |  12 +-
 drivers/usb/typec/tcpm/Kconfig                     |   2 +-
 drivers/watchdog/Kconfig                           |   1 +
 drivers/watchdog/iTCO_wdt.c                        |  25 +-
 drivers/watchdog/intel-mid_wdt.c                   |  53 +-
 include/linux/mfd/intel_pmc_bxt.h                  |  53 ++
 include/linux/mfd/intel_soc_pmic.h                 |  15 +
 include/linux/platform_data/itco_wdt.h             |  11 +-
 include/linux/platform_data/x86/asus-wmi.h         |   3 +
 include/linux/property.h                           |   3 +
 tools/power/x86/intel-speed-select/isst-config.c   |  49 +-
 tools/power/x86/intel-speed-select/isst-core.c     |   6 +-
 tools/power/x86/intel-speed-select/isst-display.c  |  28 +-
 tools/power/x86/intel-speed-select/isst.h          |   1 +
 68 files changed, 2338 insertions(+), 1731 deletions(-)
 create mode 100644 Documentation/ABI/obsolete/sysfs-driver-intel_pmc_bxt
 create mode 100644 Documentation/ABI/testing/sysfs-platform-intel-wmi-sbl-fw-update
 delete mode 100644 arch/x86/include/asm/intel_pmc_ipc.h
 create mode 100644 arch/x86/include/asm/intel_scu_ipc_legacy.h
 create mode 100644 drivers/mfd/intel_pmc_bxt.c
 create mode 100644 drivers/platform/x86/intel-wmi-sbl-fw-update.c
 delete mode 100644 drivers/platform/x86/intel_pmc_ipc.c
 create mode 100644 drivers/platform/x86/intel_scu_pcidrv.c
 create mode 100644 drivers/platform/x86/intel_scu_pltdrv.c
 create mode 100644 include/linux/mfd/intel_pmc_bxt.h

-- 
With Best Regards,
Andy Shevchenko


