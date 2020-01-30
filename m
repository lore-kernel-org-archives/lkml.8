Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AA5C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C77632173E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580410084;
	bh=g7iUG3P/vV3u1gAoyzlinadyflWpDD9tPXwLkewpevo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IFq5/k1xZy3AExX+xJ/bep/W/if4qrh0/W4VF0G4OMLo7pro0+TiRCMb2S3rJ8w6z
	 tr1CUX9BkcsRQj+Xc4hcuydgb9Ramt//vqSRNfXqMjGbLZgl+7zt8BIrGwW7NaaBFv
	 soF8hYgDfhW6E/oQHhuldMGQ90H/eK+fKg5Xekfs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730796AbgA3SsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:48:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:58758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731464AbgA3Sr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:47:59 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D60A520CC7;
        Thu, 30 Jan 2020 18:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580410077;
        bh=g7iUG3P/vV3u1gAoyzlinadyflWpDD9tPXwLkewpevo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qsiq6YJYlwH9VLeZ++w+Cudg/83YIjA6nI9NsGFRMg2wC1vNwnbA2xgzhYxE8XgJ3
         yAQ4bF1uviyEa73121iOr2qUuQ66NJDef9jWEVnfBcfqVhcZJyg0iLetrty0hyCsS4
         liJSEi79G8udG8qqU8qE0uwM+udUo29uws6ixe9I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 37/55] net: wan: sdla: Fix cast from pointer to integer of different size
Date:   Thu, 30 Jan 2020 19:39:18 +0100
Message-Id: <20200130183615.265337658@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130183608.563083888@linuxfoundation.org>
References: <20200130183608.563083888@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>

[ Upstream commit 00c0688cecadbf7ac2f5b4cdb36d912a2d3f0cca ]

Since net_device.mem_start is unsigned long, it should not be cast to
int right before casting to pointer.  This fixes warning (compile
testing on alpha architecture):

    drivers/net/wan/sdla.c: In function ‘sdla_transmit’:
    drivers/net/wan/sdla.c:711:13: warning:
        cast to pointer from integer of different size [-Wint-to-pointer-cast]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wan/sdla.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wan/sdla.c b/drivers/net/wan/sdla.c
index 57ed259c8208d..09fde60a5f9de 100644
--- a/drivers/net/wan/sdla.c
+++ b/drivers/net/wan/sdla.c
@@ -711,7 +711,7 @@ static netdev_tx_t sdla_transmit(struct sk_buff *skb,
 
 					spin_lock_irqsave(&sdla_lock, flags);
 					SDLA_WINDOW(dev, addr);
-					pbuf = (void *)(((int) dev->mem_start) + (addr & SDLA_ADDR_MASK));
+					pbuf = (void *)(dev->mem_start + (addr & SDLA_ADDR_MASK));
 					__sdla_write(dev, pbuf->buf_addr, skb->data, skb->len);
 					SDLA_WINDOW(dev, addr);
 					pbuf->opp_flag = 1;
-- 
2.20.1



