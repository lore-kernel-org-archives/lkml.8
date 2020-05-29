Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E172DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 09:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C36BE2074B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 09:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgE2Jt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 05:49:26 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:52263 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgE2JtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 05:49:24 -0400
X-Originating-IP: 90.76.143.236
Received: from localhost (lfbn-tou-1-1075-236.w90-76.abo.wanadoo.fr [90.76.143.236])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id A09391C0012;
        Fri, 29 May 2020 09:49:21 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com,
        hkallweit1@gmail.com
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>, michael@walle.cc,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: phy: mscc: fix PHYs using the vsc8574_probe
Date:   Fri, 29 May 2020 11:49:09 +0200
Message-Id: <20200529094909.1254629-1-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PHYs using the vsc8574_probe fail to be initialized and their
config_init return -EIO leading to errors like:
"could not attach PHY: -5".

This is because when the conversion of the MSCC PHY driver to use the
shared PHY package helpers was done, the base address retrieval and the
base PHY read and write helpers in the driver were modified. In
particular, the base address retrieval logic was moved from the
config_init to the probe. But the vsc8574_probe was forgotten. This
patch fixes it.

Fixes: deb04e9c0ff2 ("net: phy: mscc: use phy_package_shared")
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---

Hello,

While the patch has a Fixes: tag, it's sent to net-next as commit
deb04e9c0ff2 only is in net-next. This patch do not have to be
backported to any prior version.

Thanks!
Antoine

 drivers/net/phy/mscc/mscc_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
index 550acf547ced..7ed0285206d0 100644
--- a/drivers/net/phy/mscc/mscc_main.c
+++ b/drivers/net/phy/mscc/mscc_main.c
@@ -1977,6 +1977,10 @@ static int vsc8574_probe(struct phy_device *phydev)
 
 	phydev->priv = vsc8531;
 
+	vsc8584_get_base_addr(phydev);
+	devm_phy_package_join(&phydev->mdio.dev, phydev,
+			      vsc8531->base_addr, 0);
+
 	vsc8531->nleds = 4;
 	vsc8531->supp_led_modes = VSC8584_SUPP_LED_MODES;
 	vsc8531->hw_stats = vsc8584_hw_stats;
-- 
2.26.2

