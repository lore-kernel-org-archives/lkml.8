Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6FFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 02:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCA4220709
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 02:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgHSCfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 22:35:22 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33778 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726982AbgHSCfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 22:35:22 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CBDD3FADFBFB5252C158;
        Wed, 19 Aug 2020 10:35:19 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Wed, 19 Aug 2020
 10:35:18 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <ulli.kroll@googlemail.com>, <linus.walleij@linaro.org>,
        <davem@davemloft.net>, <kuba@kernel.org>, <mirq-linux@rere.qmqm.pl>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH net v2] net: gemini: Fix missing free_netdev() in error path of gemini_ethernet_port_probe()
Date:   Wed, 19 Aug 2020 10:33:09 +0800
Message-ID: <20200819023309.31331-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace alloc_etherdev_mq with devm_alloc_etherdev_mqs. In this way,
when probe fails, netdev can be freed automatically.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
v1->v2: Make use of devm_alloc_etherdev_mqs() to simplify the code
 drivers/net/ethernet/cortina/gemini.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 66e67b24a887..62e271aea4a5 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -2389,7 +2389,7 @@ static int gemini_ethernet_port_probe(struct platform_device *pdev)
 
 	dev_info(dev, "probe %s ID %d\n", dev_name(dev), id);
 
-	netdev = alloc_etherdev_mq(sizeof(*port), TX_QUEUE_NUM);
+	netdev = devm_alloc_etherdev_mqs(dev, sizeof(*port), TX_QUEUE_NUM, TX_QUEUE_NUM);
 	if (!netdev) {
 		dev_err(dev, "Can't allocate ethernet device #%d\n", id);
 		return -ENOMEM;
@@ -2521,7 +2521,6 @@ static int gemini_ethernet_port_probe(struct platform_device *pdev)
 	}
 
 	port->netdev = NULL;
-	free_netdev(netdev);
 	return ret;
 }
 
@@ -2530,7 +2529,6 @@ static int gemini_ethernet_port_remove(struct platform_device *pdev)
 	struct gemini_ethernet_port *port = platform_get_drvdata(pdev);
 
 	gemini_port_remove(port);
-	free_netdev(port->netdev);
 	return 0;
 }
 
-- 
2.17.1

