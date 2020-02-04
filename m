Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2245EC3524A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 03:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF6C92087E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 03:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noKxKsEi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbgBDDlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 22:41:45 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36650 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbgBDDlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 22:41:44 -0500
Received: by mail-pg1-f196.google.com with SMTP id k3so8955026pgc.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 19:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1wmDFAPTkYAVmGiYdseoOV0PhssU/32kZAP1D1mGzWo=;
        b=noKxKsEi5hJ2cN/mBOCu3khdeeb7bbWj7tR9w6qPmD+eX8jqCpDkZyQY9nO5WpAeZA
         GzNWgpYijTZ0q7eBbDClz2SaJONmfVvs40Amgr75dA7c7xRfDL/NoCYojvslUcK3l+gV
         nur8NYEHNaC7kp2kCeYxQbi7G98N/2gM2sD9U4AxFQGYoqgJzhcZIPn39aRiRX1EavUk
         21Pzq6OyY9jQjvZC0/smnR24WtF0kPZk6kT74Roc4sx2zTN7i+JSsfHsCr+oXo2NidiA
         vcHoCfVrdx/DoGAOclpJlomGpakDmrVb0mgdFGU4txNrSgm8N9HZ0/qoG7xPODXUdGP+
         ydbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1wmDFAPTkYAVmGiYdseoOV0PhssU/32kZAP1D1mGzWo=;
        b=kRqTMTgy0n4VR24t4gX5YWy4JYoAr2uIOewyWwKSXqOx4ymbdaiMQzVDwdDnNoqQa1
         n1CF0GO8RCa9899lSzjBJFq0Nsy9oYDdMZPdJtCFJ60OZrBd7oMqJHNxDT4YycEkabWw
         2/avViUhZ7NCY4Mh+QK2OSnrJnLYIwHvazY+EqIZftzQTQ0ABah/Wtpa2sA0eIt+CfdL
         Poz6349vDSwvHMlfAm70O6yoWa8BZDRhq2cxyAyQTHRhT0qS2wKJKx8fOubbroUG/UPY
         fP+MFx6V97KmC+JEIeBMO2KnpKguHeDgsFPtWtvZHN8b/Xb6iTEHtPkuePTMAJ811KiP
         D7OQ==
X-Gm-Message-State: APjAAAWnh+jykves/uzc3sq+7VJp6328FxBKCr9WeeB4m++uO4+lL1e1
        rM28+YNyfxnmiaCzG1uVdKM=
X-Google-Smtp-Source: APXvYqxg3TSdFJZZvoI2dsCVEsSxKOoClXMJvrr+oBpfUQsKLTXYgnyJiFnjM+W2BxkO+0zW38D7rA==
X-Received: by 2002:a63:e309:: with SMTP id f9mr29046059pgh.391.1580787703774;
        Mon, 03 Feb 2020 19:41:43 -0800 (PST)
Received: from localhost.localdomain ([101.12.16.40])
        by smtp.gmail.com with ESMTPSA id 23sm11294194pfh.28.2020.02.03.19.41.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Feb 2020 19:41:43 -0800 (PST)
From:   Jeff Chang <richtek.jeff.chang@gmail.com>
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        matthias.bgg@gmail.com, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jeff_chang@richtek.com, richtek.jeff.chang@gmail.com
Subject: [PATCH] ASoC: MT6660 update to 1.0.8_G
Date:   Tue,  4 Feb 2020 11:41:37 +0800
Message-Id: <1580787697-3041-1-git-send-email-richtek.jeff.chang@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Chang <jeff_chang@richtek.com>

1. add parsing register initial table via device tree.
2. add applying initial register value function at component driver.

Signed-off-by: Jeff Chang <jeff_chang@richtek.com>
---
 Documentation/devicetree/bindings/sound/mt6660.txt |  53 ++++++++++
 sound/soc/codecs/mt6660.c                          | 114 ++++++++++++++++++++-
 2 files changed, 164 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/mt6660.txt


Following Mr. Mark's Suggestion, I create another patch for applying our chip INIT SETTING.


