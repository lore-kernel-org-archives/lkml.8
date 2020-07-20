Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE065C433EA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDD8D2176B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgGTJgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 05:36:46 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8335 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728153AbgGTJgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 05:36:46 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 789F1960A3EA3503108A;
        Mon, 20 Jul 2020 17:36:42 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Mon, 20 Jul 2020 17:36:41 +0800
From:   Zhang Changzhong <zhangchangzhong@huawei.com>
To:     <opendmb@gmail.com>, <f.fainelli@gmail.com>, <davem@davemloft.net>,
        <kuba@kernel.org>
CC:     <bcm-kernel-feedback-list@broadcom.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH net] net: bcmgenet: add missed clk_disable_unprepare in bcmgenet_probe
Date:   Mon, 20 Jul 2020 17:36:34 +0800
Message-ID: <1595237794-11530-1-git-send-email-zhangchangzhong@huawei.com>
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

Fix to goto err_clk_disable if clk_prepare_enable() is successful.

Fixes: c80d36ff63a5 ("net: bcmgenet: Use devm_clk_get_optional() to get the clocks")
Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 368e05b..79d27be 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -4000,14 +4000,14 @@ static int bcmgenet_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->clk_wol)) {
 		dev_dbg(&priv->pdev->dev, "failed to get enet-wol clock\n");
 		err = PTR_ERR(priv->clk_wol);
-		goto err;
+		goto err_clk_disable;
 	}
 
 	priv->clk_eee = devm_clk_get_optional(&priv->pdev->dev, "enet-eee");
 	if (IS_ERR(priv->clk_eee)) {
 		dev_dbg(&priv->pdev->dev, "failed to get enet-eee clock\n");
 		err = PTR_ERR(priv->clk_eee);
-		goto err;
+		goto err_clk_disable;
 	}
 
 	/* If this is an internal GPHY, power it on now, before UniMAC is
-- 
1.8.3.1

