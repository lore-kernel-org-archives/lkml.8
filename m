Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D11C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 231C020849
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590521610;
	bh=gLO9TxPKPmQEBtghshP8SXnLozpdrF8yCro+cbXp6Ts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uSfLNNRxpzkJQ7CyAt9Aw6I8aiYcvZDTErkbP3TZU40tZtQzHFMF7DH6BQxk/Y4Ej
	 q1NMz0zVSWkcBzLfHyZgilYOsodpikU635zIP10/tP71m3MBU21AuegwEmdGMBxTvH
	 jbd/w4veagzsN/JpKi8xtCejNHtYgoaj3/hznEdw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391487AbgEZTd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:33:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:49072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389776AbgEZS4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 14:56:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 613A3208B8;
        Tue, 26 May 2020 18:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519377;
        bh=gLO9TxPKPmQEBtghshP8SXnLozpdrF8yCro+cbXp6Ts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gtO01F7UQozw6zg+RUZYm4n42/zPuhOws8PDEKU6oXrX3ABhRwPa7/23DmzZzgDb1
         X1ApW99sOQuFgzcOrlXwX1s2CK/B4tsCdfjq5LKebU92N9oLC9aBPsx2p+pGTwGIF3
         JZw06e0M8UdP6t7/uLdmVtECAelnfSauNahe8yWs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, greg@kroah.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "R. Parameswaran" <rparames@brocade.com>,
        "David S. Miller" <davem@davemloft.net>,
        Giuliano Procida <gprocida@google.com>
Subject: [PATCH 4.4 43/65] L2TP:Adjust intf MTU, add underlay L3, L2 hdrs.
Date:   Tue, 26 May 2020 20:53:02 +0200
Message-Id: <20200526183920.780983327@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183905.988782958@linuxfoundation.org>
References: <20200526183905.988782958@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "R. Parameswaran" <parameswaran.r7@gmail.com>

commit b784e7ebfce8cfb16c6f95e14e8532d0768ab7ff upstream.

Existing L2TP kernel code does not derive the optimal MTU for Ethernet
pseudowires and instead leaves this to a userspace L2TP daemon or
operator. If an MTU is not specified, the existing kernel code chooses
an MTU that does not take account of all tunnel header overheads, which
can lead to unwanted IP fragmentation. When L2TP is used without a
control plane (userspace daemon), we would prefer that the kernel does a
better job of choosing a default pseudowire MTU, taking account of all
tunnel header overheads, including IP header options, if any. This patch
addresses this.

Change-set here uses the new kernel function, kernel_sock_ip_overhead(),
to factor the outer IP overhead on the L2TP tunnel socket (including
IP Options, if any) when calculating the default MTU for an Ethernet
pseudowire, along with consideration of the inner Ethernet header.

Signed-off-by: R. Parameswaran <rparames@brocade.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Giuliano Procida <gprocida@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/l2tp/l2tp_eth.c |   55 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 4 deletions(-)

--- a/net/l2tp/l2tp_eth.c
+++ b/net/l2tp/l2tp_eth.c
@@ -30,6 +30,9 @@
 #include <net/xfrm.h>
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <linux/udp.h>
 
 #include "l2tp_core.h"
 
@@ -206,6 +209,53 @@ static void l2tp_eth_show(struct seq_fil
 }
 #endif
 
+static void l2tp_eth_adjust_mtu(struct l2tp_tunnel *tunnel,
+				struct l2tp_session *session,
+				struct net_device *dev)
+{
+	unsigned int overhead = 0;
+	struct dst_entry *dst;
+	u32 l3_overhead = 0;
+
+	/* if the encap is UDP, account for UDP header size */
+	if (tunnel->encap == L2TP_ENCAPTYPE_UDP) {
+		overhead += sizeof(struct udphdr);
+		dev->needed_headroom += sizeof(struct udphdr);
+	}
+	if (session->mtu != 0) {
+		dev->mtu = session->mtu;
+		dev->needed_headroom += session->hdr_len;
+		return;
+	}
+	l3_overhead = kernel_sock_ip_overhead(tunnel->sock);
+	if (l3_overhead == 0) {
+		/* L3 Overhead couldn't be identified, this could be
+		 * because tunnel->sock was NULL or the socket's
+		 * address family was not IPv4 or IPv6,
+		 * dev mtu stays at 1500.
+		 */
+		return;
+	}
+	/* Adjust MTU, factor overhead - underlay L3, overlay L2 hdr
+	 * UDP overhead, if any, was already factored in above.
+	 */
+	overhead += session->hdr_len + ETH_HLEN + l3_overhead;
+
+	/* If PMTU discovery was enabled, use discovered MTU on L2TP device */
+	dst = sk_dst_get(tunnel->sock);
+	if (dst) {
+		/* dst_mtu will use PMTU if found, else fallback to intf MTU */
+		u32 pmtu = dst_mtu(dst);
+
+		if (pmtu != 0)
+			dev->mtu = pmtu;
+		dst_release(dst);
+	}
+	session->mtu = dev->mtu - overhead;
+	dev->mtu = session->mtu;
+	dev->needed_headroom += session->hdr_len;
+}
+
 static int l2tp_eth_create(struct net *net, u32 tunnel_id, u32 session_id, u32 peer_session_id, struct l2tp_session_cfg *cfg)
 {
 	struct net_device *dev;
@@ -249,10 +299,7 @@ static int l2tp_eth_create(struct net *n
 	}
 
 	dev_net_set(dev, net);
-	if (session->mtu == 0)
-		session->mtu = dev->mtu - session->hdr_len;
-	dev->mtu = session->mtu;
-	dev->needed_headroom += session->hdr_len;
+	l2tp_eth_adjust_mtu(tunnel, session, dev);
 
 	priv = netdev_priv(dev);
 	priv->dev = dev;


