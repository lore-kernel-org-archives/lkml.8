Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20F0C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 06:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC62B2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 06:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgEGGWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 02:22:07 -0400
Received: from atl4mhfb04.myregisteredsite.com ([209.17.115.120]:47608 "EHLO
        atl4mhfb04.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725763AbgEGGWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 02:22:06 -0400
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 May 2020 02:22:05 EDT
Received: from jax4mhob21.registeredsite.com (jax4mhob21.registeredsite.com [64.69.218.109])
        by atl4mhfb04.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id 0476G0YS025511
        for <linux-kernel@vger.kernel.org>; Thu, 7 May 2020 02:16:00 -0400
Received: from mailpod.hostingplatform.com ([10.30.71.203])
        by jax4mhob21.registeredsite.com (8.14.4/8.14.4) with ESMTP id 0476FtAO179886
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Thu, 7 May 2020 02:15:56 -0400
Received: (qmail 7574 invoked by uid 0); 7 May 2020 06:15:55 -0000
X-TCPREMOTEIP: 83.128.90.119
X-Authenticated-UID: mike@milosoftware.com
Received: from unknown (HELO phenom.domain?not?set.invalid) (mike@milosoftware.com@83.128.90.119)
  by 0 with ESMTPA; 7 May 2020 06:15:55 -0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     linux-clk@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH] clk: clk-si5341: Add support for the Si5345 series
Date:   Thu,  7 May 2020 08:15:44 +0200
Message-Id: <20200507061544.11388-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Si5342, Si5344 and Si5345 chips. These are equivalent
to the Si5341 family, but with more clock input options (which are not
supported yet by this driver).

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
 .../bindings/clock/silabs,si5341.txt          | 11 ++-
 drivers/clk/clk-si5341.c                      | 69 +++++++++++++++++--
 2 files changed, 74 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/silabs,si5341.txt b/Documentation/devicetree/bindings/clock/silabs,si5341.txt
index a70c333e4cd4..504cce3abe46 100644
--- a/Documentation/devicetree/bindings/clock/silabs,si5341.txt
+++ b/Documentation/devicetree/bindings/clock/silabs,si5341.txt
@@ -1,15 +1,21 @@
-Binding for Silicon Labs Si5341 and Si5340 programmable i2c clock generator.
+Binding for Silicon Labs Si5340, Si5341 Si5342, Si5344 and Si5345 programmable
+i2c clock generator.
 
 Reference
 [1] Si5341 Data Sheet
     https://www.silabs.com/documents/public/data-sheets/Si5341-40-D-DataSheet.pdf
 [2] Si5341 Reference Manual
     https://www.silabs.com/documents/public/reference-manuals/Si5341-40-D-RM.pdf
+[3] Si5345 Reference Manual
+    https://www.silabs.com/documents/public/reference-manuals/Si5345-44-42-D-RM.pdf
 
 The Si5341 and Si5340 are programmable i2c clock generators with up to 10 output
 clocks. The chip contains a PLL that sources 5 (or 4) multisynth clocks, which
 in turn can be directed to any of the 10 (or 4) outputs through a divider.
 The internal structure of the clock generators can be found in [2].
+The Si5345 is similar to the Si5341 with the addition of fractional input
+dividers and automatic input selection, as described in [3].
+The Si5342 and Si5344 are smaller versions of the Si5345, with 2 or 4 outputs.
 
 The driver can be used in "as is" mode, reading the current settings from the
 chip at boot, in case you have a (pre-)programmed device. If the PLL is not
@@ -28,6 +34,9 @@ Required properties:
 - compatible: shall be one of the following:
 	"silabs,si5340" - Si5340 A/B/C/D
 	"silabs,si5341" - Si5341 A/B/C/D
+	"silabs,si5342" - Si5342 A/B/C/D
+	"silabs,si5344" - Si5344 A/B/C/D
+	"silabs,si5345" - Si5345 A/B/C/D
 - reg: i2c device address, usually 0x74
 - #clock-cells: from common clock binding; shall be set to 2.
 	The first value is "0" for outputs, "1" for synthesizers.
diff --git a/drivers/clk/clk-si5341.c b/drivers/clk/clk-si5341.c
index 3c228b018116..3d7acab9d280 100644
--- a/drivers/clk/clk-si5341.c
+++ b/drivers/clk/clk-si5341.c
@@ -1,8 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Driver for Silicon Labs Si5341/Si5340 Clock generator
+ * Driver for Silicon Labs Si5340, Si5341, Si5342, Si5344 and Si5345
  * Copyright (C) 2019 Topic Embedded Products
  * Author: Mike Looijmans <mike.looijmans@topic.nl>
+ *
+ * The Si5341 has 10 outputs and 5 synthesizers.
+ * The Si5340 is a smaller version of the Si5341 with only 4 outputs.
+ * The Si5345 is similar to the Si5341, with the addition of fractional input
+ * dividers and automatic input selection.
+ * The Si5342 and Si5344 are smaller versions of the Si5345.
  */
 
 #include <linux/clk.h>
@@ -18,11 +24,17 @@
 
 #define SI5341_NUM_INPUTS 4
 
-#define SI5341_MAX_NUM_OUTPUTS 10
 #define SI5340_MAX_NUM_OUTPUTS 4
+#define SI5341_MAX_NUM_OUTPUTS 10
+#define SI5342_MAX_NUM_OUTPUTS 2
+#define SI5344_MAX_NUM_OUTPUTS 4
+#define SI5345_MAX_NUM_OUTPUTS 10
 
