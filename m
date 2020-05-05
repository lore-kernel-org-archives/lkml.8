Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D2AC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 17:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05DBF206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 17:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730046AbgEERVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 13:21:04 -0400
Received: from mga09.intel.com ([134.134.136.24]:23276 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbgEERVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 13:21:03 -0400
IronPort-SDR: IRQnpuZEfUA3rjgwVg5aBGRigYE1vAYIOkhIEA+BHKwVVoxqeCdAnE0DGPCDrlaNYs5DVPHnrw
 Xy+6hVsNrdNg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 10:21:02 -0700
IronPort-SDR: ul/Oo439OtJ4NN+4MpxUhZNWjqEBFThB4oPUGwXn0xqMusDJxtOZPLAhTOcY5nrWTwyDhhzIBR
 ti2Jarj72tVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,356,1583222400"; 
   d="scan'208";a="295043860"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002.fm.intel.com with ESMTP; 05 May 2020 10:21:01 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jW1Fg-004r42-PX; Tue, 05 May 2020 20:21:04 +0300
Date:   Tue, 5 May 2020 20:21:04 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: [GIT PULL] platform-drivers-x86 for 5.7-2
Message-ID: <20200505172104.GA1157275@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Collected fixes for PDx96 so far.

Thanks,

With Best Regards,
Andy Shevchenko

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v5.7-2

for you to fetch changes up to f8a31eca47bec197f5ec5dc40ad675450c2058a5:

  platform/x86: thinkpad_acpi: Remove always false 'value < 0' statement (2020-05-05 15:33:24 +0300)

----------------------------------------------------------------
platform-drivers-x86 for v5.7-2

* Avoid loading asus-nb-wmi module on selected laptop models
* Fix S0ix debug support for Jasper Lake PMC
* Few fixes which have been reported by Hulk bot and others

The following is an automated git shortlog grouped by driver:

asus-nb-wmi:
 -  Do not load on Asus T100TA and T200TA

intel_pmc_core:
 -  avoid unused-function warnings
 -  Change Jasper Lake S0ix debug reg map back to ICL

platform/x86/intel-uncore-freq:
 -  make uncore_root_kobj static

surface3_power:
 -  Fix a NULL vs IS_ERR() check in probe

thinkpad_acpi:
 -  Remove always false 'value < 0' statement

wmi:
 -  Make two functions static

----------------------------------------------------------------
Archana Patni (1):
      platform/x86: intel_pmc_core: Change Jasper Lake S0ix debug reg map back to ICL

Arnd Bergmann (1):
      platform/x86: intel_pmc_core: avoid unused-function warnings

Dan Carpenter (1):
      platform/x86: surface3_power: Fix a NULL vs IS_ERR() check in probe

Hans de Goede (1):
      platform/x86: asus-nb-wmi: Do not load on Asus T100TA and T200TA

Jason Yan (1):
      platform/x86/intel-uncore-freq: make uncore_root_kobj static

Xiongfeng Wang (1):
      platform/x86: thinkpad_acpi: Remove always false 'value < 0' statement

YueHaibing (1):
      platform/x86: wmi: Make two functions static

 drivers/platform/x86/asus-nb-wmi.c            | 24 ++++++++++++++++++++++++
 drivers/platform/x86/intel-uncore-frequency.c |  2 +-
 drivers/platform/x86/intel_pmc_core.c         | 24 +++++-------------------
 drivers/platform/x86/intel_pmc_core.h         |  2 --
 drivers/platform/x86/surface3_power.c         |  4 ++--
 drivers/platform/x86/thinkpad_acpi.c          |  2 +-
 drivers/platform/x86/xiaomi-wmi.c             |  4 ++--
 7 files changed, 35 insertions(+), 27 deletions(-)

-- 
With Best Regards,
Andy Shevchenko


