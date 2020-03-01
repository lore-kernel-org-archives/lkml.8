Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EF3C3F2D1
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 20:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87769206CC
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 20:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgCAUse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 15:48:34 -0500
Received: from mga09.intel.com ([134.134.136.24]:58737 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbgCAUsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 15:48:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Mar 2020 12:48:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,505,1574150400"; 
   d="scan'208";a="233094869"
Received: from gayuk-dev-mach.sc.intel.com ([10.3.79.171])
  by fmsmga008.fm.intel.com with ESMTP; 01 Mar 2020 12:48:31 -0800
From:   Gayatri Kammela <gayatri.kammela@intel.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vishwanath.somayaji@intel.com,
        dvhart@infradead.org, mika.westerberg@intel.com,
        peterz@infradead.org, charles.d.prestopine@intel.com,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Chen Zhou <chenzhou10@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "David E . Box" <david.e.box@intel.com>
Subject: [PATCH v3 2/5] platform/x86: intel_pmc_core: fix: Remove the duplicate if() to create debugfs entry for substate_live_status_registers
Date:   Sun,  1 Mar 2020 12:44:23 -0800
Message-Id: <bcd8e4973f3da460410ed536c1d1bf55578a3890.1583093898.git.gayatri.kammela@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1583093898.git.gayatri.kammela@intel.com>
References: <cover.1583093898.git.gayatri.kammela@intel.com>
In-Reply-To: <cover.1583093898.git.gayatri.kammela@intel.com>
References: <cover.1583093898.git.gayatri.kammela@intel.com>
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
index 20b2f49726cf..a36051c2a18c 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -1108,9 +1108,6 @@ static void pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
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

