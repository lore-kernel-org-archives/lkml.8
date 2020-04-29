Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B08C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 20:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A249C20BED
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 20:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="gpuPNDZs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgD2Uq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 16:46:58 -0400
Received: from plaes.org ([188.166.43.21]:35020 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727823AbgD2Uqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 16:46:54 -0400
Received: from localhost (unknown [IPv6:2001:1530:1000:d397:940e:6b9e:3deb:3])
        by plaes.org (Postfix) with ESMTPSA id 317AE40982;
        Wed, 29 Apr 2020 20:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1588193182; bh=iBYb49MohVTATz4R/8x9Z94Kuj2gJif8RNrCb2NzudQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gpuPNDZsbpNXEodt3H8N7cFkS/KzbFx5NP6wVyEhhASy+yfwMvMrsCmWggT7chfDP
         y2UyzMN0wV9FPVTu+BiE8HRPypTmGAkn3aprcU4HhraffAXA/AXODTG/QGrVDOi9zK
         mzF6UQxVdgC5iEbpa0k6TPPYfJHKOhMgYkvJMaOrwtAuuApdMOB/iBGB46c/GeTd2j
         qOMBByxn1d3K/Y1ffPUpwIbq6IniFFh1G+INFfeUWJFzXX/1dre4Aw9CKtpqfdMCnv
         HB7MHiW159lpDBjOVl7aKkIY4xF2cWB5RHBBG259UK7a/4NJ3rv2vfpaUqOjK+Lgc8
         mx9oK/pd+VXgA==
From:   Priit Laes <plaes@plaes.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Priit Laes <plaes@plaes.org>
Subject: [PATCH v2 2/6] clk: sunxi-ng: a31: Register regmap for sun6i CCU
Date:   Wed, 29 Apr 2020 23:46:08 +0300
Message-Id: <20200429204612.31883-3-plaes@plaes.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200429204612.31883-1-plaes@plaes.org>
References: <20200429204612.31883-1-plaes@plaes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On sun6i, the gmac clock is handled by the dwmac-sunxi driver, but
its configuration register is located in the CCU register range,
requiring proper regmap setup.

In order to do that, we use CLK_OF_DECLARE_DRIVER to initialize
sun7i ccu, which clears the OF_POPULATED flag, allowing the
platform device to probe the same resource with device node.

Signed-off-by: Priit Laes <plaes@plaes.org>
---
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c | 60 +++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
index 9b40d53266a3..086eb93a4efd 100644
--- a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
+++ b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
@@ -1262,5 +1262,61 @@ static void __init sun6i_a31_ccu_setup(struct device_node *node)
 	ccu_mux_notifier_register(pll_cpu_clk.common.hw.clk,
 				  &sun6i_a31_cpu_nb);
 }
-CLK_OF_DECLARE(sun6i_a31_ccu, "allwinner,sun6i-a31-ccu",
-	       sun6i_a31_ccu_setup);
+CLK_OF_DECLARE_DRIVER(sun6i_a31_ccu, "allwinner,sun6i-a31-ccu",
+		      sun6i_a31_ccu_setup);
+
+/*
+ * Regmap for the GMAC driver (dwmac-sunxi) to allow access to
+ * GMAC configuration register.
+ */
+#define SUN6I_A31_GMAC_CFG_REG 0xD0
+static bool sun6i_a31_ccu_regmap_accessible_reg(struct device *dev,
+						unsigned int reg)
+{
+	if (reg == SUN6I_A31_GMAC_CFG_REG)
+		return true;
+	return false;
+}
+
+static struct regmap_config sun6i_a31_ccu_regmap_config = {
+	.reg_bits	= 32,
+	.val_bits	= 32,
+	.reg_stride	= 4,
+	.max_register	= 0x308, /* clk_out_b */
+
+	.readable_reg	= sun6i_a31_ccu_regmap_accessible_reg,
+	.writeable_reg	= sun6i_a31_ccu_regmap_accessible_reg,
+};
+
+static int sun6i_a31_ccu_probe_regmap(struct platform_device *pdev)
+{
+	void __iomem *reg;
+	struct resource *res;
+	struct regmap *regmap;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	reg = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
+
+	regmap = devm_regmap_init_mmio(&pdev->dev, reg,
+				       &sun6i_a31_ccu_regmap_accessible_reg);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return 0;
+}
+
+static const struct of_device_id sun6i_a31_ccu_ids[] = {
+	{ .compatible = "allwinner,sun6i-a31-ccu"},
+	{ }
+};
+
+static struct platform_driver sun6i_a31_ccu_driver = {
+	.probe = sun6i_a31_ccu_probe_regmap,
+	.driver = {
+		.name = "sun6i-a31-ccu",
+		.of_match_table = sun6i_a31_ccu_ids,
+	},
+};
+builtin_platform_driver(sun6i_a31_ccu_driver);
-- 
2.26.2