diff --git a/Documentation/devicetree/bindings/sound/mt6660.txt b/Documentation/devicetree/bindings/sound/mt6660.txt
new file mode 100644
index 0000000..2a1736b
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mt6660.txt
@@ -0,0 +1,53 @@
+MT6660 MediaTek Speaker Amplifier
+
+This device supports I2C mode only.
+
+Required properties:
+
+	- compatible : "mediatek,mt6660"
+	
+	- reg : The I2C slave address
+
+Optional properties:
+
+	- rt,init_setting_num : The initial register setting element number.
+
+	- rt,init_setting_addr : the addreses array for INIT Setting table.
+
+	- rt,init_setting_mask : the mask array for INIT Setting table.
+
+	- rt,init_setting_val : the value array for INIT Setting table.
+
+Example:
+
+	mt6660@34 {
+		status = "ok";
+		compatible = "mediatek,mt6660";
+		reg = <0x34>;
+		rt,init_setting_num = <26>;
+		rt,init_setting_addr =
+			<0x20 0x30 0x50 0xB1
+			 0xD3 0xE0 0x98 0xB9
+			 0xB7 0xB6 0x6B 0x07
+			 0xBB 0x69 0xBD 0x70
+			 0x7C 0x46 0x1A 0x1B
+			 0x51 0xA2 0x33 0x4C
+			 0x15 0x68>;
+		rt,init_setting_mask =
+			<0x80 0x01 0x1c 0x0c
+			 0x03 0x01 0x44 0xff
+			 0x7777 0x07 0xe0 0xff
+			 0xff 0xff 0xffff 0xff
+			 0xff 0xff 0xffffffff 0xffffffff
+			 0xff 0xff 0xffff 0xffff
+			 0x1800 0x1f>;
+		rt,init_setting_val =
+			<0x00 0x00 0x04 0x00
+			 0x03 0x00 0x04 0x82
+			 0x7273 0x03 0x20 0x70
+			 0x20 0x40 0x17f8 0x15
+			 0x00 0x1d 0x7fdb7ffe 0x7fdb7ffe
+			 0x58 0xce 0x7fff 0x0116
+			 0x0800 0x07>;
+	};
+
diff --git a/sound/soc/codecs/mt6660.c b/sound/soc/codecs/mt6660.c
index a36c416..5df2780 100644
--- a/sound/soc/codecs/mt6660.c
+++ b/sound/soc/codecs/mt6660.c
@@ -9,7 +9,6 @@
 #include <linux/i2c.h>
 #include <linux/pm_runtime.h>
 #include <linux/delay.h>
-#include <linux/debugfs.h>
 #include <sound/soc.h>
 #include <sound/tlv.h>
 #include <sound/pcm_params.h>
@@ -225,14 +224,48 @@ static int _mt6660_chip_power_on(struct mt6660_chip *chip, int on_off)
 				 0x01, on_off ? 0x00 : 0x01);
 }
 
+static int mt6660_apply_plat_data(struct mt6660_chip *chip,
+		struct snd_soc_component *component)
+{
+	size_t i;
+	int num = chip->plat_data.init_setting_num;
+	int ret;
+
+	ret = _mt6660_chip_power_on(chip, 1);
+	if (ret < 0) {
+		dev_err(chip->dev, "%s power on failed\n", __func__);
+		return ret;
+	}
+
+	for (i = 0; i < num; i++) {
+		ret = snd_soc_component_update_bits(component,
+				chip->plat_data.init_setting_addr[i],
+				chip->plat_data.init_setting_mask[i],
+				chip->plat_data.init_setting_val[i]);
+		if (ret < 0)
+			return ret;
+	}
+	ret = _mt6660_chip_power_on(chip, 0);
+	if (ret < 0) {
+		dev_err(chip->dev, "%s power on failed\n", __func__);
+		return ret;
+	}
+	return 0;
+}
+
 static int mt6660_component_probe(struct snd_soc_component *component)
 {
 	struct mt6660_chip *chip = snd_soc_component_get_drvdata(component);
+	int ret;
 
 	dev_dbg(component->dev, "%s\n", __func__);
 	snd_soc_component_init_regmap(component, chip->regmap);
 
-	return 0;
+	ret = mt6660_apply_plat_data(chip, component);
+	if (ret < 0)
+		dev_err(chip->dev, "mt6660 apply plat data failed\n");
+
+	return ret;
 }
 
 static void mt6660_component_remove(struct snd_soc_component *component)
