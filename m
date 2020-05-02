Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638A6C3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 12:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35CCB2137B
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 12:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCF0fvZI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgEBMVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 08:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727815AbgEBMVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 08:21:47 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13856C061A0C;
        Sat,  2 May 2020 05:21:47 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id q7so11872508qkf.3;
        Sat, 02 May 2020 05:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xc+J3gtEQ6bPEPTp0sgpXqx6Tn93A+XqoBLEHYkXhKM=;
        b=jCF0fvZIPTawUCjHOM7V09c/e61xyhbmprSvjmt5CNWIj1nAVGMPsw9kbKD51QFdWm
         03uJGvvUfvsu1dTlTd5/5nN0JnqoTO6CO7EkDY0Hwpn+Vh3+o2qdd+d0QZlUcccxePUr
         kD9c56Z6Q20pTHpQ4LpUWaehjXgZx7gc3YZoVk4G1aj/9NM1vRxklXIGn7kHXiD+qug3
         0hBljFsRm5q1fvpd+Xc4+6Y6bw0VzledqZ7+fna1KmLqDxg8kDwQJa5PaeEax6cMKepS
         zJ5baYMhXyghH50gxaAGOUP4iHXZZWBd5lxXrd7KeHVTPxiqvTt+O/Rx7sETyK6rXSfW
         DVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xc+J3gtEQ6bPEPTp0sgpXqx6Tn93A+XqoBLEHYkXhKM=;
        b=jH769tSljB2sFSVhzRJ2IXHLs4AS5Io7KScXEbMYELdaGrA7lQPl/aj2Aj3eYw2kAd
         gkqDfszpmidmBhKnWy/1WoMqbf+xSRf4neBFVgwdDdfcFZPtxS46fvwU957hbR2F37Kg
         NfIgHMoz9ARE1TfIQA8pUvoX5E5+fm2KGDeXPU1bzyAv6Ccw6sGWyO1I/O/YZMaU5apX
         PuNytKRcAT1j7y56O2htpWe4NBLF59oHeHnOhS5qAXvpn063Ex8sgUt2//x7ddIP/qKQ
         +yroOtZ/6oBROeHYBo94pIsuo/S/NgtQBI/ZohWtZYPxToaEBM0ntW02D0L8nXjEkNXV
         8E8w==
X-Gm-Message-State: AGi0PuY4nrE5zX0jbJjnHW+KJwaerqx2zgpOp5c1EJF4YSJsTFjj2LHw
        bUU6qljntcdYLe+MzqBcIDYuLulqOOQ=
X-Google-Smtp-Source: APiQypKenyB99S4TSSF7qhbgp0pDpPJx8fMkndmgo9aJiw8nzsHsQJPKUOuBihrBg1nimDH4HwY6Vw==
X-Received: by 2002:a37:d8e:: with SMTP id 136mr7804191qkn.260.1588422105817;
        Sat, 02 May 2020 05:21:45 -0700 (PDT)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id p47sm5256413qta.44.2020.05.02.05.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2020 05:21:45 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     aford@beaconembedded.com, charles.stevens@logicpd.com,
        Adam Ford <aford173@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/3] clk: vc5: Enable addition output configurations of the Versaclock
Date:   Sat,  2 May 2020 07:21:25 -0500
Message-Id: <20200502122126.188001-2-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200502122126.188001-1-aford173@gmail.com>
References: <20200502122126.188001-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing driver is expecting the Versaclock to be pre-programmed,
and only sets the output frequency.  Unfortunately, not all devices
are pre-programmed, and the Versaclock chip has more options beyond
just the frequency.

This patch enables the following additional features:

   - Programmable voltage: 1.8V, 2.5V, or 3.3V​
   - Slew Percentage of normal: 85%, 90%, or 100%
   - Output Type: LVPECL, CMOS, HCSL, or LVDS

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.c
index 81255d923f00..ad99d50b7b16 100644
--- a/drivers/clk/clk-versaclock5.c
+++ b/drivers/clk/clk-versaclock5.c
@@ -24,6 +24,8 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
+#include <dt-bindings/clk/versaclock.h>
+
 /* VersaClock5 registers */
 #define VC5_OTP_CONTROL				0x00
 
@@ -89,6 +91,28 @@
 
 /* Clock control register for clock 1,2 */
 #define VC5_CLK_OUTPUT_CFG(idx, n)	(0x60 + ((idx) * 0x2) + (n))
