Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0AAC2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 14:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 082AF2082D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 14:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgDJO1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 10:27:00 -0400
Received: from albert.telenet-ops.be ([195.130.137.90]:36832 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgDJO1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 10:27:00 -0400
Received: from ramsan ([84.195.182.253])
        by albert.telenet-ops.be with bizsmtp
        id R2Sq2200B5USYZQ062SqQ2; Fri, 10 Apr 2020 16:26:58 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jMucM-0004qD-Ci; Fri, 10 Apr 2020 16:26:50 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jMucM-0004qj-9Q; Fri, 10 Apr 2020 16:26:50 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Joerg Roedel <joro@8bytes.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] netfilter: nft_fwd_netdev: Fix CONFIG_NET_CLS_ACT=n build
Date:   Fri, 10 Apr 2020 16:26:48 +0200
Message-Id: <20200410142648.18599-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_NET_CLS_ACT=n:

    net/netfilter/nft_fwd_netdev.c: In function ‘nft_fwd_netdev_eval’:
    net/netfilter/nft_fwd_netdev.c:32:10: error: ‘struct sk_buff’ has no member named ‘tc_redirected’
      pkt->skb->tc_redirected = 1;
	      ^~
    net/netfilter/nft_fwd_netdev.c:33:10: error: ‘struct sk_buff’ has no member named ‘tc_from_ingress’
      pkt->skb->tc_from_ingress = 1;
	      ^~

Fix this by protecting this code hunk with the appropriate #ifdef.

Reported-by: noreply@ellerman.id.au
Fixes: bcfabee1afd99484 ("netfilter: nft_fwd_netdev: allow to redirect to ifb via ingress")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 net/netfilter/nft_fwd_netdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/netfilter/nft_fwd_netdev.c b/net/netfilter/nft_fwd_netdev.c
index 74f050ba6badc9dc..ebcaf5c325712f30 100644
--- a/net/netfilter/nft_fwd_netdev.c
+++ b/net/netfilter/nft_fwd_netdev.c
@@ -28,9 +28,11 @@ static void nft_fwd_netdev_eval(const struct nft_expr *expr,
 	struct nft_fwd_netdev *priv = nft_expr_priv(expr);
 	int oif = regs->data[priv->sreg_dev];
 
+#ifdef CONFIG_NET_CLS_ACT
 	/* These are used by ifb only. */
 	pkt->skb->tc_redirected = 1;
 	pkt->skb->tc_from_ingress = 1;
+#endif
 
 	nf_fwd_netdev_egress(pkt, oif);
 	regs->verdict.code = NF_STOLEN;
-- 
2.17.1

