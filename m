Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6D5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 11:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F063220738
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 11:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgHCLd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 07:33:57 -0400
Received: from mga05.intel.com ([192.55.52.43]:17491 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbgHCLdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 07:33:55 -0400
IronPort-SDR: CyzIfQpiDxCryoZzUlHqx8/LfBuVQJAvf1NqCF9B1NR+hTQgqAUwbZxzC6zlaX7iOUju59ucru
 7/n7GnVR4l/A==
X-IronPort-AV: E=McAfee;i="6000,8403,9701"; a="236949261"
X-IronPort-AV: E=Sophos;i="5.75,430,1589266800"; 
   d="scan'208";a="236949261"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2020 04:33:53 -0700
IronPort-SDR: E2xg3pSjVs+HkCh+VrRCf8P6oK3BCoStEag5YEu0o9AvL7QRvWR6JPfK/KZmshIg8ohegIPPBx
 ru/Y4nDFXkZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800"; 
   d="scan'208";a="324020905"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002.fm.intel.com with ESMTP; 03 Aug 2020 04:33:52 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k2Yj2-005vnM-6m; Mon, 03 Aug 2020 14:33:52 +0300
Date:   Mon, 3 Aug 2020 14:33:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: [GIT PULL] platform-drivers-x86 for 5.9-1
Message-ID: <20200803113352.GA1413788@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Rather calm cycle for PDx86 and here is PR for v5.9. No conflicts were found
so far. It was in the Linux next for a while and no bot complains.

Thanks,

With Best Regards,
Andy Shevchenko

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v5.9-1

for you to fetch changes up to 67186653c90360922e3965d0376a61dbf6c42711:

  platform/x86: asus-nb-wmi: Drop duplicate DMI quirk structures (2020-08-02 14:07:04 +0300)

----------------------------------------------------------------
platform-drivers-x86 for v5.9-1

* ASUS WMI driver honors BAT1 name of the battery
  (quite a few new laptops are using it)
* Dell WMI driver supports new key codes and backlight events
* ThinkPad ACPI driver now may use standard charge threshold interface,
  it also has been updated to provide Laptop or Desktop mode to the user
* Intel Speed Select Technology gained support on Sapphire Rapids platform
* Regular update of Speed Select Technology tools
* Mellanox has been updated to support complex attributes
* PMC core driver has been fixed to show correct names for LPM0 register
* HTTP links were replaced by HTTPS ones where it applies
* Miscellaneous fixes and cleanups here and there

The following is an automated git shortlog grouped by driver:

acerhdf:
 -  Replace HTTP links with HTTPS ones

Add new intel_atomisp2_led driver:
 - Add new intel_atomisp2_led driver

apple-gmux:
 -  Replace HTTP links with HTTPS ones

asus-nb-wmi:
 -  Drop duplicate DMI quirk structures
 -  add support for ASUS ROG Zephyrus G14 and G15

asus-wmi:
 -  allow BAT1 battery name

dell-wmi:
 -  add new dmi mapping for keycode 0xffff
 -  add new keymap type 0x0012
 -  add new backlight events

intel_cht_int33fe:
 -  Drop double check for ACPI companion device

intel-hid:
 -  Fix return value check in check_acpi_dev()

intel_pmc_core:
 -  fix bound check in pmc_core_mphy_pg_show()
 -  update TGL's LPM0 reg bit map name

intel-vbtn:
 -  Fix return value check in check_acpi_dev()

ISST:
 -  drop a duplicated word in isst_if.h
 -  Add new PCI device ids

pcengines-apuv2:
 -  revert wiring up simswitch GPIO as LED

platform/mellanox:
 -  Introduce string_upper() and string_lower() helpers
 -  Add string_upper() and string_lower() tests
 -  Extend FAN platform data description
 -  Add more definitions for system attributes
 -  Add new attribute for mlxreg-io sysfs interfaces
 -  Add presence register field for FAN devices
 -  Add support for complex attributes
 -  mlxreg-io: Add support for complex attributes
 -  mlxreg-hotplug: Add environmental data to uevent
 -  mlxreg-hotplug: Use capability register for attribute creation
 -  mlxreg-hotplug: Modify module license

system76-acpi:
 -  Fix brightness_set schedule while atomic

thinkpad_acpi:
 -  Make some symbols static
 -  add documentation for battery charge control
 -  use standard charge control attribute names
 -  remove unused defines
 -  Replace HTTP links with HTTPS ones
 -  not loading brightness_init when _BCL invalid
 -  lap or desk mode interface
 -  Revert "Use strndup_user() in dispatch_proc_write()"

tools/power/x86/intel-speed-select:
 -  Update version for v5.9
 -  Add retries for mail box commands
 -  Add option to delay mbox commands
 -  Ignore -o option processing on error
 -  Change path for caching topology info

----------------------------------------------------------------
Aaron Ma (1):
      platform/x86: thinkpad_acpi: not loading brightness_init when _BCL invalid

Alexander A. Klimov (3):
      platform/x86: thinkpad_acpi: Replace HTTP links with HTTPS ones
      platform/x86: apple-gmux: Replace HTTP links with HTTPS ones
      platform/x86: acerhdf: Replace HTTP links with HTTPS ones

Andy Shevchenko (4):
      platform/x86: intel_cht_int33fe: Drop double check for ACPI companion device
      platform/x86: thinkpad_acpi: Revert "Use strndup_user() in dispatch_proc_write()"
      Merge branch 'for-next'
      platform/x86: asus-nb-wmi: Drop duplicate DMI quirk structures

Armas Spann (1):
      platform/x86: asus-nb-wmi: add support for ASUS ROG Zephyrus G14 and G15

Barnabás Pőcze (1):
      platform/x86: thinkpad_acpi: add documentation for battery charge control

Florian Eckert (1):
      platform/x86: pcengines-apuv2: revert wiring up simswitch GPIO as LED

Gaurav Singh (1):
      platform/x86: intel_pmc_core: fix bound check in pmc_core_mphy_pg_show()

Hans de Goede (1):
      platform/x86: Add new intel_atomisp2_led driver

Lu Wei (2):
      platform/x86: intel-hid: Fix return value check in check_acpi_dev()
      platform/x86: intel-vbtn: Fix return value check in check_acpi_dev()

Mark Pearson (1):
      platform/x86: thinkpad_acpi: lap or desk mode interface

Nick Shipp (1):
      platform/x86: system76-acpi: Fix brightness_set schedule while atomic

Randy Dunlap (1):
      platform/x86: ISST: drop a duplicated word in isst_if.h

Sathyanarayana Nujella (1):
      platform/x86: intel_pmc_core: update TGL's LPM0 reg bit map name

Srinivas Pandruvada (6):
      platform/x86: ISST: Add new PCI device ids
      tools/power/x86/intel-speed-select: Change path for caching topology info
      tools/power/x86/intel-speed-select: Ignore -o option processing on error
      tools/power/x86/intel-speed-select: Add option to delay mbox commands
      tools/power/x86/intel-speed-select: Add retries for mail box commands
      tools/power/x86/intel-speed-select: Update version for v5.9

Thomas Weißschuh (2):
      platform/x86: thinkpad_acpi: remove unused defines
      platform/x86: thinkpad_acpi: use standard charge control attribute names

Vadim Pasternak (11):
      lib/string_helpers: Introduce string_upper() and string_lower() helpers
      lib/test-string_helpers.c: Add string_upper() and string_lower() tests
      platform/mellanox: mlxreg-hotplug: Modify module license
      platform/mellanox: mlxreg-hotplug: Use capability register for attribute creation
      platform/mellanox: mlxreg-hotplug: Add environmental data to uevent
      platform_data/mlxreg: Add support for complex attributes
      platform/x86: mlx-platform: Add more definitions for system attributes
      platform/mellanox: mlxreg-io: Add support for complex attributes
      Documentation/ABI: Add new attribute for mlxreg-io sysfs interfaces
      platform_data/mlxreg: Add presence register field for FAN devices
      platform/x86: mlx-platform: Extend FAN platform data description

Vasiliy Kupriakov (1):
      platform/x86: asus-wmi: allow BAT1 battery name

Wei Yongjun (1):
      platform/x86: thinkpad_acpi: Make some symbols static

Y Paritcher (3):
      platform/x86: dell-wmi: add new backlight events
      platform/x86: dell-wmi: add new keymap type 0x0012
      platform/x86: dell-wmi: add new dmi mapping for keycode 0xffff

 Documentation/ABI/stable/sysfs-driver-mlxreg-io    |  17 ++
 .../admin-guide/laptops/thinkpad-acpi.rst          |  32 ++++
 MAINTAINERS                                        |   6 +
 drivers/platform/mellanox/mlxreg-hotplug.c         | 114 ++++++++------
 drivers/platform/mellanox/mlxreg-io.c              |  45 ++++--
 drivers/platform/x86/Kconfig                       |  23 ++-
 drivers/platform/x86/Makefile                      |   1 +
 drivers/platform/x86/acerhdf.c                     |   2 +-
 drivers/platform/x86/apple-gmux.c                  |  16 +-
 drivers/platform/x86/asus-nb-wmi.c                 |  77 ++++++++++
 drivers/platform/x86/asus-wmi.c                    |   1 +
 drivers/platform/x86/dell-wmi.c                    |  28 +++-
 drivers/platform/x86/intel-hid.c                   |   2 +-
 drivers/platform/x86/intel-vbtn.c                  |   2 +-
 drivers/platform/x86/intel_atomisp2_led.c          | 116 ++++++++++++++
 drivers/platform/x86/intel_cht_int33fe_common.c    |  14 +-
 drivers/platform/x86/intel_pmc_core.c              |   4 +-
 .../x86/intel_speed_select_if/isst_if_common.h     |   3 +
 .../x86/intel_speed_select_if/isst_if_mbox_pci.c   |   1 +
 .../x86/intel_speed_select_if/isst_if_mmio.c       |   1 +
 drivers/platform/x86/mlx-platform.c                | 141 +++++++++++++++++
 drivers/platform/x86/pcengines-apuv2.c             |   3 -
 drivers/platform/x86/system76_acpi.c               |  12 +-
 drivers/platform/x86/thinkpad_acpi.c               | 171 ++++++++++++++++++---
 include/linux/platform_data/mlxreg.h               |   4 +
 include/linux/string_helpers.h                     |  15 ++
 include/uapi/linux/isst_if.h                       |   2 +-
 lib/test-string_helpers.c                          |  67 ++++++++
 tools/power/x86/intel-speed-select/isst-config.c   |  81 +++++++---
 29 files changed, 863 insertions(+), 138 deletions(-)
 create mode 100644 drivers/platform/x86/intel_atomisp2_led.c

-- 
With Best Regards,
Andy Shevchenko


