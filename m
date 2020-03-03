Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F79C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A9D20842
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 07:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbgCCHhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 02:37:22 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46637 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgCCHhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 02:37:22 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1j927E-0001po-4W; Tue, 03 Mar 2020 08:37:20 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1j927B-0000TD-11; Tue, 03 Mar 2020 08:37:17 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Marek Vasut <marex@denx.de>, David Jander <david@protonic.nl>
Subject: [PATCH v1] net: phy: tja11xx: add TJA1102 support
Date:   Tue,  3 Mar 2020 08:37:15 +0100
Message-Id: <20200303073715.32301-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TJA1102 is an dual T1 PHY chip. Both PHYs are separately addressable.
PHY 0 can be identified by PHY ID. PHY 1 has no PHY ID and can be
configured in device tree by setting compatible =
"ethernet-phy-id0180.dc81".

PHY 1 has less suported registers and functionality. For current driver
it will affect only the HWMON support.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/phy/nxp-tja11xx.c | 43 +++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/net/phy/nxp-tja11xx.c b/drivers/net/phy/nxp-tja11xx.c
index b705d0bd798b..52090cfaa54e 100644
--- a/drivers/net/phy/nxp-tja11xx.c
+++ b/drivers/net/phy/nxp-tja11xx.c
@@ -15,6 +15,7 @@
 #define PHY_ID_MASK			0xfffffff0
 #define PHY_ID_TJA1100			0x0180dc40
 #define PHY_ID_TJA1101			0x0180dd00
+#define PHY_ID_TJA1102			0x0180dc80
 
 #define MII_ECTRL			17
 #define MII_ECTRL_LINK_CONTROL		BIT(15)
@@ -190,6 +191,7 @@ static int tja11xx_config_init(struct phy_device *phydev)
 			return ret;
 		break;
 	case PHY_ID_TJA1101:
+	case PHY_ID_TJA1102:
 		ret = phy_set_bits(phydev, MII_COMMCFG, MII_COMMCFG_AUTO_OP);
 		if (ret)
 			return ret;
@@ -337,6 +339,31 @@ static int tja11xx_probe(struct phy_device *phydev)
 	if (!priv)
 		return -ENOMEM;
 
+	/* Use the phyid to distinguish between port 0 and port 1 of the
+	 * TJA1102. Port 0 has a proper phyid, while port 1 reads 0.
+	 */
+	if ((phydev->phy_id & PHY_ID_MASK) == PHY_ID_TJA1102) {
+		int ret;
+		u32 id;
+
+		ret = phy_read(phydev, MII_PHYSID1);
+		if (ret < 0)
+			return ret;
+
+		id = ret;
+		ret = phy_read(phydev, MII_PHYSID2);
+		if (ret < 0)
+			return ret;
+
+		id |= ret << 16;
+
+		/* TJA1102 Port 1 has phyid 0 and doesn't support temperature
+		 * and undervoltage alarms.
+		 */
+		if (id == 0)
+			return 0;
+	}
+
 	priv->hwmon_name = devm_kstrdup(dev, dev_name(dev), GFP_KERNEL);
 	if (!priv->hwmon_name)
 		return -ENOMEM;
@@ -385,6 +412,21 @@ static struct phy_driver tja11xx_driver[] = {
 		.get_sset_count = tja11xx_get_sset_count,
 		.get_strings	= tja11xx_get_strings,
 		.get_stats	= tja11xx_get_stats,
+	}, {
+		PHY_ID_MATCH_MODEL(PHY_ID_TJA1102),
+		.name		= "NXP TJA1102",
+		.features       = PHY_BASIC_T1_FEATURES,
+		.probe		= tja11xx_probe,
+		.soft_reset	= tja11xx_soft_reset,
+		.config_init	= tja11xx_config_init,
+		.read_status	= tja11xx_read_status,
+		.suspend	= genphy_suspend,
+		.resume		= genphy_resume,
+		.set_loopback   = genphy_loopback,
+		/* Statistics */
+		.get_sset_count = tja11xx_get_sset_count,
+		.get_strings	= tja11xx_get_strings,
+		.get_stats	= tja11xx_get_stats,
 	}
 };
 
@@ -393,6 +435,7 @@ module_phy_driver(tja11xx_driver);
 static struct mdio_device_id __maybe_unused tja11xx_tbl[] = {
 	{ PHY_ID_MATCH_MODEL(PHY_ID_TJA1100) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_TJA1101) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_TJA1102) },
 	{ }
 };
 
-- 
2.25.0

