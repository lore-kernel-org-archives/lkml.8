Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E695C3524B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 23:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34E321582
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 23:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbgBDXE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 18:04:57 -0500
Received: from mga01.intel.com ([192.55.52.88]:22705 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727412AbgBDXEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 18:04:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2020 15:04:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,403,1574150400"; 
   d="scan'208";a="264017996"
Received: from unknown (HELO gayuk-dev-mach.sc.intel.com) ([10.3.79.172])
  by fmsmga002.fm.intel.com with ESMTP; 04 Feb 2020 15:04:55 -0800
From:   Gayatri Kammela <gayatri.kammela@intel.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vishwanath.somayaji@intel.com,
        dvhart@infradead.org, mika.westerberg@intel.com,
        peterz@infradead.org, charles.d.prestopine@intel.com,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Box <david.e.box@intel.com>
Subject: [PATCH v2 4/7] platform/x86: intel_pmc_core: Remove slp_s0 attributes from tgl_reg_map
Date:   Tue,  4 Feb 2020 15:01:57 -0800
Message-Id: <2a29abb24e648c10121c52eeb6902993e139e092.1580848931.git.gayatri.kammela@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1580848931.git.gayatri.kammela@intel.com>
References: <cover.1580848931.git.gayatri.kammela@intel.com>
In-Reply-To: <cover.1580848931.git.gayatri.kammela@intel.com>
References: <cover.1580848931.git.gayatri.kammela@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If platforms such as Tiger Lake has sub-states of S0ix, then both
slp_s0_debug_status and slp_s0_dbg_latch entries become invalid. Thus,
remove slp_s0_offset and slp_s0_dbg_maps attributes from tgl_reg_map, so
that both the entries are not created.

Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Box <david.e.box@intel.com>
Suggested-by: David Box <david.e.box@intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
---
 drivers/platform/x86/intel_pmc_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 9c66f253cf2b..a7394cfc4906 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -556,8 +556,6 @@ static const struct pmc_bit_map *tgl_lpm_maps[] = {
 
 static const struct pmc_reg_map tgl_reg_map = {
 	.pfear_sts = ext_tgl_pfear_map,
-	.slp_s0_offset = CNP_PMC_SLP_S0_RES_COUNTER_OFFSET,
-	.slps0_dbg_maps = cnp_slps0_dbg_maps,
 	.ltr_show_sts = cnp_ltr_show_map,
 	.msr_sts = msr_map,
 	.slps0_dbg_offset = CNP_PMC_SLPS0_DBG_OFFSET,
-- 
2.17.1

