Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41ABC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 23:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD35320771
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 23:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XbsdunOd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731453AbgGUX32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 19:29:28 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:47328 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgGUX3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 19:29:25 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06LNTPnF008444
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 18:29:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595374165;
        bh=M57k5GNdOhuFYfIUg8vfITWLthlh55K2f8tW0oPt63g=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=XbsdunOdgIHRtKISife1AzQZ3TmsmOpjqDMvk4X+NSDForthxPpjrZG1Iy1pI3oBu
         45ndBXQLrtm85awYCukuyrMGieqj3lMzd6e7MmzRw+nSpwNHy+7bVXa0e8zdP7AfGZ
         3YEzcIevoKkg/2qmrTVmhtD9LCBmwLxgvraJOWpA=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06LNTOVq096967
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 18:29:24 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 21
 Jul 2020 18:29:24 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 21 Jul 2020 18:29:24 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06LNTNmm116815;
        Tue, 21 Jul 2020 18:29:23 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 2/3] phy: ti: gmii-sel: use features mask during init
Date:   Wed, 22 Jul 2020 02:29:12 +0300
Message-ID: <20200721232913.4979-3-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200721232913.4979-1-grygorii.strashko@ti.com>
References: <20200721232913.4979-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use features mask during PHYs initialization to simplify code.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/phy/ti/phy-gmii-sel.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/ti/phy-gmii-sel.c b/drivers/phy/ti/phy-gmii-sel.c
index d4b02ad023b2..a6b7f22e85c4 100644
--- a/drivers/phy/ti/phy-gmii-sel.c
+++ b/drivers/phy/ti/phy-gmii-sel.c
@@ -147,13 +147,9 @@ static const
 struct reg_field phy_gmii_sel_fields_dra7[][PHY_GMII_SEL_LAST] = {
 	{
 		[PHY_GMII_SEL_PORT_MODE] = REG_FIELD(0x554, 0, 1),
-		[PHY_GMII_SEL_RGMII_ID_MODE] = REG_FIELD((~0), 0, 0),
-		[PHY_GMII_SEL_RMII_IO_CLK_EN] = REG_FIELD((~0), 0, 0),
 	},
 	{
 		[PHY_GMII_SEL_PORT_MODE] = REG_FIELD(0x554, 4, 5),
-		[PHY_GMII_SEL_RGMII_ID_MODE] = REG_FIELD((~0), 0, 0),
-		[PHY_GMII_SEL_RMII_IO_CLK_EN] = REG_FIELD((~0), 0, 0),
 	},
 };
 
@@ -174,8 +170,6 @@ static const
 struct reg_field phy_gmii_sel_fields_am654[][PHY_GMII_SEL_LAST] = {
 	{
 		[PHY_GMII_SEL_PORT_MODE] = REG_FIELD(0x4040, 0, 1),
-		[PHY_GMII_SEL_RGMII_ID_MODE] = REG_FIELD((~0), 0, 0),
-		[PHY_GMII_SEL_RMII_IO_CLK_EN] = REG_FIELD((~0), 0, 0),
 	},
 };
 
@@ -266,7 +260,7 @@ static int phy_gmii_init_phy(struct phy_gmii_sel_priv *priv, int port,
 	if_phy->fields[PHY_GMII_SEL_PORT_MODE] = regfield;
 
 	field = *fields++;
-	if (field.reg != (~0)) {
+	if (soc_data->features & BIT(PHY_GMII_SEL_RGMII_ID_MODE)) {
 		regfield = devm_regmap_field_alloc(dev,
 						   priv->regmap,
 						   field);
@@ -278,7 +272,7 @@ static int phy_gmii_init_phy(struct phy_gmii_sel_priv *priv, int port,
 	}
 
 	field = *fields;
-	if (field.reg != (~0)) {
+	if (soc_data->features & BIT(PHY_GMII_SEL_RMII_IO_CLK_EN)) {
 		regfield = devm_regmap_field_alloc(dev,
 						   priv->regmap,
 						   field);
-- 
2.17.1

