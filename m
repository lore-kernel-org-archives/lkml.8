Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD108C433EB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6AF620775
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595859731;
	bh=UB1WFAH0LsvRP3pR4wMVX8K7pSEkfAz9uaGlQBD04b8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G0OqXMAvIoaYRqAsKPL8h1SL9+FkepQvz4SkeW94vmCb8g8SW66b2F8eHg5dLw8V2
	 Huk5Tw9T3d7aFXcH5fhGxPD9WMd5Xh1aMriYKkUYer4k3CAu58wpCQYvB4FiSNLRLA
	 KusUTetxTM18drkYxEANK2a94/PMpNxffOj0Y/MQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731839AbgG0OWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:22:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:50934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731833AbgG0OWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:22:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C9C721775;
        Mon, 27 Jul 2020 14:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859724;
        bh=UB1WFAH0LsvRP3pR4wMVX8K7pSEkfAz9uaGlQBD04b8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LC4zaScf3dgloaNBJ1HMfoaXusieb9iA1avXkfVSYaQUvBk1+yso08XiAnMUIHuLF
         +TKx3S3C9CidhXYgS751lKZanJioVHk2IXIeHIUaLqPwusPlodIVX3MElQPehMfMfN
         e8vwi/TcJu3Krls0P9rk/XCyskJ8+Gp794oq9xi4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yunsheng Lin <linyunsheng@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 079/179] net: hns3: fix error handling for desc filling
Date:   Mon, 27 Jul 2020 16:04:14 +0200
Message-Id: <20200727134936.531272429@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134932.659499757@linuxfoundation.org>
References: <20200727134932.659499757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

[ Upstream commit 8ceca59fb3ed48a693171bd571c4fcbd555b7f1f ]

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
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h     | 1 +
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 5587605d6deb2..cc45662f77f04 100644
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
index 5dab84aa3afd5..df1cb0441183c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1351,6 +1351,10 @@ static void hns3_clear_desc(struct hns3_enet_ring *ring, int next_to_use_orig)
 	unsigned int i;
 
 	for (i = 0; i < ring->desc_num; i++) {
+		struct hns3_desc *desc = &ring->desc[ring->next_to_use];
+
+		memset(desc, 0, sizeof(*desc));
+
 		/* check if this is where we started */
 		if (ring->next_to_use == next_to_use_orig)
 			break;
@@ -1358,6 +1362,9 @@ static void hns3_clear_desc(struct hns3_enet_ring *ring, int next_to_use_orig)
 		/* rollback one */
 		ring_ptr_move_bw(ring, next_to_use);
 
+		if (!ring->desc_cb[ring->next_to_use].dma)
+			continue;
+
 		/* unmap the descriptor dma address */
 		if (ring->desc_cb[ring->next_to_use].type == DESC_TYPE_SKB ||
 		    ring->desc_cb[ring->next_to_use].type ==
@@ -1374,6 +1381,7 @@ static void hns3_clear_desc(struct hns3_enet_ring *ring, int next_to_use_orig)
 
 		ring->desc_cb[ring->next_to_use].length = 0;
 		ring->desc_cb[ring->next_to_use].dma = 0;
+		ring->desc_cb[ring->next_to_use].type = DESC_TYPE_UNKNOWN;
 	}
 }
 
-- 
2.25.1



