Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C47CC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AE7C24955
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588339962;
	bh=NEw4h2mf+ZommB+hhjS96rqsqdRd5+L5tcm2uLB/e9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ci6NWaE5W2plne9zqERCsoPa5f3jz1JjUuL43DYvIn55dxZFdsLJ4/YmuCoegHGSb
	 keafBqCsCDrQvqelX8lcU7IeQwbnOesom9mGBtqTRgI6OPKFXODEDaVJdXqiDrQhj5
	 1pcY0lRliuT6UdRTN/JlrQVexqsxRj81KdvE2e1o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbgEANcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:32:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:57596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730327AbgEANci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:32:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38870208C3;
        Fri,  1 May 2020 13:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588339957;
        bh=NEw4h2mf+ZommB+hhjS96rqsqdRd5+L5tcm2uLB/e9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j+HBFbTghTemx/skq5l9gLPWNP3QJ75RAT3SSYj2HOMipYQap7XnXvElOL22kQq9W
         T9YbcEszmZlPvKW+lEWvITEMtaK84YJExqIXHlrj6oT9Idkx4dYK0nQZSXBrSDP+1c
         LyadhPMVS6ffR3PDTiLtLeJfKrHpoX8L2JRqLp6s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Trev Larock <trev@larock.ca>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 035/117] vrf: Check skb for XFRM_TRANSFORMED flag
Date:   Fri,  1 May 2020 15:21:11 +0200
Message-Id: <20200501131548.956894222@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131544.291247695@linuxfoundation.org>
References: <20200501131544.291247695@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Ahern <dsahern@gmail.com>

[ Upstream commit 16b9db1ce34ff00d6c18e82825125cfef0cdfb13 ]

To avoid a loop with qdiscs and xfrms, check if the skb has already gone
through the qdisc attached to the VRF device and then to the xfrm layer.
If so, no need for a second redirect.

Fixes: 193125dbd8eb ("net: Introduce VRF device driver")
Reported-by: Trev Larock <trev@larock.ca>
Signed-off-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/vrf.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -476,7 +476,8 @@ static struct sk_buff *vrf_ip6_out(struc
 	if (rt6_need_strict(&ipv6_hdr(skb)->daddr))
 		return skb;
 
-	if (qdisc_tx_is_default(vrf_dev))
+	if (qdisc_tx_is_default(vrf_dev) ||
+	    IP6CB(skb)->flags & IP6SKB_XFRM_TRANSFORMED)
 		return vrf_ip6_out_direct(vrf_dev, sk, skb);
 
 	return vrf_ip6_out_redirect(vrf_dev, skb);
@@ -692,7 +693,8 @@ static struct sk_buff *vrf_ip_out(struct
 	    ipv4_is_lbcast(ip_hdr(skb)->daddr))
 		return skb;
 
-	if (qdisc_tx_is_default(vrf_dev))
+	if (qdisc_tx_is_default(vrf_dev) ||
+	    IPCB(skb)->flags & IPSKB_XFRM_TRANSFORMED)
 		return vrf_ip_out_direct(vrf_dev, sk, skb);
 
 	return vrf_ip_out_redirect(vrf_dev, skb);


