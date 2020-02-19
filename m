Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783C6C3404D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 09:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F60C2464E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 09:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNHopnRD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgBSJEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 04:04:35 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38226 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgBSJEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 04:04:34 -0500
Received: by mail-pf1-f195.google.com with SMTP id x185so12183311pfc.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 01:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zzjNsVT7oFssvopVPRdGW/YTCcDi0QZYWBWNA17kwhg=;
        b=eNHopnRDIVVrepw5vDCEHq2Oka1gXLsWwAXhAKzSHRO7h69Y9ZTIgAIKTw5sIE1zcr
         dDFIvcL0ReVbdcKCQOIsJTxWs7E9rSs/Ehg6Sjqt7C804okv8FBBfTp8WyrqoQ7qfyZ1
         um28qJXOkM72Gb0thvNp8UdV8ZDW5FB9sfqtK1Khzx5Lcw2l8j/DRfX3m6U/VHT3G7aO
         VA5Ql/nTRfhqLJGefDkORrM6q+9nmHHIeRph1hJVh9wwvnEzIF6Qp868Orz+oAtG3xow
         Cu4+wEg4IgD3AOV2KvTcJfY0sSWMMaac/CGvNqWXa9+rlA0eo1htT3NY7k7dZp/z5DPB
         bobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zzjNsVT7oFssvopVPRdGW/YTCcDi0QZYWBWNA17kwhg=;
        b=SURSlmvcXguxI6D5XHYZjmEapw0MvisRf84q2bXIbCQnRdUtVqJe3Fn5KTVhXxFJBe
         ai6mJ+jyPU6YS3qh1NXQBOSg+zzbuSTgJfVNkwiCAQD3lSVgzH8OuhT+qXiuvpXk0seO
         74mRMOFlD5/ynmcle0qzqejyf6kAZq7ykzRfcMAMcV0y+5ch+2RquuYuMEF1Sf0nHx1/
         VwoFA302nD4By4rlZbtB1m+bl8XJvhT98hRV1OZvM9yYO2DBXYtatQv+w4AFNMkqT9+l
         aqgqJGhKOxi0Nuh/m1TNtYpekvRbyrUpSDO3kOG8BpYnFbJ/WqE7GDVaVt4+9O+uADHj
         bMwA==
X-Gm-Message-State: APjAAAUMNaPTHrXhP/nT8zz7MMA4jECaO54ZT5EQVvE1aYjPVPDpw+i0
        ZecK5hRSqYlgZbDFDg+PNh4=
X-Google-Smtp-Source: APXvYqyUx/ed9xaA7LIfb73jmGtEiSRQm+UAORQvBANl91x/+R19025joyq1EtFB4+oxNnDeYjNruQ==
X-Received: by 2002:a63:2a02:: with SMTP id q2mr26247331pgq.198.1582103073166;
        Wed, 19 Feb 2020 01:04:33 -0800 (PST)
Received: from localhost.localdomain ([101.13.197.106])
        by smtp.gmail.com with ESMTPSA id b25sm1849858pfo.38.2020.02.19.01.04.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Feb 2020 01:04:32 -0800 (PST)
From:   Jeff Chang <richtek.jeff.chang@gmail.com>
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        matthias.bgg@gmail.com, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jeff_chang@richtek.com, richtek.jeff.chang@gmail.com
Subject: [PATCH v2] ASoC: MT6660 update to 1.0.8_G
Date:   Wed, 19 Feb 2020 17:04:24 +0800
Message-Id: <1582103064-25088-1-git-send-email-richtek.jeff.chang@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Chang <jeff_chang@richtek.com>

1. add mt6660_component_settign for Component INIT Setting

Signed-off-by: Jeff Chang <jeff_chang@richtek.com>
---
 sound/soc/codecs/mt6660.c | 78 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 75 insertions(+), 3 deletions(-)


changelogs between v2 & v1
        - remove parse DT and apply function about Chip INIT SETTING.
        - use hard coding for MT6660 Component INIT SETTING.


diff --git a/sound/soc/codecs/mt6660.c b/sound/soc/codecs/mt6660.c
index a36c416..88cf228 100644
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
@@ -225,14 +224,87 @@ static int _mt6660_chip_power_on(struct mt6660_chip *chip, int on_off)
 				 0x01, on_off ? 0x00 : 0x01);
 }
 
+struct reg_table {
+	uint32_t addr;
+	uint32_t mask;
+	uint32_t val;
+};
+
+static const struct reg_table mt6660_setting_table[] = {
+	{ 0x20, 0x80, 0x00 },
+	{ 0x30, 0x01, 0x00 },
+	{ 0x50, 0x1c, 0x04 },
+	{ 0xB1, 0x0c, 0x00 },
+	{ 0xD3, 0x03, 0x03 },
+	{ 0xE0, 0x01, 0x00 },
+	{ 0x98, 0x44, 0x04 },
+	{ 0xB9, 0xff, 0x82 },
+	{ 0xB7, 0x7777, 0x7273 },
+	{ 0xB6, 0x07, 0x03 },
+	{ 0x6B, 0xe0, 0x20 },
+	{ 0x07, 0xff, 0x70 },
+	{ 0xBB, 0xff, 0x20 },
+	{ 0x69, 0xff, 0x40 },
+	{ 0xBD, 0xffff, 0x17f8 },
+	{ 0x70, 0xff, 0x15 },
+	{ 0x7C, 0xff, 0x00 },
+	{ 0x46, 0xff, 0x1d },
+	{ 0x1A, 0xffffffff, 0x7fdb7ffe },
+	{ 0x1B, 0xffffffff, 0x7fdb7ffe },
+	{ 0x51, 0xff, 0x58 },
+	{ 0xA2, 0xff, 0xce },
+	{ 0x33, 0xffff, 0x7fff },
+	{ 0x4C, 0xffff, 0x0116 },
+	{ 0x16, 0x1800, 0x0800 },
+	{ 0x68, 0x1f, 0x07 },
+};
+
+static int mt6660_component_setting(struct snd_soc_component *component)
+{
+	struct mt6660_chip *chip = snd_soc_component_get_drvdata(component);
+	int ret = 0;
+	size_t i = 0;
+
+	ret = _mt6660_chip_power_on(chip, 1);
+	if (ret < 0) {
+		dev_err(component->dev, "%s chip power on failed\n", __func__);
+		return ret;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(mt6660_setting_table); i++) {
+		ret = snd_soc_component_update_bits(component,
+				mt6660_setting_table[i].addr,
+				mt6660_setting_table[i].mask,
+				mt6660_setting_table[i].val);
+		if (ret < 0) {
+			dev_err(component->dev, "%s update 0x%02x failed\n",
+				__func__, mt6660_setting_table[i].addr);
+			return ret;
+		}
+	}
+
+	ret = _mt6660_chip_power_on(chip, 0);
+	if (ret < 0) {
+		dev_err(component->dev, "%s chip power off failed\n", __func__);
+		return ret;
+	}
+
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
+	ret = mt6660_component_setting(component);
+	if (ret < 0)
+		dev_err(chip->dev, "mt6660 component setting failed\n");
+
+	return ret;
 }
 
 static void mt6660_component_remove(struct snd_soc_component *component)
@@ -506,4 +578,4 @@ module_i2c_driver(mt6660_i2c_driver);
 MODULE_AUTHOR("Jeff Chang <jeff_chang@richtek.com>");
 MODULE_DESCRIPTION("MT6660 SPKAMP Driver");
 MODULE_LICENSE("GPL");
-MODULE_VERSION("1.0.7_G");
+MODULE_VERSION("1.0.8_G");
-- 
2.7.4

