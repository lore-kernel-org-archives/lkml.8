Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC5EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7F8420704
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgGQIBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 04:01:23 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49170 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726198AbgGQIBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 04:01:23 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 17F7466E5BAB4079F98A;
        Fri, 17 Jul 2020 16:01:21 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 17 Jul 2020 16:01:19 +0800
From:   Zhang Changzhong <zhangchangzhong@huawei.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>,
        <kuba@kernel.org>, <faber@faberman.de>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] can: mscan: simplify clock enable/disable
Date:   Fri, 17 Jul 2020 16:01:15 +0800
Message-ID: <1594972875-27631-1-git-send-email-zhangchangzhong@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.70]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the NULL checks are pointless, clk_*() routines already deal with
NULL just fine.

Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>
---
 drivers/net/can/mscan/mscan.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/net/can/mscan/mscan.c b/drivers/net/can/mscan/mscan.c
index 99101d7..d4390b6 100644
--- a/drivers/net/can/mscan/mscan.c
+++ b/drivers/net/can/mscan/mscan.c
@@ -540,16 +540,12 @@ static int mscan_open(struct net_device *dev)
 	struct mscan_priv *priv = netdev_priv(dev);
 	struct mscan_regs __iomem *regs = priv->reg_base;
 
-	if (priv->clk_ipg) {
-		ret = clk_prepare_enable(priv->clk_ipg);
-		if (ret)
-			goto exit_retcode;
-	}
-	if (priv->clk_can) {
-		ret = clk_prepare_enable(priv->clk_can);
-		if (ret)
-			goto exit_dis_ipg_clock;
-	}
+	ret = clk_prepare_enable(priv->clk_ipg);
+	if (ret)
+		goto exit_retcode;
+	ret = clk_prepare_enable(priv->clk_can);
+	if (ret)
+		goto exit_dis_ipg_clock;
 
 	/* common open */
 	ret = open_candev(dev);
@@ -583,11 +579,9 @@ static int mscan_open(struct net_device *dev)
 	napi_disable(&priv->napi);
 	close_candev(dev);
 exit_dis_can_clock:
-	if (priv->clk_can)
-		clk_disable_unprepare(priv->clk_can);
+	clk_disable_unprepare(priv->clk_can);
 exit_dis_ipg_clock:
-	if (priv->clk_ipg)
-		clk_disable_unprepare(priv->clk_ipg);
+	clk_disable_unprepare(priv->clk_ipg);
 exit_retcode:
 	return ret;
 }
@@ -606,10 +600,8 @@ static int mscan_close(struct net_device *dev)
 	close_candev(dev);
 	free_irq(dev->irq, dev);
 
-	if (priv->clk_can)
-		clk_disable_unprepare(priv->clk_can);
-	if (priv->clk_ipg)
-		clk_disable_unprepare(priv->clk_ipg);
+	clk_disable_unprepare(priv->clk_can);
+	clk_disable_unprepare(priv->clk_ipg);
 
 	return 0;
 }
-- 
1.8.3.1

