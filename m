Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79388C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 13:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41FDA2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 13:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580219929;
	bh=iju2MUBovglChgfNk+Qc+3ZhD2dGF/lzAqyPHgcwKC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vCLNzAjILSfhVSyKbIW0jAewW5J3oruOsu4Yxz2EnVTA0Cr7ggH/0zx2pNxxUlsQL
	 fH5Le76+duCmusLunm8NgJd2N4auc7PlIlRoFduScfrdnEzZw8Y9JfAKZolqQxKBeO
	 EC6LwYGkrztQUeMSReqTfF1o9wYoqUU+IcKXRMEQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgA1N6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 08:58:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:43510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbgA1N6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 08:58:41 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E8802173E;
        Tue, 28 Jan 2020 13:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580219920;
        bh=iju2MUBovglChgfNk+Qc+3ZhD2dGF/lzAqyPHgcwKC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vf+4DlyILJvTKwWykgPF3dhucb5HbZxlLYhMFzD9qTcfuZqVlugoDFYAUVs8/e18L
         Osui6uvFuWyfowFrHJmNfo2Dcw1kSHdBkZ9jBhRb7haZ0UKaLVkx+3BWImP1NL3XkY
         hdjrSLRfIpkbizaLnUZ4CtSC7lXzNXbuoAJx2w2M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, William Dauchy <w.dauchy@criteo.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 06/46] net, ip6_tunnel: fix namespaces move
Date:   Tue, 28 Jan 2020 14:57:40 +0100
Message-Id: <20200128135750.912050929@linuxfoundation.org>
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

[ Upstream commit 5311a69aaca30fa849c3cc46fb25f75727fb72d0 ]

in the same manner as commit d0f418516022 ("net, ip_tunnel: fix
namespaces move"), fix namespace moving as it was broken since commit
8d79266bc48c ("ip6_tunnel: add collect_md mode to IPv6 tunnel"), but for
ipv6 this time; there is no reason to keep it for ip6_tunnel.

Fixes: 8d79266bc48c ("ip6_tunnel: add collect_md mode to IPv6 tunnel")
Signed-off-by: William Dauchy <w.dauchy@criteo.com>
Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_tunnel.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1878,10 +1878,8 @@ static int ip6_tnl_dev_init(struct net_d
 	if (err)
 		return err;
 	ip6_tnl_link_config(t);
-	if (t->parms.collect_md) {
-		dev->features |= NETIF_F_NETNS_LOCAL;
+	if (t->parms.collect_md)
 		netif_keep_dst(dev);
-	}
 	return 0;
 }
 


