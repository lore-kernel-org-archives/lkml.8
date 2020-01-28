Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AA7C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B84D24690
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580221639;
	bh=PC0id2miedv7/wiSN1qvLDzT5fsZnx2ZkPMCamtFNYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vr2TSY29zOP3hvaLbzv+i2gjSZXK8x01HmER7r09xqHtpgnzhPG9GTVovkc4zpehP
	 /yavkah2UKUq4NU0hjATWHXcJcGYC3V7Fs3i6lhn87BggvZ3bnEXBy9gsmvIDN9Be4
	 T8z2fE4/0pLAfhgVp6T2qNX6wQSMWVGLm/x8dw9M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733282AbgA1O1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:27:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:54746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733093AbgA1O1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:27:05 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B774720716;
        Tue, 28 Jan 2020 14:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221625;
        bh=PC0id2miedv7/wiSN1qvLDzT5fsZnx2ZkPMCamtFNYc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=01SkfZxvjEV9ZHYfdCTluj+QTlMxZJ10WO5qUc0VUcCZhROC8HWin7fqaEa8kSzi3
         d61xmA4DyOnwySElHnb7bUE154MhpaUF/Wi2q+Vcb16RpUxcO2hs5eTcfv65cMOncw
         ++mNgqoYtxG+RmWACrNkPy+8iJVi3Ghe7lQb7xyE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, William Dauchy <w.dauchy@criteo.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 09/92] net, ip_tunnel: fix namespaces move
Date:   Tue, 28 Jan 2020 15:07:37 +0100
Message-Id: <20200128135810.389478122@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135809.344954797@linuxfoundation.org>
References: <20200128135809.344954797@linuxfoundation.org>
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
@@ -1203,10 +1203,8 @@ int ip_tunnel_init(struct net_device *de
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


