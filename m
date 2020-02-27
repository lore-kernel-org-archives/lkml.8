Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B04C3F2C6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 23:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25F77246A4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 23:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbgB0XdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 18:33:23 -0500
Received: from mga12.intel.com ([192.55.52.136]:32153 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730071AbgB0XdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 18:33:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 15:33:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,493,1574150400"; 
   d="scan'208";a="261672768"
Received: from gayuk-dev-mach.sc.intel.com ([10.3.79.171])
  by fmsmga004.fm.intel.com with ESMTP; 27 Feb 2020 15:33:21 -0800
From:   Gayatri Kammela <gayatri.kammela@intel.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vishwanath.somayaji@intel.com,
        dvhart@infradead.org, mika.westerberg@intel.com,
        peterz@infradead.org, charles.d.prestopine@intel.com,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Chen Zhou <chenzhou10@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "David E . Box" <david.e.box@intel.com>
Subject: [PATCH v2 3/4] platform/x86: intel_pmc_core: fix: Remove the duplicate if() to create debugfs entry for substate_live_status_registers
Date:   Thu, 27 Feb 2020 15:29:15 -0800
Message-Id: <e0c594f0a09dc2458f038b90bb0c436ff29ab4bb.1582845395.git.gayatri.kammela@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1582845395.git.gayatri.kammela@intel.com>
References: <cover.1582845395.git.gayatri.kammela@intel.com>
In-Reply-To: <cover.1582845395.git.gayatri.kammela@intel.com>
References: <cover.1582845395.git.gayatri.kammela@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A debugfs entry for substate_live_status_registers is created only if
the platform has sub-states, which requires the same condition to create
substate_status_registers debugfs entry. Hence remove the redundant
condition and re-use the exisiting one.

Cc: Chen Zhou <chenzhou10@huawei.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David E. Box <david.e.box@intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
---
 drivers/platform/x86/intel_pmc_core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 3f000b6c8d8e..f6cc80987257 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -1121,9 +1121,6 @@ static void pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
 		debugfs_create_file("substate_status_registers", 0444,
 				    pmcdev->dbgfs_dir, pmcdev,
 				    &pmc_core_substate_sts_regs_fops);
-	}
-
-	if (pmcdev->map->lpm_status_offset) {
 		debugfs_create_file("substate_live_status_registers", 0444,
 				    pmcdev->dbgfs_dir, pmcdev,
 				    &pmc_core_substate_l_sts_regs_fops);
-- 
2.17.1

