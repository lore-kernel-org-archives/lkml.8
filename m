Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E7FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 10:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D47A2073B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 10:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731858AbgEZKIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 06:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbgEZKIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 06:08:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE55C03E97E
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 03:08:31 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jdWVZ-0002iL-3Y; Tue, 26 May 2020 12:08:29 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jdWVU-0000cb-K3; Tue, 26 May 2020 12:08:24 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH net-next v1] net: phy: at803x: add cable diagnostics support for ATH9331 and ATH8032
Date:   Tue, 26 May 2020 12:08:23 +0200
Message-Id: <20200526100823.2331-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.26.2
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

Add support for Atheros 100Bast-T PHYs. The only difference seems to be
the ability to test 2 pares instead of 4 and the lack of 1000Bast-T
specific register.

Only ATH9331 was tested with this patch.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/phy/at803x.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index acd51b29a476b..4b9dd43b5b5bf 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -920,10 +920,16 @@ static int at803x_cable_test_one_pair(struct phy_device *phydev, int pair)
 static int at803x_cable_test_get_status(struct phy_device *phydev,
 					bool *finished)
 {
-	unsigned long pair_mask = 0xf;
+	unsigned long pair_mask;
 	int retries = 20;
 	int pair, ret;
 
+	if (phydev->phy_id == ATH9331_PHY_ID ||
+	    phydev->phy_id == ATH8032_PHY_ID)
+		pair_mask = 0x3;
+	else
+		pair_mask = 0xf;
+
 	*finished = false;
 
 	/* According to the datasheet the CDT can be performed when
@@ -958,7 +964,9 @@ static int at803x_cable_test_start(struct phy_device *phydev)
 	 */
 	phy_write(phydev, MII_BMCR, BMCR_ANENABLE);
 	phy_write(phydev, MII_ADVERTISE, ADVERTISE_CSMA);
-	phy_write(phydev, MII_CTRL1000, 0);
+	if (phydev->phy_id != ATH9331_PHY_ID &&
+	    phydev->phy_id != ATH8032_PHY_ID)
+		phy_write(phydev, MII_CTRL1000, 0);
 
 	/* we do all the (time consuming) work later */
 	return 0;
@@ -1032,6 +1040,7 @@ static struct phy_driver at803x_driver[] = {
 	.name			= "Qualcomm Atheros AR8032",
 	.probe			= at803x_probe,
 	.remove			= at803x_remove,
+	.flags			= PHY_POLL_CABLE_TEST,
 	.config_init		= at803x_config_init,
 	.link_change_notify	= at803x_link_change_notify,
 	.set_wol		= at803x_set_wol,
@@ -1041,15 +1050,20 @@ static struct phy_driver at803x_driver[] = {
 	/* PHY_BASIC_FEATURES */
 	.ack_interrupt		= at803x_ack_interrupt,
 	.config_intr		= at803x_config_intr,
+	.cable_test_start	= at803x_cable_test_start,
+	.cable_test_get_status	= at803x_cable_test_get_status,
 }, {
 	/* ATHEROS AR9331 */
 	PHY_ID_MATCH_EXACT(ATH9331_PHY_ID),
 	.name			= "Qualcomm Atheros AR9331 built-in PHY",
 	.suspend		= at803x_suspend,
 	.resume			= at803x_resume,
+	.flags			= PHY_POLL_CABLE_TEST,
 	/* PHY_BASIC_FEATURES */
 	.ack_interrupt		= &at803x_ack_interrupt,
 	.config_intr		= &at803x_config_intr,
+	.cable_test_start	= at803x_cable_test_start,
+	.cable_test_get_status	= at803x_cable_test_get_status,
 } };
 
 module_phy_driver(at803x_driver);
-- 
2.26.2

