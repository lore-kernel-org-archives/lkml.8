Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D86C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 467CF208B3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wTMt38MO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbgIBPrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:47:45 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54690 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbgIBNav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 09:30:51 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 082DQ2qc053066;
        Wed, 2 Sep 2020 08:26:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599053162;
        bh=FG0xfoVeIu6JzNEiM238ECbgeUrr1zSiaAXYcKF6hxg=;
        h=From:To:CC:Subject:Date;
        b=wTMt38MOKup5/ifDQFcbxERC3bV8q5mF/uoZYqNzWE+lo/aq1E19gDXzqLN31SzCC
         YCyEgZW1jtBoww2rNva+oiLCuDtiYPhlnxj+mxzRoEfw4vsWmT5pI3038xUJeyPHGK
         LjYGYhpCZFpXMMQ/oku0OxTFBxAPEj7ZsD74zgxM=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 082DQ20C090579
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Sep 2020 08:26:02 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 2 Sep
 2020 08:26:02 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 2 Sep 2020 08:26:02 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 082DQ1vf074977;
        Wed, 2 Sep 2020 08:26:01 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <davem@davemloft.net>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
        <hkallweit1@gmail.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH net-next] net: dp83869: Add ability to advertise Fiber connection
Date:   Wed, 2 Sep 2020 08:25:56 -0500
Message-ID: <20200902132556.10285-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the ability to advertise the Fiber connection if the strap or the
op-mode is configured for 100Base-FX.

Auto negotiation is not supported on this PHY when in fiber mode.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/net/phy/dp83869.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
index 58103152c601..1acf498832f1 100644
--- a/drivers/net/phy/dp83869.c
+++ b/drivers/net/phy/dp83869.c
@@ -52,6 +52,11 @@
 					 BMCR_FULLDPLX | \
 					 BMCR_SPEED1000)
 
+#define MII_DP83869_FIBER_ADVERTISE    (ADVERTISED_TP | ADVERTISED_MII | \
+					ADVERTISED_FIBRE | ADVERTISED_BNC |  \
+					ADVERTISED_Pause | ADVERTISED_Asym_Pause | \
+					ADVERTISED_100baseT_Full)
+
 /* This is the same bit mask as the BMCR so re-use the BMCR default */
 #define DP83869_FX_CTRL_DEFAULT	MII_DP83869_BMCR_DEFAULT
 
@@ -300,6 +305,7 @@ static int dp83869_configure_mode(struct phy_device *phydev,
 {
 	int phy_ctrl_val;
 	int ret;
+	int bmcr;
 
 	if (dp83869->mode < DP83869_RGMII_COPPER_ETHERNET ||
 	    dp83869->mode > DP83869_SGMII_COPPER_ETHERNET)
@@ -383,7 +389,36 @@ static int dp83869_configure_mode(struct phy_device *phydev,
 
 		break;
 	case DP83869_RGMII_1000_BASE:
+		break;
 	case DP83869_RGMII_100_BASE:
+		/* Only allow advertising what this PHY supports */
+		linkmode_and(phydev->advertising, phydev->advertising,
+			     phydev->supported);
+
+		linkmode_set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT,
+				 phydev->supported);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT,
+				 phydev->advertising);
+
+		/* Auto neg is not supported in fiber mode */
+		bmcr = phy_read(phydev, MII_BMCR);
+		if (bmcr < 0)
+			return bmcr;
+
+		phydev->autoneg = AUTONEG_DISABLE;
+		linkmode_clear_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
+				   phydev->supported);
+		linkmode_clear_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
+				   phydev->advertising);
+
+		if (bmcr & BMCR_ANENABLE) {
+			ret =  phy_modify(phydev, MII_BMCR, BMCR_ANENABLE, 0);
+			if (ret < 0)
+				return ret;
+		}
+		ret = phy_modify_changed(phydev, MII_ADVERTISE,
+					 MII_DP83869_FIBER_ADVERTISE,
+					 MII_DP83869_FIBER_ADVERTISE);
 		break;
 	default:
 		return -EINVAL;
-- 
2.28.0

