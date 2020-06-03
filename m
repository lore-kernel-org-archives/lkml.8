Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B17CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FB1220679
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUrQZkJx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgFCPnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 11:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbgFCPnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 11:43:45 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBEBC08C5C0;
        Wed,  3 Jun 2020 08:43:45 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id b5so2946886iln.5;
        Wed, 03 Jun 2020 08:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tLRrk+5TE7AqBI0mMmOMi48T5DlCW6ljfttlxXJKiYE=;
        b=IUrQZkJxLQS8vRxDz1Ix+0rHj99xB3GbUzrWZj/JZPNQPvkIJu3B16AggQhDBSagKZ
         Pf1KVl1wtwQGVZmIdODKBgyzQEyhXXXe9DMnsDBbAdxzlq7tN/XHQrx5QSD9hyvfx8Yq
         4zspKiKPrPVlC+lrqHYZP306yG7jynMXx96z9NRlWqITDkN4XABIC9Gwk5yAb8mtohsv
         vyG3Y0JwrmpO2tdQKKFwK0Glt5tx18+kR3WeLqcxI9hhwEIHxluIv3PVSsPo0XA1RlpG
         eW7S2OGyn9NlAlKNM1UQ3Hwm2SgS+muzoDxTC1Vjodk8bqpgasLPsecs3OjblPcH47l5
         WhqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tLRrk+5TE7AqBI0mMmOMi48T5DlCW6ljfttlxXJKiYE=;
        b=gJtRiALzf23Sb/vndPmJxjj2ss7COxBs/aSi9MO1rchzVz4XhkBX5exijxpy/uY+lI
         SwoJ4QIvSVK9DOsINotBqKJHhZUMEdsadJNSjEnup5XzX5GDRYFJFBf+/Ri+ycxdDmxY
         FNAC6MMW28cRLoKJhVuayh6WMP5opQNqGedFepWKL7i2oMt5csy+YyoROnNv7lYmINb0
         E3Lhp7m0t9rKkYBKlYbtjATneCOrBpswgl3CgqNxqM3SFioTwTfbtp1urC8BfJhiDpXW
         xkYVsqeYSPZB5jo83lQdQOp+WcOSqbiPXEXQJgMxSo5oTmf3cereNzLRP5gJJoLZjDIn
         UwPA==
X-Gm-Message-State: AOAM532828iRqd834oMxVAUxSG9T18WJdKed0XxNtEuE14O4kcPaVyQ0
        Nvf5ksqnF/KskfDtZZ9pcqn5dCxi
X-Google-Smtp-Source: ABdhPJwy5l9sjRB7900J+AVZRjv/sYrReTt7uHRcax/vKGx9WOIeiCHAJoHdz3889FuO3WgMPS3CDg==
X-Received: by 2002:a05:6e02:50c:: with SMTP id d12mr170386ils.140.1591199023986;
        Wed, 03 Jun 2020 08:43:43 -0700 (PDT)
Received: from aford-OptiPlex-7050.logicpd.com ([174.46.170.158])
        by smtp.gmail.com with ESMTPSA id l26sm1237027ild.59.2020.06.03.08.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 08:43:43 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     Adam Ford <aford173@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 3/3] clk: vc5: Enable addition output configurations of the Versaclock
Date:   Wed,  3 Jun 2020 10:43:29 -0500
Message-Id: <20200603154329.31579-3-aford173@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603154329.31579-1-aford173@gmail.com>
References: <20200603154329.31579-1-aford173@gmail.com>
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
---
V3:  Make source code change following the binding changes since there
     is a dependency and move changes to binding header file to the
     patch with bindings changes.

diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.c
index 41e3a75963b9..9a5fb3834b9a 100644
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
-- 
2.17.1

