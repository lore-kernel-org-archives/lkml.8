Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F215C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 10:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3983E2187F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 10:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbgAOK5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 05:57:21 -0500
Received: from mga18.intel.com ([134.134.136.126]:53142 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgAOK5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 05:57:20 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2020 02:57:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,322,1574150400"; 
   d="scan'208";a="397850802"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005.jf.intel.com with ESMTP; 15 Jan 2020 02:57:18 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1irgMS-0003m3-53; Wed, 15 Jan 2020 12:57:20 +0200
Date:   Wed, 15 Jan 2020 12:57:20 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: [GIT PULL] platform-drivers-x86 for 5.5-3
Message-ID: <20200115105720.GA14489@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

After holiday collection of the fixes for PDx86. No conflict or build bot
warnings being observed so far.

Thanks,

With Best Regards,
Andy Shevchenko

The following changes since commit 46cf053efec6a3a5f343fead837777efe8252a46:

  Linux 5.5-rc3 (2019-12-22 17:02:23 -0800)

are available in the Git repository at:

  git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v5.5-3

for you to fetch changes up to f3efc406d67e6236b513c4302133b0c9be74fd99:

  Documentation/ABI: Add missed attribute for mlxreg-io sysfs interfaces (2020-01-13 21:04:33 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v5.5-3

* Fix keyboard brightness control for ASUS laptops
* Better handling parameters of GPD pocket fan module to avoid thermal shock
* Add IDs to PMC platform driver to support Intel Comet Lake
* Fix potential dead lock in Mellanox TM FIFO driver and ABI documentation

The following is an automated git shortlog grouped by driver:

asus-wmi:
 -  Fix keyboard brightness cannot be set to 0

Documentation/ABI:
 -  Add missed attribute for mlxreg-io sysfs interfaces
 -  Fix documentation inconsistency for mlxreg-io sysfs interfaces

GPD pocket fan:
 -  Allow somewhat lower/higher temperature limits
 -  Use default values when wrong modparams are given

intel-ips:
 -  Use the correct style for SPDX License Identifier

intel_pmc_core:
 -  update Comet Lake platform driver

platform/mellanox:
 -  fix potential deadlock in the tmfifo driver

----------------------------------------------------------------
Hans de Goede (2):
      platform/x86: GPD pocket fan: Use default values when wrong modparams are given
      platform/x86: GPD pocket fan: Allow somewhat lower/higher temperature limits

Harry Pan (1):
      platform/x86: intel_pmc_core: update Comet Lake platform driver

Jian-Hong Pan (1):
      platform/x86: asus-wmi: Fix keyboard brightness cannot be set to 0

Liming Sun (1):
      platform/mellanox: fix potential deadlock in the tmfifo driver

Nishad Kamdar (1):
      platform/x86: intel-ips: Use the correct style for SPDX License Identifier

Vadim Pasternak (2):
      Documentation/ABI: Fix documentation inconsistency for mlxreg-io sysfs interfaces
      Documentation/ABI: Add missed attribute for mlxreg-io sysfs interfaces

 Documentation/ABI/stable/sysfs-driver-mlxreg-io | 13 ++++++++++--
 drivers/platform/mellanox/mlxbf-tmfifo.c        | 19 ++++++++---------
 drivers/platform/x86/asus-wmi.c                 |  8 +-------
 drivers/platform/x86/gpd-pocket-fan.c           | 27 ++++++++++++++++++-------
 drivers/platform/x86/intel_ips.h                |  2 +-
 drivers/platform/x86/intel_pmc_core.h           |  2 +-
 drivers/platform/x86/intel_pmc_core_pltdrv.c    |  2 ++
 7 files changed, 46 insertions(+), 27 deletions(-)

-- 
With Best Regards,
Andy Shevchenko


