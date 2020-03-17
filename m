Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF16C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5E8E20724
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584442660;
	bh=uVRnw+094GgmmnXVbLjP5UJppU4Che6pg2zeRL5Bo8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SuIAS6b2FAV4LJHY7gim5Gpm3ui7WPQkwH67aINFR8XGfkrfcvR/CC5fipCDH7fNy
	 MGZntLahxZ/KTXkhQsHGTr2UPLnBybJYRo+AlO8GY+v7EYC88bv6ZRTRcf10o4S+KB
	 Gz8nRRRbxUsYQVoHAE1doZybAhUaTzOrl7HEho94=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgCQK5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 06:57:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:35520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726704AbgCQK5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 06:57:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38A0C20658;
        Tue, 17 Mar 2020 10:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584442655;
        bh=uVRnw+094GgmmnXVbLjP5UJppU4Che6pg2zeRL5Bo8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QhzN6i0QDCyEjHQozgkqTdb/pxAprbRALjjXyr7bfSAwBwdE9N481slLMr9JpQmUf
         rDQEBFs9sdGrHvctzbJFloKxiqo4cEPKeXO5rZDMcyocxl2dgcCVpXUE+xAkUBYEhb
         DgowLFiINBAQhb3e0c9HNkjk4YgmXpWI1QLKr07s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hangbin Liu <liuhangbin@gmail.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 38/89] net/ipv6: need update peer route when modify metric
Date:   Tue, 17 Mar 2020 11:54:47 +0100
Message-Id: <20200317103304.385720843@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103259.744774526@linuxfoundation.org>
References: <20200317103259.744774526@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit 617940123e0140521f3080d2befc2bf55bcda094 ]

When we modify the route metric, the peer address's route need also
be updated. Before the fix:

+ ip addr add dev dummy1 2001:db8::1 peer 2001:db8::2 metric 60
+ ip -6 route show dev dummy1
2001:db8::1 proto kernel metric 60 pref medium
2001:db8::2 proto kernel metric 60 pref medium
+ ip addr change dev dummy1 2001:db8::1 peer 2001:db8::2 metric 61
+ ip -6 route show dev dummy1
2001:db8::1 proto kernel metric 61 pref medium
2001:db8::2 proto kernel metric 60 pref medium

After the fix:
+ ip addr change dev dummy1 2001:db8::1 peer 2001:db8::2 metric 61
+ ip -6 route show dev dummy1
2001:db8::1 proto kernel metric 61 pref medium
2001:db8::2 proto kernel metric 61 pref medium

Fixes: 8308f3ff1753 ("net/ipv6: Add support for specifying metric of connected routes")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/addrconf.c |   19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -4535,12 +4535,13 @@ inet6_rtm_deladdr(struct sk_buff *skb, s
 }
 
 static int modify_prefix_route(struct inet6_ifaddr *ifp,
-			       unsigned long expires, u32 flags)
+			       unsigned long expires, u32 flags,
+			       bool modify_peer)
 {
 	struct fib6_info *f6i;
 	u32 prio;
 
-	f6i = addrconf_get_prefix_route(&ifp->addr,
+	f6i = addrconf_get_prefix_route(modify_peer ? &ifp->peer_addr : &ifp->addr,
 					ifp->prefix_len,
 					ifp->idev->dev,
 					0, RTF_GATEWAY | RTF_DEFAULT);
@@ -4553,7 +4554,8 @@ static int modify_prefix_route(struct in
 		ip6_del_rt(dev_net(ifp->idev->dev), f6i);
 
 		/* add new one */
-		addrconf_prefix_route(&ifp->addr, ifp->prefix_len,
+		addrconf_prefix_route(modify_peer ? &ifp->peer_addr : &ifp->addr,
+				      ifp->prefix_len,
 				      ifp->rt_priority, ifp->idev->dev,
 				      expires, flags, GFP_KERNEL);
 	} else {
@@ -4629,7 +4631,7 @@ static int inet6_addr_modify(struct inet
 		int rc = -ENOENT;
 
 		if (had_prefixroute)
-			rc = modify_prefix_route(ifp, expires, flags);
+			rc = modify_prefix_route(ifp, expires, flags, false);
 
 		/* prefix route could have been deleted; if so restore it */
 		if (rc == -ENOENT) {
@@ -4637,6 +4639,15 @@ static int inet6_addr_modify(struct inet
 					      ifp->rt_priority, ifp->idev->dev,
 					      expires, flags, GFP_KERNEL);
 		}
+
+		if (had_prefixroute && !ipv6_addr_any(&ifp->peer_addr))
+			rc = modify_prefix_route(ifp, expires, flags, true);
+
+		if (rc == -ENOENT && !ipv6_addr_any(&ifp->peer_addr)) {
+			addrconf_prefix_route(&ifp->peer_addr, ifp->prefix_len,
+					      ifp->rt_priority, ifp->idev->dev,
+					      expires, flags, GFP_KERNEL);
+		}
 	} else if (had_prefixroute) {
 		enum cleanup_prefix_rt_t action;
 		unsigned long rt_expires;


