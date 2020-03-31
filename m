Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89416C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 12:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 514EF208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 12:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730817AbgCaMmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 08:42:55 -0400
Received: from mga04.intel.com ([192.55.52.120]:34998 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730753AbgCaMmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 08:42:54 -0400
IronPort-SDR: 2JMldSsAI43rmTFe29Eo3YN5twOFEBrcLW0IkiR7Ln7wUEg83kHQUTZvBU8GYY77IW+TqOHhL8
 DpUKfS2WojyQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2020 05:21:37 -0700
IronPort-SDR: DGnBY/dtYEQBb46KreKw8hFpbZXxR9nEnLjj3WvSX+jy9oUlabqYjhshiQ6PvxjxQXqAGqiW3H
 bii0dsTOo5hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,327,1580803200"; 
   d="scan'208";a="240107704"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007.fm.intel.com with ESMTP; 31 Mar 2020 05:21:35 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jJFtj-00EUTF-8x; Tue, 31 Mar 2020 15:21:39 +0300
Date:   Tue, 31 Mar 2020 15:21:39 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: [GIT PULL] platform-drivers-x86 for 5.7-1
Message-ID: <20200331122139.GA3453702@smile.fi.intel.com>
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

Few updates for PDx86 here. The merge will conflict with some updates from the
tip and driver trees. One is in Kconfig (one line has been added in driver
tree) and one in intel_pmc_core.c (tip tree introduced new macros to match x86
CPUs). For your convenience I pushed an example of resolution in the branch
test-pr-5.7-1.

Thanks,

With Best Regards,
Andy Shevchenko

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v5.7-1

for you to fetch changes up to d878bdfba8ffda64265c921cf7497934a607f83a:

  platform/x86: surface3_power: Fix always true condition in mshw0011_space_handler() (2020-03-30 13:26:50 +0300)

----------------------------------------------------------------
platform-drivers-x86 for v5.7-1

* Fix for improper handling of fan_boost_mode in sysfs for ASUS laptops.
* On newer ASUS laptops the 1st battery is named differently, here is a fix.
* Fix Lex 2I385SW to allow both network cards to be used.
* The power integrated circuit driver for Surface 3 has been added.
* Refactor and clean up of Intel PMC driver and enable it on Intel Jasper Lake.
* Clean up of Dell RBU driver.
* Big update for Intel Speed Select technology support tool and driver.

The following is an automated git shortlog grouped by driver:

asus-wmi:
 -  Support laptops where the first battery is named BATT
 -  Fix return value of fan_boost_mode_store

dell_rbu:
 -  Unify format of the printed messages
 -  Use max_t() to get rid of casting
 -  Simplify cleanup code in create_packet()
 -  don't open code list_for_each_entry*()
 -  Use sysfs_create_group() API

GPD pocket fan:
 -  Fix error message when temp-limits are out of range

i2c-multi-instantiate:
 -  Replace zero-length array with flexible-array member

intel-hid:
 -  Move MODULE_DEVICE_TABLE() closer to the table

intel_pmc_core:
 -  Make pmc_core_substate_res_show() generic
 -  Make pmc_core_lpm_display() generic for platforms that support sub-states
 -  Add slp_s0_offset attribute back to tgl_reg_map
 -  Remove duplicate 'if' to create debugfs entry
 -  Relocate pmc_core_*_display() to outside of CONFIG_DEBUG_FS
 -  Add debugfs support to access live status registers
 -  Dump low power status registers on an S0ix.y failure
 -  Add an additional parameter to pmc_core_lpm_display()
 -  Remove slp_s0 attributes from tgl_reg_map
 -  Refactor the driver by removing redundant code
 -  Add debugfs entry for low power mode status registers
 -  Add debugfs entry to access sub-state residencies
 -  Add Atom based Jasper Lake (JSL) platform support

intel-vbtn:
 -  Move MODULE_DEVICE_TABLE() closer to the table

ISST:
 -  Fix wrong unregister type

PDx86:
 -  Kconfig: Fix a typo
 -  Kconfig: Group modules by companies and functions
 -  MAINTAINERS: Sort entries in database for PDx86
 -  Makefile: Group modules by companies and functions

platform/x86/intel-uncore-freq:
 -  Add release callback
 -  Fix static checker issue and potential race condition

pmc_atom:
 -  Add Lex 2I385SW to critclk_systems DMI table

sony-laptop:
 -  Use scnprintf() for avoiding potential buffer overflow

surface3_power:
 -  Fix always true condition in mshw0011_space_handler()
 -  Fix Kconfig section ordering
 -  Add missed headers
 -  Reformat GUID assignment
 -  Drop useless macro ACPI_PTR()
 -  Prefix POLL_INTERVAL with SURFACE_3
 -  Simplify mshw0011_adp_psr() to one liner
 -  Use dev_err() instead of pr_err()
 -  Drop unused structure definition
 -  MSHW0011 rev-eng implementation

tools/power/x86/intel-speed-select:
 -  Fix a typo in error message
 -  Update version
 -  Avoid duplicate Package strings for json
 -  Add display for enabled cpus count
 -  Print friendly warning for bad command line
 -  Fix avx options for turbo-freq feature
 -  Improve CLX commands
 -  Show error for invalid CPUs in the options
 -  Improve core-power result and error display
 -  Kernel interface error handling
 -  Improve error display for turbo-freq feature
 -  Improve error display for base-freq feature
 -  Improve output of perf-profile commands
 -  Enhance help for core-power assoc
 -  Display error for invalid priority type
 -  Check feature status first
 -  Improve error display for perf-profile feature
 -  Add an API for error/information print
 -  Enhance --info option
 -  Enhance help
 -  Helpful warning for missing kernel interface
 -  Store topology information
 -  Max CPU count calculation when CPU0 is offline
 -  Special handling for CPU 0 online/offline
 -  Use more verbiage for clos information
 -  Enhance core-power info command
 -  Make target CPU optional for core-power info
 -  Warn for invalid package id
 -  Fix last cpu number
 -  Fix mailbox usage for CLOS_PM_QOS_CONFIG
 -  Avoid duplicate names for json parsing
 -  Fix display for turbo-freq auto mode

----------------------------------------------------------------
Andy Shevchenko (19):
      MAINTAINERS: Sort entries in database for PDx86
      platform/x86: intel-hid: Move MODULE_DEVICE_TABLE() closer to the table
      platform/x86: intel-vbtn: Move MODULE_DEVICE_TABLE() closer to the table
      platform/x86: Makefile: Group modules by companies and functions
      platform/x86: Kconfig: Group modules by companies and functions
      platform/x86: dell_rbu: Use sysfs_create_group() API
      platform/x86: dell_rbu: don't open code list_for_each_entry*()
      platform/x86: dell_rbu: Simplify cleanup code in create_packet()
      platform/x86: dell_rbu: Use max_t() to get rid of casting
      platform/x86: dell_rbu: Unify format of the printed messages
      platform/x86: surface3_power: Drop unused structure definition
      platform/x86: surface3_power: Use dev_err() instead of pr_err()
      platform/x86: surface3_power: Simplify mshw0011_adp_psr() to one liner
      platform/x86: surface3_power: Prefix POLL_INTERVAL with SURFACE_3
      platform/x86: surface3_power: Drop useless macro ACPI_PTR()
      platform/x86: surface3_power: Reformat GUID assignment
      platform/x86: surface3_power: Add missed headers
      platform/x86: surface3_power: Fix Kconfig section ordering
      platform/x86: surface3_power: Fix always true condition in mshw0011_space_handler()

Blaž Hrastnik (1):
      platform/x86: surface3_power: MSHW0011 rev-eng implementation

Christophe JAILLET (1):
      platform/x86: Kconfig: Fix a typo

Gayatri Kammela (13):
      platform/x86: intel_pmc_core: Add Atom based Jasper Lake (JSL) platform support
      platform/x86: intel_pmc_core: Add debugfs entry to access sub-state residencies
      platform/x86: intel_pmc_core: Add debugfs entry for low power mode status registers
      platform/x86: intel_pmc_core: Refactor the driver by removing redundant code
      platform/x86: intel_pmc_core: Remove slp_s0 attributes from tgl_reg_map
      platform/x86: intel_pmc_core: Add an additional parameter to pmc_core_lpm_display()
      platform/x86: intel_pmc_core: Dump low power status registers on an S0ix.y failure
      platform/x86: intel_pmc_core: Add debugfs support to access live status registers
      platform/x86: intel_pmc_core: Relocate pmc_core_*_display() to outside of CONFIG_DEBUG_FS
      platform/x86: intel_pmc_core: Remove duplicate 'if' to create debugfs entry
      platform/x86: intel_pmc_core: Add slp_s0_offset attribute back to tgl_reg_map
      platform/x86: intel_pmc_core: Make pmc_core_lpm_display() generic for platforms that support sub-states
      platform/x86: intel_pmc_core: Make pmc_core_substate_res_show() generic

Georg Müller (1):
      platform/x86: pmc_atom: Add Lex 2I385SW to critclk_systems DMI table

Gustavo A. R. Silva (1):
      platform/x86: i2c-multi-instantiate: Replace zero-length array with flexible-array member

Hans de Goede (1):
      platform/x86: GPD pocket fan: Fix error message when temp-limits are out of range

Kristian Klausen (1):
      platform/x86: asus-wmi: Support laptops where the first battery is named BATT

Leonid Maksymchuk (1):
      platform/x86: asus_wmi: Fix return value of fan_boost_mode_store

Masanari Iida (1):
      tools/power/x86/intel-speed-select: Fix a typo in error message

Srinivas Pandruvada (34):
      tools/power/x86/intel-speed-select: Fix display for turbo-freq auto mode
      tools/power/x86/intel-speed-select: Avoid duplicate names for json parsing
      platform/x86/intel-uncore-freq: Fix static checker issue and potential race condition
      platform/x86/intel-uncore-freq: Add release callback
      platform/x86: ISST: Fix wrong unregister type
      tools/power/x86/intel-speed-select: Fix mailbox usage for CLOS_PM_QOS_CONFIG
      tools/power/x86/intel-speed-select: Fix last cpu number
      tools/power/x86/intel-speed-select: Warn for invalid package id
      tools/power/x86/intel-speed-select: Make target CPU optional for core-power info
      tools/power/x86/intel-speed-select: Enhance core-power info command
      tools/power/x86/intel-speed-select: Use more verbiage for clos information
      tools/power/x86/intel-speed-select: Special handling for CPU 0 online/offline
      tools/power/x86/intel-speed-select: Max CPU count calculation when CPU0 is offline
      tools/power/x86/intel-speed-select: Store topology information
      tools/power/x86/intel-speed-select: Helpful warning for missing kernel interface
      tools/power/x86/intel-speed-select: Enhance help
      tools/power/x86/intel-speed-select: Enhance --info option
      tools/power/x86/intel-speed-select: Add an API for error/information print
      tools/power/x86/intel-speed-select: Improve error display for perf-profile feature
      tools/power/x86/intel-speed-select: Check feature status first
      tools/power/x86/intel-speed-select: Display error for invalid priority type
      tools/power/x86/intel-speed-select: Enhance help for core-power assoc
      tools/power/x86/intel-speed-select: Improve output of perf-profile commands
      tools/power/x86/intel-speed-select: Improve error display for base-freq feature
      tools/power/x86/intel-speed-select: Improve error display for turbo-freq feature
      tools/power/x86/intel-speed-select: Kernel interface error handling
      tools/power/x86/intel-speed-select: Improve core-power result and error display
      tools/power/x86/intel-speed-select: Show error for invalid CPUs in the options
      tools/power/x86/intel-speed-select: Improve CLX commands
      tools/power/x86/intel-speed-select: Fix avx options for turbo-freq feature
      tools/power/x86/intel-speed-select: Print friendly warning for bad command line
      tools/power/x86/intel-speed-select: Add display for enabled cpus count
      tools/power/x86/intel-speed-select: Avoid duplicate Package strings for json
      tools/power/x86/intel-speed-select: Update version

Takashi Iwai (1):
      platform/x86: sony-laptop: Use scnprintf() for avoiding potential buffer overflow

 MAINTAINERS                                        |   82 +-
 drivers/platform/x86/Kconfig                       | 1323 ++++++++++----------
 drivers/platform/x86/Makefile                      |  198 +--
 drivers/platform/x86/asus-wmi.c                    |    7 +-
 drivers/platform/x86/dell_rbu.c                    |  173 +--
 drivers/platform/x86/gpd-pocket-fan.c              |    2 +-
 drivers/platform/x86/i2c-multi-instantiate.c       |    2 +-
 drivers/platform/x86/intel-hid.c                   |    2 +-
 drivers/platform/x86/intel-uncore-frequency.c      |   51 +-
 drivers/platform/x86/intel-vbtn.c                  |    2 +-
 drivers/platform/x86/intel_pmc_core.c              |  343 ++++-
 drivers/platform/x86/intel_pmc_core.h              |   29 +
 .../x86/intel_speed_select_if/isst_if_mmio.c       |    2 +-
 drivers/platform/x86/pmc_atom.c                    |    8 +
 drivers/platform/x86/sony-laptop.c                 |    8 +-
 drivers/platform/x86/surface3_power.c              |  589 +++++++++
 tools/power/x86/intel-speed-select/isst-config.c   |  583 +++++++--
 tools/power/x86/intel-speed-select/isst-core.c     |  117 +-
 tools/power/x86/intel-speed-select/isst-display.c  |  278 ++--
 tools/power/x86/intel-speed-select/isst.h          |   12 +-
 20 files changed, 2626 insertions(+), 1185 deletions(-)
 create mode 100644 drivers/platform/x86/surface3_power.c

-- 
With Best Regards,
Andy Shevchenko


