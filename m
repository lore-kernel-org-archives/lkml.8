Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BE6C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E45F20575
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588099775;
	bh=Ue9oNTy9Oq40zi5GBiH7Z4hIpfAqI/nfYyVazPMhCy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KyCQbFgAYFUgAq/hjoE/VO+g0z9sl4ODXpWjMhtrjASPMt8u675FFm+QSEweULI4b
	 2cRrFgiIgB1+lPr/YReby+3CwuQTDI9LaOjSkv2xvJ7XkVcJHcXwbE34i1uVi3cYOJ
	 vVTom4Mb95x+AsPu/ApdO7zAeF9SzOU2he6AMVqM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731500AbgD1Ste (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:49:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:59130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730762AbgD1SkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:40:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F02E620575;
        Tue, 28 Apr 2020 18:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588099207;
        bh=Ue9oNTy9Oq40zi5GBiH7Z4hIpfAqI/nfYyVazPMhCy0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rZNWitJl4nnVaOf2EPWz4EvTrMKmF4Ck6EDMP7JP9U3EgJQptBQ7KF09+nVPYQcrc
         9p+uY0lcJ8oDaOCyA+kXuczcn0Bpz87E5zwprqU7KZyqq7SBHqZuDPxxYZDBrd+/1I
         TeUz6xDBjEoxApzgatez8YpSj1o9ICiB/XCIg7yI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 073/168] vrf: Fix IPv6 with qdisc and xfrm
Date:   Tue, 28 Apr 2020 20:24:07 +0200
Message-Id: <20200428182241.291061422@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182231.704304409@linuxfoundation.org>
References: <20200428182231.704304409@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Ahern <dsahern@gmail.com>

[ Upstream commit a53c102872ad6e34e1518e25899dc9498c27f8b1 ]

When a qdisc is attached to the VRF device, the packet goes down the ndo
xmit function which is setup to send the packet back to the VRF driver
which does a lookup to send the packet out. The lookup in the VRF driver
is not considering xfrm policies. Change it to use ip6_dst_lookup_flow
rather than ip6_route_output.

Fixes: 35402e313663 ("net: Add IPv6 support to VRF device")
Signed-off-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/vrf.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -188,8 +188,8 @@ static netdev_tx_t vrf_process_v6_outbou
 	fl6.flowi6_proto = iph->nexthdr;
 	fl6.flowi6_flags = FLOWI_FLAG_SKIP_NH_OIF;
 
-	dst = ip6_route_output(net, NULL, &fl6);
-	if (dst == dst_null)
+	dst = ip6_dst_lookup_flow(net, NULL, &fl6, NULL);
+	if (IS_ERR(dst) || dst == dst_null)
 		goto err;
 
 	skb_dst_drop(skb);


