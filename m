Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D1EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 06:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8990720759
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 06:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730409AbgF3Ghp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 02:37:45 -0400
Received: from mga04.intel.com ([192.55.52.120]:47553 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730373AbgF3Gho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 02:37:44 -0400
IronPort-SDR: huZ27mEyBq+IB1htHzkcC/gLV64tGpBS4fRQYuxqdb7IKMt6VBap+Y4aJOhqzeOf4GTbq5hXEw
 ZXRx399Y/yVg==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="143638920"
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="143638920"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 23:37:13 -0700
IronPort-SDR: Id1b9LUdRv0jr27N7ZjFhoSD9J+C6WE5exCoS/fB3XJmLM7pPPbY66tSR1b82D29aeNdLamhyV
 /M7QDM99xfjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="480822274"
Received: from brentlu-desk0.itwn.intel.com ([10.5.253.11])
  by fmsmga006.fm.intel.com with ESMTP; 29 Jun 2020 23:37:03 -0700
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Naveen Manohar <naveen.m@intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Libin Yang <libin.yang@linux.intel.com>,
        Brent Lu <brent.lu@intel.com>,
        Mac Chiang <mac.chiang@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Amery Song <chao.song@intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jason Yan <yanaijie@huawei.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: Intel: bxt-da7219-max98357a: support MAX98390 speaker amp
Date:   Tue, 30 Jun 2020 14:32:02 +0800
Message-Id: <1593498722-7074-1-git-send-email-brent.lu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support MAX98390 speaker amplifier on cometlake platform. Driver now
detects amplifier type in the probe function and installs corresponding
controls and DAPM widgets/routes in the late_probe function.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/soc/intel/boards/Kconfig                    |  20 ++++
 sound/soc/intel/boards/bxt_da7219_max98357a.c     | 129 ++++++++++++++++++++--
 sound/soc/intel/common/soc-acpi-intel-cml-match.c |   4 +-
 3 files changed, 139 insertions(+), 14 deletions(-)

diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index 3d820e1..b3b863e 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -291,9 +291,17 @@ config SND_SOC_INTEL_DA7219_MAX98357A_GENERIC
 	select SND_SOC_DMIC
 	select SND_SOC_HDAC_HDMI
 
+config SND_SOC_INTEL_DA7219_MAX98390_GENERIC
+	tristate
+	select SND_SOC_DA7219
+	select SND_SOC_MAX98390
+	select SND_SOC_DMIC
+	select SND_SOC_HDAC_HDMI
+
 config SND_SOC_INTEL_BXT_DA7219_MAX98357A_COMMON
 	tristate
 	select SND_SOC_INTEL_DA7219_MAX98357A_GENERIC
+	select SND_SOC_INTEL_DA7219_MAX98390_GENERIC
 
 if SND_SOC_INTEL_APL
 
@@ -309,6 +317,18 @@ config SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH
 	   Say Y or m if you have such a device. This is a recommended option.
 	   If unsure select "N".
 
+config SND_SOC_INTEL_BXT_DA7219_MAX98390_MACH
+	tristate "Broxton with DA7219 and MAX98390 in I2S Mode"
+	depends on I2C && ACPI && GPIOLIB
+	depends on MFD_INTEL_LPSS || COMPILE_TEST
+	depends on SND_HDA_CODEC_HDMI
+	select SND_SOC_INTEL_BXT_DA7219_MAX98357A_COMMON
+	help
+	   This adds support for ASoC machine driver for Broxton-P platforms
+	   with DA7219 + MAX98390 I2S audio codec.
+	   Say Y or m if you have such a device. This is a recommended option.
+	   If unsure select "N".
+
 config SND_SOC_INTEL_BXT_RT298_MACH
 	tristate "Broxton with RT298 I2S mode"
 	depends on I2C && ACPI && GPIOLIB
diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index 44016c1..12f07e1 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -25,9 +25,14 @@
 
 #define BXT_DIALOG_CODEC_DAI	"da7219-hifi"
 #define BXT_MAXIM_CODEC_DAI	"HiFi"
+#define MAX98390_DEV0_NAME	"i2c-MX98390:00"
+#define MAX98390_DEV1_NAME	"i2c-MX98390:01"
 #define DUAL_CHANNEL		2
 #define QUAD_CHANNEL		4
 
+#define SPKAMP_MAX98357A	1
+#define SPKAMP_MAX98390	2
+
 static struct snd_soc_jack broxton_headset;
 static struct snd_soc_jack broxton_hdmi[3];
 
@@ -40,6 +45,7 @@ struct bxt_hdmi_pcm {
 struct bxt_card_private {
 	struct list_head hdmi_pcm_list;
 	bool common_hdmi_codec_drv;
+	int spkamp;
 };
 
 enum {
@@ -85,13 +91,20 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 static const struct snd_kcontrol_new broxton_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+};
+
+static const struct snd_kcontrol_new max98357a_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Spk"),
 };
 
+static const struct snd_kcontrol_new max98390_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Left Spk"),
+	SOC_DAPM_PIN_SWITCH("Right Spk"),
+};
+
 static const struct snd_soc_dapm_widget broxton_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone Jack", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
