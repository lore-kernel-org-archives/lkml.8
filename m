Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921FBC83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 720DB20730
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588098910;
	bh=L24Z/pnJD8Hs0p2+ekS4GjMizN9gO9MLeOJpLDy3rLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IIq34bpein9CO8ggkrnWmOd5NSODK96+9yuiOLV5n4JClVqNi16C8vZyvXxzsfpd+
	 J5LKLqZ3DZGr1VCU9FTtYeBH4WSyrRYtT2BBvgG0HlpidYyi6GelE/b6/deR9YwC53
	 pByOcV7kE+dmjWBnai6gFUUUYbmIMHiXXNe/H1Q0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730210AbgD1SfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:35:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:52106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729424AbgD1SfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:35:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 500A22085B;
        Tue, 28 Apr 2020 18:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588098905;
        bh=L24Z/pnJD8Hs0p2+ekS4GjMizN9gO9MLeOJpLDy3rLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yxYpfvg4yNn0WZ+7pqoPvdJfBkQy4AOigvPqCqIAZllGNS4qE23zNcWCE8C4BKnQR
         BM7y7AvWbG8E18doZskAanleOEyVOHY6L8Mka/5FLcQ5uanhs6IIeQqXxfbjp1eYw6
         7lWfKfhpusFe3qF5qu22UVcRg8iEB9j36/hwFVDs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Trev Larock <trev@larock.ca>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 071/131] vrf: Check skb for XFRM_TRANSFORMED flag
Date:   Tue, 28 Apr 2020 20:24:43 +0200
Message-Id: <20200428182233.851420820@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182224.822179290@linuxfoundation.org>
References: <20200428182224.822179290@linuxfoundation.org>
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
@@ -478,7 +478,8 @@ static struct sk_buff *vrf_ip6_out(struc
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


