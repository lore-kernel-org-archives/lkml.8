Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCE3C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 09:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0200721741
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 09:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com header.b="KECIOW3I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbgIHJSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 05:18:20 -0400
Received: from smtp1.axis.com ([195.60.68.17]:26636 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729031AbgIHJSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 05:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=6903; q=dns/txt; s=axis-central1;
  t=1599556696; x=1631092696;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TEEozU67nGxX3siJVtdFbZmHHEp3Nx0htJv3gTsxY1w=;
  b=KECIOW3I1tsm0+cJOzsTx9zDLEER565Tlj90KbbRGL7Qs4Rj0iCwLb8P
   vuwd1fcpujZsszwm+QpH15vyFEEmikWzeGCX6Op1oewE/eb/SOBRekLmX
   eTluJpT/ud6WaWDnqx1ZrNcdLd9WSLYpQf7NoJ8uJ9aepo+9Ed807uhi+
   y4Lw5wONBmYESIEa6eN7BGytem4thCXc90XEj5tvGFla/6TLpoLONaRHM
   3lCDuI2OQuhjyse5NYs118Foz0vJ+3VzfB8WmJ0HIQu7TasDl9dQULI/o
   6UvUDusI8LHTQqUdFBhfamTBlhnq83rMZmwcmvzqYQIH30rDYfGrElO5q
   g==;
IronPort-SDR: 8ihknXVvMLPdLUhNh8gjuGhyi4/EgqK6hB6R3X5BMhXKfnUBABR2KLGJtza23yQrPOrQlsfPCz
 yykSr4Zpbt9SLBRLJP+foAFxFRzrn0dkA9bo+OAdAu3EHIgg0Qxz8lFzt1ks709U+oXX4iGIaT
 VrtgJAFVQ+q2Z3BZNC+tGGXSNH2DaSrTa3kaqniQi79lPG1AGRyXyVuc76XQlnGqOGOYJxtNMb
 CNMI8ZdJuBwtV573AgKSfIfa4CCIpvyA7MIk826ezYlWxqHEulVMBEDtY2oyFVJKkpxSlSRVLa
 v/M=
X-IronPort-AV: E=Sophos;i="5.76,405,1592863200"; 
   d="scan'208";a="12654985"
From:   Camel Guo <camel.guo@axis.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <tiwai@suse.com>,
        <dmurphy@ti.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Camel Guo <camelg@axis.com>
Subject: [PATCH] ASoC: tlv320adcx140: Add support for master mode
Date:   Tue, 8 Sep 2020 11:18:12 +0200
Message-ID: <20200908091812.1441-1-camel.guo@axis.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Camel Guo <camelg@axis.com>

Add setup of bclk-to-ws ratio and sample rate when in master mode,
as well as MCLK input pin setup.

Limitations:

- MCLK is assumed to be connected to GPIO1 (other possible choices
  would be GPI0..3 if they weren't used for analog positive inputs).
- PLL is always enabled, and clock generation is in automatic mode.

Signed-off-by: Camel Guo <camelg@axis.com>
---
 sound/soc/codecs/tlv320adcx140.c | 134 ++++++++++++++++++++++++++++++-
 sound/soc/codecs/tlv320adcx140.h |  35 ++++++++
 2 files changed, 165 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index 13ece039e9fe..f143b6b62f84 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -35,6 +35,7 @@ struct adcx140_priv {
 	unsigned int dai_fmt;
 	unsigned int tdm_delay;
 	unsigned int slot_width;
+	int master;
 };
 
 static const char * const gpo_config_names[] = {
@@ -614,12 +615,85 @@ static int adcx140_reset(struct adcx140_priv *adcx140)
 	return ret;
 }
 
+static int adcx140_fs_bclk_ratio(unsigned int bclk_ratio)
+{
+	switch (bclk_ratio) {
+	case 16:
+		return ADCX140_RATIO_16;
+	case 24:
+		return ADCX140_RATIO_24;
+	case 32:
+		return ADCX140_RATIO_32;
+	case 48:
+		return ADCX140_RATIO_48;
+	case 64:
+		return ADCX140_RATIO_64;
+	case 96:
+		return ADCX140_RATIO_96;
+	case 128:
+		return ADCX140_RATIO_128;
+	case 192:
+		return ADCX140_RATIO_192;
+	case 256:
+		return ADCX140_RATIO_256;
+	case 384:
+		return ADCX140_RATIO_384;
+	case 512:
+		return ADCX140_RATIO_512;
+	case 1024:
+		return ADCX140_RATIO_1024;
+	case 2048:
+		return ADCX140_RATIO_2048;
+	default:
+		break;
+	}
+	return -EINVAL;
+}
+
+static int adcx140_fs_rate(unsigned int rate)
+{
+	switch (rate) {
+	case 7350:
+	case 8000:
+		return ADCX140_8_OR_7_35KHZ;
+	case 14700:
+	case 16000:
+		return ADCX140_16_OR_14_7KHZ;
+	case 22050:
+	case 24000:
+		return ADCX140_24_OR_22_05KHZ;
+	case 29400:
+	case 32000:
+		return ADCX140_32_OR_29_4KHZ;
+	case 44100:
+	case 48000:
+		return ADCX140_48_OR_44_1KHZ;
+	case 88200:
+	case 96000:
+		return ADCX140_96_OR_88_2KHZ;
+	case 176400:
+	case 192000:
+		return ADCX140_192_OR_176_4KHZ;
+	case 352800:
+	case 384000:
+		return ADCX140_384_OR_352_8KHZ;
+	case 705600:
+	case 768000:
+		return ADCX140_768_OR_705_6KHZ;
+	default:
+		break;
+	}
+	return -EINVAL;
+}
+
 static int adcx140_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *params,
 			     struct snd_soc_dai *dai)
 {
 	struct snd_soc_component *component = dai->component;
+	struct adcx140_priv *adcx140 = snd_soc_component_get_drvdata(component);
 	u8 data = 0;
+	u8 mst_cfg0 = 0;
 
 	switch (params_width(params)) {
 	case 16:
@@ -640,6 +714,60 @@ static int adcx140_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
+	if (adcx140->master) {
+		u8 mst_cfg1 = 0;
+		u8 gpio_cfg0 = 0;
+		unsigned int bclk_ratio;
+		int ret;
+
+		mst_cfg0 = ADCX140_MST_SLV_CFG_BIT;
+		if (params_rate(params) % 1000)
+			mst_cfg0 |= ADCX140_FS_MODE_BIT; /* 44.1 kHz et al */
+
+		ret = adcx140_fs_rate(params_rate(params));
+		if (ret < 0) {
+			dev_err(component->dev, "%s: Unsupported rate %d\n",
+				__func__, params_rate(params));
+			return ret;
+		}
+		mst_cfg1 |= ret;
+
+		/* In slave mode when using automatic clock configuration,
+		 * the codec figures out the BCLK to FSYNC ratio itself. But
+		 * here in master mode, we need to tell it.
+		 */
+
+		bclk_ratio = snd_soc_params_to_frame_size(params);
+		ret = adcx140_fs_bclk_ratio(bclk_ratio);
+		if (ret < 0) {
+			dev_err(component->dev, "%s: Unsupported bclk_ratio %d\n",
+				__func__, bclk_ratio);
+			return ret;
+		}
+		mst_cfg1 |= ret;
+
+		/* The codec can receive MCLK on any input: GPIO, GPI0..3.
+		 * While in future it would be nice to have these selectable
+		 * via clk_id for instance, for now we fix GPIO1 as the MCLK
+		 * source.
+		 */
+		gpio_cfg0 |= ADCX140_GPIO1_MCLK;
+
+		snd_soc_component_update_bits(component, ADCX140_MST_CFG1,
+					      ADCX140_FS_RATE_MSK |
+					      ADCX140_RATIO_MSK,
+					      mst_cfg1);
+
+		snd_soc_component_update_bits(component, ADCX140_GPIO_CFG0,
+					      ADCX140_GPIO1_CFG_MSK,
+					      gpio_cfg0);
+	}
+
+	snd_soc_component_update_bits(component, ADCX140_MST_CFG0,
+				      ADCX140_FS_MODE_BIT |
+				      ADCX140_MST_SLV_CFG_BIT,
+				      mst_cfg0);
+
 	snd_soc_component_update_bits(component, ADCX140_ASI_CFG0,
 			    ADCX140_WORD_LEN_MSK, data);
 
@@ -652,16 +780,16 @@ static int adcx140_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	struct snd_soc_component *component = codec_dai->component;
 	struct adcx140_priv *adcx140 = snd_soc_component_get_drvdata(component);
 	u8 iface_reg1 = 0;
-	u8 iface_reg2 = 0;
 	int offset = 0;
 	int width = adcx140->slot_width;
 
 	/* set master/slave audio interface */
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBM_CFM:
-		iface_reg2 |= ADCX140_BCLK_FSYNC_MASTER;
+		adcx140->master = 1;
 		break;
 	case SND_SOC_DAIFMT_CBS_CFS:
+		adcx140->master = 0;
 		break;
 	case SND_SOC_DAIFMT_CBS_CFM:
 	case SND_SOC_DAIFMT_CBM_CFS:
@@ -714,8 +842,6 @@ static int adcx140_set_dai_fmt(struct snd_soc_dai *codec_dai,
 				      ADCX140_BCLKINV_BIT |
 				      ADCX140_ASI_FORMAT_MSK,
 				      iface_reg1);
-	snd_soc_component_update_bits(component, ADCX140_MST_CFG0,
-				      ADCX140_BCLK_FSYNC_MASTER, iface_reg2);
 
 	/* Configure data offset */
 	snd_soc_component_update_bits(component, ADCX140_ASI_CFG1,
diff --git a/sound/soc/codecs/tlv320adcx140.h b/sound/soc/codecs/tlv320adcx140.h
index eedbc1d7221f..bac34800b189 100644
--- a/sound/soc/codecs/tlv320adcx140.h
+++ b/sound/soc/codecs/tlv320adcx140.h
@@ -145,4 +145,39 @@
 #define ADCX140_GPO_CFG_MAX		4
 #define ADCX140_GPO_DRV_MAX		5
 
+/* MST_CFG0 */
+#define ADCX140_MST_SLV_CFG_BIT	BIT(7)
+#define ADCX140_FS_MODE_BIT	BIT(3)
+
+/* MST_CFG1 */
+#define ADCX140_8_OR_7_35KHZ	(0 << 4)
+#define ADCX140_16_OR_14_7KHZ	(1 << 4)
+#define ADCX140_24_OR_22_05KHZ	(2 << 4)
+#define ADCX140_32_OR_29_4KHZ	(3 << 4)
+#define ADCX140_48_OR_44_1KHZ	(4 << 4)
+#define ADCX140_96_OR_88_2KHZ	(5 << 4)
+#define ADCX140_192_OR_176_4KHZ	(6 << 4)
+#define ADCX140_384_OR_352_8KHZ	(7 << 4)
+#define ADCX140_768_OR_705_6KHZ	(8 << 4)
+#define ADCX140_FS_RATE_MSK	GENMASK(7, 4)
+
+#define ADCX140_RATIO_16	0
+#define ADCX140_RATIO_24	1
+#define ADCX140_RATIO_32	2
+#define ADCX140_RATIO_48	3
+#define ADCX140_RATIO_64	4
+#define ADCX140_RATIO_96	5
+#define ADCX140_RATIO_128	6
+#define ADCX140_RATIO_192	7
+#define ADCX140_RATIO_256	8
+#define ADCX140_RATIO_384	9
+#define ADCX140_RATIO_512	10
+#define ADCX140_RATIO_1024	11
+#define ADCX140_RATIO_2048	12
+#define ADCX140_RATIO_MSK	GENMASK(3, 0)
+
+/* GPIO_CFG0 */
+#define ADCX140_GPIO1_MCLK	(10 << 4)
+#define ADCX140_GPIO1_CFG_MSK	GENMASK(7, 4)
+
 #endif /* _TLV320ADCX140_ */
-- 
2.20.1