-#define SI5341_NUM_SYNTH 5
 #define SI5340_NUM_SYNTH 4
+#define SI5341_NUM_SYNTH 5
+#define SI5342_NUM_SYNTH 2
+#define SI5344_NUM_SYNTH 4
+#define SI5345_NUM_SYNTH 5
 
 /* Range of the synthesizer fractional divider */
 #define SI5341_SYNTH_N_MIN	10
@@ -65,6 +77,7 @@ struct clk_si5341 {
 	u64 freq_vco; /* 13500–14256 MHz */
 	u8 num_outputs;
 	u8 num_synth;
+	u16 chip_id;
 };
 #define to_clk_si5341(_hw)	container_of(_hw, struct clk_si5341, hw)
 
@@ -142,6 +155,7 @@ static const char * const si5341_input_clock_names[] = {
 };
 
 /* Output configuration registers 0..9 are not quite logically organized */
+/* Also for si5345 */
 static const u16 si5341_reg_output_offset[] = {
 	0x0108,
 	0x010D,
@@ -155,6 +169,7 @@ static const u16 si5341_reg_output_offset[] = {
 	0x013A,
 };
 
+/* for si5340, si5342 and si5344 */
 static const u16 si5340_reg_output_offset[] = {
 	0x0112,
 	0x0117,
@@ -974,12 +989,32 @@ static int si5341_probe_chip_id(struct clk_si5341 *data)
 		data->reg_output_offset = si5341_reg_output_offset;
 		data->reg_rdiv_offset = si5341_reg_rdiv_offset;
 		break;
+	case 0x5342:
+		data->num_outputs = SI5342_MAX_NUM_OUTPUTS;
+		data->num_synth = SI5342_NUM_SYNTH;
+		data->reg_output_offset = si5340_reg_output_offset;
+		data->reg_rdiv_offset = si5340_reg_rdiv_offset;
+		break;
+	case 0x5344:
+		data->num_outputs = SI5344_MAX_NUM_OUTPUTS;
+		data->num_synth = SI5344_NUM_SYNTH;
+		data->reg_output_offset = si5340_reg_output_offset;
+		data->reg_rdiv_offset = si5340_reg_rdiv_offset;
+		break;
+	case 0x5345:
+		data->num_outputs = SI5345_MAX_NUM_OUTPUTS;
+		data->num_synth = SI5345_NUM_SYNTH;
+		data->reg_output_offset = si5341_reg_output_offset;
+		data->reg_rdiv_offset = si5341_reg_rdiv_offset;
+		break;
 	default:
 		dev_err(&data->i2c_client->dev, "Model '%x' not supported\n",
 			model);
 		return -EINVAL;
 	}
 
+	data->chip_id = model;
+
 	return 0;
 }
 
@@ -1054,6 +1089,11 @@ static const struct si5341_reg_default si5341_preamble[] = {
 	{ 0x0B4E, 0x1A },
 };
 
+static const struct si5341_reg_default si5345_preamble[] = {
+	{ 0x0B25, 0x00 },
+	{ 0x0540, 0x01 },
+};
+
 static int si5341_send_preamble(struct clk_si5341 *data)
 {
 	int res;
@@ -1068,8 +1108,14 @@ static int si5341_send_preamble(struct clk_si5341 *data)
 	res = regmap_write(data->regmap, 0xB24, revision < 2 ? 0xD8 : 0xC0);
 	if (res < 0)
 		return res;
-	res = si5341_write_multiple(data,
-		si5341_preamble, ARRAY_SIZE(si5341_preamble));
+
+	/* The si5342..si5345 require a different preamble */
+	if (data->chip_id > 0x5341)
+		res = si5341_write_multiple(data,
+			si5345_preamble, ARRAY_SIZE(si5345_preamble));
+	else
+		res = si5341_write_multiple(data,
+			si5341_preamble, ARRAY_SIZE(si5341_preamble));
 	if (res < 0)
 		return res;
 
@@ -1095,6 +1141,13 @@ static int si5341_finalize_defaults(struct clk_si5341 *data)
 	if (res < 0)
 		return res;
 
+	/* The si5342..si5345 have an additional post-amble */
+	if (data->chip_id > 0x5341) {
+		res = regmap_write(data->regmap, 0x540, 0x0);
+		if (res < 0)
+			return res;
+	}
+
 	/* Datasheet does not explain these nameless registers */
 	res = regmap_write(data->regmap, 0xB24, revision < 2 ? 0xDB : 0xC3);
 	if (res < 0)
@@ -1499,6 +1552,9 @@ static int si5341_probe(struct i2c_client *client,
 static const struct i2c_device_id si5341_id[] = {
 	{ "si5340", 0 },
 	{ "si5341", 1 },
+	{ "si5342", 2 },
+	{ "si5344", 4 },
+	{ "si5345", 5 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, si5341_id);
@@ -1506,6 +1562,9 @@ MODULE_DEVICE_TABLE(i2c, si5341_id);
 static const struct of_device_id clk_si5341_of_match[] = {
 	{ .compatible = "silabs,si5340" },
 	{ .compatible = "silabs,si5341" },
+	{ .compatible = "silabs,si5342" },
+	{ .compatible = "silabs,si5344" },
+	{ .compatible = "silabs,si5345" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, clk_si5341_of_match);
-- 
2.17.1

