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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC25AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 23:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8378D2073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 23:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZrKX6ePg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731434AbgGUX3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 19:29:24 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42346 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgGUX3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 19:29:24 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06LNTNZ5121968
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 18:29:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595374163;
        bh=GPBIRBxSaqSX1gRvjRUGO8/oXfm/CjOWaKbp5f1GVp8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ZrKX6ePgdmdSRfmpR4z3a4qa4zw76xmgKgSvxUtjOxvlHWBFhZ/y3HGiUVQzXb8bz
         IHiMoFqN3LhBA0ZwJZMC9YI9kLScr6H8/+du6BY0lf26KG9+hWwwfHvikQgPCACed6
         5zvE0zc1aXVONJ6Ceqti+b4xrZwRHeKQHc10lzMg=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06LNTNkn127143
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 18:29:23 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 21
 Jul 2020 18:29:22 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 21 Jul 2020 18:29:22 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06LNTL24007717;
        Tue, 21 Jul 2020 18:29:21 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 1/3] phy: ti: gmii-sel: move phy init in separate function
Date:   Wed, 22 Jul 2020 02:29:11 +0300
Message-ID: <20200721232913.4979-2-grygorii.strashko@ti.com>
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

Move phy initialization in separate function to improve code readability
and simplify future changes.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/phy/ti/phy-gmii-sel.c | 111 ++++++++++++++++++++--------------
 1 file changed, 64 insertions(+), 47 deletions(-)

