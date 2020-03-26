Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDBAC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADA092070A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbgCZRyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 13:54:21 -0400
Received: from mga17.intel.com ([192.55.52.151]:37829 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726971AbgCZRyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 13:54:21 -0400
IronPort-SDR: 3BJA3FMU3QO63eUTx2NtsyzglZABEsZROCoTzEn3vw1w5K0DYAEIXTRlRZo+PJcR0ClHMFYKC3
 evilY/7sU3SQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2020 10:54:20 -0700
IronPort-SDR: eO0oXpkcP+JrmK2DfvLF1N3u4+jli6PUEGF2JMPDEiNXD3WwIFROnSTCtWoT2e8mJr93ox/BNU
 pGu34SkmFVjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,309,1580803200"; 
   d="scan'208";a="394090478"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 26 Mar 2020 10:54:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7CF563BA; Thu, 26 Mar 2020 19:54:16 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] x86/early_printk: Drop unused headers
Date:   Thu, 26 Mar 2020 19:54:15 +0200
Message-Id: <20200326175415.8618-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the commit 1bd187de5364
("x86, intel-mid: remove Intel MID specific serial support")
the Intel MID header is not needed anymore.

After the commit 69c1f396f25b
("efi/x86: Convert x86 EFI earlyprintk into generic earlycon implementation")
the EFI headers are not needed anymore.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/kernel/early_printk.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kernel/early_printk.c b/arch/x86/kernel/early_printk.c
index 9b33904251a9..93fbdff2974f 100644
--- a/arch/x86/kernel/early_printk.c
+++ b/arch/x86/kernel/early_printk.c
@@ -15,12 +15,9 @@
 #include <xen/hvc-console.h>
 #include <asm/pci-direct.h>
 #include <asm/fixmap.h>
-#include <asm/intel-mid.h>
 #include <asm/pgtable.h>
 #include <linux/usb/ehci_def.h>
 #include <linux/usb/xhci-dbgp.h>
-#include <linux/efi.h>
-#include <asm/efi.h>
 #include <asm/pci_x86.h>
 
 /* Simple VGA output */
-- 
2.25.1