@@ -386,6 +419,75 @@ static int _mt6660_read_chip_revision(struct mt6660_chip *chip)
 	return 0;
 }
 
+static int mt6660_parse_dt(struct mt6660_chip *chip, struct device *dev)
+{
+	struct device_node *np = dev->of_node;
+	u32 val;
+	size_t i;
+
+	if (!np) {
+		dev_err(dev, "no device node\n");
+		return -EINVAL;
+	}
+
+	if (of_property_read_u32(np, "rt,init_setting_num", &val)) {
+		dev_err(dev, "no init setting\n");
+		chip->plat_data.init_setting_num = 0;
+	} else {
+		chip->plat_data.init_setting_num = val;
+	}
+
+	if (chip->plat_data.init_setting_num) {
+		chip->plat_data.init_setting_addr =
+			devm_kzalloc(dev, sizeof(u32) *
+			chip->plat_data.init_setting_num, GFP_KERNEL);
+		if (!chip->plat_data.init_setting_addr) {
+			dev_err(dev, "%s addr memory alloc failed\n", __func__);
+			return -ENOMEM;
+		}
+		chip->plat_data.init_setting_mask =
+			devm_kzalloc(dev, sizeof(u32) *
+			chip->plat_data.init_setting_num, GFP_KERNEL);
+		if (!chip->plat_data.init_setting_mask) {
+			dev_err(dev, "%s mask memory alloc failed\n", __func__);
+			return -ENOMEM;
+		}
+		chip->plat_data.init_setting_val =
+			devm_kzalloc(dev, sizeof(u32) *
+			chip->plat_data.init_setting_num, GFP_KERNEL);
+		if (!chip->plat_data.init_setting_val) {
+			dev_err(dev, "%s val memory alloc failed\n", __func__);
+			return -ENOMEM;
+		}
+
+		if (of_property_read_u32_array(np, "rt,init_setting_addr",
+					chip->plat_data.init_setting_addr,
+					chip->plat_data.init_setting_num)) {
+			dev_err(dev, "no init setting addr\n");
+		}
+		if (of_property_read_u32_array(np, "rt,init_setting_mask",
+					chip->plat_data.init_setting_mask,
+					chip->plat_data.init_setting_num)) {
+			dev_err(dev, "no init setting mask\n");
+		}
+		if (of_property_read_u32_array(np, "rt,init_setting_val",
+					chip->plat_data.init_setting_val,
+					chip->plat_data.init_setting_num)) {
+			dev_err(dev, "no init setting val\n");
+		}
+	}
+
+	dev_dbg(dev, "%s, init stting table, num = %d\n", __func__,
+		chip->plat_data.init_setting_num);
+	for (i = 0; i < chip->plat_data.init_setting_num; i++) {
+		dev_dbg(dev, "0x%02x, 0x%08x, 0x%08x\n",
+				chip->plat_data.init_setting_addr[i],
+				chip->plat_data.init_setting_mask[i],
+				chip->plat_data.init_setting_val[i]);
+	}
+	return 0;
+}
+
 static int mt6660_i2c_probe(struct i2c_client *client,
 			    const struct i2c_device_id *id)
 {
@@ -401,6 +503,12 @@ static int mt6660_i2c_probe(struct i2c_client *client,
 	mutex_init(&chip->io_lock);
 	i2c_set_clientdata(client, chip);
 
+	ret = mt6660_parse_dt(chip, &client->dev);
+	if (ret < 0) {
+		dev_err(&client->dev, "parsing dts failed\n");
+		return ret;
+	}
+
 	chip->regmap = devm_regmap_init(&client->dev,
 		NULL, chip, &mt6660_regmap_config);
 	if (IS_ERR(chip->regmap)) {
@@ -506,4 +614,4 @@ module_i2c_driver(mt6660_i2c_driver);
 MODULE_AUTHOR("Jeff Chang <jeff_chang@richtek.com>");
 MODULE_DESCRIPTION("MT6660 SPKAMP Driver");
 MODULE_LICENSE("GPL");
-MODULE_VERSION("1.0.7_G");
+MODULE_VERSION("1.0.8_G");
-- 
2.7.4

