Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49ABEC2D0F3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21205212CC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758804;
	bh=uhP+hck1hNEcRAscebSU3DBIGE7R1kqMaA2F1qX4I8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ot2QriVTWDMYFTg5bG6BrNA71IFvpE/dTBrFkTLlMOSlOa/6xt6MTRi46tJyPSy2N
	 FZVilxQ+giklIxILN2E1NdWxlOXrY3Hynhkp6gzKyL2B8ZNYNCaaWzstkINE03FduK
	 f1LL+3LY0adNO8EvIHJRx7cH+wZXCaKZX3xPVZ6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388542AbgDAQdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:33:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:59808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388534AbgDAQdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:33:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A649720658;
        Wed,  1 Apr 2020 16:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758797;
        bh=uhP+hck1hNEcRAscebSU3DBIGE7R1kqMaA2F1qX4I8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UCal2DKfLoy6lyOpmjs4CXoItAijudU3pDLri3SYCEIs64/PMPRaajQVt01UPRorK
         sQ28j2GreIkjxw53y/WtLmv+iMuD0P4c5gMUSqKxxDsOYDq/dgdH7olC8jL5aHIsLA
         tSHn1L+yt1wVfUFBKCPcqJsS1HoanlLl7NoZR3Kk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 4.4 61/91] vti[6]: fix packet tx through bpf_redirect() in XinY cases
Date:   Wed,  1 Apr 2020 18:17:57 +0200
Message-Id: <20200401161534.227074591@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161512.917494101@linuxfoundation.org>
References: <20200401161512.917494101@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Dichtel <nicolas.dichtel@6wind.com>

commit f1ed10264ed6b66b9cd5e8461cffce69be482356 upstream.

I forgot the 4in6/6in4 cases in my previous patch. Let's fix them.

Fixes: 95224166a903 ("vti[6]: fix packet tx through bpf_redirect()")
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv4/Kconfig   |    1 +
 net/ipv4/ip_vti.c  |   36 +++++++++++++++++++++++++++++-------
 net/ipv6/ip6_vti.c |   32 +++++++++++++++++++++++++-------
 3 files changed, 55 insertions(+), 14 deletions(-)

--- a/net/ipv4/Kconfig
+++ b/net/ipv4/Kconfig
@@ -298,6 +298,7 @@ config SYN_COOKIES
 
 config NET_IPVTI
 	tristate "Virtual (secure) IP: tunneling"
+	depends on IPV6 || IPV6=n
 	select INET_TUNNEL
 	select NET_IP_TUNNEL
 	depends on INET_XFRM_MODE_TUNNEL
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -195,17 +195,39 @@ static netdev_tx_t vti_xmit(struct sk_bu
 	int err;
 
 	if (!dst) {
-		struct rtable *rt;
+		switch (skb->protocol) {
+		case htons(ETH_P_IP): {
+			struct rtable *rt;
 
-		fl->u.ip4.flowi4_oif = dev->ifindex;
-		fl->u.ip4.flowi4_flags |= FLOWI_FLAG_ANYSRC;
-		rt = __ip_route_output_key(dev_net(dev), &fl->u.ip4);
-		if (IS_ERR(rt)) {
+			fl->u.ip4.flowi4_oif = dev->ifindex;
+			fl->u.ip4.flowi4_flags |= FLOWI_FLAG_ANYSRC;
+			rt = __ip_route_output_key(dev_net(dev), &fl->u.ip4);
+			if (IS_ERR(rt)) {
+				dev->stats.tx_carrier_errors++;
+				goto tx_error_icmp;
+			}
+			dst = &rt->dst;
+			skb_dst_set(skb, dst);
+			break;
+		}
+#if IS_ENABLED(CONFIG_IPV6)
+		case htons(ETH_P_IPV6):
+			fl->u.ip6.flowi6_oif = dev->ifindex;
+			fl->u.ip6.flowi6_flags |= FLOWI_FLAG_ANYSRC;
+			dst = ip6_route_output(dev_net(dev), NULL, &fl->u.ip6);
+			if (dst->error) {
+				dst_release(dst);
+				dst = NULL;
+				dev->stats.tx_carrier_errors++;
+				goto tx_error_icmp;
+			}
+			skb_dst_set(skb, dst);
+			break;
+#endif
+		default:
 			dev->stats.tx_carrier_errors++;
 			goto tx_error_icmp;
 		}
-		dst = &rt->dst;
-		skb_dst_set(skb, dst);
 	}
 
 	dst_hold(dst);
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -442,15 +442,33 @@ vti6_xmit(struct sk_buff *skb, struct ne
 	int mtu;
 
 	if (!dst) {
-		fl->u.ip6.flowi6_oif = dev->ifindex;
-		fl->u.ip6.flowi6_flags |= FLOWI_FLAG_ANYSRC;
-		dst = ip6_route_output(dev_net(dev), NULL, &fl->u.ip6);
-		if (dst->error) {
-			dst_release(dst);
-			dst = NULL;
+		switch (skb->protocol) {
+		case htons(ETH_P_IP): {
+			struct rtable *rt;
+
+			fl->u.ip4.flowi4_oif = dev->ifindex;
+			fl->u.ip4.flowi4_flags |= FLOWI_FLAG_ANYSRC;
+			rt = __ip_route_output_key(dev_net(dev), &fl->u.ip4);
+			if (IS_ERR(rt))
+				goto tx_err_link_failure;
+			dst = &rt->dst;
+			skb_dst_set(skb, dst);
+			break;
+		}
+		case htons(ETH_P_IPV6):
+			fl->u.ip6.flowi6_oif = dev->ifindex;
+			fl->u.ip6.flowi6_flags |= FLOWI_FLAG_ANYSRC;
+			dst = ip6_route_output(dev_net(dev), NULL, &fl->u.ip6);
+			if (dst->error) {
+				dst_release(dst);
+				dst = NULL;
+				goto tx_err_link_failure;
+			}
+			skb_dst_set(skb, dst);
+			break;
+		default:
 			goto tx_err_link_failure;
 		}
-		skb_dst_set(skb, dst);
 	}
 
 	dst_hold(dst);


