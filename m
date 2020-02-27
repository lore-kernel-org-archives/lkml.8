Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6949C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 02:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6631222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 02:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgB0Crg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 21:47:36 -0500
Received: from mga05.intel.com ([192.55.52.43]:47772 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728221AbgB0Crc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 21:47:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 18:47:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,490,1574150400"; 
   d="scan'208";a="438670604"
Received: from gayuk-dev-mach.sc.intel.com ([10.3.79.171])
  by fmsmga006.fm.intel.com with ESMTP; 26 Feb 2020 18:47:32 -0800
From:   Gayatri Kammela <gayatri.kammela@intel.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vishwanath.somayaji@intel.com,
        dvhart@infradead.org, mika.westerberg@intel.com,
        peterz@infradead.org, charles.d.prestopine@intel.com,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Chen Zhou <chenzhou10@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "David E . Box" <david.e.box@intel.com>
Subject: [PATCH v1 2/4] platform/x86: intel_pmc_core: fix: Relocate pmc_core_slps0_display() and pmc_core_lpm_display() to outside of CONFIG_DEBUG_FS
Date:   Wed, 26 Feb 2020 18:43:28 -0800
Message-Id: <329f6dbbe6c7b690cd87db9e8ca05dc86a7b0393.1582770011.git.gayatri.kammela@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1582770011.git.gayatri.kammela@intel.com>
References: <cover.1582770011.git.gayatri.kammela@intel.com>
In-Reply-To: <cover.1582770011.git.gayatri.kammela@intel.com>
References: <cover.1582770011.git.gayatri.kammela@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since pmc_core_slps0_display() and pmc_core_lpm_display() is responsible
for dumping as well as displaying debug registers, there is no need for
these two functions to be defined under CONFIG_DEBUG_FS.

Hence, relocate these functions from under CONFIG_DEBUG_FS to above the
block.

Cc: Chen Zhou <chenzhou10@huawei.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David E. Box <david.e.box@intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
---
 drivers/platform/x86/intel_pmc_core.c | 130 +++++++++++++-------------
 1 file changed, 65 insertions(+), 65 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 333c6963d270..37db13ad7d39 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -612,6 +612,71 @@ static int pmc_core_check_read_lock_bit(void)
 	return value & BIT(pmcdev->map->pm_read_disable_bit);
 }
 
+static void pmc_core_slps0_display(struct pmc_dev *pmcdev, struct device *dev,
+				   struct seq_file *s)
+{
+	const struct pmc_bit_map **maps = pmcdev->map->slps0_dbg_maps;
+	const struct pmc_bit_map *map;
+	int offset = pmcdev->map->slps0_dbg_offset;
+	u32 data;
+
+	while (*maps) {
+		map = *maps;
+		data = pmc_core_reg_read(pmcdev, offset);
+		offset += 4;
+		while (map->name) {
+			if (dev)
+				dev_dbg(dev, "SLP_S0_DBG: %-32s\tState: %s\n",
+					map->name,
+					data & map->bit_mask ? "Yes" : "No");
+			if (s)
+				seq_printf(s, "SLP_S0_DBG: %-32s\tState: %s\n",
+					   map->name,
+					   data & map->bit_mask ? "Yes" : "No");
+			++map;
+		}
+		++maps;
+	}
+}
+
+static void pmc_core_lpm_display(struct pmc_dev *pmcdev, struct device *dev,
+				 struct seq_file *s, u32 offset,
+				 const char *str,
+				 const struct pmc_bit_map **maps)
+{
+	int index, idx, len = 32, bit_mask, arr_size = 0;
+
+	for (index = 0; maps[index]; index++)
+		arr_size++;
+
+	u32 lpm_regs[arr_size];
+
+	for (index = 0; maps[index]; index++) {
+		lpm_regs[index] = pmc_core_reg_read(pmcdev, offset);
+		offset += 4;
+	}
+
+	for (idx = 0; maps[idx]; idx++) {
+		if (dev)
+			dev_dbg(dev, "\nLPM_%s_%d:\t0x%x\n", str, idx,
+				lpm_regs[idx]);
+		if (s)
+			seq_printf(s, "\nLPM_%s_%d:\t0x%x\n", str, idx,
+				   lpm_regs[idx]);
+		for (index = 0; maps[idx][index].name && index < len; index++) {
+			bit_mask = maps[idx][index].bit_mask;
+			if (dev)
+				dev_dbg(dev, "%-30s %-30d\n",
+					maps[idx][index].name,
+					lpm_regs[idx] & bit_mask ? 1 : 0);
+			if (s)
+				seq_printf(s, "%-30s %-30d\n",
+					   maps[idx][index].name,
+					   lpm_regs[idx] & bit_mask ? 1 : 0);
+		}
+	}
+}
+
 #if IS_ENABLED(CONFIG_DEBUG_FS)
 static bool slps0_dbg_latch;
 
