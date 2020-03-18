Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7199C43332
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA87020B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584564834;
	bh=uoVMebWe7RHvPOdPiykiNjr6bM/F83Hnq1Lu/j1MuDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WPwADtmoh6MD0pkkj4wnQ+W97R0pGWqydYwRLWLfgx/1jWl4VFQ3L5RKd0W3ZeTRw
	 vzQmfLzwsBsWawKH8fKCuwp4GPqBzv+K9kv7r3lXEkGcQ6wzdP+ff/XVLwadSCzNav
	 0E3XDzR5YUWR+Yd7hLaWA8xUgHqjqjiq2hPvgf4M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbgCRUxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 16:53:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:53030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727368AbgCRUxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 16:53:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19B0D208CA;
        Wed, 18 Mar 2020 20:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584564830;
        bh=uoVMebWe7RHvPOdPiykiNjr6bM/F83Hnq1Lu/j1MuDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ea6r4H0VKQ1aVQfaGcWLeQYGwV4OgLYejQ2NKqx/Hns6CAbB8SVHldipmvkDBJCCk
         9P3hsq3AnidONcT/n/+73sUkOmDl1uat7iF4WFuh7AZyCPwWNqYtvH2c/mOGYKVrQU
         /TkZHE++g/ke3V+kHt1ESVsikdL21TAjCHaO+fmE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Michael Walle <michael@walle.cc>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 11/73] net: phy: avoid clearing PHY interrupts twice in irq handler
Date:   Wed, 18 Mar 2020 16:52:35 -0400
Message-Id: <20200318205337.16279-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200318205337.16279-1-sashal@kernel.org>
References: <20200318205337.16279-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit 249bc9744e165abe74ae326f43e9d70bad54c3b7 ]

On all PHY drivers that implement did_interrupt() reading the interrupt
status bits clears them. This means we may loose an interrupt that
is triggered between calling did_interrupt() and phy_clear_interrupt().
As part of the fix make it a requirement that did_interrupt() clears
the interrupt.

The Fixes tag refers to the first commit where the patch applies
cleanly.

Fixes: 49644e68f472 ("net: phy: add callback for custom interrupt handler to struct phy_driver")
Reported-by: Michael Walle <michael@walle.cc>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/phy.c | 3 ++-
 include/linux/phy.h   | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 105d389b58e74..ea890d802ffe5 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -761,7 +761,8 @@ static irqreturn_t phy_interrupt(int irq, void *phy_dat)
 		phy_trigger_machine(phydev);
 	}
 
-	if (phy_clear_interrupt(phydev))
+	/* did_interrupt() may have cleared the interrupt already */
+	if (!phydev->drv->did_interrupt && phy_clear_interrupt(phydev))
 		goto phy_err;
 	return IRQ_HANDLED;
 
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 3d5d53313e6c0..bf87c59a98bb3 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -524,6 +524,7 @@ struct phy_driver {
 	/*
 	 * Checks if the PHY generated an interrupt.
 	 * For multi-PHY devices with shared PHY interrupt pin
+	 * Set interrupt bits have to be cleared.
 	 */
 	int (*did_interrupt)(struct phy_device *phydev);
 
-- 
2.20.1

