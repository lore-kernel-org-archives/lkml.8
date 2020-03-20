Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F15BC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 20:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBDB420724
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 20:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbgCTUlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 16:41:55 -0400
Received: from mga11.intel.com ([192.55.52.93]:31053 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726951AbgCTUly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 16:41:54 -0400
IronPort-SDR: MsdOcJkIGyJnFnhBYq5HzkaZoWFPWSGVr7vxojSFvN67bXk19VUIUCxo2tmLExouwVZx2yWfR2
 85J9rZZZpPQQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2020 13:41:44 -0700
IronPort-SDR: l/7ORJ/V1k+H7ybtuEZS2UH6rKz8/XOCrrZuHzZ6Tm6nAMnFab797IpR+XM6HVSGnf/Lf2JjDl
 mvKNGPsuxvyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,285,1580803200"; 
   d="scan'208";a="392265091"
Received: from gayuk-dev-mach.sc.intel.com ([10.3.79.171])
  by orsmga004.jf.intel.com with ESMTP; 20 Mar 2020 13:41:43 -0700
From:   Gayatri Kammela <gayatri.kammela@intel.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vishwanath.somayaji@intel.com,
        dvhart@infradead.org, mika.westerberg@intel.com,
        peterz@infradead.org, charles.d.prestopine@intel.com,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Chen Zhou <chenzhou10@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "David E . Box" <david.e.box@intel.com>
Subject: [PATCH v5] platform/x86: intel_pmc_core: Make pmc_core_substate_res_show() generic
Date:   Fri, 20 Mar 2020 13:36:20 -0700
Message-Id: <434440f39a0ec5074e2a310dc3b5c4c7a6ebe7b2.1584735971.git.gayatri.kammela@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like pmc_core_lpm_display(), pmc_core_substate_res_show() is also
hardcoded to work for Tiger Lake and cannot be re-used for future
platforms that support sub-states. To maintain readability, make
pmc_core_substate_res_show() generic, so that it can re-used for future
platforms.

Cc: Chen Zhou <chenzhou10@huawei.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David E. Box <david.e.box@intel.com>
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
2) Sending patch 5 of v3 alone in v4.

Changes since v4:
1) Modified the commit message to keep it to the point.
2) Sending patch 4 of v3 alone in v5.

 drivers/platform/x86/intel_pmc_core.c | 2 ++
 drivers/platform/x86/intel_pmc_core.h | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 6ddb74d05ea6..d265cd5b1f45 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -567,6 +567,7 @@ static const struct pmc_reg_map tgl_reg_map = {
 	.pm_cfg_offset = CNP_PMC_PM_CFG_OFFSET,
 	.pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
 	.ltr_ignore_max = TGL_NUM_IP_IGN_ALLOWED,
+	.lpm_modes = tgl_lpm_modes,
 	.lpm_en_offset = TGL_LPM_EN_OFFSET,
 	.lpm_residency_offset = TGL_LPM_RESIDENCY_OFFSET,
 	.lpm_sts = tgl_lpm_maps,
@@ -1009,6 +1010,7 @@ DEFINE_SHOW_ATTRIBUTE(pmc_core_ltr);
 static int pmc_core_substate_res_show(struct seq_file *s, void *unused)
 {
 	struct pmc_dev *pmcdev = s->private;
+	const char **lpm_modes = pmcdev->map->lpm_modes;
 	u32 offset = pmcdev->map->lpm_residency_offset;
 	u32 lpm_en;
 	int index;
diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
index 1bbdffe80bde..0d50b2402abe 100644
--- a/drivers/platform/x86/intel_pmc_core.h
+++ b/drivers/platform/x86/intel_pmc_core.h
@@ -198,7 +198,7 @@ enum ppfear_regs {
 #define TGL_LPM_STATUS_OFFSET			0x1C3C
 #define TGL_LPM_LIVE_STATUS_OFFSET		0x1C5C
 
-const char *lpm_modes[] = {
+const char *tgl_lpm_modes[] = {
 	"S0i2.0",
 	"S0i2.1",
 	"S0i2.2",
@@ -255,6 +255,7 @@ struct pmc_reg_map {
 	const u32 ltr_ignore_max;
 	const u32 pm_vric1_offset;
 	/* Low Power Mode registers */
+	const char **lpm_modes;
 	const u32 lpm_en_offset;
 	const u32 lpm_residency_offset;
 	const u32 lpm_status_offset;

base-commit: 267fc714cab797574a3a9df2074f05c3cdeb2511
-- 
2.17.1

