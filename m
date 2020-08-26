Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A47C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC7AF20838
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598443627;
	bh=2XcRTPsVP0VTGwPPOvpblCyH0VPcg1tQYmW4aYRN1pw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tzgWlhX5idqJkZAgZ+gmhUjDq51VvAK901kwWZWkDYuePbCQqbqxI26J67wOi3DPS
	 jFbqjyYrRwRT+cQITtXnU+GcYOeOxR2JDbBwTot9Spc3iw6p0A/V+qIj7wOVuoYvz0
	 1/mNT5/vodsRokR111kLP4KpNrIPSkpcWH5/JJRI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbgHZMHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 08:07:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:38178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729514AbgHZMDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 08:03:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D053D20838;
        Wed, 26 Aug 2020 12:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598443397;
        bh=2XcRTPsVP0VTGwPPOvpblCyH0VPcg1tQYmW4aYRN1pw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lf9YvBsYjUm5+vr9iqugjwySfuUxEdzv+6SVDwM6wJjx8dIILaqN2K5Xs+0ClAOoq
         markfA2px1hR+kkbmJvS1tZVEsiQm/m+KbQImINuE2nWAuMXU+DXg7Y7y+0YMYdABY
         xkThXcQoplAvpk1wOyI41BaLwToQpaF3pIt1yZW8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.8 01/16] gre6: Fix reception with IP6_TNL_F_RCV_DSCP_COPY
Date:   Wed, 26 Aug 2020 14:02:38 +0200
Message-Id: <20200826114911.290991186@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200826114911.216745274@linuxfoundation.org>
References: <20200826114911.216745274@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>

[ Upstream commit 272502fcb7cda01ab07fc2fcff82d1d2f73d43cc ]

When receiving an IPv4 packet inside an IPv6 GRE packet, and the
IP6_TNL_F_RCV_DSCP_COPY flag is set on the tunnel, the IPv4 header would
get corrupted. This is due to the common ip6_tnl_rcv() function assuming
that the inner header is always IPv6. This patch checks the tunnel
protocol for IPv4 inner packets, but still defaults to IPv6.

Fixes: 308edfdf1563 ("gre6: Cleanup GREv6 receive path, call common GRE functions")
Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_tunnel.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -913,7 +913,15 @@ int ip6_tnl_rcv(struct ip6_tnl *t, struc
 		struct metadata_dst *tun_dst,
 		bool log_ecn_err)
 {
-	return __ip6_tnl_rcv(t, skb, tpi, tun_dst, ip6ip6_dscp_ecn_decapsulate,
+	int (*dscp_ecn_decapsulate)(const struct ip6_tnl *t,
+				    const struct ipv6hdr *ipv6h,
+				    struct sk_buff *skb);
+
+	dscp_ecn_decapsulate = ip6ip6_dscp_ecn_decapsulate;
+	if (tpi->proto == htons(ETH_P_IP))
+		dscp_ecn_decapsulate = ip4ip6_dscp_ecn_decapsulate;
+
+	return __ip6_tnl_rcv(t, skb, tpi, tun_dst, dscp_ecn_decapsulate,
 			     log_ecn_err);
 }
 EXPORT_SYMBOL(ip6_tnl_rcv);


