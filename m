Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5DBC2BA80
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3CBF20730
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgDIJew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 05:34:52 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52750 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726571AbgDIJew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 05:34:52 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3AF08A7135E5C9A07FE2;
        Thu,  9 Apr 2020 17:34:36 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Thu, 9 Apr 2020
 17:34:26 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <khuong@os.amperecomputing.com>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rrichter@marvell.com>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH v2] EDAC, xgene: remove set but not used 'address'
Date:   Thu, 9 Apr 2020 17:32:59 +0800
Message-ID: <20200409093259.20069-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following gcc warning:

drivers/edac/xgene_edac.c:1486:7: warning: variable ‘address’ set but
not used [-Wunused-but-set-variable]
   u32 address;
       ^~~~~~~
And remove the unused macro RBERRADDR_RD after that.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/edac/xgene_edac.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/edac/xgene_edac.c b/drivers/edac/xgene_edac.c
index e4a1032ba0b5..1d2c27a00a4a 100644
--- a/drivers/edac/xgene_edac.c
+++ b/drivers/edac/xgene_edac.c
@@ -1349,7 +1349,6 @@ static int xgene_edac_l3_remove(struct xgene_edac_dev_ctx *l3)
 #define WORD_ALIGNED_ERR_MASK		BIT(28)
 #define PAGE_ACCESS_ERR_MASK		BIT(27)
 #define WRITE_ACCESS_MASK		BIT(26)
-#define RBERRADDR_RD(src)		((src) & 0x03FFFFFF)
 
 static const char * const soc_mem_err_v1[] = {
 	"10GbE0",
@@ -1483,13 +1482,11 @@ static void xgene_edac_rb_report(struct edac_device_ctl_info *edac_dev)
 		return;
 	if (reg & STICKYERR_MASK) {
 		bool write;
-		u32 address;
 
 		dev_err(edac_dev->dev, "IOB bus access error(s)\n");
 		if (regmap_read(ctx->edac->rb_map, RBEIR, &reg))
 			return;
 		write = reg & WRITE_ACCESS_MASK ? 1 : 0;
-		address = RBERRADDR_RD(reg);
 		if (reg & AGENT_OFFLINE_ERR_MASK)
 			dev_err(edac_dev->dev,
 				"IOB bus %s access to offline agent error\n",
-- 
2.17.2

