Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D29C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23CEA20704
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgGQIEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 04:04:54 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7778 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726233AbgGQIEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 04:04:53 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 53DCEEDD0FC8870816BE;
        Fri, 17 Jul 2020 16:04:45 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 17 Jul 2020 16:04:41 +0800
From:   Zhang Changzhong <zhangchangzhong@huawei.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>,
        <kuba@kernel.org>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v2] can: ti_hecc: add missed clk_disable_unprepare() in error path
Date:   Fri, 17 Jul 2020 16:04:39 +0800
Message-ID: <1594973079-27743-1-git-send-email-zhangchangzhong@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.70]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver forgets to call clk_disable_unprepare() in error path after
a success calling for clk_prepare_enable().

Fix it by adding a clk_disable_unprepare() in error path.

Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>
---
 drivers/net/can/ti_hecc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index 94b1491..228ecd4 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -950,7 +950,7 @@ static int ti_hecc_probe(struct platform_device *pdev)
 	err = clk_prepare_enable(priv->clk);
 	if (err) {
 		dev_err(&pdev->dev, "clk_prepare_enable() failed\n");
-		goto probe_exit_clk;
+		goto probe_exit_release_clk;
 	}
 
 	priv->offload.mailbox_read = ti_hecc_mailbox_read;
@@ -959,7 +959,7 @@ static int ti_hecc_probe(struct platform_device *pdev)
 	err = can_rx_offload_add_timestamp(ndev, &priv->offload);
 	if (err) {
 		dev_err(&pdev->dev, "can_rx_offload_add_timestamp() failed\n");
-		goto probe_exit_clk;
+		goto probe_exit_disable_clk;
 	}
 
 	err = register_candev(ndev);
@@ -977,7 +977,9 @@ static int ti_hecc_probe(struct platform_device *pdev)
 
 probe_exit_offload:
 	can_rx_offload_del(&priv->offload);
-probe_exit_clk:
+probe_exit_disable_clk:
+	clk_disable_unprepare(priv->clk);
+probe_exit_release_clk:
 	clk_put(priv->clk);
 probe_exit_candev:
 	free_candev(ndev);
-- 
1.8.3.1

