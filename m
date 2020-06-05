Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8522EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57B432074B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbgFEOCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 10:02:33 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:34545 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbgFEOCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 10:02:33 -0400
Received: from localhost (lfbn-tou-1-1075-236.w90-76.abo.wanadoo.fr [90.76.143.236])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id EE714100010;
        Fri,  5 Jun 2020 14:02:28 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com,
        hkallweit1@gmail.com
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>, michael@walle.cc,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net] net: phy: mscc: fix Serdes configuration in vsc8584_config_init
Date:   Fri,  5 Jun 2020 16:00:09 +0200
Message-Id: <20200605140009.1352990-1-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When converting the MSCC PHY driver to shared PHY packages, the Serdes
configuration in vsc8584_config_init was modified to use 'base_addr'
instead of 'base' as the port number. But 'base_addr' isn't equal to
'addr' for all PHYs inside the package, which leads to the Serdes still
being enabled on those ports. This patch fixes it.

Fixes: deb04e9c0ff2 ("net: phy: mscc: use phy_package_shared")
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/phy/mscc/mscc_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
index 7ed0285206d0..24687ac5ee14 100644
--- a/drivers/net/phy/mscc/mscc_main.c
+++ b/drivers/net/phy/mscc/mscc_main.c
@@ -1396,7 +1396,7 @@ static int vsc8584_config_init(struct phy_device *phydev)
 
 	/* Disable SerDes for 100Base-FX */
 	ret = vsc8584_cmd(phydev, PROC_CMD_FIBER_MEDIA_CONF |
-			  PROC_CMD_FIBER_PORT(vsc8531->base_addr) |
+			  PROC_CMD_FIBER_PORT(vsc8531->addr) |
 			  PROC_CMD_FIBER_DISABLE |
 			  PROC_CMD_READ_MOD_WRITE_PORT |
 			  PROC_CMD_RST_CONF_PORT | PROC_CMD_FIBER_100BASE_FX);
@@ -1405,7 +1405,7 @@ static int vsc8584_config_init(struct phy_device *phydev)
 
 	/* Disable SerDes for 1000Base-X */
 	ret = vsc8584_cmd(phydev, PROC_CMD_FIBER_MEDIA_CONF |
-			  PROC_CMD_FIBER_PORT(vsc8531->base_addr) |
+			  PROC_CMD_FIBER_PORT(vsc8531->addr) |
 			  PROC_CMD_FIBER_DISABLE |
 			  PROC_CMD_READ_MOD_WRITE_PORT |
 			  PROC_CMD_RST_CONF_PORT | PROC_CMD_FIBER_1000BASE_X);
-- 
2.26.2

