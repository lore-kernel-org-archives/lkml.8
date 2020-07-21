Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1684BC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F279E20709
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbgGULHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 07:07:06 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7805 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727002AbgGULHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 07:07:04 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 210774A1D073E0192DD4;
        Tue, 21 Jul 2020 19:07:02 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Tue, 21 Jul 2020 19:06:55 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <kuba@kernel.org>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net 3/4] net: hns3: fix error handling for desc filling
Date:   Tue, 21 Jul 2020 19:03:53 +0800
Message-ID: <1595329434-46766-4-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595329434-46766-1-git-send-email-tanhuazhong@huawei.com>
References: <1595329434-46766-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

The content of the TX desc is automatically cleared by the HW
when the HW has sent out the packet to the wire. When desc filling
fails in hns3_nic_net_xmit(), it will call hns3_clear_desc() to do
the error handling, which miss zeroing of the TX desc and the
checking if a unmapping is needed.

So add the zeroing and checking in hns3_clear_desc() to avoid the
above problem. Also add DESC_TYPE_UNKNOWN to indicate the info in
desc_cb is not valid, because hns3_nic_reclaim_desc() may treat
the desc_cb->type of zero as packet and add to the sent pkt
statistics accordingly.

Fixes: 76ad4f0ee747 ("net: hns3: Add support of HNS3 Ethernet Driver for hip08 SoC")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h     | 1 +
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index d041cac..088550d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -77,6 +77,7 @@
 	((ring)->p = ((ring)->p - 1 + (ring)->desc_num) % (ring)->desc_num)
 
 enum hns_desc_type {
+	DESC_TYPE_UNKNOWN,
 	DESC_TYPE_SKB,
 	DESC_TYPE_FRAGLIST_SKB,
 	DESC_TYPE_PAGE,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index a814d99..b1bea030 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1338,6 +1338,10 @@ static void hns3_clear_desc(struct hns3_enet_ring *ring, int next_to_use_orig)
 	unsigned int i;
 
 	for (i = 0; i < ring->desc_num; i++) {
+		struct hns3_desc *desc = &ring->desc[ring->next_to_use];
+
+		memset(desc, 0, sizeof(*desc));
+
 		/* check if this is where we started */
 		if (ring->next_to_use == next_to_use_orig)
 			break;
@@ -1345,6 +1349,9 @@ static void hns3_clear_desc(struct hns3_enet_ring *ring, int next_to_use_orig)
 		/* rollback one */
 		ring_ptr_move_bw(ring, next_to_use);
 
+		if (!ring->desc_cb[ring->next_to_use].dma)
+			continue;
+
 		/* unmap the descriptor dma address */
 		if (ring->desc_cb[ring->next_to_use].type == DESC_TYPE_SKB ||
 		    ring->desc_cb[ring->next_to_use].type ==
@@ -1361,6 +1368,7 @@ static void hns3_clear_desc(struct hns3_enet_ring *ring, int next_to_use_orig)
 
 		ring->desc_cb[ring->next_to_use].length = 0;
 		ring->desc_cb[ring->next_to_use].dma = 0;
+		ring->desc_cb[ring->next_to_use].type = DESC_TYPE_UNKNOWN;
 	}
 }
 
-- 
2.7.4

