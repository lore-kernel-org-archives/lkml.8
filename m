Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24401C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E579B222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579864027;
	bh=Ce6RWmWFGSyumQt6jlJtqZiKhdFfjizz0H4LJ73SCgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=efVf26FhsEJRDLQdZwF2IkKEs1I3I3UXG6ORuJ3Vd8nEJKm0iJ7kbaWnwcKLZd/Is
	 oUlApX3K7m0oHK8c87R2gk+3/9QEYsFnb/93F5H9oIbQvBG8FQPTlTunAOdSyaU14v
	 mGWKrxYD1o3PhMZJpq1ynnD+9V/homqjggrW/PLM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389411AbgAXLHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:07:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:42100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389390AbgAXLHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:07:03 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABA5320663;
        Fri, 24 Jan 2020 11:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864023;
        bh=Ce6RWmWFGSyumQt6jlJtqZiKhdFfjizz0H4LJ73SCgs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eYXvMSgchjq41LWM6fU3XjU6UTtce1eX+A0rD3rP5RTwp3GBcrkGpy3HUZftiRbWO
         ook3B04HQoG5Y984aWth1DVBTNJur3Uu9Lk5UE5QhT71d89Zwb8LsensMcIVhfKlSB
         njxc4m52/IYp9c5/BbSDvm+qMha1Ozh1eYdWzB2I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, wenxu <wenxu@ucloud.cn>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 150/639] ip_tunnel: Fix route fl4 init in ip_md_tunnel_xmit
Date:   Fri, 24 Jan 2020 10:25:20 +0100
Message-Id: <20200124093106.023860956@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

[ Upstream commit 6e6b904ad4f9aed43ec320afbd5a52ed8461ab41 ]

Init the gre_key from tuninfo->key.tun_id and init the mark
from the skb->mark, set the oif to zero in the collect metadata
mode.

Fixes: cfc7381b3002 ("ip_tunnel: add collect_md mode to IPIP tunnel")
Signed-off-by: wenxu <wenxu@ucloud.cn>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/ip_tunnel.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 420e891ac59da..f03a1b68e70f0 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -574,8 +574,9 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev, u8 proto)
 		else if (skb->protocol == htons(ETH_P_IPV6))
 			tos = ipv6_get_dsfield((const struct ipv6hdr *)inner_iph);
 	}
-	ip_tunnel_init_flow(&fl4, proto, key->u.ipv4.dst, key->u.ipv4.src, 0,
-			    RT_TOS(tos), tunnel->parms.link, tunnel->fwmark);
+	ip_tunnel_init_flow(&fl4, proto, key->u.ipv4.dst, key->u.ipv4.src,
+			    tunnel_id_to_key32(key->tun_id), RT_TOS(tos),
+			    0, skb->mark);
 	if (tunnel->encap.type != TUNNEL_ENCAP_NONE)
 		goto tx_error;
 	rt = ip_route_output_key(tunnel->net, &fl4);
-- 
2.20.1



