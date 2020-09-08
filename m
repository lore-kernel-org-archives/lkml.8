Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601E1C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24C1321D7A
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbgIHKAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 06:00:25 -0400
Received: from mga01.intel.com ([192.55.52.88]:31813 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbgIHKAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 06:00:24 -0400
IronPort-SDR: 1nEawPwz0tfvWK/lq5ls1DeOvNbpOzXuay8knPjb3+CfhhhyGinjESDCSNuiXB4e/HXtUESwsa
 GhTyjCbZJq0w==
X-IronPort-AV: E=McAfee;i="6000,8403,9737"; a="176157417"
X-IronPort-AV: E=Sophos;i="5.76,405,1592895600"; 
   d="scan'208";a="176157417"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 03:00:23 -0700
IronPort-SDR: DSMyosH8hh3BdOlwoY3feITQQKoaPKBFI1pLYFCPuYT90lIDgcmFSuSnYZHOvd9lRzj24LXD5O
 0QOAjwKnvOVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,405,1592895600"; 
   d="scan'208";a="505005949"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 08 Sep 2020 03:00:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5D00EDE; Tue,  8 Sep 2020 13:00:19 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH v1] x86/defconfigs: Unbreak 32-bit defconfig builds
Date:   Tue,  8 Sep 2020 13:00:18 +0300
Message-Id: <20200908100018.50188-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the commit 1d0e12fd3a84 ("x86/defconfigs: Refresh defconfig files")
32-bit builds using defconfig become broken because on x86_64 build host
with no ARCH provided the default behaviour is to assume 64-bit independently
on the configuration file name. The crucial part is CONFIG_64BIT option
that used to be explicit. Let restore the latter option in order to unbreak
32-bit builds.

Fixes: 1d0e12fd3a84 ("x86/defconfigs: Refresh defconfig files")
Reported-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/configs/i386_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index d66078fc94a4..0b75c4291748 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -19,6 +19,7 @@ CONFIG_CGROUP_CPUACCT=y
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=y
+# CONFIG_64BIT is not set
 CONFIG_SMP=y
 CONFIG_X86_GENERIC=y
 CONFIG_HPET_TIMER=y
-- 
2.28.0

