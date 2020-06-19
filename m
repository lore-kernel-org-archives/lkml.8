Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A75C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69E5C2100A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592584218;
	bh=Tz0l8XZHBHCcqhE/18c0qkDSHj4sG4APZ4jK0ZbKGac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1jhgXmlgzaRiBaFCuSNfM9vn9Ri2rcvCQhR06StyXtKcExAu8yCaBW6UzXgCGR0eo
	 XQMQjSawVIfTV9NOM9CDP2CO/Mjzq4e72sWsQriNh1nDwDKJkoAtdeB540c/Euijdm
	 dhjYLb9Cqg7AXwoZJa7LIem92gkvHKik+z4dmvz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394870AbgFSQaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:30:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:48398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389781AbgFSOxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:53:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 119F8217D8;
        Fri, 19 Jun 2020 14:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578434;
        bh=Tz0l8XZHBHCcqhE/18c0qkDSHj4sG4APZ4jK0ZbKGac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dbgzzWDMjjRT5ShRewM842Tq7jRa4Tu4U9L+YmuAe0ZMPeNBH2TaZROGhPlZgRNPv
         +ED+zYc0EOg6nSAtjPZiTRlOCuKlmXaGdcCh6BJSRGmdgYcD8djIUoRwZEyVUbES87
         spVgOn4P9gRld+P/WmsOqclTq3x54oi0Ayn1gXnA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ido Schimmel <idosch@mellanox.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 004/267] vxlan: Avoid infinite loop when suppressing NS messages with invalid options
Date:   Fri, 19 Jun 2020 16:29:49 +0200
Message-Id: <20200619141649.066202552@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141648.840376470@linuxfoundation.org>
References: <20200619141648.840376470@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ido Schimmel <idosch@mellanox.com>

[ Upstream commit 8066e6b449e050675df48e7c4b16c29f00507ff0 ]

When proxy mode is enabled the vxlan device might reply to Neighbor
Solicitation (NS) messages on behalf of remote hosts.

In case the NS message includes the "Source link-layer address" option
[1], the vxlan device will use the specified address as the link-layer
destination address in its reply.

To avoid an infinite loop, break out of the options parsing loop when
encountering an option with length zero and disregard the NS message.

This is consistent with the IPv6 ndisc code and RFC 4886 which states
that "Nodes MUST silently discard an ND packet that contains an option
with length zero" [2].

[1] https://tools.ietf.org/html/rfc4861#section-4.3
[2] https://tools.ietf.org/html/rfc4861#section-4.6

Fixes: 4b29dba9c085 ("vxlan: fix nonfunctional neigh_reduce()")
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/vxlan.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -1611,6 +1611,10 @@ static struct sk_buff *vxlan_na_create(s
 	ns_olen = request->len - skb_network_offset(request) -
 		sizeof(struct ipv6hdr) - sizeof(*ns);
 	for (i = 0; i < ns_olen-1; i += (ns->opt[i+1]<<3)) {
+		if (!ns->opt[i + 1]) {
+			kfree_skb(reply);
+			return NULL;
+		}
 		if (ns->opt[i] == ND_OPT_SOURCE_LL_ADDR) {
 			daddr = ns->opt + i + sizeof(struct nd_opt_hdr);
 			break;


