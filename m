Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B1AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 11:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D380624694
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 11:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgAVLXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 06:23:12 -0500
Received: from mga14.intel.com ([192.55.52.115]:34818 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbgAVLXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 06:23:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2020 03:23:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,349,1574150400"; 
   d="scan'208";a="399980655"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 22 Jan 2020 03:23:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9781D34C; Wed, 22 Jan 2020 13:23:07 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 3/9] x86/quirks: Introduce hpet_dev_print_force_hpet_address() helper
Date:   Wed, 22 Jan 2020 13:23:00 +0200
Message-Id: <20200122112306.64598-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200122112306.64598-1-andriy.shevchenko@linux.intel.com>
References: <20200122112306.64598-1-andriy.shevchenko@linux.intel.com>
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
index 5b96654aacc0..ce8fc9bec43b 100644
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
2.24.1

