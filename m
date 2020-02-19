Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD69C3524E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 20:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E4524673
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 20:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582145867;
	bh=0556/W4oJCT2Llotqt/ikhVTlPFGLryOXw5ErmcBMjY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=ZgmwbUknElQ5aujilPQZvCIvPNNr181sx2V94ui+EH5cF6o6Mu/ORRwist4crM0q9
	 VPkrHYBaUoJJ9BAAmVjxrOerbXY3nG9SK0sKj5uU2vCJ07xVyfiBQFVDJCpWod6XfM
	 bmdf0zPlgtd6Ze2RnPVCSalqw4LnJye80ZswHTfM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbgBSU5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 15:57:46 -0500
Received: from foss.arm.com ([217.140.110.172]:56776 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbgBSU5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 15:57:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3225F1FB;
        Wed, 19 Feb 2020 12:57:45 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABEED3F68F;
        Wed, 19 Feb 2020 12:57:44 -0800 (PST)
Date:   Wed, 19 Feb 2020 20:57:43 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: tas2562: Add support for ISENSE and VSENSE" to the asoc tree
In-Reply-To:  <20200219134622.22066-1-dmurphy@ti.com>
Message-Id:  <applied-20200219134622.22066-1-dmurphy@ti.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: tas2562: Add support for ISENSE and VSENSE

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 69e53129d01317d94e8b97ec11688880106a2f97 Mon Sep 17 00:00:00 2001
From: Dan Murphy <dmurphy@ti.com>
Date: Wed, 19 Feb 2020 07:46:22 -0600
Subject: [PATCH] ASoC: tas2562: Add support for ISENSE and VSENSE

Add additional support for ISENSE and VSENSE feature for the TAS2562.
This feature monitors the output to the loud speaker attempts to
eliminate IR drop errors due to packaging.

This feature is defined in Section 8.4.5 IV Sense of the data sheet.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
Link: https://lore.kernel.org/r/20200219134622.22066-1-dmurphy@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tas2562.c | 32 +++++++++++++++++++++++++++-----
 sound/soc/codecs/tas2562.h |  6 +++---
 2 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/tas2562.c b/sound/soc/codecs/tas2562.c
index 729acd874c48..b517ada7e809 100644
--- a/sound/soc/codecs/tas2562.c
+++ b/sound/soc/codecs/tas2562.c
@@ -382,18 +382,34 @@ static int tas2562_dac_event(struct snd_soc_dapm_widget *w,
 	struct snd_soc_component *component =
 					snd_soc_dapm_to_component(w->dapm);
 	struct tas2562_data *tas2562 = snd_soc_component_get_drvdata(component);
+	int ret;
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
-		dev_info(tas2562->dev, "SND_SOC_DAPM_POST_PMU\n");
+		ret = snd_soc_component_update_bits(component,
+			TAS2562_PWR_CTRL,
+			TAS2562_MODE_MASK,
+			TAS2562_MUTE);
+		if (ret)
+			goto end;
 		break;
 	case SND_SOC_DAPM_PRE_PMD:
-		dev_info(tas2562->dev, "SND_SOC_DAPM_PRE_PMD\n");
+		ret = snd_soc_component_update_bits(component,
+			TAS2562_PWR_CTRL,
+			TAS2562_MODE_MASK,
+			TAS2562_SHUTDOWN);
+		if (ret)
+			goto end;
 		break;
 	default:
-		break;
+		dev_err(tas2562->dev, "Not supported evevt\n");
+		return -EINVAL;
 	}
 
+end:
+	if (ret < 0)
+		return ret;
+
 	return 0;
 }
 
@@ -415,7 +431,6 @@ static const struct snd_kcontrol_new tas2562_snd_controls[] = {
 static const struct snd_soc_dapm_widget tas2562_dapm_widgets[] = {
 	SND_SOC_DAPM_AIF_IN("ASI1", "ASI1 Playback", 0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_MUX("ASI1 Sel", SND_SOC_NOPM, 0, 0, &tas2562_asi1_mux),
-	SND_SOC_DAPM_AIF_IN("DAC IN", "Playback", 0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_DAC_E("DAC", NULL, SND_SOC_NOPM, 0, 0, tas2562_dac_event,
 			   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
 	SND_SOC_DAPM_SWITCH("ISENSE", TAS2562_PWR_CTRL, 3, 1, &isense_switch),
@@ -430,7 +445,7 @@ static const struct snd_soc_dapm_route tas2562_audio_map[] = {
 	{"ASI1 Sel", "Left", "ASI1"},
 	{"ASI1 Sel", "Right", "ASI1"},
 	{"ASI1 Sel", "LeftRightDiv2", "ASI1"},
-	{ "DAC", NULL, "DAC IN" },
+	{ "DAC", NULL, "ASI1 Sel" },
 	{ "OUT", NULL, "DAC" },
 	{"ISENSE", "Switch", "IMON"},
 	{"VSENSE", "Switch", "VMON"},
@@ -471,6 +486,13 @@ static struct snd_soc_dai_driver tas2562_dai[] = {
 			.rates      = SNDRV_PCM_RATE_8000_192000,
 			.formats    = TAS2562_FORMATS,
 		},
+		.capture = {
+			.stream_name    = "ASI1 Capture",
+			.channels_min   = 0,
+			.channels_max   = 2,
+			.rates		= SNDRV_PCM_RATE_8000_192000,
+			.formats	= TAS2562_FORMATS,
+		},
 		.ops = &tas2562_speaker_dai_ops,
 	},
 };
diff --git a/sound/soc/codecs/tas2562.h b/sound/soc/codecs/tas2562.h
index 62e659ab786d..6f55ebcf19ea 100644
--- a/sound/soc/codecs/tas2562.h
+++ b/sound/soc/codecs/tas2562.h
@@ -40,7 +40,7 @@
 
 #define TAS2562_RESET	BIT(0)
 
-#define TAS2562_MODE_MASK	0x3
+#define TAS2562_MODE_MASK	GENMASK(1,0)
 #define TAS2562_ACTIVE		0x0
 #define TAS2562_MUTE		0x1
 #define TAS2562_SHUTDOWN	0x2
@@ -73,8 +73,8 @@
 #define TAS2562_TDM_CFG2_RXWLEN_24B	BIT(3)
 #define TAS2562_TDM_CFG2_RXWLEN_32B	(BIT(2) | BIT(3))
 
-#define TAS2562_VSENSE_POWER_EN		BIT(2)
-#define TAS2562_ISENSE_POWER_EN		BIT(3)
+#define TAS2562_VSENSE_POWER_EN		2
+#define TAS2562_ISENSE_POWER_EN		3
 
 #define TAS2562_TDM_CFG5_VSNS_EN	BIT(6)
 #define TAS2562_TDM_CFG5_VSNS_SLOT_MASK	GENMASK(5, 0)
-- 
2.20.1

