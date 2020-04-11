Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08345C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D664F21556
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586607219;
	bh=8b6+SjPVlptKlpHpNs5BryqjkHoJs5ngMdVdKcZM1GY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2AOGlGwpJTt+gtVw4Yi+gGj5RBmGg7W6zyBoOjWh+nIOF91N0XJBsTXiOG1+MYxDV
	 U38CuLarRUhWm/kfOS8WaRg3JdMDQ1nM4APkJGc+mhS+sUbL2Agl++05xxNtg09kFb
	 IAAf5x50etx0jS3ax8HasnFTib9AuRREf8g4VXGU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgDKMNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:13:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:46546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727806AbgDKMNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 08:13:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF8A821835;
        Sat, 11 Apr 2020 12:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586607211;
        bh=8b6+SjPVlptKlpHpNs5BryqjkHoJs5ngMdVdKcZM1GY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UzvoKZw+2FKeFUlF9IQBl8MlIx8VUDOu00KM0zp7WvMlRBVA+k0P/jZ2XeHC3dJ0s
         UjxzZA2s6tK3ofi0e2H32+QsbJDT8A2TNg8nL9KGDgNyshK4RxHLhGX53y1iuRwG6A
         MA7iRWk3H+M8J2Bdt5+dyCrqm86R8/cBYNtd2Tow=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, William Dauchy <w.dauchy@criteo.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 02/38] net, ip_tunnel: fix interface lookup with no key
Date:   Sat, 11 Apr 2020 14:08:46 +0200
Message-Id: <20200411115437.998346755@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200411115437.795556138@linuxfoundation.org>
References: <20200411115437.795556138@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: William Dauchy <w.dauchy@criteo.com>

[ Upstream commit 25629fdaff2ff509dd0b3f5ff93d70a75e79e0a1 ]

when creating a new ipip interface with no local/remote configuration,
the lookup is done with TUNNEL_NO_KEY flag, making it impossible to
match the new interface (only possible match being fallback or metada
case interface); e.g: `ip link add tunl1 type ipip dev eth0`

To fix this case, adding a flag check before the key comparison so we
permit to match an interface with no local/remote config; it also avoids
breaking possible userland tools relying on TUNNEL_NO_KEY flag and
uninitialised key.

context being on my side, I'm creating an extra ipip interface attached
to the physical one, and moving it to a dedicated namespace.

Fixes: c54419321455 ("GRE: Refactor GRE tunneling code.")
Signed-off-by: William Dauchy <w.dauchy@criteo.com>
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ip_tunnel.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -155,11 +155,8 @@ struct ip_tunnel *ip_tunnel_lookup(struc
 			cand = t;
 	}
 
-	if (flags & TUNNEL_NO_KEY)
-		goto skip_key_lookup;
-
 	hlist_for_each_entry_rcu(t, head, hash_node) {
-		if (t->parms.i_key != key ||
+		if ((!(flags & TUNNEL_NO_KEY) && t->parms.i_key != key) ||
 		    t->parms.iph.saddr != 0 ||
 		    t->parms.iph.daddr != 0 ||
 		    !(t->dev->flags & IFF_UP))
@@ -171,7 +168,6 @@ struct ip_tunnel *ip_tunnel_lookup(struc
 			cand = t;
 	}
 
-skip_key_lookup:
 	if (cand)
 		return cand;
 


