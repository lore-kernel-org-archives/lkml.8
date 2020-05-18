Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B729C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1980F20657
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589826670;
	bh=Bbrs+y755BSyM/MVYEODb6BWtxLA7BzsDuuqPjzRNUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VBmrZuA6MikkH8Zvl5rqFKMbpGRsKVZEPwjPho8WwOzpK1CalvqSi96HbsHrYXWLW
	 JopuCdkor/bNLwyYGL7/RLmY5VYmKHmJKAVbBh5fyuWvWL8h+bybsXJmAAJteKagoQ
	 WpUpwks4QEgWyE6Xu4mmp146nJ18FrlC0zuJo9Mc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732356AbgERSbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:31:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:35376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728964AbgERRkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:40:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3D3820884;
        Mon, 18 May 2020 17:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589823605;
        bh=Bbrs+y755BSyM/MVYEODb6BWtxLA7BzsDuuqPjzRNUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zwxPysCdZZEig3igjJ1hGQpTTKC0P/es6UnunpjpVkX3YmakNJ8EauJ8C37tU2/MZ
         skGD5bNQrSGKTug3MI/JuOqCOK936rc4d7sItamCRjK3SI8w5dE7zgkoRcFCKbOwet
         M/GoPGfHztWVxa1qSVNA0fB+qGa4D6k8Y/ghrd3Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Benc <jbenc@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 48/86] gre: do not keep the GRE header around in collect medata mode
Date:   Mon, 18 May 2020 19:36:19 +0200
Message-Id: <20200518173500.350608854@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173450.254571947@linuxfoundation.org>
References: <20200518173450.254571947@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Benc <jbenc@redhat.com>

[ Upstream commit e271c7b4420ddbb9fae82a2b31a5ab3edafcf4fe ]

For ipgre interface in collect metadata mode, it doesn't make sense for the
interface to be of ARPHRD_IPGRE type. The outer header of received packets
is not needed, as all the information from it is present in metadata_dst. We
already don't set ipgre_header_ops for collect metadata interfaces, which is
the only consumer of mac_header pointing to the outer IP header.

Just set the interface type to ARPHRD_NONE in collect metadata mode for
ipgre (not gretap, that still correctly stays ARPHRD_ETHER) and reset
mac_header.

Fixes: a64b04d86d14 ("gre: do not assign header_ops in collect metadata mode")
Fixes: 2e15ea390e6f4 ("ip_gre: Add support to collect tunnel metadata.")
Signed-off-by: Jiri Benc <jbenc@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/ip_gre.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index e5448570d6483..900ee28bda99a 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -399,7 +399,10 @@ static int ipgre_rcv(struct sk_buff *skb, const struct tnl_ptk_info *tpi)
 				  iph->saddr, iph->daddr, tpi->key);
 
 	if (tunnel) {
-		skb_pop_mac_header(skb);
+		if (tunnel->dev->type != ARPHRD_NONE)
+			skb_pop_mac_header(skb);
+		else
+			skb_reset_mac_header(skb);
 		if (tunnel->collect_md) {
 			__be16 flags;
 			__be64 tun_id;
@@ -1015,6 +1018,8 @@ static void ipgre_netlink_parms(struct net_device *dev,
 		struct ip_tunnel *t = netdev_priv(dev);
 
 		t->collect_md = true;
+		if (dev->type == ARPHRD_IPGRE)
+			dev->type = ARPHRD_NONE;
 	}
 }
 
-- 
2.20.1



