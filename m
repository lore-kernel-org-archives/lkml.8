Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2174C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 18:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C67C62075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 18:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391710AbgAXSxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 13:53:50 -0500
Received: from mga18.intel.com ([134.134.136.126]:51262 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391680AbgAXSxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 13:53:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jan 2020 10:53:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,358,1574150400"; 
   d="scan'208";a="222692903"
Received: from unknown (HELO gayuk-dev-mach.sc.intel.com) ([10.3.79.172])
  by fmsmga008.fm.intel.com with ESMTP; 24 Jan 2020 10:53:48 -0800
From:   Gayatri Kammela <gayatri.kammela@intel.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vishwanath.somayaji@intel.com,
        dvhart@infradead.org, mika.westerberg@intel.com,
        peterz@infradead.org, charles.d.prestopine@intel.com,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Box <david.e.box@intel.com>
Subject: [PATCH v1 6/7] platform/x86: intel_pmc_core: Dump low power status registers on an S0ix.y failure
Date:   Fri, 24 Jan 2020 10:50:27 -0800
Message-Id: <e870280c057531ab26a119b444ca19d998d847a3.1579890793.git.gayatri.kammela@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1579890793.git.gayatri.kammela@intel.com>
References: <cover.1579890793.git.gayatri.kammela@intel.com>
In-Reply-To: <cover.1579890793.git.gayatri.kammela@intel.com>
References: <cover.1579890793.git.gayatri.kammela@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Platforms prior to Tiger Lake has no sub-states of S0ix and accessing
device PM states that are latched whenever there is a PC10 entry is
possible with the help of slp_s0_debug_status and slp_s0_dbg_latch
debugfs entries.

If a platform has sub-states of S0ix, no such entries are created.
Hence, dump low power status registers on resume When any attempt to
enter any low power state was unsuccessful.

Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Box <david.e.box@intel.com>
Suggested-by: David Box <david.e.box@intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
---
 drivers/platform/x86/intel_pmc_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 0018fdd0194b..92c9840b5029 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -1283,6 +1283,8 @@ static inline bool pmc_core_is_s0ix_failed(struct pmc_dev *pmcdev)
 static int pmc_core_resume(struct device *dev)
 {
 	struct pmc_dev *pmcdev = dev_get_drvdata(dev);
+	const struct pmc_bit_map **maps = pmcdev->map->lpm_sts;
+	int offset = pmcdev->map->lpm_status_offset;
 
 	if (!pmcdev->check_counters)
 		return 0;
@@ -1302,6 +1304,8 @@ static int pmc_core_resume(struct device *dev)
 		 pmcdev->s0ix_counter);
 	if (pmcdev->map->slps0_dbg_maps)
 		pmc_core_slps0_display(pmcdev, dev, NULL);
+	if (pmcdev->map->lpm_sts)
+		pmc_core_lpm_display(pmcdev, dev, NULL, "STATUS", offset, maps);
 
 	return 0;
 }
-- 
2.17.1

