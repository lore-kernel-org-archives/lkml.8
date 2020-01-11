Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730D7C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46190205F4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578737884;
	bh=qFaFhA/v8t/Rov8CR3MaVpvPyNkIPH9jwaowkLAYxUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tb3kC9QUuq/PSnBYGfab+gtdApIfb14vZwWsqrk+A9TP2+KrJl0dNt/DGfx5aJF+F
	 L8lpYKrw7WbykWGQdRCJHrVnvhFKUYPLscmae2l77ObSIBbR36jKCxsag+0T7R2nic
	 xh5c752A/5cFcLHmcO/8ZEWWXzvSsDAmx5aiSceY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730434AbgAKKSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:18:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:35358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730511AbgAKKR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:17:56 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D0F1205F4;
        Sat, 11 Jan 2020 10:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578737876;
        bh=qFaFhA/v8t/Rov8CR3MaVpvPyNkIPH9jwaowkLAYxUY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bABpykEpirfWMCUk5jge3L3tj7CuKQJ4JawLdverMaG8WDnFYv7j4CIJbdXFCaoKs
         RVfTLOZcCGnN4rXqADiGpNYYGISzFX9iaYHmLxy7GuL0jK0IISvR0r2dA74TNNOVWK
         EB/YNbv9cXns5gFs/PkuiqltGegyTjaNEuc9xhoc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 49/84] net: stmmac: xgmac: Clear previous RX buffer size
Date:   Sat, 11 Jan 2020 10:50:26 +0100
Message-Id: <20200111094905.013686656@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094845.328046411@linuxfoundation.org>
References: <20200111094845.328046411@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jose Abreu <Jose.Abreu@synopsys.com>

[ Upstream commit 11d55fd9975f8e46a0e5e19c14899544e81e1e15 ]

When switching between buffer sizes we need to clear the previous value.

Fixes: d6ddfacd95c7 ("net: stmmac: Add DMA related callbacks for XGMAC2")
Signed-off-by: Jose Abreu <Jose.Abreu@synopsys.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     | 2 ++
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 0a80fa25afe3..209745294751 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -169,6 +169,8 @@
 #define XGMAC_DMA_CH_RX_CONTROL(x)	(0x00003108 + (0x80 * (x)))
 #define XGMAC_RxPBL			GENMASK(21, 16)
 #define XGMAC_RxPBL_SHIFT		16
+#define XGMAC_RBSZ			GENMASK(14, 1)
+#define XGMAC_RBSZ_SHIFT		1
 #define XGMAC_RXST			BIT(0)
 #define XGMAC_DMA_CH_TxDESC_LADDR(x)	(0x00003114 + (0x80 * (x)))
 #define XGMAC_DMA_CH_RxDESC_LADDR(x)	(0x0000311c + (0x80 * (x)))
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index 1c3930527444..27942c53b567 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -379,7 +379,8 @@ static void dwxgmac2_set_bfsize(void __iomem *ioaddr, int bfsize, u32 chan)
 	u32 value;
 
 	value = readl(ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
-	value |= bfsize << 1;
+	value &= ~XGMAC_RBSZ;
+	value |= bfsize << XGMAC_RBSZ_SHIFT;
 	writel(value, ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
 }
 
-- 
2.20.1



