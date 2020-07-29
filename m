Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0A3C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4FD02070B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgG2M3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 08:29:01 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8852 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726054AbgG2M3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 08:29:01 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 50D97E8CFB5032563D5B;
        Wed, 29 Jul 2020 20:28:57 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Wed, 29 Jul 2020
 20:28:46 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <ludovic.desroches@microchip.com>, <tudor.ambarus@microchip.com>,
        <vkoul@kernel.org>, <dan.j.williams@intel.com>, <arnd@arndb.de>,
        <nicolas.ferre@microchip.com>, <plagnioj@jcrosoft.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH] dmaengine: at_hdmac: do exception handling appropriately in at_dma_xlate()
Date:   Wed, 29 Jul 2020 20:29:03 +0800
Message-ID: <20200729122903.2473297-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do several things for exception handing:

a. check return value of of_find_device_by_node().
b. call put_device() if memory allocation for 'atslave' failed.
c. if dma_request_channel() failed, call put_device() and kfree().

Fixes: bbe89c8e3d59 ("at_hdmac: move to generic DMA binding")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/dma/at_hdmac.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 45bbcd6146fd..a2cf25c6e3b3 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -1650,13 +1650,17 @@ static struct dma_chan *at_dma_xlate(struct of_phandle_args *dma_spec,
 		return NULL;
 
 	dmac_pdev = of_find_device_by_node(dma_spec->np);
+	if (!dmac_pdev)
+		return NULL;
 
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
 	atslave = kmalloc(sizeof(*atslave), GFP_KERNEL);
-	if (!atslave)
+	if (!atslave) {
+		put_device(&dmac_pdev->dev);
 		return NULL;
+	}
 
 	atslave->cfg = ATC_DST_H2SEL_HW | ATC_SRC_H2SEL_HW;
 	/*
@@ -1685,8 +1689,11 @@ static struct dma_chan *at_dma_xlate(struct of_phandle_args *dma_spec,
 	atslave->dma_dev = &dmac_pdev->dev;
 
 	chan = dma_request_channel(mask, at_dma_filter, atslave);
-	if (!chan)
+	if (!chan) {
+		put_device(&dmac_pdev->dev);
+		kfree(atslave);
 		return NULL;
+	}
 
 	atchan = to_at_dma_chan(chan);
 	atchan->per_if = dma_spec->args[0] & 0xff;
-- 
2.25.4

