Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E025C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C134922BEB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597678241;
	bh=kw06jVtb/jIPSntCZK3WXF6KXsRzue6VWinIXA0xhaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mO6lN3lebgNOk6LzGMfW+sfg/2p58mV54XUdOAjEnb1BJw5pt68qVg1tpsWzdZneK
	 142FPZVWNGUtlDtGNCEa/pD3lNX52zfBypMJwhmaBT522/awZLD5VHDEd9QIdSM69J
	 1Pbb0OjnwK4kG4wFALmeDPYqe7LK7k9UoYnj4pf4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730208AbgHQPak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 11:30:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:42294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730013AbgHQP2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:28:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F96923B84;
        Mon, 17 Aug 2020 15:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678094;
        bh=kw06jVtb/jIPSntCZK3WXF6KXsRzue6VWinIXA0xhaw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pEEnzWvbFhlQKSllOVE6mMo4Pnq3ovHy1z1YawBOXzY5ueodHSV8s3NUIdvI19a4s
         eoGRv7MVspvYVxVb2k2AdtzR0ya9VQCMAd8JrSqw7hhzbWOGBzOIhES9ZrfVk+M6qn
         hE3U2SKad1TD1PLrfrzjPvIA3H8a1tjSoR3hPFjw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhu Yanjun <yanjunz@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 215/464] RDMA/rxe: Skip dgid check in loopback mode
Date:   Mon, 17 Aug 2020 17:12:48 +0200
Message-Id: <20200817143844.108261185@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhu Yanjun <yanjunz@mellanox.com>

[ Upstream commit 5c99274be8864519328aa74bc550ba410095bc1c ]

In the loopback tests, the following call trace occurs.

 Call Trace:
  __rxe_do_task+0x1a/0x30 [rdma_rxe]
  rxe_qp_destroy+0x61/0xa0 [rdma_rxe]
  rxe_destroy_qp+0x20/0x60 [rdma_rxe]
  ib_destroy_qp_user+0xcc/0x220 [ib_core]
  uverbs_free_qp+0x3c/0xc0 [ib_uverbs]
  destroy_hw_idr_uobject+0x24/0x70 [ib_uverbs]
  uverbs_destroy_uobject+0x43/0x1b0 [ib_uverbs]
  uobj_destroy+0x41/0x70 [ib_uverbs]
  __uobj_get_destroy+0x39/0x70 [ib_uverbs]
  ib_uverbs_destroy_qp+0x88/0xc0 [ib_uverbs]
  ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0xb9/0xf0 [ib_uverbs]
  ib_uverbs_cmd_verbs+0xb16/0xc30 [ib_uverbs]

The root cause is that the actual RDMA connection is not created in the
loopback tests and the rxe_match_dgid will fail randomly.

To fix this call trace which appear in the loopback tests, skip check of
the dgid.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Link: https://lore.kernel.org/r/20200630123605.446959-1-leon@kernel.org
Signed-off-by: Zhu Yanjun <yanjunz@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/sw/rxe/rxe_recv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index 831ad578a7b29..46e111c218fd4 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -330,10 +330,14 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 
 static int rxe_match_dgid(struct rxe_dev *rxe, struct sk_buff *skb)
 {
+	struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
 	const struct ib_gid_attr *gid_attr;
 	union ib_gid dgid;
 	union ib_gid *pdgid;
 
+	if (pkt->mask & RXE_LOOPBACK_MASK)
+		return 0;
+
 	if (skb->protocol == htons(ETH_P_IP)) {
 		ipv6_addr_set_v4mapped(ip_hdr(skb)->daddr,
 				       (struct in6_addr *)&dgid);
@@ -366,7 +370,7 @@ void rxe_rcv(struct sk_buff *skb)
 	if (unlikely(skb->len < pkt->offset + RXE_BTH_BYTES))
 		goto drop;
 
-	if (unlikely(rxe_match_dgid(rxe, skb) < 0)) {
+	if (rxe_match_dgid(rxe, skb) < 0) {
 		pr_warn_ratelimited("failed matching dgid\n");
 		goto drop;
 	}
-- 
2.25.1



