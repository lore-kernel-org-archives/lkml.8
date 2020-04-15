Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901BEC3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A69C2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371102AbgDOOzz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 10:55:55 -0400
Received: from mga11.intel.com ([192.55.52.93]:46559 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S371076AbgDOOzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:55:44 -0400
IronPort-SDR: sgkIa+bN6RBlI0We6qm8R3eQoARu8D8ZnUFH9iJ+Hgdtmk9VrIhb/sJ7UThcHQi+z4I0l3S3NV
 e5kA/W1JiT6g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 07:55:43 -0700
IronPort-SDR: wPwkqQeLhVw38AdafLLi1V2EaLmpDlmcaqVOBg7cGjpbzZfs8hzyKIWVcpjrYw15mLG2dUE/AN
 H3J0+k5YRfzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,387,1580803200"; 
   d="scan'208";a="332520439"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 15 Apr 2020 07:55:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4670E76D; Wed, 15 Apr 2020 17:55:40 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 4/9] x86/quirks: Join string literals back
Date:   Wed, 15 Apr 2020 17:55:19 +0300
Message-Id: <20200415145524.31745-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200415145524.31745-1-andriy.shevchenko@linux.intel.com>
References: <20200415145524.31745-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to split string literals. Moreover, it would be simpler
to grep for an actual code line, when debugging, by using almost any
part of the string literal in question.

No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/kernel/quirks.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/quirks.c b/arch/x86/kernel/quirks.c
index 0313016f6756..091d03cfbb1e 100644
--- a/arch/x86/kernel/quirks.c
+++ b/arch/x86/kernel/quirks.c
@@ -36,8 +36,7 @@ static void quirk_intel_irqbalance(struct pci_dev *dev)
 	pci_bus_read_config_word(dev->bus, PCI_DEVFN(8, 0), 0x4c, &word);
 
 	if (!(word & (1 << 13))) {
-		dev_info(&dev->dev, "Intel E7520/7320/7525 detected; "
-			"disabling irq balancing and affinity\n");
+		dev_info(&dev->dev, "Intel E7520/7320/7525 detected; disabling irq balancing and affinity\n");
 		noirqdebug_setup("");
 #ifdef CONFIG_PROC_FS
 		no_irq_affinity = 1;
@@ -110,16 +109,14 @@ static void ich_force_enable_hpet(struct pci_dev *dev)
 	pci_read_config_dword(dev, 0xF0, &rcba);
 	rcba &= 0xFFFFC000;
 	if (rcba == 0) {
-		dev_printk(KERN_DEBUG, &dev->dev, "RCBA disabled; "
-			"cannot force enable HPET\n");
+		dev_printk(KERN_DEBUG, &dev->dev, "RCBA disabled; cannot force enable HPET\n");
 		return;
 	}
 
 	/* use bits 31:14, 16 kB aligned */
 	rcba_base = ioremap(rcba, 0x4000);
 	if (rcba_base == NULL) {
-		dev_printk(KERN_DEBUG, &dev->dev, "ioremap failed; "
-			"cannot force enable HPET\n");
+		dev_printk(KERN_DEBUG, &dev->dev, "ioremap failed; cannot force enable HPET\n");
 		return;
 	}
 
@@ -149,8 +146,7 @@ static void ich_force_enable_hpet(struct pci_dev *dev)
 	if (err) {
 		force_hpet_address = 0;
 		iounmap(rcba_base);
-		dev_printk(KERN_DEBUG, &dev->dev,
-			"Failed to force enable HPET\n");
+		dev_printk(KERN_DEBUG, &dev->dev, "Failed to force enable HPET\n");
 	} else {
 		force_hpet_resume_type = ICH_FORCE_HPET_RESUME;
 		hpet_dev_print_force_hpet_address(&dev->dev);
@@ -182,8 +178,7 @@ static struct pci_dev *cached_dev;
 
 static void hpet_print_force_info(void)
 {
-	printk(KERN_INFO "HPET not enabled in BIOS. "
-	       "You might try hpet=force boot option\n");
+	printk(KERN_INFO "HPET not enabled in BIOS. You might try hpet=force boot option\n");
 }
 
 static void old_ich_force_hpet_resume(void)
-- 
2.25.1