-	SND_SOC_DAPM_SPK("Spk", NULL),
 	SND_SOC_DAPM_MIC("SoC DMIC", NULL),
 	SND_SOC_DAPM_SPK("HDMI1", NULL),
 	SND_SOC_DAPM_SPK("HDMI2", NULL),
@@ -100,14 +113,20 @@ static const struct snd_soc_dapm_widget broxton_widgets[] = {
 			platform_clock_control,	SND_SOC_DAPM_POST_PMD|SND_SOC_DAPM_PRE_PMU),
 };
 
+static const struct snd_soc_dapm_widget max98357a_widgets[] = {
+	SND_SOC_DAPM_SPK("Spk", NULL),
+};
+
+static const struct snd_soc_dapm_widget max98390_widgets[] = {
+	SND_SOC_DAPM_SPK("Left Spk", NULL),
+	SND_SOC_DAPM_SPK("Right Spk", NULL),
+};
+
 static const struct snd_soc_dapm_route audio_map[] = {
 	/* HP jack connectors - unknown if we have jack detection */
 	{"Headphone Jack", NULL, "HPL"},
 	{"Headphone Jack", NULL, "HPR"},
 
-	/* speaker */
-	{"Spk", NULL, "Speaker"},
-
 	/* other jacks */
 	{"MIC", NULL, "Headset Mic"},
 
@@ -134,6 +153,17 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{ "Headset Mic", NULL, "Platform Clock" },
 };
 
