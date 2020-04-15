Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28435C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ED6E208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371145AbgDOO4V (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 10:56:21 -0400
Received: from mga09.intel.com ([134.134.136.24]:4846 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S371093AbgDOOzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:55:51 -0400
IronPort-SDR: aC/0Pz9yJMcQBWgV+7P09PxsGKT1bAOfKCxOZe/YpiZD8K7tjsTDoy+LM1CTp43OwDshP2ltsj
 GEIhFYsZOsMQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 07:55:50 -0700
IronPort-SDR: qemmsPKp5lpipocUHcSQ020vk3nd6na8Xz4igA6gIdQiLHy3Pd8I57Vs1JpUmMyU+xWKdW/NVi
 ffVwYtMfD7hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,387,1580803200"; 
   d="scan'208";a="244121203"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 15 Apr 2020 07:55:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0F60319C; Wed, 15 Apr 2020 17:55:39 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        alsa-devel@alsa-project.org
Subject: [PATCH v4 0/9] x86: Easy way of detecting MS Surface 3
Date:   Wed, 15 Apr 2020 17:55:15 +0300
Message-Id: <20200415145524.31745-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While working on RTC regression, I noticed that we are using the same DMI check
over and over in the drivers for MS Surface 3 platform. This series dedicated
for making it easier in the same way how it's done for Apple machines.

Changelog v4:
- rebase on top of v5.7-rc1

Changelog v3:
- fixed typo in patch 5 (Jonathan)
- returned back to if {} else {} condition in ASoC driver (Mark)
- added Mark's Ack tag

Changelog v2:
- removed RTC patches for now (the fix will be independent to this series)
- added couple more clean ups to arch/x86/kernel/quirks.c
- redone DMI quirk to use driver_data instead of callback
- simplified check in soc-acpi-intel-cht-match.c to be oneliner
- added a new patch to cover rt5645 codec driver

Cc: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Jie Yang <yang.jie@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org

Andy Shevchenko (9):
  x86/platform: Rename x86/apple.h -> x86/machine.h
  x86/quirks: Add missed include to satisfy static checker
  x86/quirks: Introduce hpet_dev_print_force_hpet_address() helper
  x86/quirks: Join string literals back
  x86/quirks: Convert DMI matching to use a table
  x86/quirks: Add a DMI quirk for Microsoft Surface 3
  platform/x86: surface3_wmi: Switch DMI table match to a test of
    variable
  ASoC: rt5645: Switch DMI table match to a test of variable
  ASoC: Intel: Switch DMI table match to a test of variable

 arch/x86/kernel/quirks.c                      | 91 +++++++++++++------
 drivers/platform/x86/surface3-wmi.c           | 16 +---
 include/linux/platform_data/x86/apple.h       | 14 +--
 include/linux/platform_data/x86/machine.h     | 20 ++++
 sound/soc/codecs/rt5645.c                     | 14 ++-
 .../intel/common/soc-acpi-intel-cht-match.c   | 28 +-----
 6 files changed, 93 insertions(+), 90 deletions(-)
 create mode 100644 include/linux/platform_data/x86/machine.h

-- 
2.25.1

