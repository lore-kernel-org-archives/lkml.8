Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18285C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 02:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA52D222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 02:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgB0Crq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 21:47:46 -0500
Received: from mga05.intel.com ([192.55.52.43]:47772 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728173AbgB0Crc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 21:47:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 18:47:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,490,1574150400"; 
   d="scan'208";a="438670600"
Received: from gayuk-dev-mach.sc.intel.com ([10.3.79.171])
  by fmsmga006.fm.intel.com with ESMTP; 26 Feb 2020 18:47:31 -0800
From:   Gayatri Kammela <gayatri.kammela@intel.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vishwanath.somayaji@intel.com,
        dvhart@infradead.org, mika.westerberg@intel.com,
        peterz@infradead.org, charles.d.prestopine@intel.com,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Chen Zhou <chenzhou10@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "David E . Box" <david.e.box@intel.com>
Subject: [PATCH v1 1/4] platform/x86: intel_pmc_core: fix: Make pmc_core_lpm_display() generic for platforms that support sub-states
Date:   Wed, 26 Feb 2020 18:43:27 -0800
Message-Id: <4ed31a98bbb65717f5182f6d512dd4df80c78272.1582770011.git.gayatri.kammela@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1582770011.git.gayatri.kammela@intel.com>
References: <cover.1582770011.git.gayatri.kammela@intel.com>
In-Reply-To: <cover.1582770011.git.gayatri.kammela@intel.com>
References: <cover.1582770011.git.gayatri.kammela@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently pmc_core_lpm_display() uses array of struct pointers i.e.,
tgl_lpm_maps for Tiger Lake directly to iterate through and to get the
number of status/live status registers which is hardcoded and will not
work for future platforms that support sub-states. To maintain
readability, make pmc_core_lpm_display() generic, so that it can re-used
for future platforms.

Cc: Chen Zhou <chenzhou10@huawei.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David E. Box <david.e.box@intel.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
---
 drivers/platform/x86/intel_pmc_core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index f4a36fbabf4c..333c6963d270 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -979,10 +979,14 @@ static void pmc_core_lpm_display(struct pmc_dev *pmcdev, struct device *dev,
 				 const char *str,
 				 const struct pmc_bit_map **maps)
 {
-	u32 lpm_regs[ARRAY_SIZE(tgl_lpm_maps)-1];
-	int index, idx, len = 32, bit_mask;
+	int index, idx, len = 32, bit_mask, arr_size = 0;
 
-	for (index = 0; tgl_lpm_maps[index]; index++) {
+	for (index = 0; maps[index]; index++)
+		arr_size++;
+
+	u32 lpm_regs[arr_size];
+
+	for (index = 0; maps[index]; index++) {
 		lpm_regs[index] = pmc_core_reg_read(pmcdev, offset);
 		offset += 4;
 	}
-- 
2.17.1

