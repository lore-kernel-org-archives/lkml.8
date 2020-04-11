Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C09FC2BBFD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C6E42137B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586607533;
	bh=XK80WFjCFM0+ej1+ead99YTMoIFBiX/cPmEjWmGYqzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xTtP4V6YPc10ACP38t+divlNAstBBLZ/toduyJVX3KRWnfbkOuhpVPMNU/u6YiREA
	 nU5WKn1SqQkK2GnO6muNc9HQumXyLzWjAAmfTKLV4P+oga2oyWJEZhf4T/rD3isIE/
	 8+LVfGI+xxKK/A85msKdsNkk417LYZurmwvlntts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbgDKMSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:18:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:53876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728667AbgDKMSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 08:18:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D5FB20692;
        Sat, 11 Apr 2020 12:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586607527;
        bh=XK80WFjCFM0+ej1+ead99YTMoIFBiX/cPmEjWmGYqzI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oW5CPjTuJI+NPlfcj64Uk2qFjwBlQdKh3TZeohHIPpxl3EIXoteAdEZwp63aowy1L
         ZRPmldFixCk3LJaoTL26Q517ToUOSvaMs81ZJg5LMqvfWsLaajdWaPQYnYlG/lV1bc
         vTU8gORyZUt91Nk9x3H38W+yViVAo/SplpghoIAM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.5 15/44] net: phy: at803x: fix clock sink configuration on ATH8030 and ATH8035
Date:   Sat, 11 Apr 2020 14:09:35 +0200
Message-Id: <20200411115458.182861396@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200411115456.934174282@linuxfoundation.org>
References: <20200411115456.934174282@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/at803x.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -425,8 +425,8 @@ static int at803x_parse_dt(struct phy_de
 		 */
 		if (at803x_match_phy_id(phydev, ATH8030_PHY_ID) ||
 		    at803x_match_phy_id(phydev, ATH8035_PHY_ID)) {
-			priv->clk_25m_reg &= ~AT8035_CLK_OUT_MASK;
-			priv->clk_25m_mask &= ~AT8035_CLK_OUT_MASK;
+			priv->clk_25m_reg &= AT8035_CLK_OUT_MASK;
+			priv->clk_25m_mask &= AT8035_CLK_OUT_MASK;
 		}
 	}
 


