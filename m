Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E57C38A29
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 22:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF54C206D6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 22:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="TZclkyba"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbgDQWXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 18:23:47 -0400
Received: from plaes.org ([188.166.43.21]:57460 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728517AbgDQWXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 18:23:46 -0400
X-Greylist: delayed 350 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Apr 2020 18:23:45 EDT
Received: from localhost (unknown [IPv6:2001:1530:1000:9d4d:940e:6b9e:3deb:4])
        by plaes.org (Postfix) with ESMTPSA id A7D8840F77;
        Fri, 17 Apr 2020 22:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1587161875; bh=R/e4AeS+hYtR1SV4lPnHnWWGgqogYvwGJXb2bJni8Gs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TZclkybauT9AxtT/TF3Gf+6lkIYgIDJ33SAAPA7Z1QS2G+JfTqiHhragEBFO3DhFS
         OfUoqA4fOMbc5KFs9+r3FpQLDgaFVWdr3dMj5h+Gl8u1njA4Rw8oUzRVddcgTdUJGi
         yCKykq9IOyV7KLmIszFsL69mqkL3vTNhmE7zydscV2AlVepJgGL9832h8TD2dUaofB
         onfU46E8V+TyUsQg6k8UN7Qk+nlmqSNNA/RCPybFbkTu0am88SnX18QAJN4m3UqLgQ
         BgiZ7wwuHfUJ019K34mfd9zZDYNqF3ALiyU+aKhyAKARtd5Gvnzt2X+voW8qTld69L
         RNhCre324KBBg==
From:   Priit Laes <plaes@plaes.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Priit Laes <plaes@plaes.org>
Subject: [PATCH 2/4] clk: sunxi-ng: a20: export a regmap to access the GMAC register
Date:   Sat, 18 Apr 2020 01:17:28 +0300
Message-Id: <20200417221730.555954-3-plaes@plaes.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200417221730.555954-1-plaes@plaes.org>
References: <20200417221730.555954-1-plaes@plaes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only GMAC register is allowed to be written, read access to registers
is not restricted.

Export a regmap of the CCU.

Signed-off-by: Priit Laes <plaes@plaes.org>
---
 drivers/clk/sunxi-ng/ccu-sun4i-a10.c | 31 ++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun4i-a10.c b/drivers/clk/sunxi-ng/ccu-sun4i-a10.c
index 839e9d5a1cff..cba51c2c7eba 100644
--- a/drivers/clk/sunxi-ng/ccu-sun4i-a10.c
+++ b/drivers/clk/sunxi-ng/ccu-sun4i-a10.c
@@ -1426,6 +1426,30 @@ static const struct sunxi_ccu_desc sun7i_a20_ccu_desc = {
 	.num_resets	= ARRAY_SIZE(sunxi_a10_a20_ccu_resets),
 };
 
+/*
+ * Add regmap for the GMAC driver (dwmac-sun8i) to allow access to
+ * GMAC configuration register.
+ */
+
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
 static void bootstrap_clocks(void __iomem *reg)
 {
 	u32 val;
@@ -1474,6 +1498,7 @@ static int sun4i_a10_ccu_probe(struct platform_device *pdev)
 
 static int sun7i_a20_ccu_probe(struct platform_device *pdev)
 {
+	struct regmap *regmap;
 	struct resource *res;
 	void __iomem *reg;
 
@@ -1484,6 +1509,12 @@ static int sun7i_a20_ccu_probe(struct platform_device *pdev)
 
 	bootstrap_clocks(reg);
 
+	regmap = devm_regmap_init_mmio(&pdev->dev, reg,
+				       &sun7i_a20_ccu_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+
 	return sunxi_ccu_probe(pdev->dev.of_node, reg, &sun7i_a20_ccu_desc);
 }
 
-- 
2.25.2

