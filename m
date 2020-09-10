Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803B2C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36ACD21556
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="BTnq1Tt6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbgIJTka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731350AbgIJPlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:41:05 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28786C06138E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 08:41:02 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id v23so8841531ljd.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 08:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=7QU6Dco3seQSgpaPl5a+T9XTXFp4c3vdKUDI38UuxdM=;
        b=BTnq1Tt6NuuFGMwy9W+u8UV9wcJqQmtXJlEKe2rKoWIlDfhTetk6p2JWT2N9vDK2K4
         AMctq5dfhOsSzSBr7IPMXQjozfOjw56LfD1Xfn49IczBgNn//UgLPVwxkWYMcy3g++7e
         7uQA/02lGGByCCSL99lQgM4f/CroSY78CoIKFmCsIAjZtYVW3YstZjS5XoKzjbcDubxH
         Cs7cdwMB0turEwNkGT7Slb60MNuh6JgsF1uGSH3PsJDf1AFQx+vOQBcQCVHiUojOvKhc
         QSzmKU0sAcjyVyIwWYNBqcsx5jfzpAiWtUyq9yL/ISCZ/htVHQoh2+zNT6+2mF7Iy7Jx
         L7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7QU6Dco3seQSgpaPl5a+T9XTXFp4c3vdKUDI38UuxdM=;
        b=bU7R3PJlzEaH0dtCJlktwd/2q5UdH/1eHbhMvZTePr1SIdM0YXAwZ/Ol6F+DHlFiFu
         hRY4FE9vsVxBiHqnuDqc9PWlE0LNpzbMWYDtfkdtES5nJE0s0+ttt6rC6952ezNgEI8X
         rDfMfXw+rcQSlkJukg9hbI/oatYG3NxOTGU4FBNJLFk2+fyu+YBuMxxIaHt9Oo9H6VVk
         VF9/okiP9KdEP3PgmdaSFPyHoBybhC8mWcPO/JI/BgebVZd9qvjjLSZ5m+bCesSl5vMv
         YHpLQCVobBItCWbjgbofP8Z1Fp+SD8lJyXq5EAeSl6cv5E4PU6Cw5wRuiqDRjLtW3/pL
         qPFA==
X-Gm-Message-State: AOAM530cJbAgq2gqFPBOBYYvmJrbovWyNp5H9innleB5cuX45J1dcNO8
        Tjfb8O7AyqIsA0CutUXVH383LA==
X-Google-Smtp-Source: ABdhPJyiMisO+WmkaxkuCvXz1PmU18l5b1nhp0h5N8/HLzafCQYAXfVaigddVxXcKtXNFgvyKKFtIQ==
X-Received: by 2002:a2e:8906:: with SMTP id d6mr4532766lji.354.1599752460228;
        Thu, 10 Sep 2020 08:41:00 -0700 (PDT)
Received: from rad-H81M-S1.semihalf.local (193-106-246-138.noc.fibertech.net.pl. [193.106.246.138])
        by smtp.gmail.com with ESMTPSA id t21sm1676424ljj.40.2020.09.10.08.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 08:40:59 -0700 (PDT)
From:   Radoslaw Biernacki <rad@semihalf.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Ben Zhang <benzh@chromium.org>, Marcin Wojtas <mw@semihalf.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Vamshi Krishna <vamshi.krishna.gopal@intel.com>,
        Harshapriya <harshapriya.n@intel.com>,
        michal.sienkiewicz@intel.com, Lech Betlej <Lech.Betlej@intel.com>,
        Radoslaw Biernacki <rad@semihalf.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        John Hsu <KCHSU0@nuvoton.com>, Yong Zhi <yong.zhi@intel.com>,
        Mac Chiang <mac.chiang@intel.com>
Subject: [PATCH V4] ASoC: Intel: boards: Use FS as nau8825 sysclk in nau88125_* machine
Date:   Thu, 10 Sep 2020 17:40:56 +0200
Message-Id: <20200910154056.30962-1-rad@semihalf.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 256xFS clocks cannot be generated by SKL, the NAU8825 is
configured to re-generate its system clock from the BCLK using the
FLL. The link is configured to use a 48kHz frame rate, and 24 bits in
25-bit slot. The SSP configuration is extracted from NHLT settings and
not dynamically changed. Listening tests and measurements do not show
any distortion or issues

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: Yong Zhi <yong.zhi@intel.com>
Signed-off-by: Mac Chiang <mac.chiang@intel.com>
Signed-off-by: Ben Zhang <benzh@chromium.org>
Signed-off-by: Radoslaw Biernacki <rad@semihalf.com>
---

