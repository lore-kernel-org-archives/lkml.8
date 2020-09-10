Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE8CC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EF5E208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="VdZmhk1u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgIJR2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbgIJR0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 13:26:18 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F52C061795
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 10:25:44 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id k25so9187175ljg.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 10:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=Kk0XQNKqYfxJTLaKrt8nQK8M1p7oRPoQlJZqqiNIcnU=;
        b=VdZmhk1u/YdRZKjJ5HfFDnNdo3EYFX+MLk+JF10ESprrhiw/HkwpYwd9hb2BXxOSZb
         1R6kX2YF3Z5KTjtdw9DREuqmDhsjpBdQpuZvG+dzOZCbWrIPtfMDI8Sg6xIVID2VDLtH
         j/1DSHYlmXBz0a65LmcFaYTMF9+X55ydI5wBdAO85PCKGSrlP+784kBfpkB8RMyxCvWM
         bnFbS6e+nMOePh1kffzQF2sxpaxg+CwDoskZKUWFdn0LE12yfbAdcck3yK6gyXqMcXdY
         yc8JBs1MbLaM9HelB2F0rzxlcigJMYmw7nA4FFghcwKeU49MeZ8yUrDScWZfvqOfJtWh
         zgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Kk0XQNKqYfxJTLaKrt8nQK8M1p7oRPoQlJZqqiNIcnU=;
        b=OxIwqOdLVBpgRoa+farQn+YlYjtCabo55ZD6zsGOku9tdYv1XioH2zdhZKpSKsvkk9
         oJ/W77lUXUSKKoVocfPm7IVqyA7fii6i6+Yg9oe1DVbFXxGvbHpsxtvn7+QO3kcqZNTg
         Fv5xPwEQasP0DoLykMVLdKCHxkHVPPrXpwBrakB+Z92I7VgZuehlHO6MWCszv0fOAT4k
         9BKKGvyll3Q2uyePB/sjgcU5Fk/cLRZvP6RsRzslPCpMZ/SmmaXEwy2Zypt3YEPU05O+
         SzA0DF38ZQAYCRnbt0fWNlgiDw2XYWnMxxo6EeeEzV7AvzS0PDw2/SJjxdCHEtDhXa0v
         qQ1Q==
X-Gm-Message-State: AOAM532/ccpVzePxlE6rbq6qD0CMyb9qJRtSW8TKKDkm1N9zWpp68EnY
        +qFSuWITIoKt0feOkSOZ0b/GMQ==
X-Google-Smtp-Source: ABdhPJxudeY6fTGVl5c0g/UH6MTEHtKcAfGOUGOnRU0QFxMEzqkONNtOjgzMNh65NumDGs9moMoQuA==
X-Received: by 2002:a05:651c:3c2:: with SMTP id f2mr4828475ljp.14.1599758742622;
        Thu, 10 Sep 2020 10:25:42 -0700 (PDT)
Received: from rad-H81M-S1.semihalf.local (193-106-246-138.noc.fibertech.net.pl. [193.106.246.138])
        by smtp.gmail.com with ESMTPSA id f6sm1755079ljj.28.2020.09.10.10.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 10:25:41 -0700 (PDT)
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
Subject: [PATCH V6] ASoC: Intel: boards: Use FS as nau8825 sysclk in nau88125_* machine
Date:   Thu, 10 Sep 2020 19:25:38 +0200
Message-Id: <20200910172538.31425-1-rad@semihalf.com>
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
    v4 -> v5:
     - removed stray change ~ SSP0 ops
    v5 -> v6:
     - fixing typos and comment style

 .../soc/intel/boards/skl_nau88l25_max98357a.c | 62 +++++++++++-------
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c | 63 ++++++++++++-------
 2 files changed, 83 insertions(+), 42 deletions(-)

diff --git a/sound/soc/intel/boards/skl_nau88l25_max98357a.c b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
index d7b8154c43a4..12595138f44b 100644
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
@@ -292,24 +286,50 @@ static const struct snd_soc_ops skylake_nau8825_fe_ops = {
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
+		 * not given earlier by FW (like in hw_param). We let nau8825 to
+		 * use internal VCO clock till now which reduces the audible
+		 * pop's.
+		 */
+	case SNDRV_PCM_TRIGGER_RESUME:
+		/* Once device resumes, the system will only enable power
+		 * sequence for playback without doing hardware parameter, audio
+		 * format, and PLL configure. In the mean time, the jack
+		 * detection sequence has changed PLL parameters and switched to
+		 * internal clock. Thus, the playback signal distorted without
+		 * correct PLL parameters. Therefore we need to configure PLL
+		 * again
+		 */
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
index 4b317bcf6ea0..38faaf20306e 100644
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
 
@@ -344,24 +339,50 @@ static int skylake_dmic_fixup(struct snd_soc_pcm_runtime *rtd,
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
+		 * not given earlier by FW (like in hw_param). We let nau8825 to
+		 * use internal VCO clock till now which reduces the audible
+		 * pop's.
+		 */
+	case SNDRV_PCM_TRIGGER_RESUME:
+		/* Once device resumes, the system will only enable power
+		 * sequence for playback without doing hardware parameter, audio
+		 * format, and PLL configure. In the mean time, the jack
+		 * detection sequence has changed PLL parameters and switched to
+		 * internal clock. Thus, the playback signal distorted without
+		 * correct PLL parameters. Therefore we need to configure PLL
+		 * again
+		 */
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
-- 
2.17.1

