Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3546C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77BCD222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="W2joqd9A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387620AbgBMPwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:52:20 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34983 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729229AbgBMPwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:52:17 -0500
Received: by mail-wm1-f68.google.com with SMTP id b17so7334675wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 07:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PE6MSof9ikEAHBm0daRLxCQZwkiheW3ZANvlgjgzY4A=;
        b=W2joqd9AKon1Xq5f0Upd6Q7fOnSObgDd7NrBexU5uRn9qpzPt6VZMXwXgZX5vxZmjc
         4jHc9q1srDbda3SNX04xCXQZRzFsO0c8bddtguhgNSLTE6FaqUAa9BT5yRI92nu58Xpe
         o+VZVidv3whdiXRlMKVBm79NlEi+Bd2JDawi5EFef+MiOd6r2JF5cYKGFhN40pTHOUcw
         2NUe4YqYfHzP0IaAEcwttcyXFnswgF7GCOSFIr2MA+cMCuZawBM7z7SZlrbfPAacBcve
         GW+0792a9w/+gxK6Ojm9r8gaU55CMgpN5qAqLnFpmmfDReqmKFdVNXtmK6m/VrFgVG+j
         6ZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PE6MSof9ikEAHBm0daRLxCQZwkiheW3ZANvlgjgzY4A=;
        b=Hizxma8FEqxfnCBaM5fglGjyUq5DtiKCQxL8pr02QUd5RDKXpBnN5eCpZAtvsNmG5K
         RIrsraLQja7A/9P9bTTiF0ENP2kLVs2nrNGR8aLPlr/n745MUlFTkSRt5TN57qHjKUND
         7HsgNde0cBN2xQekQnEqv+iNogdFoqwZt4jNMuz70Jdg50+zp6RmFcmk1mtG9cQ5LYW0
         20b+QRdXcdEQVR6GP+vpQZnuHSpY0O56GLj3IwWyHNaP2M2cqDzAmd4FmjwCuBJQ2miS
         JhBuqtdRR96WyAMS5AcThWZIVrdyRwoUyd9BxNyZnCxhdqLAKVvCbSzAT5/kT3YyAF6i
         koHw==
X-Gm-Message-State: APjAAAXTsbkebV3yJPKFjs2CGxmlLW5O1CLYjZvI/kcLJCPLcPAAvxtI
        wCXj9yKKc1mirw9+aVmtC1CcoQ==
X-Google-Smtp-Source: APXvYqx4wuZLfC7RkbrXtkvYozkKIHXN5pJWTAs/jiDRgx6uE3jhvMkw7UoC1BQRf3SxfBRDSaCoAQ==
X-Received: by 2002:a05:600c:34b:: with SMTP id u11mr6405614wmd.69.1581609133827;
        Thu, 13 Feb 2020 07:52:13 -0800 (PST)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id e1sm3319814wrt.84.2020.02.13.07.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 07:52:13 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 6/9] ASoC: meson: aiu: add internal dac codec control support
Date:   Thu, 13 Feb 2020 16:51:56 +0100
Message-Id: <20200213155159.3235792-7-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200213155159.3235792-1-jbrunet@baylibre.com>
References: <20200213155159.3235792-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the codec to codec component which handles the routing between
the audio producers and the internal audio DAC found on the amlogic GXL
SoC family

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/Makefile          |   1 +
 sound/soc/meson/aiu-acodec-ctrl.c | 205 ++++++++++++++++++++++++++++++
 sound/soc/meson/aiu.c             |  10 ++
 sound/soc/meson/aiu.h             |   1 +
 4 files changed, 217 insertions(+)
 create mode 100644 sound/soc/meson/aiu-acodec-ctrl.c

diff --git a/sound/soc/meson/Makefile b/sound/soc/meson/Makefile
index 3b21f648e322..80f9113701b3 100644
--- a/sound/soc/meson/Makefile
+++ b/sound/soc/meson/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0 OR MIT)
 
 snd-soc-meson-aiu-objs := aiu.o