@@ -844,33 +909,6 @@ static void pmc_core_slps0_dbg_latch(struct pmc_dev *pmcdev, bool reset)
 	mutex_unlock(&pmcdev->lock);
 }
 
-static void pmc_core_slps0_display(struct pmc_dev *pmcdev, struct device *dev,
-				   struct seq_file *s)
-{
-	const struct pmc_bit_map **maps = pmcdev->map->slps0_dbg_maps;
-	const struct pmc_bit_map *map;
-	int offset = pmcdev->map->slps0_dbg_offset;
-	u32 data;
-
-	while (*maps) {
-		map = *maps;
-		data = pmc_core_reg_read(pmcdev, offset);
-		offset += 4;
-		while (map->name) {
-			if (dev)
-				dev_dbg(dev, "SLP_S0_DBG: %-32s\tState: %s\n",
-					map->name,
-					data & map->bit_mask ? "Yes" : "No");
-			if (s)
-				seq_printf(s, "SLP_S0_DBG: %-32s\tState: %s\n",
-					   map->name,
-					   data & map->bit_mask ? "Yes" : "No");
-			++map;
-		}
-		++maps;
-	}
-}
-
 static int pmc_core_slps0_dbg_show(struct seq_file *s, void *unused)
 {
 	struct pmc_dev *pmcdev = s->private;
@@ -974,44 +1012,6 @@ static int pmc_core_substate_res_show(struct seq_file *s, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(pmc_core_substate_res);
 
-static void pmc_core_lpm_display(struct pmc_dev *pmcdev, struct device *dev,
-				 struct seq_file *s, u32 offset,
-				 const char *str,
-				 const struct pmc_bit_map **maps)
-{
-	int index, idx, len = 32, bit_mask, arr_size = 0;
-
-	for (index = 0; maps[index]; index++)
-		arr_size++;
-
-	u32 lpm_regs[arr_size];
-
-	for (index = 0; maps[index]; index++) {
-		lpm_regs[index] = pmc_core_reg_read(pmcdev, offset);
-		offset += 4;
-	}
-
-	for (idx = 0; maps[idx]; idx++) {
-		if (dev)
-			dev_dbg(dev, "\nLPM_%s_%d:\t0x%x\n", str, idx,
-				lpm_regs[idx]);
-		if (s)
-			seq_printf(s, "\nLPM_%s_%d:\t0x%x\n", str, idx,
-				   lpm_regs[idx]);
-		for (index = 0; maps[idx][index].name && index < len; index++) {
-			bit_mask = maps[idx][index].bit_mask;
-			if (dev)
-				dev_dbg(dev, "%-30s %-30d\n",
-					maps[idx][index].name,
-					lpm_regs[idx] & bit_mask ? 1 : 0);
-			if (s)
-				seq_printf(s, "%-30s %-30d\n",
-					   maps[idx][index].name,
-					   lpm_regs[idx] & bit_mask ? 1 : 0);
-		}
-	}
-}
-
 static int pmc_core_substate_sts_regs_show(struct seq_file *s, void *unused)
 {
 	struct pmc_dev *pmcdev = s->private;
-- 
2.17.1

