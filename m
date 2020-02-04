Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CFAC3524B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 23:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D6F21582
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 23:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgBDXFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 18:05:04 -0500
Received: from mga01.intel.com ([192.55.52.88]:22705 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727730AbgBDXFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 18:05:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2020 15:05:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,403,1574150400"; 
   d="scan'208";a="264018019"
Received: from unknown (HELO gayuk-dev-mach.sc.intel.com) ([10.3.79.172])
  by fmsmga002.fm.intel.com with ESMTP; 04 Feb 2020 15:05:00 -0800
From:   Gayatri Kammela <gayatri.kammela@intel.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vishwanath.somayaji@intel.com,
        dvhart@infradead.org, mika.westerberg@intel.com,
        peterz@infradead.org, charles.d.prestopine@intel.com,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "David E . Box" <david.e.box@intel.com>
Subject: [PATCH v2 7/7] platform/x86: intel_pmc_core: Add debugfs support to access live status registers
Date:   Tue,  4 Feb 2020 15:02:00 -0800
Message-Id: <89269c13aa2dbc99246741ff3026a6c7cb3c7495.1580848931.git.gayatri.kammela@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1580848931.git.gayatri.kammela@intel.com>
References: <cover.1580848931.git.gayatri.kammela@intel.com>
In-Reply-To: <cover.1580848931.git.gayatri.kammela@intel.com>
References: <cover.1580848931.git.gayatri.kammela@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like status registers, Tiger Lake has another set of 6 registers
that help with status of the low power mode requirements. They are
latched on every PC10 entry/exit and S0ix.y entry/exit as well.

Though status and live status registers show the status of same list
of requirements, live status registers show the status of the low power
mode requirements at the time of reading.

Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David E. Box <david.e.box@intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
---
 drivers/platform/x86/intel_pmc_core.c | 19 +++++++++++++++++++
 drivers/platform/x86/intel_pmc_core.h |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 62cce906755e..19e02319fd0e 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -570,6 +570,7 @@ static const struct pmc_reg_map tgl_reg_map = {
 	.lpm_residency_offset = TGL_LPM_RESIDENCY_OFFSET,
 	.lpm_sts = tgl_lpm_maps,
 	.lpm_status_offset = TGL_LPM_STATUS_OFFSET,
+	.lpm_live_status_offset = TGL_LPM_LIVE_STATUS_OFFSET,
 };
 
 static inline u32 pmc_core_reg_read(struct pmc_dev *pmcdev, int reg_offset)
@@ -1019,6 +1020,18 @@ static int pmc_core_substate_sts_regs_show(struct seq_file *s, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(pmc_core_substate_sts_regs);
 
+static int pmc_core_substate_l_sts_regs_show(struct seq_file *s, void *unused)
+{
+	struct pmc_dev *pmcdev = s->private;
+	const struct pmc_bit_map **maps = pmcdev->map->lpm_sts;
+	u32 offset = pmcdev->map->lpm_live_status_offset;
+
+	pmc_core_lpm_display(pmcdev, NULL, s, offset, "LIVE_STATUS", maps);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(pmc_core_substate_l_sts_regs);
+
 static int pmc_core_pkgc_show(struct seq_file *s, void *unused)
 {
 	struct pmc_dev *pmcdev = s->private;
@@ -1096,6 +1109,12 @@ static void pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
 				    pmcdev->dbgfs_dir, pmcdev,
 				    &pmc_core_substate_sts_regs_fops);
 	}
+
+	if (pmcdev->map->lpm_status_offset) {
+		debugfs_create_file("substate_live_status_registers", 0444,
+				    pmcdev->dbgfs_dir, pmcdev,
+				    &pmc_core_substate_l_sts_regs_fops);
+	}
 }
 #else
 static inline void pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
index 3fdf4735c56f..1bbdffe80bde 100644
--- a/drivers/platform/x86/intel_pmc_core.h
+++ b/drivers/platform/x86/intel_pmc_core.h
@@ -196,6 +196,7 @@ enum ppfear_regs {
 
 /* Tigerlake Low Power Mode debug registers */
 #define TGL_LPM_STATUS_OFFSET			0x1C3C
+#define TGL_LPM_LIVE_STATUS_OFFSET		0x1C5C
 
 const char *lpm_modes[] = {
 	"S0i2.0",
@@ -257,6 +258,7 @@ struct pmc_reg_map {
 	const u32 lpm_en_offset;
 	const u32 lpm_residency_offset;
 	const u32 lpm_status_offset;
+	const u32 lpm_live_status_offset;
 };
 
 /**
-- 
2.17.1

