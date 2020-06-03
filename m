Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E737EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 10:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE5C1206A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 10:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbgFCKhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 06:37:39 -0400
Received: from inva021.nxp.com ([92.121.34.21]:53340 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgFCKhg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 06:37:36 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 77BD5200E03;
        Wed,  3 Jun 2020 12:37:34 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3D04F200DFE;
        Wed,  3 Jun 2020 12:37:29 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 80710402B1;
        Wed,  3 Jun 2020 18:37:22 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        broonie@kernel.org, ckeepax@opensource.cirrus.com,
        allison@lohutok.net, info@metux.net, tglx@linutronix.de,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 2/2] ASoC: wm8960: Support headphone jack detection function
Date:   Wed,  3 Jun 2020 18:26:53 +0800
Message-Id: <1591180013-12416-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591180013-12416-1-git-send-email-shengjiu.wang@nxp.com>
References: <1591180013-12416-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two platform variables for headphone jack detection.
"hp_cfg" is for configuration of heaphone jack detection.
"gpio_cfg" is for configuration of gpio, the gpio is used
for plug & unplug interrupt on SoC.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 include/sound/wm8960.h    | 17 +++++++++++++++++
 sound/soc/codecs/wm8960.c | 20 ++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/sound/wm8960.h b/include/sound/wm8960.h
index d22e84805025..275fd5b201ce 100644
--- a/include/sound/wm8960.h
+++ b/include/sound/wm8960.h
@@ -16,6 +16,23 @@ struct wm8960_data {
 	bool capless;  /* Headphone outputs configured in capless mode */
 
 	bool shared_lrclk;  /* DAC and ADC LRCLKs are wired together */
+
+	/*
+	 * Setup for headphone detection
+	 *
+	 * hp_cfg[0]: HPSEL[1:0] of R48 (Additional Control 4)
+	 * hp_cfg[1]: {HPSWEN:HPSWPOL} of R24 (Additional Control 2).
+	 * hp_cfg[2]: {TOCLKSEL:TOEN} of R23 (Additional Control 1).
+	 */
+	u32 hp_cfg[3];
+
+	/*
+	 * Setup for gpio configuration
+	 *
+	 * gpio_cfg[0]: ALRCGPIO of R9 (Audio interface)
+	 * gpio_cfg[1]: {GPIOPOL:GPIOSEL[2:0]} of R48 (Additional Control 4).
+	 */
+	u32 gpio_cfg[2];
 };
 
 #endif
diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 6cf0f6612bda..2f7f0493144a 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -1389,6 +1389,12 @@ static void wm8960_set_pdata_from_of(struct i2c_client *i2c,
 
 	if (of_property_read_bool(np, "wlf,shared-lrclk"))
 		pdata->shared_lrclk = true;
+
+	of_property_read_u32_array(np, "wlf,gpio-cfg", pdata->gpio_cfg,
+				   ARRAY_SIZE(pdata->gpio_cfg));
+
+	of_property_read_u32_array(np, "wlf,hp-cfg", pdata->hp_cfg,
+				   ARRAY_SIZE(pdata->hp_cfg));
 }
 
 static int wm8960_i2c_probe(struct i2c_client *i2c,
@@ -1446,6 +1452,20 @@ static int wm8960_i2c_probe(struct i2c_client *i2c,
 	regmap_update_bits(wm8960->regmap, WM8960_LOUT2, 0x100, 0x100);
 	regmap_update_bits(wm8960->regmap, WM8960_ROUT2, 0x100, 0x100);
 
+	/* ADCLRC pin configured as GPIO. */
+	regmap_update_bits(wm8960->regmap, WM8960_IFACE2, 1 << 6,
+			   wm8960->pdata.gpio_cfg[0] << 6);
+	regmap_update_bits(wm8960->regmap, WM8960_ADDCTL4, 0xF << 4,
+			   wm8960->pdata.gpio_cfg[1] << 4);
+
+	/* Enable headphone jack detect */
+	regmap_update_bits(wm8960->regmap, WM8960_ADDCTL4, 3 << 2,
+			   wm8960->pdata.hp_cfg[0] << 2);
+	regmap_update_bits(wm8960->regmap, WM8960_ADDCTL2, 3 << 5,
+			   wm8960->pdata.hp_cfg[1] << 5);
+	regmap_update_bits(wm8960->regmap, WM8960_ADDCTL1, 3,
+			   wm8960->pdata.hp_cfg[2]);
+
 	i2c_set_clientdata(i2c, wm8960);
 
 	ret = devm_snd_soc_register_component(&i2c->dev,
-- 
2.21.0

