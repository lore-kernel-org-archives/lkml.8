Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73FCC47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C621624958
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588941948;
	bh=kt3yg/PQJQCoDNeJE8s644Q/i648VVi5QUmWT08wOsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fIpsbz58CTCWpReXZXYBcKWnnNA5cgUsvnQOc+mZmecGKE41mMZgm0cX8+5Q1VvCI
	 i1fsT/86q3/iOM99/NuBhv7ThC2xRdMAFfs6roQpsh/GnAOBUxb0JcleZxt0bcJSAT
	 LcN+Ncb5wkoTtmAzIcb5DT36iASxz8e96FqA/PFw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbgEHMpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:45:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:45682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729329AbgEHMpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:45:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 874C02145D;
        Fri,  8 May 2020 12:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941941;
        bh=kt3yg/PQJQCoDNeJE8s644Q/i648VVi5QUmWT08wOsM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bZHlEroRK8fsrnuiIiIBu4TM3pMMdC2OzqnG7UigFKw6ugPIMIM1N+ZMfapyRjnMZ
         GTJAAClEHvW+gJND5hQwXMPh2RMinBrq8JVlMFj1SYdHubC3yyvEV7LI8nNXcXgXX3
         m+VDcX74lovYUp9vl9xqZrYfuiZqApqZGpJ+cbwE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 194/312] ipv6: do not abuse GFP_ATOMIC in inet6_netconf_notify_devconf()
Date:   Fri,  8 May 2020 14:33:05 +0200
Message-Id: <20200508123138.093150659@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

commit 927265bc6cd6374c9bafc43408ece4e92311b149 upstream.

All inet6_netconf_notify_devconf() callers are in process context,
so we can use GFP_KERNEL allocations if we take care of not holding
a rwlock while not needed in ip6mr (we hold RTNL there)

Fixes: d67b8c616b48 ("netconf: advertise mc_forwarding status")
Fixes: f3a1bfb11ccb ("rtnl/ipv6: use netconf msg to advertise forwarding status")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv6/addrconf.c |    4 ++--
 net/ipv6/ip6mr.c    |   13 +++++++------
 2 files changed, 9 insertions(+), 8 deletions(-)

--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -540,7 +540,7 @@ void inet6_netconf_notify_devconf(struct
 	struct sk_buff *skb;
 	int err = -ENOBUFS;
 
-	skb = nlmsg_new(inet6_netconf_msgsize_devconf(type), GFP_ATOMIC);
+	skb = nlmsg_new(inet6_netconf_msgsize_devconf(type), GFP_KERNEL);
 	if (!skb)
 		goto errout;
 
@@ -552,7 +552,7 @@ void inet6_netconf_notify_devconf(struct
 		kfree_skb(skb);
 		goto errout;
 	}
-	rtnl_notify(skb, net, 0, RTNLGRP_IPV6_NETCONF, NULL, GFP_ATOMIC);
+	rtnl_notify(skb, net, 0, RTNLGRP_IPV6_NETCONF, NULL, GFP_KERNEL);
 	return;
 errout:
 	rtnl_set_sk_err(net, RTNLGRP_IPV6_NETCONF, err);
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1594,14 +1594,15 @@ static int ip6mr_sk_init(struct mr6_tabl
 	if (likely(mrt->mroute6_sk == NULL)) {
 		mrt->mroute6_sk = sk;
 		net->ipv6.devconf_all->mc_forwarding++;
-		inet6_netconf_notify_devconf(net, NETCONFA_MC_FORWARDING,
-					     NETCONFA_IFINDEX_ALL,
-					     net->ipv6.devconf_all);
-	}
-	else
+	} else {
 		err = -EADDRINUSE;
+	}
 	write_unlock_bh(&mrt_lock);
 
+	if (!err)
+		inet6_netconf_notify_devconf(net, NETCONFA_MC_FORWARDING,
+					     NETCONFA_IFINDEX_ALL,
+					     net->ipv6.devconf_all);
 	rtnl_unlock();
 
 	return err;
@@ -1619,11 +1620,11 @@ int ip6mr_sk_done(struct sock *sk)
 			write_lock_bh(&mrt_lock);
 			mrt->mroute6_sk = NULL;
 			net->ipv6.devconf_all->mc_forwarding--;
+			write_unlock_bh(&mrt_lock);
 			inet6_netconf_notify_devconf(net,
 						     NETCONFA_MC_FORWARDING,
 						     NETCONFA_IFINDEX_ALL,
 						     net->ipv6.devconf_all);
-			write_unlock_bh(&mrt_lock);
 
 			mroute_clean_tables(mrt, false);
 			err = 0;


