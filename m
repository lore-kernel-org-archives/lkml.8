Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11471C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E07E92065F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589483178;
	bh=8gRYW0rLglVlDQwkjPXAtEHK9dKZHTsxDbFgyBskrlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P/CClrIuYSpAG70HIJ5QbcqgAdMMRB9V901Us2WXuiRX8ccdqfDmiAYYyeIdSQrXc
	 G151sLF0twUjGDX0md5uKXM2yJgF/5vgOnM7NT5vtW/OK5BCYxI1gDr/vzzB0t+rPU
	 IEf5OgzIQYPSHOpQ1Aa7yxLHyR+EiW3w/0T2Wk0I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgENTGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 15:06:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:53472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728863AbgENSxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 14:53:52 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 875B12076A;
        Thu, 14 May 2020 18:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589482432;
        bh=8gRYW0rLglVlDQwkjPXAtEHK9dKZHTsxDbFgyBskrlY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Odb5ZEf9tdAw6ejGAN/vw6sd99Ljslsh0glBKFFmk35iISWjGwcIpgKEnhWyF1DmW
         /tAMWZ0E6NVJbXaAql2afNABgHoZcKODePXxKmjNK/KmEprTTB10R1R/ycqOSeLlDx
         hP8wBFrF2SdOMe9HuyJRjfZYIvJR4YSVCwHGajyE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Maxim Petrov <mmrmaximuzz@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 33/49] stmmac: fix pointer check after utilization in stmmac_interrupt
Date:   Thu, 14 May 2020 14:52:54 -0400
Message-Id: <20200514185311.20294-33-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514185311.20294-1-sashal@kernel.org>
References: <20200514185311.20294-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxim Petrov <mmrmaximuzz@gmail.com>

[ Upstream commit f42234ffd531ca6b13d9da02faa60b72eccf8334 ]

The paranoidal pointer check in IRQ handler looks very strange - it
really protects us only against bogus drivers which request IRQ line
with null pointer dev_id. However, the code fragment is incorrect
because the dev pointer is used before the actual check which leads
to undefined behavior. Remove the check to avoid confusing people
with incorrect code.

Signed-off-by: Maxim Petrov <mmrmaximuzz@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 89a6ae2b17e35..1623516efb171 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3832,7 +3832,7 @@ static int stmmac_set_features(struct net_device *netdev,
 /**
  *  stmmac_interrupt - main ISR
  *  @irq: interrupt number.
- *  @dev_id: to pass the net device pointer.
+ *  @dev_id: to pass the net device pointer (must be valid).
  *  Description: this is the main driver interrupt service routine.
  *  It can call:
  *  o DMA service routine (to manage incoming frame reception and transmission
@@ -3856,11 +3856,6 @@ static irqreturn_t stmmac_interrupt(int irq, void *dev_id)
 	if (priv->irq_wake)
 		pm_wakeup_event(priv->device, 0);
 
-	if (unlikely(!dev)) {
-		netdev_err(priv->dev, "%s: invalid dev pointer\n", __func__);
-		return IRQ_NONE;
-	}
-
 	/* Check if adapter is up */
 	if (test_bit(STMMAC_DOWN, &priv->state))
 		return IRQ_HANDLED;
-- 
2.20.1

