Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2B3C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 00:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1447820758
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 00:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrZv9/8T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgGMAZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 20:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728560AbgGMAZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 20:25:22 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63DBC061794;
        Sun, 12 Jul 2020 17:25:21 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id g13so8765247qtv.8;
        Sun, 12 Jul 2020 17:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JgHj2BWQPrhnQaPMMFNV2nwDiVdYjO7RB3aO5GzyH+c=;
        b=BrZv9/8TB75OtJEb8hEG7X366z5/nGCAsrSYyko50Rb/KVl4HHWIkzYe4ZTtfC7CSn
         svNKN2H/xvWaBnDJCD3T0VJcFzmbSiOwsKigXniF9HJItm36nCka0G6691C0aK0mPnMh
         xJ5jycZr8CPwPwWcqo54zQnQyWMtITeW9ENW+OWtlD4xRM91zGW3IF1Cf3/yPQnm5IWV
         8xhw2BpCu2+x0OvSczJDWtFw+jX5P4/7HxlqH0KY1DaLTBn0FhZ/f6LznGxOZllcUl1j
         SgQGODjLD01BuTdOV4Yu/VK61TDU8vCOhP6FxkIFQ2YxrDjMij0Y4FuXgcdy843mbrXU
         5W5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JgHj2BWQPrhnQaPMMFNV2nwDiVdYjO7RB3aO5GzyH+c=;
        b=m9KZn03LD06JOVXpDjp/r9HojpBYuWg7knk1ZubiFdSN7GyRgrcLeVCvEl7mSaKl/E
         foHfwctJbIHmB6zejaqJ75PD0IDh+7k5O3jxuq1lU3zCaOpNjUamV0t0PnisrJNCwc1K
         mk84xrgeubrcyKAIMqF88A6N73Udm9RRB8zAgtI7LP5YJa5u/V7bZv5RZubaQKyzgdew
         I9ZrjTQOHwMjUsnAu/2bYXjsH4MnEScP/OHm6AtfgEiZFrr46eO94Q0vkOiT8+PkCIk0
         D+Hgnb8TqR0fyKlgDvl4GPkpD/9Q+jmmH++WInjT9jQB04Slkv7Gxc6dAqL64bhDlt2X
         Jv8w==
X-Gm-Message-State: AOAM532UQxrmKpKTNvh1SyOR4bi0fk+ohdw7I3X/Og7iaV8743te+ffH
        elkY0LIq7hK2o63A+JMP+PzfqDym
X-Google-Smtp-Source: ABdhPJzen7JV5VR6696sjedTEkdewWidv4Db4Q2QTTCa6eH/M9EHJlz89ccx29KzPcWnTukyDtKqEw==
X-Received: by 2002:ac8:1667:: with SMTP id x36mr70871607qtk.344.1594599920703;
        Sun, 12 Jul 2020 17:25:20 -0700 (PDT)
Received: from localhost.localdomain ([72.53.229.195])
        by smtp.gmail.com with ESMTPSA id u5sm17044309qke.32.2020.07.12.17.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 17:25:20 -0700 (PDT)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v1 4/5] clk: imx6q: support improved enet clocking on QuadPlus
Date:   Sun, 12 Jul 2020 20:25:11 -0400
Message-Id: <20200713002512.28742-5-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200713002512.28742-1-TheSven73@gmail.com>
References: <20200713002512.28742-1-TheSven73@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the imx6q QuadPlus, hardware designers have improved the enet
clocking:
                          _
	 anaclk3---------| \
	                 |  |              _
	                 |M |--enet_pad-->| \
	                 |  |             |  |
	 enet_ref---o--->|_/              |M |----enet_ptp
	            |                     |  |
	            o---------------------|_/

Where anaclk3 is an external clock fed into the imx6q via
a pad, typically RGMII_TX_CTL or GPIO_16, when these are
configured in mux mode ENET_REF_CLK.

Board designers can now change the clock tree (via the devicetree)
to choose between all three supported enet clocking methods.

See follow-up devicetree patch for details.

Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---

Tree: v5.8-rc4

To: Shawn Guo <shawnguo@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-clk@vger.kernel.org

 drivers/clk/imx/clk-imx6q.c                 | 46 +++++++++++++++++++++
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h |  1 +
 2 files changed, 47 insertions(+)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index ba33c79158de..0edffa306a28 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -15,6 +15,8 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <soc/imx/revision.h>
+#include <linux/mfd/syscon.h>
+#include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
 #include <dt-bindings/clock/imx6qdl-clock.h>
 
 #include "clk.h"
@@ -87,6 +89,8 @@ static const char *pll4_bypass_sels[] = { "pll4", "pll4_bypass_src", };
 static const char *pll5_bypass_sels[] = { "pll5", "pll5_bypass_src", };
 static const char *pll6_bypass_sels[] = { "pll6", "pll6_bypass_src", };
 static const char *pll7_bypass_sels[] = { "pll7", "pll7_bypass_src", };