Notes:
    v1 -> v2:
    - adding same changes to skl_nau88l25_max98357a.c
    v2 -> v3:
    - removing msleep() in SNDRV_PCM_TRIGGER_RESUME as it unnecessarily increase
      playback/capture latency while actually FLL does not require it.
    - simplifing commit message
    v3 -> v4:
    - simplifing the PM resume callback code for setting the FLL
    - adding comment for the stream START/RESUME sequence which prevent audio pops
    - fixing mising var initialization in platform_clock_control()

 .../soc/intel/boards/skl_nau88l25_max98357a.c | 63 ++++++++++++------
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c | 65 +++++++++++++------
 2 files changed, 86 insertions(+), 42 deletions(-)

diff --git a/sound/soc/intel/boards/skl_nau88l25_max98357a.c b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
index d7b8154c43a4..2f0abbd2dd8d 100644
--- a/sound/soc/intel/boards/skl_nau88l25_max98357a.c
+++ b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
@@ -8,6 +8,7 @@
 
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/delay.h>
 #include <sound/core.h>
 #include <sound/jack.h>
 #include <sound/pcm.h>
@@ -47,12 +48,12 @@ enum {
 };
 
 static int platform_clock_control(struct snd_soc_dapm_widget *w,
-	struct snd_kcontrol *k, int  event)
+	struct snd_kcontrol *k, int event)
 {
 	struct snd_soc_dapm_context *dapm = w->dapm;
 	struct snd_soc_card *card = dapm->card;
 	struct snd_soc_dai *codec_dai;
-	int ret;
+	int ret = 0;
 
 	codec_dai = snd_soc_card_get_codec_dai(card, SKL_NUVOTON_CODEC_DAI);
 	if (!codec_dai) {
@@ -60,14 +61,7 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 		return -EIO;
 	}
 
-	if (SND_SOC_DAPM_EVENT_ON(event)) {
-		ret = snd_soc_dai_set_sysclk(codec_dai,
-				NAU8825_CLK_MCLK, 24000000, SND_SOC_CLOCK_IN);
-		if (ret < 0) {
-			dev_err(card->dev, "set sysclk err = %d\n", ret);
-			return -EIO;
-		}
-	} else {
+	if (!SND_SOC_DAPM_EVENT_ON(event)) {
 		ret = snd_soc_dai_set_sysclk(codec_dai,
 				NAU8825_CLK_INTERNAL, 0, SND_SOC_CLOCK_IN);
 		if (ret < 0) {
@@ -292,24 +286,51 @@ static const struct snd_soc_ops skylake_nau8825_fe_ops = {
 	.startup = skl_fe_startup,
 };
 
-static int skylake_nau8825_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
+static int skylake_nau8825_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
-	int ret;
-
-	ret = snd_soc_dai_set_sysclk(codec_dai,
-			NAU8825_CLK_MCLK, 24000000, SND_SOC_CLOCK_IN);
-
-	if (ret < 0)
-		dev_err(rtd->dev, "snd_soc_dai_set_sysclk err = %d\n", ret);
+	int ret = 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		/* Since 256xFS clocks cannot be generated by SKL, the NAU8825
+		 * is configured to re-generate its system clock from the BCLK
+		 * using the FLL.
+		 * We must switch system clock (FLL to use BCLK) here as it is
+		 * not given eariler by FW (like in hw_param). We let nau8825 to
+		 * use internal VCO clock till now which reduces the audiable
+		 * pop's. */
+
+		/* fall through */
+
+	case SNDRV_PCM_TRIGGER_RESUME:
+		/* Once device resumes, the system will only enable power
+		 * sequence for playback without doing hardware parameter, audio
+		 * format, and PLL configure. In the mean time, the jack
+		 * detecion sequence has changed PLL parameters and switched to
+		 * internal clock. Thus, the playback signal distorted without
+		 * correct PLL parameters. Therefore we need to configure PLL
+		 * again */
+		ret = snd_soc_dai_set_sysclk(codec_dai, NAU8825_CLK_FLL_FS, 0,
+					     SND_SOC_CLOCK_IN);
+		if (ret < 0) {
+			dev_err(codec_dai->dev, "can't set FS clock %d\n", ret);
+			break;
+		}
+		ret = snd_soc_dai_set_pll(codec_dai, 0, 0, runtime->rate,
+					  runtime->rate * 256);
+		if (ret < 0)
+			dev_err(codec_dai->dev, "can't set FLL: %d\n", ret);
+		break;
+	}
 
 	return ret;
 }
 
-static const struct snd_soc_ops skylake_nau8825_ops = {
-	.hw_params = skylake_nau8825_hw_params,
+static struct snd_soc_ops skylake_nau8825_ops = {
+	.trigger = skylake_nau8825_trigger,
 };
 
 static int skylake_dmic_fixup(struct snd_soc_pcm_runtime *rtd,
diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
index 4b317bcf6ea0..d076f19f9b78 100644
--- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
+++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
@@ -12,6 +12,7 @@
 
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/delay.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
@@ -57,12 +58,12 @@ static const struct snd_kcontrol_new skylake_controls[] = {
 };
 
 static int platform_clock_control(struct snd_soc_dapm_widget *w,
-		struct snd_kcontrol *k, int  event)
+		struct snd_kcontrol *k, int event)
 {
 	struct snd_soc_dapm_context *dapm = w->dapm;
 	struct snd_soc_card *card = dapm->card;
 	struct snd_soc_dai *codec_dai;
-	int ret;
+	int ret = 0;
 
 	codec_dai = snd_soc_card_get_codec_dai(card, SKL_NUVOTON_CODEC_DAI);
 	if (!codec_dai) {
@@ -70,14 +71,7 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 		return -EIO;
 	}
 
-	if (SND_SOC_DAPM_EVENT_ON(event)) {
-		ret = snd_soc_dai_set_sysclk(codec_dai,
-				NAU8825_CLK_MCLK, 24000000, SND_SOC_CLOCK_IN);
-		if (ret < 0) {
-			dev_err(card->dev, "set sysclk err = %d\n", ret);
-			return -EIO;
-		}
-	} else {
+	if (!SND_SOC_DAPM_EVENT_ON(event)) {
 		ret = snd_soc_dai_set_sysclk(codec_dai,
 				NAU8825_CLK_INTERNAL, 0, SND_SOC_CLOCK_IN);
 		if (ret < 0) {
@@ -85,6 +79,7 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 			return -EIO;
 		}
 	}
+
 	return ret;
 }
 
@@ -344,24 +339,51 @@ static int skylake_dmic_fixup(struct snd_soc_pcm_runtime *rtd,
 	return 0;
 }
 
-static int skylake_nau8825_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
+static int skylake_nau8825_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
-	int ret;
-
-	ret = snd_soc_dai_set_sysclk(codec_dai,
-			NAU8825_CLK_MCLK, 24000000, SND_SOC_CLOCK_IN);
-
-	if (ret < 0)
-		dev_err(rtd->dev, "snd_soc_dai_set_sysclk err = %d\n", ret);
+	int ret = 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		/* Since 256xFS clocks cannot be generated by SKL, the NAU8825
+		 * is configured to re-generate its system clock from the BCLK
+		 * using the FLL.
+		 * We must switch system clock (FLL to use BCLK) here as it is
+		 * not given eariler by FW (like in hw_param). We let nau8825 to
+		 * use internal VCO clock till now which reduces the audiable
+		 * pop's. */
+
+		/* fall through */
+
+	case SNDRV_PCM_TRIGGER_RESUME:
+		/* Once device resumes, the system will only enable power
+		 * sequence for playback without doing hardware parameter, audio
+		 * format, and PLL configure. In the mean time, the jack
+		 * detecion sequence has changed PLL parameters and switched to
+		 * internal clock. Thus, the playback signal distorted without
+		 * correct PLL parameters. Therefore we need to configure PLL
+		 * again */
+		ret = snd_soc_dai_set_sysclk(codec_dai, NAU8825_CLK_FLL_FS, 0,
+					     SND_SOC_CLOCK_IN);
+		if (ret < 0) {
+			dev_err(codec_dai->dev, "can't set FS clock %d\n", ret);
+			break;
+		}
+		ret = snd_soc_dai_set_pll(codec_dai, 0, 0, runtime->rate,
+					  runtime->rate * 256);
+		if (ret < 0)
+			dev_err(codec_dai->dev, "can't set FLL: %d\n", ret);
+		break;
+	}
 
 	return ret;
 }
 
-static const struct snd_soc_ops skylake_nau8825_ops = {
-	.hw_params = skylake_nau8825_hw_params,
+static struct snd_soc_ops skylake_nau8825_ops = {
+	.trigger = skylake_nau8825_trigger,
 };
 
 static const unsigned int channels_dmic[] = {
@@ -582,6 +604,7 @@ static struct snd_soc_dai_link skylake_dais[] = {
 		.init = skylake_ssm4567_codec_init,
 		.ignore_pmdown_time = 1,
 		.be_hw_params_fixup = skylake_ssp_fixup,
+		.ops = &skylake_nau8825_ops,
 		.dpcm_playback = 1,
 		.dpcm_capture = 1,
 		SND_SOC_DAILINK_REG(ssp0_pin, ssp0_codec, platform),
-- 
2.17.1

