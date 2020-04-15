Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8147C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99FF62078B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371158AbgDOO42 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 10:56:28 -0400
Received: from mga09.intel.com ([134.134.136.24]:4840 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S371091AbgDOOzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:55:50 -0400
IronPort-SDR: 6mTMNhMAlygCdBHMhEod+SYQfuQvLSFZxyxfRt5UpMYyV0L9T3w1a2lKS+FWjPqPNmr+0gjkuX
 LL+RYvZMqq4g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 07:55:50 -0700
IronPort-SDR: P9uqJvSuaH1B4MvCGefAbtGsGmqhMzd4lrXlT545hf8dhJM4QvQHtjUWRP5I2g/tl5mgi/yKLJ
 ar98JByFV/UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,387,1580803200"; 
   d="scan'208";a="244121182"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 15 Apr 2020 07:55:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 38653638; Wed, 15 Apr 2020 17:55:40 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 3/9] x86/quirks: Introduce hpet_dev_print_force_hpet_address() helper
Date:   Wed, 15 Apr 2020 17:55:18 +0300
Message-Id: <20200415145524.31745-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200415145524.31745-1-andriy.shevchenko@linux.intel.com>
References: <20200415145524.31745-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce hpet_dev_print_force_hpet_address() helper to unify printing
forced HPET address. No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/kernel/quirks.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/quirks.c b/arch/x86/kernel/quirks.c
index 7c054650b3a6..0313016f6756 100644
--- a/arch/x86/kernel/quirks.c
+++ b/arch/x86/kernel/quirks.c
@@ -68,6 +68,11 @@ static enum {
 	ATI_FORCE_HPET_RESUME,
 } force_hpet_resume_type;
 
+static void hpet_dev_print_force_hpet_address(struct device *dev)
+{
+	dev_printk(KERN_DEBUG, dev, "Force enabled HPET at 0x%lx\n", force_hpet_address);
+}
+
 static void __iomem *rcba_base;
 
 static void ich_force_hpet_resume(void)
@@ -125,8 +130,7 @@ static void ich_force_enable_hpet(struct pci_dev *dev)
 		/* HPET is enabled in HPTC. Just not reported by BIOS */
 		val = val & 0x3;
 		force_hpet_address = 0xFED00000 | (val << 12);
-		dev_printk(KERN_DEBUG, &dev->dev, "Force enabled HPET at "
-			"0x%lx\n", force_hpet_address);
+		hpet_dev_print_force_hpet_address(&dev->dev);
 		iounmap(rcba_base);
 		return;
 	}
@@ -149,8 +153,7 @@ static void ich_force_enable_hpet(struct pci_dev *dev)
 			"Failed to force enable HPET\n");
 	} else {
 		force_hpet_resume_type = ICH_FORCE_HPET_RESUME;
-		dev_printk(KERN_DEBUG, &dev->dev, "Force enabled HPET at "
-			"0x%lx\n", force_hpet_address);
+		hpet_dev_print_force_hpet_address(&dev->dev);
 	}
 }
 
@@ -223,8 +226,7 @@ static void old_ich_force_enable_hpet(struct pci_dev *dev)
 	if (val & 0x4) {
 		val &= 0x3;
 		force_hpet_address = 0xFED00000 | (val << 12);
-		dev_printk(KERN_DEBUG, &dev->dev, "HPET at 0x%lx\n",
-			force_hpet_address);
+		hpet_dev_print_force_hpet_address(&dev->dev);
 		return;
 	}
 
@@ -244,8 +246,7 @@ static void old_ich_force_enable_hpet(struct pci_dev *dev)
 		/* HPET is enabled in HPTC. Just not reported by BIOS */
 		val &= 0x3;
 		force_hpet_address = 0xFED00000 | (val << 12);
-		dev_printk(KERN_DEBUG, &dev->dev, "Force enabled HPET at "
-			"0x%lx\n", force_hpet_address);
+		hpet_dev_print_force_hpet_address(&dev->dev);
 		cached_dev = dev;
 		force_hpet_resume_type = OLD_ICH_FORCE_HPET_RESUME;
 		return;
@@ -316,8 +317,7 @@ static void vt8237_force_enable_hpet(struct pci_dev *dev)
 	 */
 	if (val & 0x80) {
 		force_hpet_address = (val & ~0x3ff);
-		dev_printk(KERN_DEBUG, &dev->dev, "HPET at 0x%lx\n",
-			force_hpet_address);
+		hpet_dev_print_force_hpet_address(&dev->dev);
 		return;
 	}
 
@@ -331,8 +331,7 @@ static void vt8237_force_enable_hpet(struct pci_dev *dev)
 	pci_read_config_dword(dev, 0x68, &val);
 	if (val & 0x80) {
 		force_hpet_address = (val & ~0x3ff);
-		dev_printk(KERN_DEBUG, &dev->dev, "Force enabled HPET at "
-			"0x%lx\n", force_hpet_address);
+		hpet_dev_print_force_hpet_address(&dev->dev);
 		cached_dev = dev;
 		force_hpet_resume_type = VT8237_FORCE_HPET_RESUME;
 		return;
@@ -412,8 +411,7 @@ static void ati_force_enable_hpet(struct pci_dev *dev)
 
 	force_hpet_address = val;
 	force_hpet_resume_type = ATI_FORCE_HPET_RESUME;
-	dev_printk(KERN_DEBUG, &dev->dev, "Force enabled HPET at 0x%lx\n",
-		   force_hpet_address);
+	hpet_dev_print_force_hpet_address(&dev->dev);
 	cached_dev = dev;
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP400_SMBUS,
@@ -444,8 +442,7 @@ static void nvidia_force_enable_hpet(struct pci_dev *dev)
 	pci_read_config_dword(dev, 0x44, &val);
 	force_hpet_address = val & 0xfffffffe;
 	force_hpet_resume_type = NVIDIA_FORCE_HPET_RESUME;
-	dev_printk(KERN_DEBUG, &dev->dev, "Force enabled HPET at 0x%lx\n",
-		force_hpet_address);
+	hpet_dev_print_force_hpet_address(&dev->dev);
 	cached_dev = dev;
 }
 
@@ -509,8 +506,7 @@ static void e6xx_force_enable_hpet(struct pci_dev *dev)
 
 	force_hpet_address = 0xFED00000;
 	force_hpet_resume_type = NONE_FORCE_HPET_RESUME;
-	dev_printk(KERN_DEBUG, &dev->dev, "Force enabled HPET at "
-		"0x%lx\n", force_hpet_address);
+	hpet_dev_print_force_hpet_address(&dev->dev);
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_E6XX_CU,
 			 e6xx_force_enable_hpet);
-- 
2.25.1

