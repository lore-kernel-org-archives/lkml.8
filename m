Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E064AC33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 06:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A294B206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 06:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgA3Gw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 01:52:59 -0500
Received: from mx.socionext.com ([202.248.49.38]:26346 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbgA3Gw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 01:52:58 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 30 Jan 2020 15:52:57 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 1133A180C09;
        Thu, 30 Jan 2020 15:52:57 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 30 Jan 2020 15:54:17 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id A6E2A1A01BB;
        Thu, 30 Jan 2020 15:52:56 +0900 (JST)
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
Subject: [PATCH v2 6/7] phy: uniphier-pcie: Add legacy SoC support for Pro5
Date:   Thu, 30 Jan 2020 15:52:44 +0900
Message-Id: <1580367165-16760-7-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580367165-16760-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1580367165-16760-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add legacy SoC support that needs to manage gio clock and reset and to skip
setting unimplemented phy parameters. This supports Pro5.

This specifies only 1 port use because Pro5 doesn't set it in the power-on
sequence.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/phy/socionext/phy-uniphier-pcie.c | 83 +++++++++++++++++++++++++++----
 1 file changed, 72 insertions(+), 11 deletions(-)

diff --git a/drivers/phy/socionext/phy-uniphier-pcie.c b/drivers/phy/socionext/phy-uniphier-pcie.c
index 25d1d9d..cd17c70 100644
--- a/drivers/phy/socionext/phy-uniphier-pcie.c
+++ b/drivers/phy/socionext/phy-uniphier-pcie.c
@@ -19,6 +19,10 @@
 #include <linux/resource.h>
 
 /* PHY */
+#define PCL_PHY_CLKCTRL		0x0000
+#define PORT_SEL_MASK		GENMASK(11, 9)
+#define PORT_SEL_1		FIELD_PREP(PORT_SEL_MASK, 1)
+
 #define PCL_PHY_TEST_I		0x2000
 #define PCL_PHY_TEST_O		0x2004
 #define TESTI_DAT_MASK		GENMASK(13, 6)
@@ -45,13 +49,14 @@
 struct uniphier_pciephy_priv {
 	void __iomem *base;
 	struct device *dev;
-	struct clk *clk;
-	struct reset_control *rst;
+	struct clk *clk, *clk_gio;
+	struct reset_control *rst, *rst_gio;
 	const struct uniphier_pciephy_soc_data *data;
 };
 
 struct uniphier_pciephy_soc_data {
 	bool has_syscon;
+	bool is_legacy;
 };
 
 static void uniphier_pciephy_testio_write(struct uniphier_pciephy_priv *priv,
@@ -111,16 +116,35 @@ static void uniphier_pciephy_deassert(struct uniphier_pciephy_priv *priv)
 static int uniphier_pciephy_init(struct phy *phy)
 {
 	struct uniphier_pciephy_priv *priv = phy_get_drvdata(phy);
+	u32 val;
 	int ret;
 
 	ret = clk_prepare_enable(priv->clk);
 	if (ret)
 		return ret;
 
-	ret = reset_control_deassert(priv->rst);
+	ret = clk_prepare_enable(priv->clk_gio);
 	if (ret)
 		goto out_clk_disable;
 
+	ret = reset_control_deassert(priv->rst);
+	if (ret)
+		goto out_clk_gio_disable;
+
+	ret = reset_control_deassert(priv->rst_gio);
+	if (ret)
+		goto out_rst_assert;
+
+	/* support only 1 port */
+	val = readl(priv->base + PCL_PHY_CLKCTRL);
+	val &= ~PORT_SEL_MASK;
+	val |= PORT_SEL_1;
+	writel(val, priv->base + PCL_PHY_CLKCTRL);
+
+	/* legacy controller doesn't have phy_reset and parameters */
+	if (priv->data->is_legacy)
+		return 0;
+
 	uniphier_pciephy_set_param(priv, PCL_PHY_R00,
 				   RX_EQ_ADJ_EN, RX_EQ_ADJ_EN);
 	uniphier_pciephy_set_param(priv, PCL_PHY_R06, RX_EQ_ADJ,
@@ -134,6 +158,10 @@ static int uniphier_pciephy_init(struct phy *phy)
 
 	return 0;
 
+out_rst_assert:
+	reset_control_assert(priv->rst);
+out_clk_gio_disable:
+	clk_disable_unprepare(priv->clk_gio);
 out_clk_disable:
 	clk_disable_unprepare(priv->clk);
 
@@ -144,8 +172,11 @@ static int uniphier_pciephy_exit(struct phy *phy)
 {
 	struct uniphier_pciephy_priv *priv = phy_get_drvdata(phy);
 
-	uniphier_pciephy_assert(priv);
+	if (!priv->data->is_legacy)
+		uniphier_pciephy_assert(priv);
+	reset_control_assert(priv->rst_gio);
 	reset_control_assert(priv->rst);
+	clk_disable_unprepare(priv->clk_gio);
 	clk_disable_unprepare(priv->clk);
 
 	return 0;
@@ -179,13 +210,32 @@ static int uniphier_pciephy_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-	priv->clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(priv->clk))
-		return PTR_ERR(priv->clk);
-
-	priv->rst = devm_reset_control_get_shared(dev, NULL);
-	if (IS_ERR(priv->rst))
-		return PTR_ERR(priv->rst);
+	if (priv->data->is_legacy) {
+		priv->clk_gio = devm_clk_get(dev, "gio");
+		if (IS_ERR(priv->clk_gio))
+			return PTR_ERR(priv->clk_gio);
+
+		priv->rst_gio =
+			devm_reset_control_get_shared(dev, "gio");
+		if (IS_ERR(priv->rst_gio))
+			return PTR_ERR(priv->rst_gio);
+
+		priv->clk = devm_clk_get(dev, "link");
+		if (IS_ERR(priv->clk))
+			return PTR_ERR(priv->clk);
+
+		priv->rst = devm_reset_control_get_shared(dev, "link");
+		if (IS_ERR(priv->rst))
+			return PTR_ERR(priv->rst);
+	} else {
+		priv->clk = devm_clk_get(dev, NULL);
+		if (IS_ERR(priv->clk))
+			return PTR_ERR(priv->clk);
+
+		priv->rst = devm_reset_control_get_shared(dev, NULL);
+		if (IS_ERR(priv->rst))
+			return PTR_ERR(priv->rst);
+	}
 
 	phy = devm_phy_create(dev, dev->of_node, &uniphier_pciephy_ops);
 	if (IS_ERR(phy))
@@ -203,16 +253,27 @@ static int uniphier_pciephy_probe(struct platform_device *pdev)
 	return PTR_ERR_OR_ZERO(phy_provider);
 }
 
+static const struct uniphier_pciephy_soc_data uniphier_pro5_data = {
+	.has_syscon = false,
+	.is_legacy = true,
+};
+
 static const struct uniphier_pciephy_soc_data uniphier_ld20_data = {
 	.has_syscon = true,
+	.is_legacy = false,
 };
 
 static const struct uniphier_pciephy_soc_data uniphier_pxs3_data = {
 	.has_syscon = false,
+	.is_legacy = false,
 };
 
 static const struct of_device_id uniphier_pciephy_match[] = {
 	{
+		.compatible = "socionext,uniphier-pro5-pcie-phy",
+		.data = &uniphier_pro5_data,
+	},
+	{
 		.compatible = "socionext,uniphier-ld20-pcie-phy",
 		.data = &uniphier_ld20_data,
 	},
-- 
2.7.4

