Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31334C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0362820885
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592446923;
	bh=vM6Lnc7iSV1gQ+48IRh6IG8LuG+x2QF739G8EG3STGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kgZpWdZVlD9vZobYDtp2ajwAVH4eqzNS2k9xRA+iGi/zH0D/kepGx35UKH/quu5oa
	 vTkFEcvMZUJa9keMUiv1PC3KkZKbl3P/R7pEbtVH1qr8uH150RWK3VTjRqTJfwIuoR
	 a5/NQIO2qWQMoPI+Y5oBOutIdBF95dWEsn6xGorU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbgFRBSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:18:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:45660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729487AbgFRBPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:15:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91E0821D79;
        Thu, 18 Jun 2020 01:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442933;
        bh=vM6Lnc7iSV1gQ+48IRh6IG8LuG+x2QF739G8EG3STGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cogJLe8CA7pCD2LAdziux70IACbPAQQdN4K9imkQJuhtRfzhzSGJqD3qzW0mP2L5e
         x+dxHOObFBvsKHh9hGD1FXG7nNc8oYdJZgA1mVZJDG+/1gP61w3HMeade/3yx+wJrg
         oNqmjX4IG2twh95AdrBM3YwPxVqFauBq0sqnmUTo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Murphy <dmurphy@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 346/388] net: mscc: Fix OF_MDIO config check
Date:   Wed, 17 Jun 2020 21:07:23 -0400
Message-Id: <20200618010805.600873-346-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Murphy <dmurphy@ti.com>

[ Upstream commit ae602786407fef34e1d66b3c8f278a10ed37197e ]

When CONFIG_OF_MDIO is set to be a module the code block is not
compiled. Use the IS_ENABLED macro that checks for both built in as
well as module.

Fixes: 4f58e6dceb0e4 ("net: phy: Cleanup the Edge-Rate feature in Microsemi PHYs.")
Signed-off-by: Dan Murphy <dmurphy@ti.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/mscc/mscc.h      | 2 +-
 drivers/net/phy/mscc/mscc_main.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/mscc/mscc.h b/drivers/net/phy/mscc/mscc.h
index 414e3b31bb1f..132f9bf49198 100644
--- a/drivers/net/phy/mscc/mscc.h
+++ b/drivers/net/phy/mscc/mscc.h
@@ -375,7 +375,7 @@ struct vsc8531_private {
 #endif
 };
 
-#ifdef CONFIG_OF_MDIO
+#if IS_ENABLED(CONFIG_OF_MDIO)
 struct vsc8531_edge_rate_table {
 	u32 vddmac;
 	u32 slowdown[8];
diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
index c8aa6d905d8e..485a4f8a6a9a 100644
--- a/drivers/net/phy/mscc/mscc_main.c
+++ b/drivers/net/phy/mscc/mscc_main.c
@@ -98,7 +98,7 @@ static const struct vsc85xx_hw_stat vsc8584_hw_stats[] = {
 	},
 };
 
-#ifdef CONFIG_OF_MDIO
+#if IS_ENABLED(CONFIG_OF_MDIO)
 static const struct vsc8531_edge_rate_table edge_table[] = {
 	{MSCC_VDDMAC_3300, { 0, 2,  4,  7, 10, 17, 29, 53} },
 	{MSCC_VDDMAC_2500, { 0, 3,  6, 10, 14, 23, 37, 63} },
@@ -382,7 +382,7 @@ static void vsc85xx_wol_get(struct phy_device *phydev,
 	mutex_unlock(&phydev->lock);
 }
 
-#ifdef CONFIG_OF_MDIO
+#if IS_ENABLED(CONFIG_OF_MDIO)
 static int vsc85xx_edge_rate_magic_get(struct phy_device *phydev)
 {
 	u32 vdd, sd;
-- 
2.25.1

