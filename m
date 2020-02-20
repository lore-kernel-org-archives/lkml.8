Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3998C5ACC4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 03:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B207E206E2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 03:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgBTDkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 22:40:13 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10654 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727476AbgBTDkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 22:40:13 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4F7AF69BE5179A3B8D1E;
        Thu, 20 Feb 2020 11:40:11 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Thu, 20 Feb 2020 11:40:03 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <rajneesh.bhardwaj@intel.com>, <vishwanath.somayaji@intel.com>
CC:     <dvhart@infradead.org>, <andy@infradead.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <chenzhou10@huawei.com>
Subject: [PATCH -next] platform/x86: intel_pmc_core: fix build error without CONFIG_DEBUG_FS
Date:   Thu, 20 Feb 2020 11:33:35 +0800
Message-ID: <20200220033335.106963-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_DEBUG_FS is n, build fails:

drivers/platform/x86/intel_pmc_core.c: In function pmc_core_resume:
drivers/platform/x86/intel_pmc_core.c:1327:3: error: implicit declaration of function pmc_core_slps0_display; did you mean pmc_core_is_pc10_failed? [-Werror=implicit-function-declaration]
   pmc_core_slps0_display(pmcdev, dev, NULL);
      ^~~~~~~~~~~~~~~~~~~~~~

Function pmc_core_slps0_display() is responsible for displaying debug
registers, which is under CONFIG_DEBUG_FS.

Providing the static inline stub whenever CONFIG_DEBUG_FS is disabled
to fix this. Function pmc_core_lpm_display() is the same.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 drivers/platform/x86/intel_pmc_core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index f4a36fb..939f8e0 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -1117,6 +1117,20 @@ static void pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
 	}
 }
 #else
+static inline void pmc_core_slps0_display(struct pmc_dev *pmcdev,
+					   struct device *dev,
+					   struct seq_file *s)
+{
+}
+
+static inline void pmc_core_lpm_display(struct pmc_dev *pmcdev,
+					 struct device *dev,
+					 struct seq_file *s, u32 offset,
+					 const char *str,
+					 const struct pmc_bit_map **maps)
+{
+}
+
 static inline void pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
 {
 }
-- 
2.7.4

