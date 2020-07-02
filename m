Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F2CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAAD321707
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgGBV3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 17:29:11 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:57036 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726098AbgGBV27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 17:28:59 -0400
Received: from [88.147.89.201] (port=34632 helo=melee.dev.aim)
        by hostingweb31.netsons.net with esmtpa (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1jr6lL-000AXd-B7; Thu, 02 Jul 2020 23:28:55 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-clk@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>
Subject: [PATCH 5/5] clk: vc5: optionally configure the output drive mode
Date:   Thu,  2 Jul 2020 23:28:36 +0200
Message-Id: <20200702212837.10657-5-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702212837.10657-1-luca@lucaceresoli.net>
References: <20200702212837.10657-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Versaclock chips can drive the output pins in several modes: LVDS,
CMOS, LVPECL etc. Allow configuring the output mode from device tree.

The configuration is optional. If not specified, the mode will not be
configured and the drive mode will be the chip default.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 drivers/clk/clk-versaclock5.c | 71 +++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.c
index 60c7cf9acde3..eec57286fae0 100644
--- a/drivers/clk/clk-versaclock5.c
+++ b/drivers/clk/clk-versaclock5.c
@@ -89,6 +89,8 @@
 
 /* Clock control register for clock 1,2 */
 #define VC5_CLK_OUTPUT_CFG(idx, n)	(0x60 + ((idx) * 0x2) + (n))
+#define VC5_CLK_OUTPUT_CFG0_MODE_SHIFT	5
+#define VC5_CLK_OUTPUT_CFG0_MODE_MASK	GENMASK(7, 5)
 #define VC5_CLK_OUTPUT_CFG1_EN_CLKBUF	BIT(0)
 
 #define VC5_CLK_OE_SHDN				0x68
@@ -117,6 +119,23 @@
 /* chip has PFD requency doubler */
 #define VC5_HAS_PFD_FREQ_DBL	BIT(1)
 
+/*
+ * Output modes. Values for VC5_CLK_OUTPUT_CFG(idx,0) bits [7:5].
+ * IDT_VC5_OUT_UNKNOWN = keep the hardware default.
+ */
+enum vc5_out_mode {
+	IDT_VC5_OUT_MODE_LVPECL   = 0,
+	IDT_VC5_OUT_MODE_CMOS     = 1,
+	IDT_VC5_OUT_MODE_HCSL33   = 2,
+	IDT_VC5_OUT_MODE_LVDS     = 3,
+	IDT_VC5_OUT_MODE_CMOS2    = 4,
+	IDT_VC5_OUT_MODE_CMOSD    = 5,
+	IDT_VC5_OUT_MODE_HCSL25   = 6,
+
+	IDT_VC5_OUT_NUM_MODES,
+	IDT_VC5_OUT_MODE_UNKNOWN  = 99,
+};
+
 /* Supported IDT VC5 models. */
 enum vc5_model {
 	IDT_VC5_5P49V5923,
@@ -149,6 +168,7 @@ struct vc5_out_data {
 	struct clk_hw		hw;
 	struct vc5_driver_data	*vc5;
 	unsigned int		num;
+	enum vc5_out_mode	mode:8;
 };
 
 struct vc5_driver_data {
@@ -593,6 +613,13 @@ static int vc5_clk_out_prepare(struct clk_hw *hw)
 			return ret;
 	}
 
+	/* Set output drive mode */
+	if (hwdata->mode != IDT_VC5_OUT_MODE_UNKNOWN)
+		regmap_update_bits(vc5->regmap,
+				   VC5_CLK_OUTPUT_CFG(hwdata->num, 0),
+				   VC5_CLK_OUTPUT_CFG0_MODE_MASK,
+				   (hwdata->mode << VC5_CLK_OUTPUT_CFG0_MODE_SHIFT));
+
 	/* Enable the clock buffer */
 	regmap_update_bits(vc5->regmap, VC5_CLK_OUTPUT_CFG(hwdata->num, 1),
 			   VC5_CLK_OUTPUT_CFG1_EN_CLKBUF,
@@ -696,6 +723,46 @@ static int vc5_map_index_to_output(const enum vc5_model model,
 	}
 }
 
+static int vc5_parse_dt(struct vc5_driver_data *vc5)
+{
+	struct device *dev = &vc5->client->dev;
+	struct device_node *np = dev->of_node;
+	struct device_node *child;
+	u32 val;
+	int n;
+
+	for (n = 1; n < vc5->chip_info->clk_out_cnt; n++)
+		vc5->clk_out[n].mode = IDT_VC5_OUT_MODE_UNKNOWN;
+
+	for_each_child_of_node(np, child) {
+		if (of_property_read_u32(child, "reg", &n)) {
+			dev_err(dev, "%pOF: missing reg property\n", child);
+			break;
+		}
+
+		if (n == 0 || n >= vc5->chip_info->clk_out_cnt) {
+			dev_err(dev, "%pOF: invalid reg %d\n", child, n);
+			break;
+		}
+
+		if (!of_property_read_u32(child, "idt,drive-mode", &val)) {
+			if (val >= IDT_VC5_OUT_NUM_MODES) {
+				dev_err(dev, "%pOF: invalid idt,drive-mode %u\n",
+					child, val);
+				break;
+			}
+			vc5->clk_out[n].mode = val;
+		}
+	}
+
+	if (child) {
+		of_node_put(child);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static const struct of_device_id clk_vc5_of_match[];
 
 static int vc5_probe(struct i2c_client *client,
@@ -723,6 +790,10 @@ static int vc5_probe(struct i2c_client *client,
 	if (PTR_ERR(vc5->pin_clkin) == -EPROBE_DEFER)
 		return -EPROBE_DEFER;
 
+	ret = vc5_parse_dt(vc5);
+	if (ret)
+		return ret;
+
 	vc5->regmap = devm_regmap_init_i2c(client, &vc5_regmap_config);
 	if (IS_ERR(vc5->regmap)) {
 		dev_err(&client->dev, "failed to allocate register map\n");
-- 
2.27.0

