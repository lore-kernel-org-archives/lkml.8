Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A63FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6039922D00
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597679098;
	bh=XrGXVfkZGJOfgdQoFkJoVMpIOpg0//YVEswx0Gn5SG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oE2ko3kltXvzZB28gHv0Jn4OeLdExJs7ccY/Rov8JsyNav8v6uB7+7vLmNYRfSoqB
	 JHPf0SLFRvJzoGVN5FKqZeDekUx9e5ijxFEPa2Rl/4qWHnl46ueRdcYXfUQFFh3dzu
	 Wfid6W/415NweMj+Fjbdl2mS3t/HzmSCu8mI0Slc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387721AbgHQPoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 11:44:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:46104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730578AbgHQPiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:38:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A03E4208E4;
        Mon, 17 Aug 2020 15:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678692;
        bh=XrGXVfkZGJOfgdQoFkJoVMpIOpg0//YVEswx0Gn5SG4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gi44MkZ6lHNiiWVh3ZnhNGIF2oBWzWX43zHIpjjnJYthmbFNOHDtI/lhkCZQHRUNm
         Q+OSLQM1AwXOGEnLLSPXcI6Vx7BYBeTLXUagSwSxcQ67YugAlZYe8d6uMxJFgbxizy
         YdPa7PWPVWzy70R03jcBHaI2rK+yNd22yL7XimWM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ronak Doshi <doshir@vmware.com>,
        Guolin Yang <gyang@vmware.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.8 391/464] vmxnet3: use correct tcp hdr length when packet is encapsulated
Date:   Mon, 17 Aug 2020 17:15:44 +0200
Message-Id: <20200817143852.508586799@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
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
@@ -886,7 +886,8 @@ vmxnet3_parse_hdr(struct sk_buff *skb, s
 
 			switch (protocol) {
 			case IPPROTO_TCP:
-				ctx->l4_hdr_size = tcp_hdrlen(skb);
+				ctx->l4_hdr_size = skb->encapsulation ? inner_tcp_hdrlen(skb) :
+						   tcp_hdrlen(skb);
 				break;
 			case IPPROTO_UDP:
 				ctx->l4_hdr_size = sizeof(struct udphdr);


