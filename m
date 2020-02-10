Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14531C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 19:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B73D120715
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 19:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbgBJTos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 14:44:48 -0500
Received: from mga17.intel.com ([192.55.52.151]:63657 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727003AbgBJTos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 14:44:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 11:44:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,426,1574150400"; 
   d="scan'208";a="405689163"
Received: from gayuk-dev-mach.sc.intel.com ([10.3.79.171])
  by orsmga005.jf.intel.com with ESMTP; 10 Feb 2020 11:44:46 -0800
From:   Gayatri Kammela <gayatri.kammela@intel.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vishwanath.somayaji@intel.com,
        dvhart@infradead.org, mika.westerberg@intel.com,
        peterz@infradead.org, charles.d.prestopine@intel.com,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        "David E . Box" <david.e.box@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] platform/x86: intel_pmc_core: Bug: Fix the order of the parameters passed to pmc_core_lpm_display()
Date:   Mon, 10 Feb 2020 11:40:38 -0800
Message-Id: <e0564ff97744f4bf916cd59ecb0d8fdb63806229.1581361984.git.gayatri.kammela@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parameters passed to pmc_core_lpm_display() which is called by
pmc_core_resume() are not in the right order and hence will not dump the
low power status registers on an S0ix.y failure even if it is compiled
(with warnings).

Fix the bug by passing the parameters in right order.

Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Cc: David E. Box <david.e.box@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
---

Hi Andy,
The reason for not catching this bug earlier was not passing the "-Werror"
flag while compiling. I apologize for overlooking the warnings. I wanted to
send v3 of the series, but I have noticed the patch series has been merged in
to for-next branch. I have made sure, no warnings or errors are seen before
sending this fix.

 drivers/platform/x86/intel_pmc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 753d51087838..f4a36fbabf4c 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -1326,7 +1326,7 @@ static int pmc_core_resume(struct device *dev)
 	if (pmcdev->map->slps0_dbg_maps)
 		pmc_core_slps0_display(pmcdev, dev, NULL);
 	if (pmcdev->map->lpm_sts)
-		pmc_core_lpm_display(pmcdev, dev, NULL, "STATUS", offset, maps);
+		pmc_core_lpm_display(pmcdev, dev, NULL, offset, "STATUS", maps);
 
 	return 0;
 }
-- 
2.17.1

