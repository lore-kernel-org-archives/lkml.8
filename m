Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B63C55197
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DE3D21D7A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587731089;
	bh=YSLtKtKAH6VjJBxl+1YUZMR+fDeXxDz81VkSEwqDjpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Jj5nX0np8oVW7j0CUT+QYkUpPoACYtd4I3XeuzpWEN15l+eCE8rZeaIiaUQNmUIS9
	 HXh90n9mfApf0C++PyTh2H3CJefSkV/4UmNp5wT+NjkmjjZR7ikH+RRtWKLA/IIB5w
	 aSQtlYhw8ekEnjDmFMQ+Z2MeTyEARew2E8DdY4sI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgDXMYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 08:24:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:55528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728510AbgDXMYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 08:24:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5744920700;
        Fri, 24 Apr 2020 12:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587731082;
        bh=YSLtKtKAH6VjJBxl+1YUZMR+fDeXxDz81VkSEwqDjpg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lKOLc+Qt60kHbO8MdP2Ll84hJ6r4qjVcCNBksnTXWUMIcFqMVOhYA6e9Q0z/UlRJ7
         7s2+dKZ6XeiJEoFM6ua2OIpLhfyy4vWXZfZRpCW3zFGJ6/6WpEu8t/INC25LAw0yJM
         wrfvVxS+EigAmxE/lM54qlJp36DAdragydXa4r2s=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 18/21] amd-xgbe: Use __napi_schedule() in BH context
Date:   Fri, 24 Apr 2020 08:24:16 -0400
Message-Id: <20200424122419.10648-18-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200424122419.10648-1-sashal@kernel.org>
References: <20200424122419.10648-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit d518691cbd3be3dae218e05cca3f3fc9b2f1aa77 ]

The driver uses __napi_schedule_irqoff() which is fine as long as it is
invoked with disabled interrupts by everybody. Since the commit
mentioned below the driver may invoke xgbe_isr_task() in tasklet/softirq
context. This may lead to list corruption if another driver uses
__napi_schedule_irqoff() in IRQ context.

Use __napi_schedule() which safe to use from IRQ and softirq context.

Fixes: 85b85c853401d ("amd-xgbe: Re-issue interrupt if interrupt status not cleared")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index c65d2cdcc7cfb..8556962e68244 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -515,7 +515,7 @@ static void xgbe_isr_task(unsigned long data)
 				xgbe_disable_rx_tx_ints(pdata);
 
 				/* Turn on polling */
-				__napi_schedule_irqoff(&pdata->napi);
+				__napi_schedule(&pdata->napi);
 			}
 		} else {
 			/* Don't clear Rx/Tx status if doing per channel DMA
-- 
2.20.1

