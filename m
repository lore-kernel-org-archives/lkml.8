Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02B9C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0BA1206EF
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbgIAO3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:29:39 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10752 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728297AbgIAO1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 10:27:49 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 294A94EDE485CCBE6BD4;
        Tue,  1 Sep 2020 22:10:39 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Tue, 1 Sep 2020
 22:10:32 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: sungem: Remove unneeded cast from memory allocation
Date:   Tue, 1 Sep 2020 22:10:28 +0800
Message-ID: <20200901141028.25264-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove dma_alloc_coherent return value cast.
This is detected by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/sun/sungem.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/sun/sungem.c b/drivers/net/ethernet/sun/sungem.c
index eeb8518c8a84..b7093975b14c 100644
--- a/drivers/net/ethernet/sun/sungem.c
+++ b/drivers/net/ethernet/sun/sungem.c
@@ -2965,9 +2965,8 @@ static int gem_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* It is guaranteed that the returned buffer will be at least
 	 * PAGE_SIZE aligned.
 	 */
-	gp->init_block = (struct gem_init_block *)
-		dma_alloc_coherent(&pdev->dev, sizeof(struct gem_init_block),
-				   &gp->gblock_dvma, GFP_KERNEL);
+	gp->init_block = dma_alloc_coherent(&pdev->dev, sizeof(struct gem_init_block),
+					    &gp->gblock_dvma, GFP_KERNEL);
 	if (!gp->init_block) {
 		pr_err("Cannot allocate init block, aborting\n");
 		err = -ENOMEM;
-- 
2.17.1


