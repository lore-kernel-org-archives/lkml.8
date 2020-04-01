Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B49C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A47320719
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731545AbgDAI0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 04:26:07 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12596 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726197AbgDAI0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 04:26:06 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7E093B1E66502C2BA533;
        Wed,  1 Apr 2020 16:25:56 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Wed, 1 Apr 2020
 16:25:47 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <oder_chiou@realtek.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <pierre-louis.bossart@linux.intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: rt5682: Fix build error without CONFIG_I2C
Date:   Wed, 1 Apr 2020 16:25:40 +0800
Message-ID: <20200401082540.21876-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If I2C is n but SoundWire is m, building fails:

sound/soc/codecs/rt5682.c:3716:1: warning: data definition has no type or storage class
 module_i2c_driver(rt5682_i2c_driver);
 ^~~~~~~~~~~~~~~~~
sound/soc/codecs/rt5682.c:3716:1: error: type defaults to ‘int’ in declaration of ‘module_i2c_driver’ [-Werror=implicit-int]
sound/soc/codecs/rt5682.c:3716:1: warning: parameter names (without types) in function declaration

Guard this use #ifdef CONFIG_I2C.

Fixes: 5549ea647997 ("ASoC: rt5682: fix unmet dependencies")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/codecs/rt5682.c | 110 +++++++++++++++++++-------------------
 1 file changed, 56 insertions(+), 54 deletions(-)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index c9268a230daa..ff3efad874a4 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -33,12 +33,6 @@
 #include "rt5682.h"
 #include "rt5682-sdw.h"
 
