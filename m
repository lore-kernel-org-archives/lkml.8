Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1700BC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 08:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE1A02068E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 08:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbgEEIoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 04:44:12 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49230 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725320AbgEEIoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 04:44:11 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D6267BAFC2BFCA050289;
        Tue,  5 May 2020 16:44:05 +0800 (CST)
Received: from localhost (10.166.215.154) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Tue, 5 May 2020
 16:43:56 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <christopher.lee@cspi.com>, <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] myri10ge: Remove unused inline function myri10ge_vlan_ip_csum
Date:   Tue, 5 May 2020 16:43:39 +0800
Message-ID: <20200505084339.50820-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.166.215.154]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 4ca3221fe4b6 ("myri10ge: Convert from LRO to GRO")
left behind this, remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/myricom/myri10ge/myri10ge.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/net/ethernet/myricom/myri10ge/myri10ge.c b/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
index 2616fd735aab..e1e1f4e3639e 100644
--- a/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
+++ b/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
@@ -1174,18 +1174,6 @@ myri10ge_submit_8rx(struct mcp_kreq_ether_recv __iomem * dst,
 	mb();
 }
 
-static inline void myri10ge_vlan_ip_csum(struct sk_buff *skb, __wsum hw_csum)
-{
-	struct vlan_hdr *vh = (struct vlan_hdr *)(skb->data);
-
-	if ((skb->protocol == htons(ETH_P_8021Q)) &&
-	    (vh->h_vlan_encapsulated_proto == htons(ETH_P_IP) ||
-	     vh->h_vlan_encapsulated_proto == htons(ETH_P_IPV6))) {
-		skb->csum = hw_csum;
-		skb->ip_summed = CHECKSUM_COMPLETE;
-	}
-}
-
 static void
 myri10ge_alloc_rx_pages(struct myri10ge_priv *mgp, struct myri10ge_rx_buf *rx,
 			int bytes, int watchdog)
-- 
2.17.1


