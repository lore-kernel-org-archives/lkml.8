Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875D2C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 563D220736
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584442875;
	bh=j6KYfX0E8qp+ZUPISxR1ew1BQ47eQGdfnVv83tDk2Hs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NLwBYKfT0+n1QAHSDX53QlfljUSBM3iWT3WZrPucCPQhorpc1SPM9flnGNA4Y6zXI
	 MZ34e90Cg7t2Rp9K5gr6M7t+WQa3V9iKe0MOlWuBo3W6A7IMpAgOYT2cselC8Rh3vO
	 4YXIXsWodAb1xVz0FBdrO4dmv7cUfPzVTN65k3+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbgCQLBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:01:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:40406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726823AbgCQLBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:01:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C0CA20658;
        Tue, 17 Mar 2020 11:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584442864;
        bh=j6KYfX0E8qp+ZUPISxR1ew1BQ47eQGdfnVv83tDk2Hs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EQT90Q4+4uXl/B2HWrfer6ILYn8npG0YWH9zLIHQwu8vJsjBEmlWPG8J1c7cNMVXm
         8zMcv8Qi1w3s2S7uqBNNXXPHxiLgyWuBZrK8EGWsF9lERm0v3tHD1iA6ofMV8Zfrkh
         E9BeTubTTMfySzSpIGFR8SDm7jrEjGqo3u/c7FHc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianlin Shi <jishi@redhat.com>,
        David Ahern <dsahern@gmail.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 018/123] net/ipv6: use configured metric when add peer route
Date:   Tue, 17 Mar 2020 11:54:05 +0100
Message-Id: <20200317103309.616631683@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103307.343627747@linuxfoundation.org>
References: <20200317103307.343627747@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit 07758eb9ff52794fba15d03aa88d92dbd1b7d125 ]

When we add peer address with metric configured, IPv4 could set the dest
metric correctly, but IPv6 do not. e.g.

]# ip addr add 192.0.2.1 peer 192.0.2.2/32 dev eth1 metric 20
]# ip route show dev eth1
192.0.2.2 proto kernel scope link src 192.0.2.1 metric 20
]# ip addr add 2001:db8::1 peer 2001:db8::2/128 dev eth1 metric 20
]# ip -6 route show dev eth1
2001:db8::1 proto kernel metric 20 pref medium
2001:db8::2 proto kernel metric 256 pref medium

Fix this by using configured metric instead of default one.

Reported-by: Jianlin Shi <jishi@redhat.com>
Fixes: 8308f3ff1753 ("net/ipv6: Add support for specifying metric of connected routes")
Reviewed-by: David Ahern <dsahern@gmail.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/addrconf.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -5988,9 +5988,9 @@ static void __ipv6_ifa_notify(int event,
 		if (ifp->idev->cnf.forwarding)
 			addrconf_join_anycast(ifp);
 		if (!ipv6_addr_any(&ifp->peer_addr))
-			addrconf_prefix_route(&ifp->peer_addr, 128, 0,
-					      ifp->idev->dev, 0, 0,
-					      GFP_ATOMIC);
+			addrconf_prefix_route(&ifp->peer_addr, 128,
+					      ifp->rt_priority, ifp->idev->dev,
+					      0, 0, GFP_ATOMIC);
 		break;
 	case RTM_DELADDR:
 		if (ifp->idev->cnf.forwarding)


