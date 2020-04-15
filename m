Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E62FC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 11:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BA6A206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 11:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586950873;
	bh=AGjX8jH2jQ+NeiGiHoUkxLgcU6FjIhrUWfrpcpKJaY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wmC0FqXJS9bvei0VMYrtzsCjSUj3epokPXHaMVVnDF8XM1h49pXnJbr3Bqf0bbO2j
	 gPak8hQ/r6V9b3KAdPTYH5pG9ldp04hb10FJV/A8zREwL6YcNVXSlB0riDTAnqYlg8
	 SjgZWjh8ZKtCf73jrLkfoR+eG1P+zu43i9mP61LI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897387AbgDOLlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 07:41:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:54800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897105AbgDOLgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:36:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FFA620737;
        Wed, 15 Apr 2020 11:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586950562;
        bh=AGjX8jH2jQ+NeiGiHoUkxLgcU6FjIhrUWfrpcpKJaY8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PY1VjGmN83HD+9DTnXzmndCj10DRNaeIMAe51k4tlNio6ySbkZCUJyIgbKKDF5ezO
         7K/OKqXtxNpnR82v2gCjd4jrJUdGoabK5De8LDHKdlxrSGcbhYynrnr8ky8UgBUTk4
         MEJbwLiP7QrxLXQJSawVmS7RHEBgSHeOf5FthIds=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 066/129] net: phy: at803x: fix clock sink configuration on ATH8030 and ATH8035
Date:   Wed, 15 Apr 2020 07:33:41 -0400
Message-Id: <20200415113445.11881-66-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415113445.11881-1-sashal@kernel.org>
References: <20200415113445.11881-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksij Rempel <o.rempel@pengutronix.de>

[ Upstream commit b1f4c209d84057b6d40b939b6e4404854271d797 ]

The masks in priv->clk_25m_reg and priv->clk_25m_mask are one-bits-set
for the values that comprise the fields, not zero-bits-set.

This patch fixes the clock frequency configuration for ATH8030 and
ATH8035 Atheros PHYs by removing the erroneous "~".

To reproduce this bug, configure the PHY  with the device tree binding
"qca,clk-out-frequency" and remove the machine specific PHY fixups.

Fixes: 2f664823a47021 ("net: phy: at803x: add device tree binding")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reported-by: Russell King <rmk+kernel@armlinux.org.uk>
Reviewed-by: Russell King <rmk+kernel@armlinux.org.uk>
Tested-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/at803x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 481cf48c9b9e4..31f731e6df720 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -425,8 +425,8 @@ static int at803x_parse_dt(struct phy_device *phydev)
 		 */
 		if (at803x_match_phy_id(phydev, ATH8030_PHY_ID) ||
 		    at803x_match_phy_id(phydev, ATH8035_PHY_ID)) {
-			priv->clk_25m_reg &= ~AT8035_CLK_OUT_MASK;
-			priv->clk_25m_mask &= ~AT8035_CLK_OUT_MASK;
+			priv->clk_25m_reg &= AT8035_CLK_OUT_MASK;
+			priv->clk_25m_mask &= AT8035_CLK_OUT_MASK;
 		}
 	}
 
-- 
2.20.1

