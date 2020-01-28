Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF649C33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D08B214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580223114;
	bh=H8gV40MUF4wX28yO9j3qAumV1vhdC0yOeApCL0d5jGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0joSaOwt/sUzCxaT/MTirGgGaTwZqQxhHPT7wohTScJmowL3qCte+UnjdAyas/ZfN
	 A7FvbguHa04yIJfqleusaM4Rdj18TyG494XPHUupqJG9O8Gn2/RycztNwCJQM8q9rg
	 P1uIUWrCsa7JP73J9swY8G5LEVZP5PvAkpFZJ4Ds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgA1Ovx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:51:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:43568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbgA1N6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 08:58:44 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F292224683;
        Tue, 28 Jan 2020 13:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580219923;
        bh=H8gV40MUF4wX28yO9j3qAumV1vhdC0yOeApCL0d5jGg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cDRHg2edQu7/QpdMtrfUFA1e1swfzlFXtkGJ7rkXsMd9nUn+KQBRy8ynr6hmMsTPf
         vz1xnr2hCq9/EMG6rU9VjkrVI/xrjH/vi9rxvVHCU/iGsIEuat9HWQmU1/rPzDIRKn
         H7492W0WEZRCHchca7imIfv1iruU2FBaxg64FusE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, William Dauchy <w.dauchy@criteo.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 07/46] net, ip_tunnel: fix namespaces move
Date:   Tue, 28 Jan 2020 14:57:41 +0100
Message-Id: <20200128135751.118463219@linuxfoundation.org>
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

From: William Dauchy <w.dauchy@criteo.com>

[ Upstream commit d0f418516022c32ecceaf4275423e5bd3f8743a9 ]

in the same manner as commit 690afc165bb3 ("net: ip6_gre: fix moving
ip6gre between namespaces"), fix namespace moving as it was broken since
commit 2e15ea390e6f ("ip_gre: Add support to collect tunnel metadata.").
Indeed, the ip6_gre commit removed the local flag for collect_md
condition, so there is no reason to keep it for ip_gre/ip_tunnel.

this patch will fix both ip_tunnel and ip_gre modules.

Fixes: 2e15ea390e6f ("ip_gre: Add support to collect tunnel metadata.")
Signed-off-by: William Dauchy <w.dauchy@criteo.com>
Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ip_tunnel.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -1202,10 +1202,8 @@ int ip_tunnel_init(struct net_device *de
 	iph->version		= 4;
 	iph->ihl		= 5;
 
-	if (tunnel->collect_md) {
-		dev->features |= NETIF_F_NETNS_LOCAL;
+	if (tunnel->collect_md)
 		netif_keep_dst(dev);
-	}
 	return 0;
 }
 EXPORT_SYMBOL_GPL(ip_tunnel_init);


