Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4DFC33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 13:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED5A207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 13:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgAMNFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 08:05:33 -0500
Received: from baptiste.telenet-ops.be ([195.130.132.51]:36132 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgAMNFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 08:05:33 -0500
Received: from ramsan ([84.195.182.253])
        by baptiste.telenet-ops.be with bizsmtp
        id pp5W2100k5USYZQ01p5WFA; Mon, 13 Jan 2020 14:05:31 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iqzPO-0002xH-PT; Mon, 13 Jan 2020 14:05:30 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iqzPO-00040r-Mr; Mon, 13 Jan 2020 14:05:30 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] mdio_bus: Simplify reset handling and extend to non-DT systems
Date:   Mon, 13 Jan 2020 14:05:29 +0100
Message-Id: <20200113130529.15372-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert mdiobus_register_reset() from open-coded DT-only optional reset
handling to reset_control_get_optional_exclusive().  This not only
simplifies the code, but also adds support for lookup-based resets on
non-DT systems.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Only tested on systems without PHY resets, with and without
CONFIG_RESET_CONTROLLER=y.

 drivers/net/phy/mdio_bus.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 229e480179ff1de4..8d753bb07227e561 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -59,17 +59,11 @@ static int mdiobus_register_gpiod(struct mdio_device *mdiodev)
 
 static int mdiobus_register_reset(struct mdio_device *mdiodev)
 {
-	struct reset_control *reset = NULL;
-
-	if (mdiodev->dev.of_node)
-		reset = of_reset_control_get_exclusive(mdiodev->dev.of_node,
-						       "phy");
-	if (IS_ERR(reset)) {
-		if (PTR_ERR(reset) == -ENOENT || PTR_ERR(reset) == -ENOTSUPP)
-			reset = NULL;
-		else
-			return PTR_ERR(reset);
-	}
+	struct reset_control *reset;
+
+	reset = reset_control_get_optional_exclusive(&mdiodev->dev, "phy");
+	if (IS_ERR(reset))
+		return PTR_ERR(reset);
 
 	mdiodev->reset_ctrl = reset;
 
-- 
2.17.1

