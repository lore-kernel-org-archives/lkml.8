Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DD9C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 18:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBF2A2071E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 18:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391564AbgAXSx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 13:53:26 -0500
Received: from mga04.intel.com ([192.55.52.120]:59351 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387486AbgAXSxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 13:53:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jan 2020 10:53:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,358,1574150400"; 
   d="scan'208";a="222692799"
Received: from unknown (HELO gayuk-dev-mach.sc.intel.com) ([10.3.79.172])
  by fmsmga008.fm.intel.com with ESMTP; 24 Jan 2020 10:53:25 -0800
From:   Gayatri Kammela <gayatri.kammela@intel.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vishwanath.somayaji@intel.com,
        dvhart@infradead.org, mika.westerberg@intel.com,
        peterz@infradead.org, charles.d.prestopine@intel.com,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Box <david.e.box@intel.com>
Subject: [PATCH v1 1/7] platform/x86: intel_pmc_core: Add debugfs entry to access sub-state residencies
Date:   Fri, 24 Jan 2020 10:50:22 -0800
Message-Id: <1298f8e0b19ad46f64922531ae4823c39ff69e46.1579890793.git.gayatri.kammela@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1579890793.git.gayatri.kammela@intel.com>
References: <cover.1579890793.git.gayatri.kammela@intel.com>
In-Reply-To: <cover.1579890793.git.gayatri.kammela@intel.com>
References: <cover.1579890793.git.gayatri.kammela@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prior to Tiger Lake, the platforms that support pmc_core have no
sub-states of S0ix. Tiger Lake has 8 sub-states/low power modes of S0ix
ranging from S0i2.0-S0i2.2 and S0i3.0-S0i3.4, simply represented as
S0ix.y.

Create a debugfs entry to access residency of each sub-state.

Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Box <david.e.box@intel.com>
Signed-off-by: David Box <david.e.box@intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
---
 drivers/platform/x86/intel_pmc_core.c | 28 +++++++++++++++++++++++++++
 drivers/platform/x86/intel_pmc_core.h | 21 ++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 017776551cc5..6e7cf620bea6 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -422,6 +422,8 @@ static const struct pmc_reg_map tgl_reg_map = {
 	.pm_cfg_offset = CNP_PMC_PM_CFG_OFFSET,
 	.pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
 	.ltr_ignore_max = TGL_NUM_IP_IGN_ALLOWED,
+	.lpm_en_offset = TGL_LPM_EN_OFFSET,
+	.lpm_residency_offset = TGL_LPM_RESIDENCY_OFFSET,
 };
 
 static inline u8 pmc_core_reg_read_byte(struct pmc_dev *pmcdev, int offset)
@@ -793,6 +795,26 @@ static int pmc_core_ltr_show(struct seq_file *s, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(pmc_core_ltr);
 
+static int pmc_core_substate_res_show(struct seq_file *s, void *unused)
+{
+	struct pmc_dev *pmcdev = s->private;
+	u32 offset = pmcdev->map->lpm_residency_offset;
+	u32 lpm_en;
+	int index;
+
+	lpm_en = pmc_core_reg_read(pmcdev, pmcdev->map->lpm_en_offset);
+	seq_printf(s, "status substate residency\n");
+	for (index = 0; lpm_modes[index]; index++) {
+		seq_printf(s, "%7s %7s %-15u\n",
+			   BIT(index) & lpm_en ? "Enabled" : " ",
+			   lpm_modes[index], pmc_core_reg_read(pmcdev, offset));
+		offset += 4;
+	}
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(pmc_core_substate_res);
+
 static int pmc_core_pkgc_show(struct seq_file *s, void *unused)
 {
 	struct pmc_dev *pmcdev = s->private;
@@ -858,6 +880,12 @@ static void pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
 		debugfs_create_bool("slp_s0_dbg_latch", 0644,
 				    dir, &slps0_dbg_latch);
 	}
+
+	if (pmcdev->map->lpm_en_offset) {
+		debugfs_create_file("substate_residencies", 0444,
+				    pmcdev->dbgfs_dir, pmcdev,
+				    &pmc_core_substate_res_fops);
+	}
 }
 #else
 static inline void pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
index f1a0792b3f91..ff1b2645d9b4 100644
--- a/drivers/platform/x86/intel_pmc_core.h
+++ b/drivers/platform/x86/intel_pmc_core.h
@@ -188,6 +188,24 @@ enum ppfear_regs {
 
 #define TGL_NUM_IP_IGN_ALLOWED			22
 
+/*
+ * Tigerlake Power Management Controller register offsets
+ */
+#define TGL_LPM_EN_OFFSET			0x1C78
+#define TGL_LPM_RESIDENCY_OFFSET		0x1C80
+
+const char *lpm_modes[] = {
+	"S0i2.0",
+	"S0i2.1",
+	"S0i2.2",
+	"S0i3.0",
+	"S0i3.1",
+	"S0i3.2",
+	"S0i3.3",
+	"S0i3.4",
+	NULL
+};
+
 struct pmc_bit_map {
 	const char *name;
 	u32 bit_mask;
@@ -231,6 +249,9 @@ struct pmc_reg_map {
 	const u32 slps0_dbg_offset;
 	const u32 ltr_ignore_max;
 	const u32 pm_vric1_offset;
+	/* Low Power Mode registers */
+	const u32 lpm_en_offset;
+	const u32 lpm_residency_offset;
 };
 
 /**
-- 
2.17.1