+#define VC5_CLK_OUTPUT_CFG0_CFG_SHIFT	5
+#define VC5_CLK_OUTPUT_CFG0_CFG_MASK GENMASK(7, VC5_CLK_OUTPUT_CFG0_CFG_SHIFT)
+
+#define VC5_CLK_OUTPUT_CFG0_CFG_LVPECL	(VC5_LVPECL)
+#define VC5_CLK_OUTPUT_CFG0_CFG_CMOS		(VC5_CMOS)
+#define VC5_CLK_OUTPUT_CFG0_CFG_HCSL33	(VC5_HCSL33)
+#define VC5_CLK_OUTPUT_CFG0_CFG_LVDS		(VC5_LVDS)
+#define VC5_CLK_OUTPUT_CFG0_CFG_CMOS2		(VC5_CMOS2)
+#define VC5_CLK_OUTPUT_CFG0_CFG_CMOSD		(VC5_CMOSD)
+#define VC5_CLK_OUTPUT_CFG0_CFG_HCSL25	(VC5_HCSL25)
+
+#define VC5_CLK_OUTPUT_CFG0_PWR_SHIFT	3
+#define VC5_CLK_OUTPUT_CFG0_PWR_MASK GENMASK(4, VC5_CLK_OUTPUT_CFG0_PWR_SHIFT)
+#define VC5_CLK_OUTPUT_CFG0_PWR_18	(0<<VC5_CLK_OUTPUT_CFG0_PWR_SHIFT)
+#define VC5_CLK_OUTPUT_CFG0_PWR_25	(2<<VC5_CLK_OUTPUT_CFG0_PWR_SHIFT)
+#define VC5_CLK_OUTPUT_CFG0_PWR_33	(3<<VC5_CLK_OUTPUT_CFG0_PWR_SHIFT)
+#define VC5_CLK_OUTPUT_CFG0_SLEW_SHIFT	0
+#define VC5_CLK_OUTPUT_CFG0_SLEW_MASK GENMASK(1, VC5_CLK_OUTPUT_CFG0_SLEW_SHIFT)
+#define VC5_CLK_OUTPUT_CFG0_SLEW_80	(0<<VC5_CLK_OUTPUT_CFG0_SLEW_SHIFT)
+#define VC5_CLK_OUTPUT_CFG0_SLEW_85	(1<<VC5_CLK_OUTPUT_CFG0_SLEW_SHIFT)
+#define VC5_CLK_OUTPUT_CFG0_SLEW_90	(2<<VC5_CLK_OUTPUT_CFG0_SLEW_SHIFT)
+#define VC5_CLK_OUTPUT_CFG0_SLEW_100	(3<<VC5_CLK_OUTPUT_CFG0_SLEW_SHIFT)
 #define VC5_CLK_OUTPUT_CFG1_EN_CLKBUF	BIT(0)
 
 #define VC5_CLK_OE_SHDN				0x68
@@ -143,6 +167,8 @@ struct vc5_hw_data {
 	u32			div_int;
 	u32			div_frc;
 	unsigned int		num;
+	unsigned int		clk_output_cfg0;
+	unsigned int		clk_output_cfg0_mask;
 };
 
 struct vc5_driver_data {
@@ -567,6 +593,17 @@ static int vc5_clk_out_prepare(struct clk_hw *hw)
 	regmap_update_bits(vc5->regmap, VC5_CLK_OUTPUT_CFG(hwdata->num, 1),
 			   VC5_CLK_OUTPUT_CFG1_EN_CLKBUF,
 			   VC5_CLK_OUTPUT_CFG1_EN_CLKBUF);
+	if (hwdata->clk_output_cfg0_mask) {
+		dev_dbg(&vc5->client->dev, "Update output %d mask 0x%0X val 0x%0X\n",
+			hwdata->num, hwdata->clk_output_cfg0_mask,
+			hwdata->clk_output_cfg0);
+
+		regmap_update_bits(vc5->regmap,
+			VC5_CLK_OUTPUT_CFG(hwdata->num, 0),
+			hwdata->clk_output_cfg0_mask,
+			hwdata->clk_output_cfg0);
+	}
+
 	return 0;
 }
 
@@ -666,6 +703,120 @@ static int vc5_map_index_to_output(const enum vc5_model model,
 	}
 }
 
