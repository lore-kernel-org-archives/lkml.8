Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C355C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 20:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FE5D20872
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 20:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HUb6n1ds"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgH1UUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 16:20:17 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:35610 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgH1UUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 16:20:16 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07SKKEGf069574;
        Fri, 28 Aug 2020 15:20:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598646014;
        bh=hEKoxlQs8JJoPg7kF+B3Fjt4e5sdi4yYgTGXIUC3dPo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=HUb6n1dsNrOXya3PSJ0WFxX3iImgrIWP0BvSXzF2yG5IH+1JCC+HbE8d5xHxW5yjE
         z62cCBnIJv5L/44wuXOpaTp/aNiwWrme/p81WtdccRSoyULzngAULTrMAex533tw7c
         lNXl2QAkG+YHWycT57AuDEoWWV73AP6t6plXMGZo=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07SKKEhm078918;
        Fri, 28 Aug 2020 15:20:14 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 28
 Aug 2020 15:20:13 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 28 Aug 2020 15:20:13 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07SKKCLH035768;
        Fri, 28 Aug 2020 15:20:13 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 3/3] phy: ti: gmii-sel: retrieve ports number and base offset from dt
Date:   Fri, 28 Aug 2020 23:19:43 +0300
Message-ID: <20200828201943.29155-4-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200828201943.29155-1-grygorii.strashko@ti.com>
References: <20200828201943.29155-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On K3 AM654x/J721E platforms the Port MII mode selection register(s) have
similar format and placed in the System Control Module (SCM) module
sequentially as one register per port, but, depending SOC and CPSW
instance, the base offset and number of ports can be different.

Hence, add possibility to retrieve number of ports and base registers
offset from DT and support for max possible number of ports supported by K3
SoCs like J721E.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/phy/ti/phy-gmii-sel.c | 44 ++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/drivers/phy/ti/phy-gmii-sel.c b/drivers/phy/ti/phy-gmii-sel.c
index a6b7f22e85c4..5fd2e8a08bfc 100644
--- a/drivers/phy/ti/phy-gmii-sel.c
+++ b/drivers/phy/ti/phy-gmii-sel.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/mfd/syscon.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_net.h>
 #include <linux/phy.h>
 #include <linux/phy/phy.h>
