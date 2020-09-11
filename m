Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FF9C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 03:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C397F21582
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 03:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725766AbgIKDdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 23:33:16 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11809 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725300AbgIKDdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 23:33:15 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9CAF2E9ADB58E230A09D;
        Fri, 11 Sep 2020 11:33:12 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Fri, 11 Sep 2020 11:33:04 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <pgaj@cadence.com>, <bbrezillon@kernel.org>,
        <boris.brezillon@collabora.com>
CC:     <linux-i3c@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <jingxiangfeng@huawei.com>
Subject: [PATCH] i3c: master: Fix error return in cdns_i3c_master_probe()
Date:   Fri, 11 Sep 2020 11:33:50 +0800
Message-ID: <20200911033350.23904-1-jingxiangfeng@huawei.com>
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

Fix to return negative error code -ENOMEM from the error handling
case instead of 0.

Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 drivers/i3c/master/i3c-master-cdns.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master/i3c-master-cdns.c b/drivers/i3c/master/i3c-master-cdns.c
index 3fee8bd7fe20..3f2226928fe0 100644
--- a/drivers/i3c/master/i3c-master-cdns.c
+++ b/drivers/i3c/master/i3c-master-cdns.c
@@ -1635,8 +1635,10 @@ static int cdns_i3c_master_probe(struct platform_device *pdev)
 	master->ibi.slots = devm_kcalloc(&pdev->dev, master->ibi.num_slots,
 					 sizeof(*master->ibi.slots),
 					 GFP_KERNEL);
-	if (!master->ibi.slots)
+	if (!master->ibi.slots) {
+		ret = -ENOMEM;
 		goto err_disable_sysclk;
+	}
 
 	writel(IBIR_THR(1), master->regs + CMD_IBI_THR_CTRL);
 	writel(MST_INT_IBIR_THR, master->regs + MST_IER);
-- 
2.17.1

