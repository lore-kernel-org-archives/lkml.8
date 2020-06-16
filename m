Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7747C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92E94207C4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592323421;
	bh=f4dWbME0zvTO4lNAmFwEvgbVjHjm7e7nyr1BsvdN+HM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=arOubER2IEVskyUAXmb79Vn5GoJfEjXw754PYKBiOLy5nEcIZaCmZU2WYlyeWtRxZ
	 J9CM7f0puR3u1X7bihD8C0t/11FbuZwYEoxaasQGZabjjhJUJHAurFwThY7iBXnTdO
	 BhU8T7DaFo7TZG3vsMEhdASykESOvF1VcXXv0iYY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732577AbgFPPuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:50:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732570AbgFPPuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:50:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE2CF21475;
        Tue, 16 Jun 2020 15:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592322604;
        bh=f4dWbME0zvTO4lNAmFwEvgbVjHjm7e7nyr1BsvdN+HM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KLDjSSyQ8cQmKr9slU7SLGOqu2Oq/yb0NJKms2JbcffDvHQwgDTjRXeDW+Ua2xa6L
         Exo1jVUEN0msRTiloxGBTKDW2Xk54XdIdtoasF5CLcms9/pmO+dqT8wWCQYA4jXkjt
         bdKJshMUdw/V2sNsiYG9JPyITsHFW6naU4wisv8A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ido Schimmel <idosch@mellanox.com>,
        Alla Segal <allas@mellanox.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.6 005/161] bridge: Avoid infinite loop when suppressing NS messages with invalid options
Date:   Tue, 16 Jun 2020 17:33:15 +0200
Message-Id: <20200616153106.667196714@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616153106.402291280@linuxfoundation.org>
References: <20200616153106.402291280@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ido Schimmel <idosch@mellanox.com>

[ Upstream commit 53fc685243bd6fb90d90305cea54598b78d3cbfc ]

When neighbor suppression is enabled the bridge device might reply to
Neighbor Solicitation (NS) messages on behalf of remote hosts.

In case the NS message includes the "Source link-layer address" option
[1], the bridge device will use the specified address as the link-layer
destination address in its reply.

To avoid an infinite loop, break out of the options parsing loop when
encountering an option with length zero and disregard the NS message.

This is consistent with the IPv6 ndisc code and RFC 4886 which states
that "Nodes MUST silently discard an ND packet that contains an option
with length zero" [2].

[1] https://tools.ietf.org/html/rfc4861#section-4.3
[2] https://tools.ietf.org/html/rfc4861#section-4.6

Fixes: ed842faeb2bd ("bridge: suppress nd pkts on BR_NEIGH_SUPPRESS ports")
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reported-by: Alla Segal <allas@mellanox.com>
Tested-by: Alla Segal <allas@mellanox.com>
Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bridge/br_arp_nd_proxy.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/net/bridge/br_arp_nd_proxy.c
+++ b/net/bridge/br_arp_nd_proxy.c
@@ -276,6 +276,10 @@ static void br_nd_send(struct net_bridge
 	ns_olen = request->len - (skb_network_offset(request) +
 				  sizeof(struct ipv6hdr)) - sizeof(*ns);
 	for (i = 0; i < ns_olen - 1; i += (ns->opt[i + 1] << 3)) {
+		if (!ns->opt[i + 1]) {
+			kfree_skb(reply);
+			return;
+		}
 		if (ns->opt[i] == ND_OPT_SOURCE_LL_ADDR) {
 			daddr = ns->opt + i + sizeof(struct nd_opt_hdr);
 			break;