@@ -41,6 +42,7 @@ struct phy_gmii_sel_soc_data {
 	u32 num_ports;
 	u32 features;
 	const struct reg_field (*regfields)[PHY_GMII_SEL_LAST];
+	bool use_of_data;
 };
 
 struct phy_gmii_sel_priv {
@@ -49,6 +51,8 @@ struct phy_gmii_sel_priv {
 	struct regmap *regmap;
 	struct phy_provider *phy_provider;
 	struct phy_gmii_sel_phy_priv *if_phys;
+	u32 num_ports;
+	u32 reg_offset;
 };
 
 static int phy_gmii_sel_mode(struct phy *phy, enum phy_mode mode, int submode)
@@ -168,14 +172,19 @@ struct phy_gmii_sel_soc_data phy_gmii_sel_soc_dm814 = {
 
 static const
 struct reg_field phy_gmii_sel_fields_am654[][PHY_GMII_SEL_LAST] = {
-	{
-		[PHY_GMII_SEL_PORT_MODE] = REG_FIELD(0x4040, 0, 1),
-	},
+	{ [PHY_GMII_SEL_PORT_MODE] = REG_FIELD(0x0, 0, 2), },
+	{ [PHY_GMII_SEL_PORT_MODE] = REG_FIELD(0x4, 0, 2), },
+	{ [PHY_GMII_SEL_PORT_MODE] = REG_FIELD(0x8, 0, 2), },
+	{ [PHY_GMII_SEL_PORT_MODE] = REG_FIELD(0xC, 0, 2), },
+	{ [PHY_GMII_SEL_PORT_MODE] = REG_FIELD(0x10, 0, 2), },
+	{ [PHY_GMII_SEL_PORT_MODE] = REG_FIELD(0x14, 0, 2), },
+	{ [PHY_GMII_SEL_PORT_MODE] = REG_FIELD(0x18, 0, 2), },
+	{ [PHY_GMII_SEL_PORT_MODE] = REG_FIELD(0x1C, 0, 2), },
 };
 
 static const
 struct phy_gmii_sel_soc_data phy_gmii_sel_soc_am654 = {
-	.num_ports = 1,
+	.use_of_data = true,
 	.regfields = phy_gmii_sel_fields_am654,
 };
 
@@ -222,7 +231,7 @@ static struct phy *phy_gmii_sel_of_xlate(struct device *dev,
 	if (priv->soc_data->features & BIT(PHY_GMII_SEL_RMII_IO_CLK_EN) &&
 	    args->args_count < 2)
 		return ERR_PTR(-EINVAL);
-	if (phy_id > priv->soc_data->num_ports)
+	if (phy_id > priv->num_ports)
 		return ERR_PTR(-EINVAL);
 	if (phy_id != priv->if_phys[phy_id - 1].id)
 		return ERR_PTR(-EINVAL);
@@ -251,6 +260,7 @@ static int phy_gmii_init_phy(struct phy_gmii_sel_priv *priv, int port,
 
 	fields = soc_data->regfields[port - 1];
 	field = *fields++;
+	field.reg += priv->reg_offset;
 	dev_dbg(dev, "%s field %x %d %d\n", __func__,
 		field.reg, field.msb, field.lsb);
 
@@ -260,6 +270,7 @@ static int phy_gmii_init_phy(struct phy_gmii_sel_priv *priv, int port,
 	if_phy->fields[PHY_GMII_SEL_PORT_MODE] = regfield;
 
 	field = *fields++;
+	field.reg += priv->reg_offset;
 	if (soc_data->features & BIT(PHY_GMII_SEL_RGMII_ID_MODE)) {
 		regfield = devm_regmap_field_alloc(dev,
 						   priv->regmap,
@@ -272,6 +283,7 @@ static int phy_gmii_init_phy(struct phy_gmii_sel_priv *priv, int port,
 	}
 
 	field = *fields;
+	field.reg += priv->reg_offset;
 	if (soc_data->features & BIT(PHY_GMII_SEL_RMII_IO_CLK_EN)) {
 		regfield = devm_regmap_field_alloc(dev,
 						   priv->regmap,
@@ -299,19 +311,28 @@ static int phy_gmii_init_phy(struct phy_gmii_sel_priv *priv, int port,
 static int phy_gmii_sel_init_ports(struct phy_gmii_sel_priv *priv)
 {
 	const struct phy_gmii_sel_soc_data *soc_data = priv->soc_data;
-	struct device *dev = priv->dev;
 	struct phy_gmii_sel_phy_priv *if_phys;
-	int i, num_ports, ret;
+	struct device *dev = priv->dev;
+	int i, ret;
+
+	if (soc_data->use_of_data) {
+		const __be32 *offset;
+		u64 size;
 
-	num_ports = soc_data->num_ports;
+		offset = of_get_address(dev->of_node, 0, &size, NULL);
+		priv->num_ports = size / sizeof(u32);
+		if (!priv->num_ports)
+			return -EINVAL;
+		priv->reg_offset = __be32_to_cpu(*offset);
+	}
 
-	if_phys = devm_kcalloc(priv->dev, num_ports,
+	if_phys = devm_kcalloc(dev, priv->num_ports,
 			       sizeof(*if_phys), GFP_KERNEL);
 	if (!if_phys)
 		return -ENOMEM;
-	dev_dbg(dev, "%s %d\n", __func__, num_ports);
+	dev_dbg(dev, "%s %d\n", __func__, priv->num_ports);
 
-	for (i = 0; i < num_ports; i++) {
+	for (i = 0; i < priv->num_ports; i++) {
 		ret = phy_gmii_init_phy(priv, i + 1, &if_phys[i]);
 		if (ret)
 			return ret;
@@ -339,6 +360,7 @@ static int phy_gmii_sel_probe(struct platform_device *pdev)
 
 	priv->dev = &pdev->dev;
 	priv->soc_data = of_id->data;
+	priv->num_ports = priv->soc_data->num_ports;
 
 	priv->regmap = syscon_node_to_regmap(node->parent);
 	if (IS_ERR(priv->regmap)) {
-- 
2.17.1