-static const char *rt5682_supply_names[RT5682_NUM_SUPPLIES] = {
-	"AVDD",
-	"MICVDD",
-	"VBAT",
-};
-
 static const struct rt5682_platform_data i2s_default_platform_data = {
 	.dmic1_data_pin = RT5682_DMIC1_DATA_GPIO2,
 	.dmic1_clk_pin = RT5682_DMIC1_CLK_GPIO3,
@@ -984,25 +978,6 @@ static irqreturn_t rt5682_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static void rt5682_jd_check_handler(struct work_struct *work)
-{
-	struct rt5682_priv *rt5682 = container_of(work, struct rt5682_priv,
-		jd_check_work.work);
-
-	if (snd_soc_component_read32(rt5682->component, RT5682_AJD1_CTRL)
-		& RT5682_JDH_RS_MASK) {
-		/* jack out */
-		rt5682->jack_type = rt5682_headset_detect(rt5682->component, 0);
-
-		snd_soc_jack_report(rt5682->hs_jack, rt5682->jack_type,
-				SND_JACK_HEADSET |
-				SND_JACK_BTN_0 | SND_JACK_BTN_1 |
-				SND_JACK_BTN_2 | SND_JACK_BTN_3);
-	} else {
-		schedule_delayed_work(&rt5682->jd_check_work, 500);
-	}
-}
-
 static int rt5682_set_jack_detect(struct snd_soc_component *component,
 	struct snd_soc_jack *hs_jack, void *data)
 {
@@ -3230,35 +3205,6 @@ static const struct i2c_device_id rt5682_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, rt5682_i2c_id);
 
-static int rt5682_parse_dt(struct rt5682_priv *rt5682, struct device *dev)
-{
-
-	device_property_read_u32(dev, "realtek,dmic1-data-pin",
-		&rt5682->pdata.dmic1_data_pin);
-	device_property_read_u32(dev, "realtek,dmic1-clk-pin",
-		&rt5682->pdata.dmic1_clk_pin);
-	device_property_read_u32(dev, "realtek,jd-src",
-		&rt5682->pdata.jd_src);
-	device_property_read_u32(dev, "realtek,btndet-delay",
-		&rt5682->pdata.btndet_delay);
-	device_property_read_u32(dev, "realtek,dmic-clk-rate-hz",
-		&rt5682->pdata.dmic_clk_rate);
-	device_property_read_u32(dev, "realtek,dmic-delay-ms",
-		&rt5682->pdata.dmic_delay);
-
-	rt5682->pdata.ldo1_en = of_get_named_gpio(dev->of_node,
-		"realtek,ldo1-en-gpios", 0);
-
-	if (device_property_read_string_array(dev, "clock-output-names",
-					      rt5682->pdata.dai_clk_names,
-					      RT5682_DAI_NUM_CLKS) < 0)
-		dev_warn(dev, "Using default DAI clk names: %s, %s\n",
-			 rt5682->pdata.dai_clk_names[RT5682_DAI_WCLK_IDX],
-			 rt5682->pdata.dai_clk_names[RT5682_DAI_BCLK_IDX]);
-
-	return 0;
-}
-
 static void rt5682_calibrate(struct rt5682_priv *rt5682)
 {
 	int value, count;
@@ -3526,6 +3472,61 @@ int rt5682_io_init(struct device *dev, struct sdw_slave *slave)
 EXPORT_SYMBOL_GPL(rt5682_io_init);
 #endif
 
+#ifdef CONFIG_I2C
+static const char *rt5682_supply_names[RT5682_NUM_SUPPLIES] = {
+	"AVDD",
+	"MICVDD",
+	"VBAT",
+};
+
+static void rt5682_jd_check_handler(struct work_struct *work)
+{
+	struct rt5682_priv *rt5682 = container_of(work, struct rt5682_priv,
+		jd_check_work.work);
+
+	if (snd_soc_component_read32(rt5682->component, RT5682_AJD1_CTRL)
+		& RT5682_JDH_RS_MASK) {
+		/* jack out */
+		rt5682->jack_type = rt5682_headset_detect(rt5682->component, 0);
+
+		snd_soc_jack_report(rt5682->hs_jack, rt5682->jack_type,
+				SND_JACK_HEADSET |
+				SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+				SND_JACK_BTN_2 | SND_JACK_BTN_3);
+	} else {
+		schedule_delayed_work(&rt5682->jd_check_work, 500);
+	}
+}
+
+static int rt5682_parse_dt(struct rt5682_priv *rt5682, struct device *dev)
+{
+
+	device_property_read_u32(dev, "realtek,dmic1-data-pin",
+		&rt5682->pdata.dmic1_data_pin);
+	device_property_read_u32(dev, "realtek,dmic1-clk-pin",
+		&rt5682->pdata.dmic1_clk_pin);
+	device_property_read_u32(dev, "realtek,jd-src",
+		&rt5682->pdata.jd_src);
+	device_property_read_u32(dev, "realtek,btndet-delay",
+		&rt5682->pdata.btndet_delay);
+	device_property_read_u32(dev, "realtek,dmic-clk-rate-hz",
+		&rt5682->pdata.dmic_clk_rate);
+	device_property_read_u32(dev, "realtek,dmic-delay-ms",
+		&rt5682->pdata.dmic_delay);
+
+	rt5682->pdata.ldo1_en = of_get_named_gpio(dev->of_node,
+		"realtek,ldo1-en-gpios", 0);
+
+	if (device_property_read_string_array(dev, "clock-output-names",
+					      rt5682->pdata.dai_clk_names,
+					      RT5682_DAI_NUM_CLKS) < 0)
+		dev_warn(dev, "Using default DAI clk names: %s, %s\n",
+			 rt5682->pdata.dai_clk_names[RT5682_DAI_WCLK_IDX],
+			 rt5682->pdata.dai_clk_names[RT5682_DAI_BCLK_IDX]);
+
+	return 0;
+}
+
 static int rt5682_i2c_probe(struct i2c_client *i2c,
 		    const struct i2c_device_id *id)
 {
@@ -3714,6 +3715,7 @@ static struct i2c_driver rt5682_i2c_driver = {
 	.id_table = rt5682_i2c_id,
 };
 module_i2c_driver(rt5682_i2c_driver);
+#endif
 
 MODULE_DESCRIPTION("ASoC RT5682 driver");
 MODULE_AUTHOR("Bard Liao <bardliao@realtek.com>");
-- 
2.17.1


