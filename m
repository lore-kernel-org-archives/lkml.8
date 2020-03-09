Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00855C10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 07:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE9AB20675
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 07:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgCIHkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 03:40:53 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:32845 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCIHkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 03:40:52 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jBD1r-00047b-VO; Mon, 09 Mar 2020 08:40:47 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jBD1q-0006OB-Nj; Mon, 09 Mar 2020 08:40:46 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Marek Vasut <marex@denx.de>, David Jander <david@protonic.nl>
Subject: [PATCH v2 1/2] net: phy: tja11xx: add TJA1102 support
Date:   Mon,  9 Mar 2020 08:40:43 +0100
Message-Id: <20200309074044.21399-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200309074044.21399-1-o.rempel@pengutronix.de>
References: <20200309074044.21399-1-o.rempel@pengutronix.de>
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
configured in device tree by setting compatible = "ethernet-phy-id0180.dc81".

PHY 1 has less supported registers and functionality. For current driver
it will affect only the HWMON support.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/phy/nxp-tja11xx.c | 102 ++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/drivers/net/phy/nxp-tja11xx.c b/drivers/net/phy/nxp-tja11xx.c
index b705d0bd798b..f79c9aa051ed 100644
--- a/drivers/net/phy/nxp-tja11xx.c
+++ b/drivers/net/phy/nxp-tja11xx.c
@@ -15,6 +15,7 @@
 #define PHY_ID_MASK			0xfffffff0
 #define PHY_ID_TJA1100			0x0180dc40
 #define PHY_ID_TJA1101			0x0180dd00
+#define PHY_ID_TJA1102			0x0180dc80
 
 #define MII_ECTRL			17
 #define MII_ECTRL_LINK_CONTROL		BIT(15)
@@ -40,6 +41,10 @@
 #define MII_INTSRC_TEMP_ERR		BIT(1)
 #define MII_INTSRC_UV_ERR		BIT(3)
 
+#define MII_INTEN			22
+#define MII_INTEN_LINK_FAIL		BIT(10)
+#define MII_INTEN_LINK_UP		BIT(9)
+
 #define MII_COMMSTAT			23
 #define MII_COMMSTAT_LINK_UP		BIT(15)
 
@@ -190,6 +195,7 @@ static int tja11xx_config_init(struct phy_device *phydev)
 			return ret;
 		break;
 	case PHY_ID_TJA1101:
+	case PHY_ID_TJA1102:
 		ret = phy_set_bits(phydev, MII_COMMCFG, MII_COMMCFG_AUTO_OP);
 		if (ret)
 			return ret;
@@ -354,6 +360,66 @@ static int tja11xx_probe(struct phy_device *phydev)
 	return PTR_ERR_OR_ZERO(priv->hwmon_dev);
 }
 
+static int tja1102_match_phy_device(struct phy_device *phydev, bool port0)
+{
+	int ret;
+
+	if ((phydev->phy_id & PHY_ID_MASK) != PHY_ID_TJA1102)
+		return 0;
+
+	ret = phy_read(phydev, MII_PHYSID2);
+	if (ret < 0)
+		return ret;
+
+	/* TJA1102 Port 1 has phyid 0 and doesn't support temperature
+	 * and undervoltage alarms.
+	 */
+	if (port0)
+		return ret ? 1 : 0;
+
+	return !ret;
+}
+
+static int tja1102_p0_match_phy_device(struct phy_device *phydev)
+{
+	return tja1102_match_phy_device(phydev, true);
+}
+
+static int tja1102_p1_match_phy_device(struct phy_device *phydev)
+{
+	return tja1102_match_phy_device(phydev, false);
+}
+
+static int tja11xx_ack_interrupt(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = phy_read(phydev, MII_INTSRC);
+
+	return (ret < 0) ? ret : 0;
+}
+
+static int tja11xx_config_intr(struct phy_device *phydev)
+{
+	int value;
+	int ret;
+
+	value = phy_read(phydev, MII_INTEN);
+	if (value < 0)
+		return value;
+
+	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
+		value |= MII_INTEN_LINK_FAIL;
+		value |= MII_INTEN_LINK_UP;
+
+		ret = phy_write(phydev, MII_INTEN, value);
+	}
+	else
+		ret = phy_write(phydev, MII_INTEN, 0);
+
+	return ret;
+}
+
 static struct phy_driver tja11xx_driver[] = {
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_TJA1100),
@@ -385,6 +451,41 @@ static struct phy_driver tja11xx_driver[] = {
 		.get_sset_count = tja11xx_get_sset_count,
 		.get_strings	= tja11xx_get_strings,
 		.get_stats	= tja11xx_get_stats,
+	}, {
+		.name		= "NXP TJA1102 Port 0",
+		.features       = PHY_BASIC_T1_FEATURES,
+		.probe		= tja11xx_probe,
+		.soft_reset	= tja11xx_soft_reset,
+		.config_init	= tja11xx_config_init,
+		.read_status	= tja11xx_read_status,
+		.match_phy_device = tja1102_p0_match_phy_device,
+		.suspend	= genphy_suspend,
+		.resume		= genphy_resume,
+		.set_loopback   = genphy_loopback,
+		/* Statistics */
+		.get_sset_count = tja11xx_get_sset_count,
+		.get_strings	= tja11xx_get_strings,
+		.get_stats	= tja11xx_get_stats,
+		.ack_interrupt	= tja11xx_ack_interrupt,
+		.config_intr	= tja11xx_config_intr,
+
+	}, {
+		.name		= "NXP TJA1102 Port 1",
+		.features       = PHY_BASIC_T1_FEATURES,
+		/* currently no probe for Port 1 is need */
+		.soft_reset	= tja11xx_soft_reset,
+		.config_init	= tja11xx_config_init,
+		.read_status	= tja11xx_read_status,
+		.match_phy_device = tja1102_p1_match_phy_device,
+		.suspend	= genphy_suspend,
+		.resume		= genphy_resume,
+		.set_loopback   = genphy_loopback,
+		/* Statistics */
+		.get_sset_count = tja11xx_get_sset_count,
+		.get_strings	= tja11xx_get_strings,
+		.get_stats	= tja11xx_get_stats,
+		.ack_interrupt	= tja11xx_ack_interrupt,
+		.config_intr	= tja11xx_config_intr,
 	}
 };
 
@@ -393,6 +494,7 @@ module_phy_driver(tja11xx_driver);
 static struct mdio_device_id __maybe_unused tja11xx_tbl[] = {
 	{ PHY_ID_MATCH_MODEL(PHY_ID_TJA1100) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_TJA1101) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_TJA1102) },
 	{ }
 };
 
-- 
2.25.1

