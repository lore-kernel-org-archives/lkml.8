Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D200C2BB85
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06DB4206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vYrrSX6i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505001AbgDNTi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 15:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504929AbgDNThC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 15:37:02 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CB5C061A10;
        Tue, 14 Apr 2020 12:37:02 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id j4so14623303qkc.11;
        Tue, 14 Apr 2020 12:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fjl04AvGatFBHs3F8PNak+0QD1cADS1DXagU55OwTUQ=;
        b=vYrrSX6iKHo+375LeUlauc+9yfd+cy2+mZcXdyJb9JFCH5sGbPKNseAeeaNSDaTvUe
         74sGtZyA2XuNV/O/by7jASGq7Wwax6SKW3AAkmWwdo8Ztg792L3v0QPa0NTYIrR6sX9Y
         ufeZOx/ZidFNjLkTjXxq8GfadKz2FITyeboElMaOCkPSjErVx/JZy2Z/m0fA0ShebKkt
         OlgWxjpFZz8favxunmaL5uAtUoDmsKrcVtUZ5fwIxLkBTCIn6NOJJjhYgbE+G/WALxOq
         43og3ppvNpYUSiyDOQBC2avrr/+HfIKe6FslVl6E/JBQx1s34HoXIkkY5zyEwDqaU5L2
         /gwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fjl04AvGatFBHs3F8PNak+0QD1cADS1DXagU55OwTUQ=;
        b=GrOIIFZ0fxd/AuiflzQ5XCvKXXHQmSqgddRUr7b5qk1Ocbvt4uOPDK80DAhdJr0nmj
         gQgFppxK0FEr0qE91CMs09OAOYgLdrzc5Cy9+wnTtsOy3cnhyU6MJYiqFJtjx9soS3Ha
         oTHdEXxEMhonnHBz3cpR3PecxUGMeZUCFO3yWrIbyFOYTNp52Nsccx6FXJCejgBXwuO5
         8MURuUOM+P1TF0UR1onuvAfem8M8dPJZxIP/eUursUf6hk+GdpheBUsyAwqtcI80EVPE
         jZ29jaZA8B+zQh0ykBjMpVGX3/S8PlvDn5alGXbhjlJ/uv52mCaqf1q12NtukdtYUMex
         zsfQ==
X-Gm-Message-State: AGi0PuZDBaEkDO7UR/smxqJ/c0lwm9K38FFcSDS0M7HI/1FsUA+mB560
        Hx1BILhcT8Bmfunh9wjNUWP632z18dM=
X-Google-Smtp-Source: APiQypKT/2xifUqJEDMjmJ3zkyuIFDEixFL+aFsuWFlDc0qW731t9b6jgeTEeHlmy3FlokbDLqhLlw==
X-Received: by 2002:a37:a3d8:: with SMTP id m207mr3185830qke.371.1586893021348;
        Tue, 14 Apr 2020 12:37:01 -0700 (PDT)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id t15sm11960197qtc.64.2020.04.14.12.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 12:37:00 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     aford@beaconembedded.com, charles.stevens@logicpd.com,
        Adam Ford <aford173@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] clk: vc5: Enable addition output configurations of the Versaclock
Date:   Tue, 14 Apr 2020 14:36:15 -0500
Message-Id: <20200414193616.1368209-2-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200414193616.1368209-1-aford173@gmail.com>
References: <20200414193616.1368209-1-aford173@gmail.com>
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
index 6e4b09f1f074..a1da88baf28c 100644
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
+#define VC5_CLK_OUTPUT_CFG0_CFG_MASK	GENMASK(7, VC5_CLK_OUTPUT_CFG0_CFG_SHIFT)
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
+#define VC5_CLK_OUTPUT_CFG0_PWR_MASK	GENMASK(4, VC5_CLK_OUTPUT_CFG0_PWR_SHIFT)
+#define VC5_CLK_OUTPUT_CFG0_PWR_18	(0<<VC5_CLK_OUTPUT_CFG0_PWR_SHIFT)
+#define VC5_CLK_OUTPUT_CFG0_PWR_25	(2<<VC5_CLK_OUTPUT_CFG0_PWR_SHIFT)
+#define VC5_CLK_OUTPUT_CFG0_PWR_33	(3<<VC5_CLK_OUTPUT_CFG0_PWR_SHIFT)
+#define VC5_CLK_OUTPUT_CFG0_SLEW_SHIFT	0
+#define VC5_CLK_OUTPUT_CFG0_SLEW_MASK	GENMASK(1, VC5_CLK_OUTPUT_CFG0_SLEW_SHIFT)
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
@@ -567,6 +593,16 @@ static int vc5_clk_out_prepare(struct clk_hw *hw)
 	regmap_update_bits(vc5->regmap, VC5_CLK_OUTPUT_CFG(hwdata->num, 1),
 			   VC5_CLK_OUTPUT_CFG1_EN_CLKBUF,
 			   VC5_CLK_OUTPUT_CFG1_EN_CLKBUF);
