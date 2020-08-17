Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E498C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1043C204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597692161;
	bh=WxgjWm+17kWfbBeEqTPv9ro/CB/BcaiuTpMcA4n0tTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o1Njav6y1nRrcho0EDbWPkJZN6XfppZPBC+VS+9gfBxK10ixHti4UGkAIqogKAc8I
	 LflzS6qvy10DGySXhL/y69+iOKuof0ZqfwWBj8VbIxV9+OnA/awKM7+E7IVqgfspZT
	 nKDH8h/ZsE81qRFZjEwJ/J4grc1jxlV5p4wVYh6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392457AbgHQTWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:22:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:42624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387397AbgHQPfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:35:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8679220882;
        Mon, 17 Aug 2020 15:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678542;
        bh=WxgjWm+17kWfbBeEqTPv9ro/CB/BcaiuTpMcA4n0tTI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=moN69rNUKtJfRjYk8Ekk+3WMiqXpmnDJRZ1qMQf9okHwrnoS6QL4LgSKzV04V0bK+
         4A4NPPMFi1huEa3h6qro3P9I5hIUfGZNhwI7YoZOHh6T+vUCFndsqQjWsTKGV1v1bu
         ZIgvNLExYV2tUAKDK4CPfRhM0gBVAwQxiIJcB0MY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hangbin Liu <liuhangbin@gmail.com>,
        Guillaume Nault <gnault@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 370/464] Revert "vxlan: fix tos value before xmit"
Date:   Mon, 17 Aug 2020 17:15:23 +0200
Message-Id: <20200817143851.496482411@linuxfoundation.org>
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

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit a0dced17ad9dc08b1b25e0065b54c97a318e6e8b ]

This reverts commit 71130f29979c7c7956b040673e6b9d5643003176.

In commit 71130f29979c ("vxlan: fix tos value before xmit") we want to
make sure the tos value are filtered by RT_TOS() based on RFC1349.

       0     1     2     3     4     5     6     7
    +-----+-----+-----+-----+-----+-----+-----+-----+
    |   PRECEDENCE    |          TOS          | MBZ |
    +-----+-----+-----+-----+-----+-----+-----+-----+

But RFC1349 has been obsoleted by RFC2474. The new DSCP field defined like

       0     1     2     3     4     5     6     7
    +-----+-----+-----+-----+-----+-----+-----+-----+
    |          DS FIELD, DSCP           | ECN FIELD |
    +-----+-----+-----+-----+-----+-----+-----+-----+

So with

IPTOS_TOS_MASK          0x1E
RT_TOS(tos)		((tos)&IPTOS_TOS_MASK)

the first 3 bits DSCP info will get lost.

To take all the DSCP info in xmit, we should revert the patch and just push
all tos bits to ip_tunnel_ecn_encap(), which will handling ECN field later.

Fixes: 71130f29979c ("vxlan: fix tos value before xmit")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Acked-by: Guillaume Nault <gnault@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/vxlan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index a7c3939264b00..35a7d409d8d36 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -2722,7 +2722,7 @@ static void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		ndst = &rt->dst;
 		skb_tunnel_check_pmtu(skb, ndst, VXLAN_HEADROOM);
 
-		tos = ip_tunnel_ecn_encap(RT_TOS(tos), old_iph, skb);
+		tos = ip_tunnel_ecn_encap(tos, old_iph, skb);
 		ttl = ttl ? : ip4_dst_hoplimit(&rt->dst);
 		err = vxlan_build_skb(skb, ndst, sizeof(struct iphdr),
 				      vni, md, flags, udp_sum);
@@ -2762,7 +2762,7 @@ static void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 
 		skb_tunnel_check_pmtu(skb, ndst, VXLAN6_HEADROOM);
 
-		tos = ip_tunnel_ecn_encap(RT_TOS(tos), old_iph, skb);
+		tos = ip_tunnel_ecn_encap(tos, old_iph, skb);
 		ttl = ttl ? : ip6_dst_hoplimit(ndst);
 		skb_scrub_packet(skb, xnet);
 		err = vxlan_build_skb(skb, ndst, sizeof(struct ipv6hdr),
-- 
2.25.1



