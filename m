Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E5BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6434F2064C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730941AbgGOJ6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 05:58:48 -0400
Received: from mga11.intel.com ([192.55.52.93]:3722 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728043AbgGOJ6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 05:58:47 -0400
IronPort-SDR: Ccg8o/TKYuRPlxu59lO07VnZAyh+ZVdR1vaeWk1B2zcUIMouYASEbL8SpVi7u1mTLbh3mWXTTr
 NGOfPIDyu32w==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="147121823"
X-IronPort-AV: E=Sophos;i="5.75,354,1589266800"; 
   d="scan'208";a="147121823"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 02:58:47 -0700
IronPort-SDR: qqUQiZjtJC9DtiYjrdw1wdZpnZDKzBJCJgLhXo9hV4zhclnfN/FNhad/9To1q8/bbpICKqPzp3
 XuEPLf7ZmLDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,354,1589266800"; 
   d="scan'208";a="286058587"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006.jf.intel.com with ESMTP; 15 Jul 2020 02:58:46 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jveBa-001woD-Ni; Wed, 15 Jul 2020 12:58:46 +0300
Date:   Wed, 15 Jul 2020 12:58:46 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: [GIT PULL] platform-drivers-x86 for 5.8-2
Message-ID: <20200715095846.GA464373@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Small fixes for this, v5.8 cycle in PDx86. No conflicts found.

Thanks,

With Best Regards,
Andy Shevchenko

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v5.8-2

for you to fetch changes up to 9a33e375d98ece5ea40c576eabd3257acb90c509:

  platform/x86: asus-wmi: allow BAT1 battery name (2020-07-15 12:47:04 +0300)

----------------------------------------------------------------
platform-drivers-x86 for v5.8-2

* Fix procfs handling in Thinkpad ACPI driver
* Fix battery management on new ASUS laptops
* New IDs (Sapphire Rapids) in ISST tool

The following is an automated git shortlog grouped by driver:

asus-wmi:
 -  allow BAT1 battery name

ISST:
 -  Add new PCI device ids

thinkpad_acpi:
 -  Revert "Use strndup_user() in dispatch_proc_write()"

----------------------------------------------------------------
Andy Shevchenko (1):
      platform/x86: thinkpad_acpi: Revert "Use strndup_user() in dispatch_proc_write()"

Srinivas Pandruvada (1):
      platform/x86: ISST: Add new PCI device ids

Vasiliy Kupriakov (1):
      platform/x86: asus-wmi: allow BAT1 battery name

 drivers/platform/x86/asus-wmi.c                            |  1 +
 .../platform/x86/intel_speed_select_if/isst_if_common.h    |  3 +++
 .../platform/x86/intel_speed_select_if/isst_if_mbox_pci.c  |  1 +
 drivers/platform/x86/intel_speed_select_if/isst_if_mmio.c  |  1 +
 drivers/platform/x86/thinkpad_acpi.c                       | 14 +++++++++++---
 5 files changed, 17 insertions(+), 3 deletions(-)

-- 
With Best Regards,
Andy Shevchenko


