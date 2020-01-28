Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AE7C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 13:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10B2B24683
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 13:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580219922;
	bh=WMTiwS7kIAwrMNqij8xPX1ZnmfbNjk+m9lD/MWljEfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2O+2MikbMX8gp7ndgpK7q0txgIohEQQHHYdgMlWaU4QI96MH7+kZM5Kh6xm1SyYVC
	 piueNgf8ED+G7hFZoWvxjhFnVRmezz/sI9xh+QLOsQd3hnvv1KGU+wUdnCtWhGuTHO
	 9i7o+KiAufx/6p1w/6IPYz1nLyVFxNReT8GOVFR0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgA1N6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 08:58:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:43384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbgA1N6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 08:58:36 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2004024685;
        Tue, 28 Jan 2020 13:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580219915;
        bh=WMTiwS7kIAwrMNqij8xPX1ZnmfbNjk+m9lD/MWljEfA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kwBM2A0vM4dZXkcn3mynxHZ4lUkFT1+UYjGq6MHfMQ2XO/7V0xf31Y0CMi2F3UioX
         Xve0L3PBxlsxD/iB+t6qYRQ/IqRoysmS1/m6yt43YxMv87OXs/lKpeammu9Gh9QLfe
         I2hE/BCumuPa8+aSoibSxmXdpX35ZdmWUlH5rPpw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yuki Taguchi <tagyounit@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 04/46] ipv6: sr: remove SKB_GSO_IPXIP6 on End.D* actions
Date:   Tue, 28 Jan 2020 14:57:38 +0100
Message-Id: <20200128135750.628101967@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135749.822297911@linuxfoundation.org>
References: <20200128135749.822297911@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuki Taguchi <tagyounit@gmail.com>

[ Upstream commit 62ebaeaedee7591c257543d040677a60e35c7aec ]

After LRO/GRO is applied, SRv6 encapsulated packets have
SKB_GSO_IPXIP6 feature flag, and this flag must be removed right after
decapulation procedure.

Currently, SKB_GSO_IPXIP6 flag is not removed on End.D* actions, which
creates inconsistent packet state, that is, a normal TCP/IP packets
have the SKB_GSO_IPXIP6 flag. This behavior can cause unexpected
fallback to GSO on routing to netdevices that do not support
SKB_GSO_IPXIP6. For example, on inter-VRF forwarding, decapsulated
packets separated into small packets by GSO because VRF devices do not
support TSO for packets with SKB_GSO_IPXIP6 flag, and this degrades
forwarding performance.

This patch removes encapsulation related GSO flags from the skb right
after the End.D* action is applied.

Fixes: d7a669dd2f8b ("ipv6: sr: add helper functions for seg6local")
Signed-off-by: Yuki Taguchi <tagyounit@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/seg6_local.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -27,6 +27,7 @@
 #include <net/addrconf.h>
 #include <net/ip6_route.h>
 #include <net/dst_cache.h>
+#include <net/ip_tunnels.h>
 #ifdef CONFIG_IPV6_SEG6_HMAC
 #include <net/seg6_hmac.h>
 #endif
@@ -126,7 +127,8 @@ static bool decap_and_validate(struct sk
 
 	skb_reset_network_header(skb);
 	skb_reset_transport_header(skb);
-	skb->encapsulation = 0;
+	if (iptunnel_pull_offloads(skb))
+		return false;
 
 	return true;
 }


