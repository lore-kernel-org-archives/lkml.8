Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B73EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 14:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E83CA206DA
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 14:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgHCOLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 10:11:05 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9322 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728258AbgHCOLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 10:11:04 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5974070981FE9D8A1FCC;
        Mon,  3 Aug 2020 22:10:58 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Mon, 3 Aug 2020
 22:10:48 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <dan.j.williams@intel.com>, <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] dmaengine: iop-adma: Fix -Wint-to-pointer-cast build warning
Date:   Mon, 3 Aug 2020 22:10:35 +0800
Message-ID: <20200803141035.45284-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/dma/iop-adma.c:447:13: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
drivers/dma/iop-adma.c:449:4: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
drivers/dma/iop-adma.c:1301:3: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]

Use void* for dma_desc_pool_virt, dma_addr_t for dma_desc_pool,
and use %pad to print dma_addr_t.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/dma/iop-adma.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/iop-adma.c b/drivers/dma/iop-adma.c
index 3350bffb2e93..8e17e4405959 100644
--- a/drivers/dma/iop-adma.c
+++ b/drivers/dma/iop-adma.c
@@ -415,7 +415,8 @@ static void iop_chan_start_null_xor(struct iop_adma_chan *iop_chan);
  * */
 static int iop_adma_alloc_chan_resources(struct dma_chan *chan)
 {
-	char *hw_desc;
+	void *hw_desc;
+	dma_addr_t dma_desc;
 	int idx;
 	struct iop_adma_chan *iop_chan = to_iop_adma_chan(chan);
 	struct iop_adma_desc_slot *slot = NULL;
@@ -436,17 +437,16 @@ static int iop_adma_alloc_chan_resources(struct dma_chan *chan)
 				" %d descriptor slots", idx);
 			break;
 		}
-		hw_desc = (char *) iop_chan->device->dma_desc_pool_virt;
-		slot->hw_desc = (void *) &hw_desc[idx * IOP_ADMA_SLOT_SIZE];
+		hw_desc = iop_chan->device->dma_desc_pool_virt;
+		slot->hw_desc = hw_desc + idx * IOP_ADMA_SLOT_SIZE;
 
 		dma_async_tx_descriptor_init(&slot->async_tx, chan);
 		slot->async_tx.tx_submit = iop_adma_tx_submit;
 		INIT_LIST_HEAD(&slot->tx_list);
 		INIT_LIST_HEAD(&slot->chain_node);
 		INIT_LIST_HEAD(&slot->slot_node);
-		hw_desc = (char *) iop_chan->device->dma_desc_pool;
-		slot->async_tx.phys =
-			(dma_addr_t) &hw_desc[idx * IOP_ADMA_SLOT_SIZE];
+		dma_desc = iop_chan->device->dma_desc_pool;
+		slot->async_tx.phys = dma_desc + idx * IOP_ADMA_SLOT_SIZE;
 		slot->idx = idx;
 
 		spin_lock_bh(&iop_chan->lock);
@@ -1296,9 +1296,8 @@ static int iop_adma_probe(struct platform_device *pdev)
 		goto err_free_adev;
 	}
 
-	dev_dbg(&pdev->dev, "%s: allocated descriptor pool virt %p phys %p\n",
-		__func__, adev->dma_desc_pool_virt,
-		(void *) adev->dma_desc_pool);
+	dev_dbg(&pdev->dev, "%s: allocated descriptor pool virt %p phys %pad\n",
+		__func__, adev->dma_desc_pool_virt, &adev->dma_desc_pool);
 
 	adev->id = plat_data->hw_id;
 
-- 
2.17.1