diff --git a/drivers/phy/ti/phy-gmii-sel.c b/drivers/phy/ti/phy-gmii-sel.c
index 7edd5c3bc536..d4b02ad023b2 100644
--- a/drivers/phy/ti/phy-gmii-sel.c
+++ b/drivers/phy/ti/phy-gmii-sel.c
@@ -22,7 +22,7 @@
 #define AM33XX_GMII_SEL_MODE_RGMII	2
 
 enum {
-	PHY_GMII_SEL_PORT_MODE,
+	PHY_GMII_SEL_PORT_MODE = 0,
 	PHY_GMII_SEL_RGMII_ID_MODE,
 	PHY_GMII_SEL_RMII_IO_CLK_EN,
 	PHY_GMII_SEL_LAST,
@@ -242,6 +242,66 @@ static struct phy *phy_gmii_sel_of_xlate(struct device *dev,
 	return priv->if_phys[phy_id].if_phy;
 }
 
+static int phy_gmii_init_phy(struct phy_gmii_sel_priv *priv, int port,
+			     struct phy_gmii_sel_phy_priv *if_phy)
+{
+	const struct phy_gmii_sel_soc_data *soc_data = priv->soc_data;
+	struct device *dev = priv->dev;
+	const struct reg_field *fields;
+	struct regmap_field *regfield;
+	struct reg_field field;
+	int ret;
+
+	if_phy->id = port;
+	if_phy->priv = priv;
+
+	fields = soc_data->regfields[port - 1];
+	field = *fields++;
+	dev_dbg(dev, "%s field %x %d %d\n", __func__,
+		field.reg, field.msb, field.lsb);
+
+	regfield = devm_regmap_field_alloc(dev, priv->regmap, field);
+	if (IS_ERR(regfield))
+		return PTR_ERR(regfield);
+	if_phy->fields[PHY_GMII_SEL_PORT_MODE] = regfield;
+
+	field = *fields++;
+	if (field.reg != (~0)) {
+		regfield = devm_regmap_field_alloc(dev,
+						   priv->regmap,
+						   field);
+		if (IS_ERR(regfield))
+			return PTR_ERR(regfield);
+		if_phy->fields[PHY_GMII_SEL_RGMII_ID_MODE] = regfield;
+		dev_dbg(dev, "%s field %x %d %d\n", __func__,
+			field.reg, field.msb, field.lsb);
+	}
+
+	field = *fields;
+	if (field.reg != (~0)) {
+		regfield = devm_regmap_field_alloc(dev,
+						   priv->regmap,
+						   field);
+		if (IS_ERR(regfield))
+			return PTR_ERR(regfield);
+		if_phy->fields[PHY_GMII_SEL_RMII_IO_CLK_EN] = regfield;
+		dev_dbg(dev, "%s field %x %d %d\n", __func__,
+			field.reg, field.msb, field.lsb);
+	}
+
+	if_phy->if_phy = devm_phy_create(dev,
+					 priv->dev->of_node,
+					 &phy_gmii_sel_ops);
+	if (IS_ERR(if_phy->if_phy)) {
+		ret = PTR_ERR(if_phy->if_phy);
+		dev_err(dev, "Failed to create phy%d %d\n", port, ret);
+		return ret;
+	}
+	phy_set_drvdata(if_phy->if_phy, if_phy);
+
+	return 0;
+}
+
 static int phy_gmii_sel_init_ports(struct phy_gmii_sel_priv *priv)
 {
 	const struct phy_gmii_sel_soc_data *soc_data = priv->soc_data;
@@ -249,7 +309,7 @@ static int phy_gmii_sel_init_ports(struct phy_gmii_sel_priv *priv)
 	struct phy_gmii_sel_phy_priv *if_phys;
 	int i, num_ports, ret;
 
-	num_ports = priv->soc_data->num_ports;
+	num_ports = soc_data->num_ports;
 
 	if_phys = devm_kcalloc(priv->dev, num_ports,
 			       sizeof(*if_phys), GFP_KERNEL);
@@ -258,52 +318,9 @@ static int phy_gmii_sel_init_ports(struct phy_gmii_sel_priv *priv)
 	dev_dbg(dev, "%s %d\n", __func__, num_ports);
 
 	for (i = 0; i < num_ports; i++) {
-		const struct reg_field *field;
-		struct regmap_field *regfield;
-
-		if_phys[i].id = i + 1;
-		if_phys[i].priv = priv;
-
-		field = &soc_data->regfields[i][PHY_GMII_SEL_PORT_MODE];
-		dev_dbg(dev, "%s field %x %d %d\n", __func__,
-			field->reg, field->msb, field->lsb);
-
-		regfield = devm_regmap_field_alloc(dev, priv->regmap, *field);
-		if (IS_ERR(regfield))
-			return PTR_ERR(regfield);
-		if_phys[i].fields[PHY_GMII_SEL_PORT_MODE] = regfield;
-
-		field = &soc_data->regfields[i][PHY_GMII_SEL_RGMII_ID_MODE];
-		if (field->reg != (~0)) {
-			regfield = devm_regmap_field_alloc(dev,
-							   priv->regmap,
-							   *field);
-			if (IS_ERR(regfield))
-				return PTR_ERR(regfield);
-			if_phys[i].fields[PHY_GMII_SEL_RGMII_ID_MODE] =
-				regfield;
-		}
-
-		field = &soc_data->regfields[i][PHY_GMII_SEL_RMII_IO_CLK_EN];
-		if (field->reg != (~0)) {
-			regfield = devm_regmap_field_alloc(dev,
-							   priv->regmap,
-							   *field);
-			if (IS_ERR(regfield))
-				return PTR_ERR(regfield);
-			if_phys[i].fields[PHY_GMII_SEL_RMII_IO_CLK_EN] =
-				regfield;
-		}
-
-		if_phys[i].if_phy = devm_phy_create(dev,
-						    priv->dev->of_node,
-						    &phy_gmii_sel_ops);
-		if (IS_ERR(if_phys[i].if_phy)) {
-			ret = PTR_ERR(if_phys[i].if_phy);
-			dev_err(dev, "Failed to create phy%d %d\n", i, ret);
+		ret = phy_gmii_init_phy(priv, i + 1, &if_phys[i]);
+		if (ret)
 			return ret;
-		}
-		phy_set_drvdata(if_phys[i].if_phy, &if_phys[i]);
 	}
 
 	priv->if_phys = if_phys;
-- 
2.17.1