+static const struct snd_soc_dapm_route max98357a_routes[] = {
+	/* speaker */
+	{"Spk", NULL, "Speaker"},
+};
+
+static const struct snd_soc_dapm_route max98390_routes[] = {
+	/* Speaker */
+	{"Left Spk", NULL, "Left BE_OUT"},
+	{"Right Spk", NULL, "Right BE_OUT"},
+};
+
 static const struct snd_soc_dapm_route broxton_map[] = {
 	{"HiFi Playback", NULL, "ssp5 Tx"},
 	{"ssp5 Tx", NULL, "codec0_out"},
@@ -404,6 +434,10 @@ SND_SOC_DAILINK_DEF(ssp5_pin,
 SND_SOC_DAILINK_DEF(ssp5_codec,
 	DAILINK_COMP_ARRAY(COMP_CODEC("MX98357A:00",
 				      BXT_MAXIM_CODEC_DAI)));
+SND_SOC_DAILINK_DEF(max98390_codec,
+	DAILINK_COMP_ARRAY(
+	/* Left */	COMP_CODEC(MAX98390_DEV0_NAME, "max98390-aif1"),
+	/* Right */	COMP_CODEC(MAX98390_DEV1_NAME, "max98390-aif1")));
 
 SND_SOC_DAILINK_DEF(ssp1_pin,
 	DAILINK_COMP_ARRAY(COMP_CPU("SSP1 Pin")));
@@ -601,15 +635,69 @@ static struct snd_soc_dai_link broxton_dais[] = {
 	},
 };
 
+static struct snd_soc_codec_conf max98390_codec_confs[] = {
+	{
+		.dlc = COMP_CODEC_CONF(MAX98390_DEV0_NAME),
+		.name_prefix = "Left",
+	},
+	{
+		.dlc = COMP_CODEC_CONF(MAX98390_DEV1_NAME),
+		.name_prefix = "Right",
+	},
+};
+
 #define NAME_SIZE	32
 static int bxt_card_late_probe(struct snd_soc_card *card)
 {
 	struct bxt_card_private *ctx = snd_soc_card_get_drvdata(card);
 	struct bxt_hdmi_pcm *pcm;
 	struct snd_soc_component *component = NULL;
-	int err, i = 0;
+	const struct snd_kcontrol_new *controls;
+	const struct snd_soc_dapm_widget *widgets;
+	const struct snd_soc_dapm_route *routes;
+	int num_controls, num_widgets, num_routes, ret, i = 0;
 	char jack_name[NAME_SIZE];
 
+	switch (ctx->spkamp) {
+	case SPKAMP_MAX98357A:
+		controls = max98357a_controls;
+		num_controls = ARRAY_SIZE(max98357a_controls);
+		widgets = max98357a_widgets;
+		num_widgets = ARRAY_SIZE(max98357a_widgets);
+		routes = max98357a_routes;
+		num_routes = ARRAY_SIZE(max98357a_routes);
+		break;
+	case SPKAMP_MAX98390:
+		controls = max98390_controls;
+		num_controls = ARRAY_SIZE(max98390_controls);
+		widgets = max98390_widgets;
+		num_widgets = ARRAY_SIZE(max98390_widgets);
+		routes = max98390_routes;
+		num_routes = ARRAY_SIZE(max98390_routes);
+		break;
+	default:
+		dev_err(card->dev, "Invalid speaker amplifier %d\n", ctx->spkamp);
+		break;
+	}
+
+	ret = snd_soc_dapm_new_controls(&card->dapm, widgets, num_widgets);
+	if (ret) {
+		dev_err(card->dev, "Fail to new widgets\n");
+		return ret;
+	}
+
+	ret = snd_soc_add_card_controls(card, controls, num_controls);
+	if (ret) {
+		dev_err(card->dev, "Fail to add controls\n");
+		return ret;
+	}
+
+	ret = snd_soc_dapm_add_routes(&card->dapm, routes, num_routes);
+	if (ret) {
+		dev_err(card->dev, "Fail to add routes\n");
+		return ret;
+	}
+
 	if (soc_intel_is_glk())
 		snd_soc_dapm_add_routes(&card->dapm, gemini_map,
 					ARRAY_SIZE(gemini_map));
@@ -631,17 +719,17 @@ static int bxt_card_late_probe(struct snd_soc_card *card)
 		component = pcm->codec_dai->component;
 		snprintf(jack_name, sizeof(jack_name),
 			"HDMI/DP, pcm=%d Jack", pcm->device);
-		err = snd_soc_card_jack_new(card, jack_name,
+		ret = snd_soc_card_jack_new(card, jack_name,
 					SND_JACK_AVOUT, &broxton_hdmi[i],
 					NULL, 0);
 
-		if (err)
-			return err;
+		if (ret)
+			return ret;
 
-		err = hdac_hdmi_jack_init(pcm->codec_dai, pcm->device,
+		ret = hdac_hdmi_jack_init(pcm->codec_dai, pcm->device,
 						&broxton_hdmi[i]);
-		if (err < 0)
-			return err;
+		if (ret < 0)
+			return ret;
 
 		i++;
 	}
@@ -678,6 +766,11 @@ static int broxton_audio_probe(struct platform_device *pdev)
 
 	INIT_LIST_HEAD(&ctx->hdmi_pcm_list);
 
+	if (acpi_dev_present("MX98390", NULL, -1))
+		ctx->spkamp = SPKAMP_MAX98390;
+	else
+		ctx->spkamp = SPKAMP_MAX98357A;
+
 	broxton_audio_card.dev = &pdev->dev;
 	snd_soc_card_set_drvdata(&broxton_audio_card, ctx);
 	if (soc_intel_is_glk()) {
@@ -702,7 +795,13 @@ static int broxton_audio_probe(struct platform_device *pdev)
 	} else if (soc_intel_is_cml()) {
 		unsigned int i;
 
-		broxton_audio_card.name = "cmlda7219max";
+		if (ctx->spkamp == SPKAMP_MAX98390) {
+			broxton_audio_card.name = "cml_max98390_da7219";
+
+			broxton_audio_card.codec_conf = max98390_codec_confs;
+			broxton_audio_card.num_configs = ARRAY_SIZE(max98390_codec_confs);
+		} else
+			broxton_audio_card.name = "cmlda7219max";
 
 		for (i = 0; i < ARRAY_SIZE(broxton_dais); i++) {
 			/* MAXIM_CODEC is connected to SSP1. */
@@ -710,6 +809,11 @@ static int broxton_audio_probe(struct platform_device *pdev)
 					BXT_MAXIM_CODEC_DAI)) {
 				broxton_dais[i].name = "SSP1-Codec";
 				broxton_dais[i].cpus->dai_name = "SSP1 Pin";
+
+				if (ctx->spkamp == SPKAMP_MAX98390) {
+					broxton_dais[i].codecs = max98390_codec;
+					broxton_dais[i].num_codecs = ARRAY_SIZE(max98390_codec);
+				}
 			}
 			/* DIALOG_CODEC is connected to SSP0 */
 			else if (!strcmp(broxton_dais[i].codecs->dai_name,
@@ -759,6 +863,7 @@ MODULE_AUTHOR("Harsha Priya <harshapriya.n@intel.com>");
 MODULE_AUTHOR("Conrad Cooke <conrad.cooke@intel.com>");
 MODULE_AUTHOR("Naveen Manohar <naveen.m@intel.com>");
 MODULE_AUTHOR("Mac Chiang <mac.chiang@intel.com>");
+MODULE_AUTHOR("Brent Lu <brent.lu@intel.com>");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:bxt_da7219_max98357a");
 MODULE_ALIAS("platform:glk_da7219_max98357a");
diff --git a/sound/soc/intel/common/soc-acpi-intel-cml-match.c b/sound/soc/intel/common/soc-acpi-intel-cml-match.c
index cdea0c0..7dc9ba9 100644
--- a/sound/soc/intel/common/soc-acpi-intel-cml-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-cml-match.c
@@ -15,8 +15,8 @@ static struct snd_soc_acpi_codecs rt1011_spk_codecs = {
 };
 
 static struct snd_soc_acpi_codecs max98357a_spk_codecs = {
-	.num_codecs = 1,
-	.codecs = {"MX98357A"}
+	.num_codecs = 2,
+	.codecs = {"MX98357A", "MX98390"}
 };
 
 /*
-- 
2.7.4

