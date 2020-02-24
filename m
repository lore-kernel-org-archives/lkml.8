Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83145C38BFF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 22:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605182176D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 22:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbgBXWyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 17:54:37 -0500
Received: from foss.arm.com ([217.140.110.172]:43878 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbgBXWyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 17:54:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6692630E;
        Mon, 24 Feb 2020 14:54:11 -0800 (PST)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.28.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 55B453F534;
        Mon, 24 Feb 2020 14:54:11 -0800 (PST)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     netdev@vger.kernel.org
Cc:     opendmb@gmail.com, f.fainelli@gmail.com, davem@davemloft.net,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, wahrenst@gmx.net, andrew@lunn.ch,
        hkallweit1@gmail.com, Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v2 2/6] net: bcmgenet: refactor phy mode configuration
Date:   Mon, 24 Feb 2020 16:53:59 -0600
Message-Id: <20200224225403.1650656-3-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200224225403.1650656-1-jeremy.linton@arm.com>
References: <20200224225403.1650656-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT phy mode is similar to what we want for ACPI
lets factor it out of the of path, and change the
of_ call to device_.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/net/ethernet/broadcom/genet/bcmmii.c | 42 ++++++++++++--------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index 6392a2530183..e7a1bf8ed36f 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -477,12 +477,33 @@ static int bcmgenet_mii_register(struct bcmgenet_priv *priv)
 	return ret;
 }
 
+static int bcmgenet_phy_interface_init(struct bcmgenet_priv *priv)
+{
+	struct device *kdev = &priv->pdev->dev;
+	int phy_mode = device_get_phy_mode(kdev);
+
+	if (phy_mode < 0) {
+		dev_err(kdev, "invalid PHY mode property\n");
+		return phy_mode;
+	}
+
+	priv->phy_interface = phy_mode;
+
+	/* We need to specifically look up whether this PHY interface is
+	 * internal or not *before* we even try to probe the PHY driver
+	 * over MDIO as we may have shut down the internal PHY for power
+	 * saving purposes.
+	 */
+	if (priv->phy_interface == PHY_INTERFACE_MODE_INTERNAL)
+		priv->internal_phy = true;
+
+	return 0;
+}
+
 static int bcmgenet_mii_of_init(struct bcmgenet_priv *priv)
 {
 	struct device_node *dn = priv->pdev->dev.of_node;
-	struct device *kdev = &priv->pdev->dev;
 	struct phy_device *phydev;
-	phy_interface_t phy_mode;
 	int ret;
 
 	/* Fetch the PHY phandle */
@@ -500,23 +521,12 @@ static int bcmgenet_mii_of_init(struct bcmgenet_priv *priv)
 	}
 
 	/* Get the link mode */
-	ret = of_get_phy_mode(dn, &phy_mode);
-	if (ret) {
-		dev_err(kdev, "invalid PHY mode property\n");
+	ret = bcmgenet_phy_interface_init(priv);
+	if (ret)
 		return ret;
-	}
-
-	priv->phy_interface = phy_mode;
-
-	/* We need to specifically look up whether this PHY interface is internal
-	 * or not *before* we even try to probe the PHY driver over MDIO as we
-	 * may have shut down the internal PHY for power saving purposes.
-	 */
-	if (priv->phy_interface == PHY_INTERFACE_MODE_INTERNAL)
-		priv->internal_phy = true;
 
 	/* Make sure we initialize MoCA PHYs with a link down */
-	if (phy_mode == PHY_INTERFACE_MODE_MOCA) {
+	if (priv->phy_interface == PHY_INTERFACE_MODE_MOCA) {
 		phydev = of_phy_find_device(dn);
 		if (phydev) {
 			phydev->link = 0;
-- 
2.24.1

