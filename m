Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D999C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 21:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 069E120870
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 21:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732664AbgCCVcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 16:32:05 -0500
Received: from mga06.intel.com ([134.134.136.31]:55266 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732649AbgCCVcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 16:32:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 13:32:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,511,1574150400"; 
   d="scan'208";a="263355817"
Received: from gayuk-dev-mach.sc.intel.com ([10.3.79.171])
  by fmsmga004.fm.intel.com with ESMTP; 03 Mar 2020 13:32:03 -0800
From:   Gayatri Kammela <gayatri.kammela@intel.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vishwanath.somayaji@intel.com,
        dvhart@infradead.org, mika.westerberg@intel.com,
        peterz@infradead.org, charles.d.prestopine@intel.com,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Chen Zhou <chenzhou10@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "David E . Box" <david.e.box@intel.com>
Subject: [PATCH v4] platform/x86: intel_pmc_core: fix: Make pmc_core_lpm_display() generic for platforms that support sub-states
Date:   Tue,  3 Mar 2020 13:28:08 -0800
Message-Id: <d770d0ed104ae009a98d72e85eae1ce4d63866b4.1583265275.git.gayatri.kammela@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently pmc_core_lpm_display() uses array of struct pointers i.e.,
tgl_lpm_maps for Tiger Lake directly to iterate through and to get the
number of status/live status registers which is hardcoded and cannot
be re-used for future platforms that support sub-states. To maintain
readability, make pmc_core_lpm_display() generic, so that it can re-used
for future platforms.

Cc: Chen Zhou <chenzhou10@huawei.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David E. Box <david.e.box@intel.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
---

Changes since v1:
1) Changed the order of the patches i.e., patch 2 in v1 is made first in
   the order for v2.
2) Fixed the warnings reported by kbuild test robot.

Changes since v2:
1) Add "Make pmc_core_substate_res_show() generic" patch to v3.
2) Fixed the memory leak issue in pmc_core_lpm_display().
3) Moved patch 2 in v2 to the last in the series in v3.

Changes since v3:
1) Addressed the comments received in v3.
2) Sending this patch alone in v4

 drivers/platform/x86/intel_pmc_core.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 986fe677d6fe..6ddb74d05ea6 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
 #include <linux/suspend.h>
 #include <linux/uaccess.h>
 
@@ -639,20 +640,35 @@ static void pmc_core_slps0_display(struct pmc_dev *pmcdev, struct device *dev,
 	}
 }
 
+static int pmc_core_lpm_get_arr_size(const struct pmc_bit_map **maps)
+{
+	int idx;
+
+	for (idx = 0; maps[idx]; idx++)
+		;/* Nothing */
+
+	return idx;
+}
+
 static void pmc_core_lpm_display(struct pmc_dev *pmcdev, struct device *dev,
 				 struct seq_file *s, u32 offset,
 				 const char *str,
 				 const struct pmc_bit_map **maps)
 {
-	u32 lpm_regs[ARRAY_SIZE(tgl_lpm_maps)-1];
-	int index, idx, len = 32, bit_mask;
+	int index, idx, len = 32, bit_mask, arr_size;
+	u32 *lpm_regs;
+
+	arr_size = pmc_core_lpm_get_arr_size(maps);
+	lpm_regs = kmalloc_array(arr_size, sizeof(*lpm_regs), GFP_KERNEL);
+	if (!lpm_regs)
+		return;
 
-	for (index = 0; tgl_lpm_maps[index]; index++) {
+	for (index = 0; index < arr_size; index++) {
 		lpm_regs[index] = pmc_core_reg_read(pmcdev, offset);
 		offset += 4;
 	}
 
-	for (idx = 0; maps[idx]; idx++) {
+	for (idx = 0; idx < arr_size; idx++) {
 		if (dev)
 			dev_dbg(dev, "\nLPM_%s_%d:\t0x%x\n", str, idx,
 				lpm_regs[idx]);
@@ -671,6 +687,8 @@ static void pmc_core_lpm_display(struct pmc_dev *pmcdev, struct device *dev,
 					   lpm_regs[idx] & bit_mask ? 1 : 0);
 		}
 	}
+
+	kfree(lpm_regs);
 }
 
 #if IS_ENABLED(CONFIG_DEBUG_FS)

base-commit: 8d92e160dd8fa62a4e52e334ff6dccc885cb6696
-- 
2.17.1

