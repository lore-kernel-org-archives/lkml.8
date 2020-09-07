Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8AAC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 13:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07B8121481
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 13:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbgIGNGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 09:06:14 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59776 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729318AbgIGNDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 09:03:10 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 10F611C9B9968BC436E5;
        Mon,  7 Sep 2020 21:03:07 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Mon, 7 Sep 2020 21:03:03 +0800
From:   Zhang Changzhong <zhangchangzhong@huawei.com>
To:     <radhey.shyam.pandey@xilinx.com>, <davem@davemloft.net>,
        <kuba@kernel.org>, <michal.simek@xilinx.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] net: xilinx: remove redundant null check before clk_disable_unprepare()
Date:   Mon, 7 Sep 2020 21:02:03 +0800
Message-ID: <1599483723-43704-1-git-send-email-zhangchangzhong@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.70]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because clk_prepare_enable() and clk_disable_unprepare() already checked
NULL clock parameter, so the additional checks are unnecessary, just
remove them.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>
---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index fa5dc299..9aafd3e 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -2038,8 +2038,7 @@ static int axienet_remove(struct platform_device *pdev)
 
 	axienet_mdio_teardown(lp);
 
-	if (lp->clk)
-		clk_disable_unprepare(lp->clk);
+	clk_disable_unprepare(lp->clk);
 
 	of_node_put(lp->phy_node);
 	lp->phy_node = NULL;
-- 
2.9.5