+	if (hwdata->clk_output_cfg0_mask) {
+		dev_dbg(&vc5->client->dev, "Update output %d mask 0x%0X val 0x%0X\n",
+			hwdata->num, hwdata->clk_output_cfg0_mask,
+			hwdata->clk_output_cfg0);
+
+		regmap_update_bits(vc5->regmap, VC5_CLK_OUTPUT_CFG(hwdata->num, 0),
+			hwdata->clk_output_cfg0_mask,
+			hwdata->clk_output_cfg0);
+	}
+
 	return 0;
 }
 
@@ -675,6 +711,9 @@ static int vc5_probe(struct i2c_client *client,
 	struct clk_init_data init;
 	const char *parent_names[2];
 	unsigned int n, idx = 0;
+	u32 value;
+	struct device_node *np_output;
+	char *child_name;
 	int ret;
 
 	vc5 = devm_kzalloc(&client->dev, sizeof(*vc5), GFP_KERNEL);
@@ -865,6 +904,77 @@ static int vc5_probe(struct i2c_client *client,
 				init.name);
 			goto err_clk;
 		}
+
+		/* Fetch Clock Output configuration from DT (if specified) */
+		child_name = kasprintf(GFP_KERNEL, "OUT%d", n);
+		np_output = of_get_child_by_name(client->dev.of_node, child_name);
+		kfree(child_name);
+		if (!np_output)
+			continue;
+		if (!(ret || of_property_read_u32(np_output,
+			"idt,mode", &value))) {
+			vc5->clk_out[n].clk_output_cfg0_mask |= VC5_CLK_OUTPUT_CFG0_CFG_MASK;
+			switch (value) {
+			case VC5_CLK_OUTPUT_CFG0_CFG_LVPECL:
+			case VC5_CLK_OUTPUT_CFG0_CFG_CMOS:
+			case VC5_CLK_OUTPUT_CFG0_CFG_HCSL33:
+			case VC5_CLK_OUTPUT_CFG0_CFG_LVDS:
+			case VC5_CLK_OUTPUT_CFG0_CFG_CMOS2:
+			case VC5_CLK_OUTPUT_CFG0_CFG_CMOSD:
+			case VC5_CLK_OUTPUT_CFG0_CFG_HCSL25:
+				vc5->clk_out[n].clk_output_cfg0 |= value << VC5_CLK_OUTPUT_CFG0_CFG_SHIFT;
+				break;
+			default:
+				ret = -EINVAL;
+				break;
+			}
+		}
+		if (!(ret || of_property_read_u32(np_output,
+			"idt,voltage-microvolts", &value))) {
+			vc5->clk_out[n].clk_output_cfg0_mask |= VC5_CLK_OUTPUT_CFG0_PWR_MASK;
+			switch (value) {
+			case 1800000:
+				vc5->clk_out[n].clk_output_cfg0 |= VC5_CLK_OUTPUT_CFG0_PWR_18;
+				break;
+			case 2500000:
+				vc5->clk_out[n].clk_output_cfg0 |= VC5_CLK_OUTPUT_CFG0_PWR_25;
+				break;
+			case 3300000:
+				vc5->clk_out[n].clk_output_cfg0 |= VC5_CLK_OUTPUT_CFG0_PWR_33;
+				break;
+			default:
+				ret = -EINVAL;
+				break;
+			}
+		}
+		if (!(ret || of_property_read_u32(np_output,
+			"idt,slew-percent", &value))) {
+			vc5->clk_out[n].clk_output_cfg0_mask |= VC5_CLK_OUTPUT_CFG0_SLEW_MASK;
+			switch (value) {
+			case 80:
+				vc5->clk_out[n].clk_output_cfg0 |= VC5_CLK_OUTPUT_CFG0_SLEW_80;
+				break;
+			case 85:
+				vc5->clk_out[n].clk_output_cfg0 |= VC5_CLK_OUTPUT_CFG0_SLEW_85;
+				break;
+			case 90:
+				vc5->clk_out[n].clk_output_cfg0 |= VC5_CLK_OUTPUT_CFG0_SLEW_90;
+				break;
+			case 100:
+				vc5->clk_out[n].clk_output_cfg0 |= VC5_CLK_OUTPUT_CFG0_SLEW_100;
+				break;
+			default:
+				ret = -EINVAL;
+				break;
+			}
+		}
+		of_node_put(np_output);
+		if (ret) {
+			dev_err(&client->dev,
+				 "Invalid clock output configuration OUT%d\n",
+				 n);
+			goto err_clk;
+		}
 	}
 
 	ret = of_clk_add_hw_provider(client->dev.of_node, vc5_of_clk_get, vc5);
diff --git a/include/dt-bindings/clk/versaclock.h b/include/dt-bindings/clk/versaclock.h
new file mode 100644
index 000000000000..30add3488713
--- /dev/null
+++ b/include/dt-bindings/clk/versaclock.h
@@ -0,0 +1,13 @@
+/* HEADER */
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

