Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D95C33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 06:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF55206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 06:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgA3GxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 01:53:10 -0500
Received: from mx.socionext.com ([202.248.49.38]:26335 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbgA3GxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 01:53:00 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 30 Jan 2020 15:52:57 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 18D55180C09;
        Thu, 30 Jan 2020 15:52:58 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 30 Jan 2020 15:54:18 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 6A5F51A01BB;
        Thu, 30 Jan 2020 15:52:57 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 7/7] phy: uniphier-pcie: Add SoC-dependent phy-mode function support
Date:   Thu, 30 Jan 2020 15:52:45 +0900
Message-Id: <1580367165-16760-8-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580367165-16760-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1580367165-16760-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since this phy is shared by multiple devices including USB and PCIe,
it is necessary to determine which device use this phy.
This patch adds SoC-dependent functions to determine a device using
this phy.

When there is 'socionext,syscon' property in the pcie-phy node,
the driver calls SoC-dependt function instead of checking .has_syscon
in SoC-dependent data. The function configures the system controller
to use phy for PCIe.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/phy/socionext/phy-uniphier-pcie.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/socionext/phy-uniphier-pcie.c b/drivers/phy/socionext/phy-uniphier-pcie.c
index cd17c70..e4adab3 100644
--- a/drivers/phy/socionext/phy-uniphier-pcie.c
+++ b/drivers/phy/socionext/phy-uniphier-pcie.c
@@ -55,8 +55,8 @@ struct uniphier_pciephy_priv {
 };
 
 struct uniphier_pciephy_soc_data {
-	bool has_syscon;
 	bool is_legacy;
+	void (*set_phymode)(struct regmap *regmap);
 };
 
 static void uniphier_pciephy_testio_write(struct uniphier_pciephy_priv *priv,
@@ -243,9 +243,8 @@ static int uniphier_pciephy_probe(struct platform_device *pdev)
 
 	regmap = syscon_regmap_lookup_by_phandle(dev->of_node,
 						 "socionext,syscon");
-	if (!IS_ERR(regmap) && priv->data->has_syscon)
-		regmap_update_bits(regmap, SG_USBPCIESEL,
-				   SG_USBPCIESEL_PCIE, SG_USBPCIESEL_PCIE);
+	if (!IS_ERR(regmap) && priv->data->set_phymode)
+		priv->data->set_phymode(regmap);
 
 	phy_set_drvdata(phy, priv);
 	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
@@ -253,18 +252,22 @@ static int uniphier_pciephy_probe(struct platform_device *pdev)
 	return PTR_ERR_OR_ZERO(phy_provider);
 }
 
+static void uniphier_pciephy_ld20_setmode(struct regmap *regmap)
+{
+	regmap_update_bits(regmap, SG_USBPCIESEL,
+			   SG_USBPCIESEL_PCIE, SG_USBPCIESEL_PCIE);
+}
+
 static const struct uniphier_pciephy_soc_data uniphier_pro5_data = {
-	.has_syscon = false,
 	.is_legacy = true,
 };
 
 static const struct uniphier_pciephy_soc_data uniphier_ld20_data = {
-	.has_syscon = true,
 	.is_legacy = false,
+	.set_phymode = uniphier_pciephy_ld20_setmode,
 };
 
 static const struct uniphier_pciephy_soc_data uniphier_pxs3_data = {
-	.has_syscon = false,
 	.is_legacy = false,
 };
 
-- 
2.7.4