+static int vc5_update_mode(struct device_node *np_output,
+			   struct vc5_hw_data *clk_out)
+{
+	u32 value;
+
+	if (!of_property_read_u32(np_output, "idt,mode", &value)) {
+		clk_out->clk_output_cfg0_mask |= VC5_CLK_OUTPUT_CFG0_CFG_MASK;
+		switch (value) {
+		case VC5_CLK_OUTPUT_CFG0_CFG_LVPECL:
+		case VC5_CLK_OUTPUT_CFG0_CFG_CMOS:
+		case VC5_CLK_OUTPUT_CFG0_CFG_HCSL33:
+		case VC5_CLK_OUTPUT_CFG0_CFG_LVDS:
+		case VC5_CLK_OUTPUT_CFG0_CFG_CMOS2:
+		case VC5_CLK_OUTPUT_CFG0_CFG_CMOSD:
+		case VC5_CLK_OUTPUT_CFG0_CFG_HCSL25:
+			clk_out->clk_output_cfg0 |=
+			    value << VC5_CLK_OUTPUT_CFG0_CFG_SHIFT;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
+static int vc5_update_power(struct device_node *np_output,
+			    struct vc5_hw_data *clk_out)
+{
+	u32 value;
+
+	if (!of_property_read_u32(np_output,
+				  "idt,voltage-microvolts", &value)) {
+		clk_out->clk_output_cfg0_mask |= VC5_CLK_OUTPUT_CFG0_PWR_MASK;
+		switch (value) {
+		case 1800000:
+			clk_out->clk_output_cfg0 |= VC5_CLK_OUTPUT_CFG0_PWR_18;
+			break;
+		case 2500000:
+			clk_out->clk_output_cfg0 |= VC5_CLK_OUTPUT_CFG0_PWR_25;
+			break;
+		case 3300000:
+			clk_out->clk_output_cfg0 |= VC5_CLK_OUTPUT_CFG0_PWR_33;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
+static int vc5_update_slew(struct device_node *np_output,
+			   struct vc5_hw_data *clk_out)
+{
+	u32 value;
+
+	if (!of_property_read_u32(np_output, "idt,slew-percent", &value)) {
+		clk_out->clk_output_cfg0_mask |= VC5_CLK_OUTPUT_CFG0_SLEW_MASK;
+		switch (value) {
+		case 80:
+			clk_out->clk_output_cfg0 |= VC5_CLK_OUTPUT_CFG0_SLEW_80;
+			break;
+		case 85:
+			clk_out->clk_output_cfg0 |= VC5_CLK_OUTPUT_CFG0_SLEW_85;
+			break;
+		case 90:
+			clk_out->clk_output_cfg0 |= VC5_CLK_OUTPUT_CFG0_SLEW_90;
+			break;
+		case 100:
+			clk_out->clk_output_cfg0 |=
+			    VC5_CLK_OUTPUT_CFG0_SLEW_100;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
+static int vc5_get_output_config(struct i2c_client *client,
+				 struct vc5_hw_data *clk_out)
+{
+	struct device_node *np_output;
+	char *child_name;
+	int ret = 0;
+
+	child_name = kasprintf(GFP_KERNEL, "OUT%d", clk_out->num + 1);
+	np_output = of_get_child_by_name(client->dev.of_node, child_name);
+	kfree(child_name);
+	if (!np_output)
+		goto output_done;
+
+	ret = vc5_update_mode(np_output, clk_out);
+	if (ret)
+		goto output_error;
+
+	ret = vc5_update_power(np_output, clk_out);
+	if (ret)
+		goto output_error;
+
+	ret = vc5_update_slew(np_output, clk_out);
+
+output_error:
+	if (ret) {
+		dev_err(&client->dev,
+			"Invalid clock output configuration OUT%d\n",
+			clk_out->num + 1);
+	}
+
+	of_node_put(np_output);
+
+output_done:
+	return ret;
+}
+
 static const struct of_device_id clk_vc5_of_match[];
 
 static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
@@ -863,6 +1014,11 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
 				init.name);
 			goto err_clk;
 		}
+
+		/* Fetch Clock Output configuration from DT (if specified) */
+		ret = vc5_get_output_config(client, &vc5->clk_out[n]);
+		if (ret)
+			goto err_clk;
 	}
 
 	ret = of_clk_add_hw_provider(client->dev.of_node, vc5_of_clk_get, vc5);
diff --git a/include/dt-bindings/clk/versaclock.h b/include/dt-bindings/clk/versaclock.h
new file mode 100644
index 000000000000..c6a6a0946564
--- /dev/null
+++ b/include/dt-bindings/clk/versaclock.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/* This file defines field values used by the versaclock 6 family
+ * for defining output type
+ */
+
+#define VC5_LVPECL	0
+#define VC5_CMOS	1
+#define VC5_HCSL33	2
+#define VC5_LVDS	3
+#define VC5_CMOS2	4
+#define VC5_CMOSD	5
+#define VC5_HCSL25	6
-- 
2.25.1

