Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF90C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 18:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 730332071E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 18:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391610AbgAXSxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 13:53:32 -0500
Received: from mga04.intel.com ([192.55.52.120]:59351 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391588AbgAXSxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 13:53:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jan 2020 10:53:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,358,1574150400"; 
   d="scan'208";a="222692820"
Received: from unknown (HELO gayuk-dev-mach.sc.intel.com) ([10.3.79.172])
  by fmsmga008.fm.intel.com with ESMTP; 24 Jan 2020 10:53:30 -0800
From:   Gayatri Kammela <gayatri.kammela@intel.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vishwanath.somayaji@intel.com,
        dvhart@infradead.org, mika.westerberg@intel.com,
        peterz@infradead.org, charles.d.prestopine@intel.com,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Box <david.e.box@intel.com>
Subject: [PATCH v1 3/7] platform/x86: intel_pmc_core: Refactor the driver by removing redundant code
Date:   Fri, 24 Jan 2020 10:50:24 -0800
Message-Id: <6d2e02fe67541eb5a6f38475dc963028b120a287.1579890793.git.gayatri.kammela@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1579890793.git.gayatri.kammela@intel.com>
References: <cover.1579890793.git.gayatri.kammela@intel.com>
In-Reply-To: <cover.1579890793.git.gayatri.kammela@intel.com>
References: <cover.1579890793.git.gayatri.kammela@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pmc_core_slps0_dbg_show() is responsible for displaying debug registers
through slp_s0_debug_status entry. The driver uses the same but
redundant code to dump these debug registers for an S0ix failure.

Hence, refactor the driver by removing redundant code and reuse the
same function that both dumps registers through slp_s0_debug_status
entry and in resume for an S0ix failure.

The changes in this patch are preparatory, so platforms that support low
power sub-states can dump the debug registers when the attempt to enter
low power states are unsuccessful.

Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Box <david.e.box@intel.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
---
 drivers/platform/x86/intel_pmc_core.c | 48 +++++++++++++--------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 4019f517167b..f52348edab57 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -844,30 +844,41 @@ static void pmc_core_slps0_dbg_latch(struct pmc_dev *pmcdev, bool reset)
 	mutex_unlock(&pmcdev->lock);
 }
 
-static int pmc_core_slps0_dbg_show(struct seq_file *s, void *unused)
+static void pmc_core_slps0_display(struct pmc_dev *pmcdev, struct device *dev,
+				   struct seq_file *s)
 {
-	struct pmc_dev *pmcdev = s->private;
 	const struct pmc_bit_map **maps = pmcdev->map->slps0_dbg_maps;
 	const struct pmc_bit_map *map;
-	int offset;
+	int offset = pmcdev->map->slps0_dbg_offset;
 	u32 data;
 
-	pmc_core_slps0_dbg_latch(pmcdev, false);
-	offset = pmcdev->map->slps0_dbg_offset;
 	while (*maps) {
 		map = *maps;
 		data = pmc_core_reg_read(pmcdev, offset);
 		offset += 4;
 		while (map->name) {
-			seq_printf(s, "SLP_S0_DBG: %-32s\tState: %s\n",
-				   map->name,
-				   data & map->bit_mask ?
-				   "Yes" : "No");
+			if (dev)
+				dev_dbg(dev, "SLP_S0_DBG: %-32s\tState: %s\n",
+					map->name,
+					data & map->bit_mask ? "Yes" : "No");
+			if (s)
+				seq_printf(s, "SLP_S0_DBG: %-32s\tState: %s\n",
+					   map->name,
+					   data & map->bit_mask ? "Yes" : "No");
 			++map;
 		}
 		++maps;
 	}
+}
+
+static int pmc_core_slps0_dbg_show(struct seq_file *s, void *unused)
+{
+	struct pmc_dev *pmcdev = s->private;
+
+	pmc_core_slps0_dbg_latch(pmcdev, false);
+	pmc_core_slps0_display(pmcdev, NULL, s);
 	pmc_core_slps0_dbg_latch(pmcdev, true);
+
 	return 0;
 }
 DEFINE_SHOW_ATTRIBUTE(pmc_core_slps0_dbg);
@@ -1262,10 +1273,6 @@ static inline bool pmc_core_is_s0ix_failed(struct pmc_dev *pmcdev)
 static int pmc_core_resume(struct device *dev)
 {
 	struct pmc_dev *pmcdev = dev_get_drvdata(dev);
-	const struct pmc_bit_map **maps = pmcdev->map->slps0_dbg_maps;
-	int offset = pmcdev->map->slps0_dbg_offset;
-	const struct pmc_bit_map *map;
-	u32 data;
 
 	if (!pmcdev->check_counters)
 		return 0;
@@ -1283,18 +1290,9 @@ static int pmc_core_resume(struct device *dev)
 	/* The real interesting case - S0ix failed - lets ask PMC why. */
 	dev_warn(dev, "CPU did not enter SLP_S0!!! (S0ix cnt=%llu)\n",
 		 pmcdev->s0ix_counter);
-	while (*maps) {
-		map = *maps;
-		data = pmc_core_reg_read(pmcdev, offset);
-		offset += 4;
-		while (map->name) {
-			dev_dbg(dev, "SLP_S0_DBG: %-32s\tState: %s\n",
-				map->name,
-				data & map->bit_mask ? "Yes" : "No");
-			map++;
-		}
-		maps++;
-	}
+	if (pmcdev->map->slps0_dbg_maps)
+		pmc_core_slps0_display(pmcdev, dev, NULL);
+
 	return 0;
 }
 
-- 
2.17.1

