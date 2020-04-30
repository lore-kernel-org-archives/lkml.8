Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DB8C8300C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 11:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ACF9207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 11:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="ptSca4hV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgD3L5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 07:57:41 -0400
Received: from plaes.org ([188.166.43.21]:37072 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbgD3L5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 07:57:41 -0400
Received: from localhost (unknown [IPv6:2001:1530:1000:d397:940e:6b9e:3deb:3])
        by plaes.org (Postfix) with ESMTPSA id 13D554036D;
        Thu, 30 Apr 2020 11:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1588247829; bh=bh7o9ZhtcwUOEzy3WygVte7TJMzYuXaXlcYI721k4f8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ptSca4hVYlVlD+EeQS36HhT/dPaEy5pyiigz/Kfbl3GOJ5Bo8KfOzvXrIQg8VPoDM
         Fy66ScCGvpCkDjyVF7rM4ZeaugaTacGRw/4GkvtaW1BVIBvsEjU65L3VKl/wPP/VR5
         oZFUBNSMdNsFEaFK9deqPJztaNHnS4X5yrYD6J2OprwfG/3GF+oScP+TI0uyLARkDH
         OUqgKKPngJlu71n6BqlE/UvnR+NKfdlb/nTR2IFBFOTAoIU02LI49ZndUolk5ENMII
         GAu/vY4jxfDLRiUBPUQC7Is3FUR141vs9/XhICwZ0uulGWwApMclmREtUICFh7PAAF
         w67FZ6Gbh76jw==
From:   Priit Laes <plaes@plaes.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Priit Laes <plaes@plaes.org>
Subject: [PATCH v3 1/6] clk: sunxi-ng: a20: Register regmap for sun7i CCU
Date:   Thu, 30 Apr 2020 14:56:57 +0300
Message-Id: <20200430115702.5768-2-plaes@plaes.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200430115702.5768-1-plaes@plaes.org>
References: <20200430115702.5768-1-plaes@plaes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On sun7i, the gmac clock is handled by the dwmac-sunxi driver, but
its configuration register is located in the CCU register range,
requiring proper regmap setup.

In order to do that, we use CLK_OF_DECLARE_DRIVER to initialize
sun7i ccu, which clears the OF_POPULATED flag, allowing the
platform device to probe the same resource with proper device node.

Signed-off-by: Priit Laes <plaes@plaes.org>
---
 drivers/clk/sunxi-ng/ccu-sun4i-a10.c | 62 +++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun4i-a10.c b/drivers/clk/sunxi-ng/ccu-sun4i-a10.c
index f32366d9336e..fa147b8ce705 100644
--- a/drivers/clk/sunxi-ng/ccu-sun4i-a10.c
+++ b/drivers/clk/sunxi-ng/ccu-sun4i-a10.c
@@ -8,6 +8,8 @@
 #include <linux/clk-provider.h>
 #include <linux/io.h>
 #include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
 
 #include "ccu_common.h"
 #include "ccu_reset.h"
@@ -1478,5 +1480,61 @@ static void __init sun7i_a20_ccu_setup(struct device_node *node)
 {
 	sun4i_ccu_init(node, &sun7i_a20_ccu_desc);
 }
-CLK_OF_DECLARE(sun7i_a20_ccu, "allwinner,sun7i-a20-ccu",
-	       sun7i_a20_ccu_setup);
+CLK_OF_DECLARE_DRIVER(sun7i_a20_ccu, "allwinner,sun7i-a20-ccu",
+		      sun7i_a20_ccu_setup);
+
+/*
+ * Regmap for the GMAC driver (dwmac-sunxi) to allow access to
+ * GMAC configuration register.
+ */
+#define SUN7I_A20_GMAC_CFG_REG 0x164
+static bool sun7i_a20_ccu_regmap_accessible_reg(struct device *dev,
+						unsigned int reg)
+{
+	if (reg == SUN7I_A20_GMAC_CFG_REG)
+		return true;
+	return false;
+}
+
+static struct regmap_config sun7i_a20_ccu_regmap_config = {
+	.reg_bits	= 32,
+	.val_bits	= 32,
+	.reg_stride	= 4,
+	.max_register	= 0x1f4, /* clk_out_b */
+
+	.readable_reg	= sun7i_a20_ccu_regmap_accessible_reg,
+	.writeable_reg	= sun7i_a20_ccu_regmap_accessible_reg,
+};
+
+static int sun7i_a20_ccu_probe_regmap(struct platform_device *pdev)
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
+				       &sun7i_a20_ccu_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return 0;
+}
+
+static const struct of_device_id sun7i_a20_ccu_ids[] = {
+	{ .compatible = "allwinner,sun7i-a20-ccu"},
+	{ }
+};
+
+static struct platform_driver sun7i_a20_ccu_driver = {
+	.probe = sun7i_a20_ccu_probe_regmap,
+	.driver = {
+		.name = "sun7i-a20-ccu",
+		.of_match_table = sun7i_a20_ccu_ids,
+	},
+};
+builtin_platform_driver(sun7i_a20_ccu_driver);
-- 
2.26.2

