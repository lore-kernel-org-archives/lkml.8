Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067AAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C808B204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597689687;
	bh=lMGiXrzYGdWXjhjBqQbKNddRV33RGM0bKcrYbvO8UZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TNGzNhuWD24zOPwYoExQkXi5M/HtyJfwIoPv+JwaYMi/XLi7l9zX771O6Plob2pgK
	 Oo0c4maEILHnb8Ddn4oaNwQj/Jco4PhQ452+s1Hc2QeTDhJQL5mE9xM1JkRrcl/SjV
	 UUHSC6S0FVrNVBzbFZK7SD9sxECOfRNe1Uj6tJ3M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731627AbgHQSl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:41:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:45070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730757AbgHQP5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:57:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C06C920B1F;
        Mon, 17 Aug 2020 15:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679850;
        bh=lMGiXrzYGdWXjhjBqQbKNddRV33RGM0bKcrYbvO8UZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UUY6bgIElO4hn1HKSrPIek6GJ0a7VIF0KHvhDQ2Qr9hOErVowx9V9zzSWXoK8E4KI
         wNqsXI+ciOvcREvrJBQSjhIIhB7j1O+ryJiHWzR0xu1WCdHGhBcX+g+hBruXALRia2
         2cMR4l/F3+yqGLzmkaGJyQ7IEH7114a+z7j8WLq4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ronak Doshi <doshir@vmware.com>,
        Guolin Yang <gyang@vmware.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.7 325/393] vmxnet3: use correct tcp hdr length when packet is encapsulated
Date:   Mon, 17 Aug 2020 17:16:15 +0200
Message-Id: <20200817143835.361184883@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ronak Doshi <doshir@vmware.com>

[ Upstream commit 8a7f280f29a80f6e0798f5d6e07c5dd8726620fe ]

Commit dacce2be3312 ("vmxnet3: add geneve and vxlan tunnel offload
support") added support for encapsulation offload. However, while
calculating tcp hdr length, it does not take into account if the
packet is encapsulated or not.

This patch fixes this issue by using correct reference for inner
tcp header.

Fixes: dacce2be3312 ("vmxnet3: add geneve and vxlan tunnel offload support")
Signed-off-by: Ronak Doshi <doshir@vmware.com>
Acked-by: Guolin Yang <gyang@vmware.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/vmxnet3/vmxnet3_drv.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -861,7 +861,8 @@ vmxnet3_parse_hdr(struct sk_buff *skb, s
 
 			switch (protocol) {
 			case IPPROTO_TCP:
-				ctx->l4_hdr_size = tcp_hdrlen(skb);
+				ctx->l4_hdr_size = skb->encapsulation ? inner_tcp_hdrlen(skb) :
+						   tcp_hdrlen(skb);
 				break;
 			case IPPROTO_UDP:
 				ctx->l4_hdr_size = sizeof(struct udphdr);