+snd-soc-meson-aiu-objs += aiu-acodec-ctrl.o
 snd-soc-meson-aiu-objs += aiu-codec-ctrl.o
 snd-soc-meson-aiu-objs += aiu-encoder-i2s.o
 snd-soc-meson-aiu-objs += aiu-encoder-spdif.o
diff --git a/sound/soc/meson/aiu-acodec-ctrl.c b/sound/soc/meson/aiu-acodec-ctrl.c
new file mode 100644
index 000000000000..12d8a4d351a1
--- /dev/null
+++ b/sound/soc/meson/aiu-acodec-ctrl.c
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2020 BayLibre, SAS.
+// Author: Jerome Brunet <jbrunet@baylibre.com>
+
+#include <linux/bitfield.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dai.h>
+
+#include <dt-bindings/sound/meson-aiu.h>
+#include "aiu.h"
+#include "meson-codec-glue.h"
+
+#define CTRL_DIN_EN			15
+#define CTRL_CLK_INV			BIT(14)
+#define CTRL_LRCLK_INV			BIT(13)
+#define CTRL_I2S_IN_BCLK_SRC		BIT(11)
+#define CTRL_DIN_LRCLK_SRC_SHIFT	6
+#define CTRL_DIN_LRCLK_SRC		(0x3 << CTRL_DIN_LRCLK_SRC_SHIFT)
+#define CTRL_BCLK_MCLK_SRC		GENMASK(5, 4)
+#define CTRL_DIN_SKEW			GENMASK(3, 2)
+#define CTRL_I2S_OUT_LANE_SRC		0
+
+#define AIU_ACODEC_OUT_CHMAX		2
+
+static const char * const aiu_acodec_ctrl_mux_texts[] = {
+	"DISABLED", "I2S", "PCM",
+};
+
+static int aiu_acodec_ctrl_mux_put_enum(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component =
+		snd_soc_dapm_kcontrol_component(kcontrol);
+	struct snd_soc_dapm_context *dapm =
+		snd_soc_dapm_kcontrol_dapm(kcontrol);
+	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+	unsigned int mux, changed;
+
+	mux = snd_soc_enum_item_to_val(e, ucontrol->value.enumerated.item[0]);
+	changed = snd_soc_component_test_bits(component, e->reg,
+					      CTRL_DIN_LRCLK_SRC,
+					      FIELD_PREP(CTRL_DIN_LRCLK_SRC,
+							 mux));
+
+	if (!changed)
+		return 0;
+
+	/* Force disconnect of the mux while updating */
+	snd_soc_dapm_mux_update_power(dapm, kcontrol, 0, NULL, NULL);
+
+	snd_soc_component_update_bits(component, e->reg,
+				      CTRL_DIN_LRCLK_SRC |
+				      CTRL_BCLK_MCLK_SRC,
+				      FIELD_PREP(CTRL_DIN_LRCLK_SRC, mux) |
+				      FIELD_PREP(CTRL_BCLK_MCLK_SRC, mux));
+
+	snd_soc_dapm_mux_update_power(dapm, kcontrol, mux, e, NULL);
+
+	return 0;
+}
+
+static SOC_ENUM_SINGLE_DECL(aiu_acodec_ctrl_mux_enum, AIU_ACODEC_CTRL,
+			    CTRL_DIN_LRCLK_SRC_SHIFT,
+			    aiu_acodec_ctrl_mux_texts);
+
+static const struct snd_kcontrol_new aiu_acodec_ctrl_mux =
+	SOC_DAPM_ENUM_EXT("ACodec Source", aiu_acodec_ctrl_mux_enum,
+			  snd_soc_dapm_get_enum_double,
+			  aiu_acodec_ctrl_mux_put_enum);
+
+static const struct snd_kcontrol_new aiu_acodec_ctrl_out_enable =
+	SOC_DAPM_SINGLE_AUTODISABLE("Switch", AIU_ACODEC_CTRL,
+				    CTRL_DIN_EN, 1, 0);
+
+static const struct snd_soc_dapm_widget aiu_acodec_ctrl_widgets[] = {
+	SND_SOC_DAPM_MUX("ACODEC SRC", SND_SOC_NOPM, 0, 0,
+			 &aiu_acodec_ctrl_mux),
+	SND_SOC_DAPM_SWITCH("ACODEC OUT EN", SND_SOC_NOPM, 0, 0,
+			    &aiu_acodec_ctrl_out_enable),
+};
+
+static int aiu_acodec_ctrl_input_hw_params(struct snd_pcm_substream *substream,
+					   struct snd_pcm_hw_params *params,
+					   struct snd_soc_dai *dai)
+{
+	struct meson_codec_glue_input *data;
+	int ret;
+
+	ret = meson_codec_glue_input_hw_params(substream, params, dai);
+	if (ret)
+		return ret;
+
+	/* The glue will provide 1 lane out of the 4 to the output */
+	data = meson_codec_glue_input_get_data(dai);
+	data->params.channels_min = min_t(unsigned int, AIU_ACODEC_OUT_CHMAX,
+					  data->params.channels_min);
+	data->params.channels_max = min_t(unsigned int, AIU_ACODEC_OUT_CHMAX,
+					  data->params.channels_max);
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops aiu_acodec_ctrl_input_ops = {
+	.hw_params	= aiu_acodec_ctrl_input_hw_params,
+	.set_fmt	= meson_codec_glue_input_set_fmt,
+};
+
+static const struct snd_soc_dai_ops aiu_acodec_ctrl_output_ops = {
+	.startup	= meson_codec_glue_output_startup,
+};
+
+#define AIU_ACODEC_CTRL_FORMATS					\
+	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |	\
+	 SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S24_LE |	\
+	 SNDRV_PCM_FMTBIT_S32_LE)
+
+#define AIU_ACODEC_STREAM(xname, xsuffix, xchmax)		\
+{								\
+	.stream_name	= xname " " xsuffix,			\
+	.channels_min	= 1,					\
+	.channels_max	= (xchmax),				\
+	.rate_min       = 5512,					\
+	.rate_max	= 192000,				\
+	.formats	= AIU_ACODEC_CTRL_FORMATS,		\
+}
+
+#define AIU_ACODEC_INPUT(xname) {				\
+	.name = "ACODEC CTRL " xname,				\
+	.name = xname,						\
+	.playback = AIU_ACODEC_STREAM(xname, "Playback", 8),	\
+	.ops = &aiu_acodec_ctrl_input_ops,			\
+	.probe = meson_codec_glue_input_dai_probe,		\
+	.remove = meson_codec_glue_input_dai_remove,		\
+}
+
+#define AIU_ACODEC_OUTPUT(xname) {				\
+	.name = "ACODEC CTRL " xname,				\
+	.capture = AIU_ACODEC_STREAM(xname, "Capture", AIU_ACODEC_OUT_CHMAX), \
+	.ops = &aiu_acodec_ctrl_output_ops,			\
+}
+
+static struct snd_soc_dai_driver aiu_acodec_ctrl_dai_drv[] = {
+	[CTRL_I2S] = AIU_ACODEC_INPUT("ACODEC I2S IN"),
+	[CTRL_PCM] = AIU_ACODEC_INPUT("ACODEC PCM IN"),
+	[CTRL_OUT] = AIU_ACODEC_OUTPUT("ACODEC OUT"),
+};
+
+static const struct snd_soc_dapm_route aiu_acodec_ctrl_routes[] = {
+	{ "ACODEC SRC", "I2S", "ACODEC I2S IN Playback" },
+	{ "ACODEC SRC", "PCM", "ACODEC PCM IN Playback" },
+	{ "ACODEC OUT EN", "Switch", "ACODEC SRC" },
+	{ "ACODEC OUT Capture", NULL, "ACODEC OUT EN" },
+};
+
+static const struct snd_kcontrol_new aiu_acodec_ctrl_controls[] = {
+	SOC_SINGLE("ACODEC I2S Lane Select", AIU_ACODEC_CTRL,
+		   CTRL_I2S_OUT_LANE_SRC, 3, 0),
+};
+
+static int aiu_acodec_of_xlate_dai_name(struct snd_soc_component *component,
+					struct of_phandle_args *args,
+					const char **dai_name)
+{
+	return aiu_of_xlate_dai_name(component, args, dai_name, AIU_ACODEC);
+}
+
+static int aiu_acodec_ctrl_component_probe(struct snd_soc_component *component)
+{
+	/*
+	 * NOTE: Din Skew setting
+	 * According to the documentation, the following update adds one delay
+	 * to the din line. Without this, the output saturates. This happens
+	 * regardless of the link format (i2s or left_j) so it is not clear what
+	 * it actually does but it seems to be required
+	 */
+	snd_soc_component_update_bits(component, AIU_ACODEC_CTRL,
+				      CTRL_DIN_SKEW,
+				      FIELD_PREP(CTRL_DIN_SKEW, 2));
+
+	return 0;
+}
+
+static const struct snd_soc_component_driver aiu_acodec_ctrl_component = {
+	.name			= "AIU Internal DAC Codec Control",
+	.probe			= aiu_acodec_ctrl_component_probe,
+	.controls		= aiu_acodec_ctrl_controls,
+	.num_controls		= ARRAY_SIZE(aiu_acodec_ctrl_controls),
+	.dapm_widgets		= aiu_acodec_ctrl_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(aiu_acodec_ctrl_widgets),
+	.dapm_routes		= aiu_acodec_ctrl_routes,
+	.num_dapm_routes	= ARRAY_SIZE(aiu_acodec_ctrl_routes),
+	.of_xlate_dai_name	= aiu_acodec_of_xlate_dai_name,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
+};
+
+int aiu_acodec_ctrl_register_component(struct device *dev)
+{
+	return aiu_add_component(dev, &aiu_acodec_ctrl_component,
+				 aiu_acodec_ctrl_dai_drv,
+				 ARRAY_SIZE(aiu_acodec_ctrl_dai_drv),
+				 "acodec");
+}
diff --git a/sound/soc/meson/aiu.c b/sound/soc/meson/aiu.c
index b765dfb70726..5c4845a23a34 100644
--- a/sound/soc/meson/aiu.c
+++ b/sound/soc/meson/aiu.c
@@ -345,6 +345,16 @@ static int aiu_probe(struct platform_device *pdev)
 		goto err;
 	}
 
+	/* Register the internal dac control component on gxl */
+	if (of_device_is_compatible(dev->of_node, "amlogic,aiu-gxl")) {
+		ret = aiu_acodec_ctrl_register_component(dev);
+		if (ret) {
+			dev_err(dev,
+			    "Failed to register acodec control component\n");
+			goto err;
+		}
+	}
+
 	return 0;
 err:
 	snd_soc_unregister_component(dev);
diff --git a/sound/soc/meson/aiu.h b/sound/soc/meson/aiu.h
index 9242ab1ab64b..a65a576e3400 100644
--- a/sound/soc/meson/aiu.h
+++ b/sound/soc/meson/aiu.h
@@ -52,6 +52,7 @@ int aiu_add_component(struct device *dev,
 		      const char *debugfs_prefix);
 
 int aiu_hdmi_ctrl_register_component(struct device *dev);
+int aiu_acodec_ctrl_register_component(struct device *dev);
 
 int aiu_fifo_i2s_dai_probe(struct snd_soc_dai *dai);
 int aiu_fifo_spdif_dai_probe(struct snd_soc_dai *dai);
-- 
2.24.1

