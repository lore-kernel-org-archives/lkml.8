Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1F6C38A2C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 22:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A60A6206D6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 22:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="itM0c/NF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbgDQWXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 18:23:49 -0400
Received: from plaes.org ([188.166.43.21]:57464 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728617AbgDQWXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 18:23:46 -0400
Received: from localhost (unknown [IPv6:2001:1530:1000:9d4d:940e:6b9e:3deb:4])
        by plaes.org (Postfix) with ESMTPSA id 14F6940E29;
        Fri, 17 Apr 2020 22:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1587161873; bh=9OnaF3dHK/bJkvPCqojRkILBF7al9aw6MaMXsXHyyK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=itM0c/NFnkFtDpdiCJTYKu1kSOTX7JKDdQ5nuJrtCDtTfhG+NDleV88SjKY1u+9Va
         lh9zFOm+dMDnbb61MSngQ2qIa4XygmAAUBwF7l0pUeEDEOqybmbOWwwHWyXKiQA4K7
         sqRJcNG9DkpX6x712sQ9AGSOVUUhQgfdUGvR7ofuimj55CiaDGW5LhZkCfz3QGTQRv
         cZjGOMj9N5M03wHFqJ+wUTko95OohNbtP7tfGJ1gsHXkmA/xShDWsgOTx97qRpuE0A
         2Mf/s/+KEeIO2Cq/tcXF+4TjGq5I2riavpZQinnLCE7xstM4cbl2x/kGDNXF/tp+mw
         1Ec/xeamHMIqg==
From:   Priit Laes <plaes@plaes.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Priit Laes <plaes@plaes.org>
Subject: [PATCH 1/4] clk: sunxi-ng: a10/a20: rewrite init code to a platform driver
Date:   Sat, 18 Apr 2020 01:17:27 +0300
Message-Id: <20200417221730.555954-2-plaes@plaes.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200417221730.555954-1-plaes@plaes.org>
References: <20200417221730.555954-1-plaes@plaes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to register regmap for sun7i CCU, there needs to be
a device structure already bound to the CCU device node.

Convert the sun4i/sun7i CCU setup to platform driver to use
it later as platform device.

Signed-off-by: Priit Laes <plaes@plaes.org>
---
 drivers/clk/sunxi-ng/ccu-sun4i-a10.c | 77 ++++++++++++++++++++--------
 1 file changed, 56 insertions(+), 21 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun4i-a10.c b/drivers/clk/sunxi-ng/ccu-sun4i-a10.c
index f32366d9336e..839e9d5a1cff 100644
--- a/drivers/clk/sunxi-ng/ccu-sun4i-a10.c
+++ b/drivers/clk/sunxi-ng/ccu-sun4i-a10.c
@@ -7,7 +7,8 @@
 
 #include <linux/clk-provider.h>
 #include <linux/io.h>
-#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
 
 #include "ccu_common.h"
 #include "ccu_reset.h"
@@ -1425,19 +1426,10 @@ static const struct sunxi_ccu_desc sun7i_a20_ccu_desc = {
 	.num_resets	= ARRAY_SIZE(sunxi_a10_a20_ccu_resets),
 };
 
-static void __init sun4i_ccu_init(struct device_node *node,
-				  const struct sunxi_ccu_desc *desc)
+static void bootstrap_clocks(void __iomem *reg)
 {
-	void __iomem *reg;
 	u32 val;
 
-	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
-	if (IS_ERR(reg)) {
-		pr_err("%s: Could not map the clock registers\n",
-		       of_node_full_name(node));
-		return;
-	}
-
 	val = readl(reg + SUN4I_PLL_AUDIO_REG);
 
 	/*
@@ -1463,20 +1455,63 @@ static void __init sun4i_ccu_init(struct device_node *node,
 	val = readl(reg + SUN4I_AHB_REG);
 	val &= ~GENMASK(7, 6);
 	writel(val | (2 << 6), reg + SUN4I_AHB_REG);
-
-	sunxi_ccu_probe(node, reg, desc);
 }
 
-static void __init sun4i_a10_ccu_setup(struct device_node *node)
+static int sun4i_a10_ccu_probe(struct platform_device *pdev)
 {
-	sun4i_ccu_init(node, &sun4i_a10_ccu_desc);
+	struct resource *res;
+	void __iomem *reg;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	reg = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
+
+	bootstrap_clocks(reg);
+
+	return sunxi_ccu_probe(pdev->dev.of_node, reg, &sun4i_a10_ccu_desc);
 }
-CLK_OF_DECLARE(sun4i_a10_ccu, "allwinner,sun4i-a10-ccu",
-	       sun4i_a10_ccu_setup);
 
-static void __init sun7i_a20_ccu_setup(struct device_node *node)
+static int sun7i_a20_ccu_probe(struct platform_device *pdev)
 {
-	sun4i_ccu_init(node, &sun7i_a20_ccu_desc);
+	struct resource *res;
+	void __iomem *reg;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	reg = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
+
+	bootstrap_clocks(reg);
+
+	return sunxi_ccu_probe(pdev->dev.of_node, reg, &sun7i_a20_ccu_desc);
 }
-CLK_OF_DECLARE(sun7i_a20_ccu, "allwinner,sun7i-a20-ccu",
-	       sun7i_a20_ccu_setup);
+
+
+static const struct of_device_id sun4i_a10_ccu_ids[] = {
+	{ .compatible = "allwinner,sun4i-a10-ccu"},
+	{ }
+};
+
+static struct platform_driver sun4i_a10_ccu_driver = {
+	.probe = sun4i_a10_ccu_probe,
+	.driver = {
+		.name = "sun4i-a10-ccu",
+		.of_match_table = sun4i_a10_ccu_ids,
+	},
+};
+builtin_platform_driver(sun4i_a10_ccu_driver);
+
+static const struct of_device_id sun7i_a20_ccu_ids[] = {
+	{ .compatible = "allwinner,sun7i-a20-ccu"},
+	{ }
+};
+
+static struct platform_driver sun7i_a20_ccu_driver = {
+	.probe = sun7i_a20_ccu_probe,
+	.driver = {
+		.name = "sun7i-a20-ccu",
+		.of_match_table = sun7i_a20_ccu_ids,
+	},
+};
+builtin_platform_driver(sun7i_a20_ccu_driver);
-- 
2.25.2

