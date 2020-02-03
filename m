Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAA3C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 700D920838
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580747124;
	bh=wmjiu5PEYm5uCqktUKV3PAIyZwrB09SvsJ4xWzYRc48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HRfq/pGRjTLSrhITCHybft5eePnmJ/DqV7lnSSG5g5Ks/KdKGqGDDjYgpUoSfTB48
	 UN6WMVE3YeKBrBL/ezyxF1r/299EFmEBncVIZgjYoZCuqzSI/x2e8oXI7Uddqc7qOb
	 hj3/P1ymU3pXZUGYDO1Y3ZPiZmckWOaXqL9DD2Yc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgBCQZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:25:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:35998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728304AbgBCQZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:25:19 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C62592080C;
        Mon,  3 Feb 2020 16:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747119;
        bh=wmjiu5PEYm5uCqktUKV3PAIyZwrB09SvsJ4xWzYRc48=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YtWmBd2oOMFdKEJi6jDYLMMHXra0GntHeC97t7pvtRjhmdEWzh0qg106aOlbVn8B7
         ad/2BIltNuM36sM1NkNAgH6xvJoV532eCzhrUn/EBfgcacVeMhHS28dt8goC2alCId
         3f3cK+BD+RR4woIjP5HtQn3kR0lj0H03rbdIjynw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 20/68] net: wan: sdla: Fix cast from pointer to integer of different size
Date:   Mon,  3 Feb 2020 16:19:16 +0000
Message-Id: <20200203161908.429641584@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161904.705434837@linuxfoundation.org>
References: <20200203161904.705434837@linuxfoundation.org>
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
index 421ac5f856994..79fd891509479 100644
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