+static const char * const enet_pad_sels[] = { "anaclk3", "enet_ref", };
+static const char * const enet_ptp_sels[] = { "enet_pad", "enet_ref", };
 
 static struct clk_hw **hws;
 static struct clk_hw_onecell_data *clk_hw_data;
@@ -436,6 +440,7 @@ static struct clk_hw * __init imx6q_obtain_fixed_clk_hw(struct device_node *np,
 
 static void __init imx6q_clocks_init(struct device_node *ccm_node)
 {
+	struct regmap *gpr;
 	struct device_node *np;
 	void __iomem *anatop_base, *base;
 	int ret;
@@ -464,6 +469,9 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	WARN_ON(!base);
 	of_node_put(np);
 
+	gpr = syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
+	WARN_ON(IS_ERR_OR_NULL(gpr));
+
 	/* Audio/video PLL post dividers do not work on i.MX6q revision 1.0 */
 	if (clk_on_imx6q() && imx_get_soc_revision() == IMX_CHIP_REVISION_1_0) {
 		post_div_table[1].div = 1;
@@ -959,6 +967,44 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	/* Audio-related clocks configuration */
 	clk_set_parent(hws[IMX6QDL_CLK_SPDIF_SEL]->clk, hws[IMX6QDL_CLK_PLL3_PFD3_454M]->clk);
 
+	/*
+	 * The QuadPlus has improved enet clocking:
+	 *                  _
+	 * anaclk3---------| \
+	 *                 |  |              _
+	 *                 |M |--enet_pad-->| \
+	 *                 |  |             |  |
+	 * enet_ref---o--->|_/              |M |----enet_ptp
+	 *            |                     |  |
+	 *            o---------------------|_/
+	 *
+	 * On the plus, three options to generate the enet ptp clock:
+	 *
+	 * a) route enet_ref externally from pad to pad (the default):
+	 *    enet_ptp from enet_pad
+	 *    enet_pad from enet_ref
+	 * b) route internally on SoC from enet_ref:
+	 *    enet_ptp from enet_ref
+	 * c) route external clock (from PHY or oscillator) via pad:
+	 *    enet_ptp from enet_pad
+	 *    enet_pad from anaclk3
+	 *    anaclk3 from PHY or oscillator, add devicetree node
+	 */
+	if (clk_on_imx6qp()) {
+		/*
+		 * anaclk3: clock source from external clock via:
+		 * - RGMII_TX_CTL PAD (mux mode ENET_REF_CLK), or
+		 * - GPIO_16      PAD (mux mode ENET_REF_CLK)
+		 */
+		hws[IMX6QDL_CLK_ANACLK3] = imx6q_obtain_fixed_clk_hw(ccm_node, "anaclk3", 0);
+		hws[IMX6QDL_CLK_ENET_PAD] = imx_clk_hw_mux_regmap("enet_pad", gpr, IOMUXC_GPR1, ffs(IMX6Q_GPR1_ENET_CLK_SEL_MASK) - 1,
+								  1, enet_pad_sels, ARRAY_SIZE(enet_pad_sels));
+		hws[IMX6QDL_CLK_ENET_PTP] = imx_clk_hw_mux_regmap("enet_ptp", gpr, IOMUXC_GPR5, ffs(IMX6Q_GPR5_ENET_TXCLK_SEL_MASK) - 1,
+								  1, enet_ptp_sels, ARRAY_SIZE(enet_ptp_sels));
+		clk_set_parent(hws[IMX6QDL_CLK_ENET_PAD]->clk, hws[IMX6QDL_CLK_ENET_REF]->clk);
+		clk_set_parent(hws[IMX6QDL_CLK_ENET_PTP]->clk, hws[IMX6QDL_CLK_ENET_PAD]->clk);
+	}
+
 	/* All existing boards with PCIe use LVDS1 */
 	if (IS_ENABLED(CONFIG_PCI_IMX6))
 		clk_set_parent(hws[IMX6QDL_CLK_LVDS1_SEL]->clk, hws[IMX6QDL_CLK_SATA_REF_100M]->clk);
diff --git a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
index d4b5e527a7a3..ac1bb3695933 100644
--- a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
+++ b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
@@ -240,6 +240,7 @@
 #define IMX6Q_GPR4_IPU_RD_CACHE_CTL		BIT(0)
 
 #define IMX6Q_GPR5_L2_CLK_STOP			BIT(8)
+#define IMX6Q_GPR5_ENET_TXCLK_SEL_MASK		BIT(9)
 #define IMX6Q_GPR5_SATA_SW_PD			BIT(10)
 #define IMX6Q_GPR5_SATA_SW_RST			BIT(11)
 
-- 
2.17.1

