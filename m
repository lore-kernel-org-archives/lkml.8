Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E9FC47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 19:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2728A2137B
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 19:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="ohsuYv8A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgEATbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 15:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726377AbgEATbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 15:31:52 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194FDC061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 12:31:51 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id w14so4666007lfk.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 12:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=Y1Sxa1L6MHtu4yCi6bcxHWPjDF8MAxhNbnipuwNwfpQ=;
        b=ohsuYv8AvDs+U2XslgnY/gQSYMYEK0EDhVT2tdfn957mC+7qCzjCY+xYHUbL3zCWm3
         ty+EE8kuwN1A69MSfs5YYYUA9hhfndNYHnyJ1au1aNnc4Nma8w0xPvMq1Ei9YNcxi6tK
         VYxEbMpVZBCfYYqKbHuGSmElyidr/n8VwM/BxZ/B7gme7G6n+GyzMhNxpPtT3kKn5h5Y
         9B+ndFPeW4rbum6Ji+rZuZDKbhC19bOvVaVA5qH6Ji1Z+0do0X4QdoasOSY6s1nvjZdd
         4FuBlbdNRwO/7eaXQ84q4TEAME1Ejt12B5BVzabbBDTWcRm2Q79C/BKVjeSlnYPonpWb
         cTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Y1Sxa1L6MHtu4yCi6bcxHWPjDF8MAxhNbnipuwNwfpQ=;
        b=gPHGDcRYCk9VUvsqxOYfRNcbFs/H4Pn5igYVkoqAVk4Z9XHDuXQzxkKZW1o/VEJTeH
         zjZRRPUTGbpHfmxuT9oN57zfGMG8tPSsxHIErAHmP5dBrVZHe7JW+T18fwKIf/5pnUML
         aJxGIou4q9m21uA8ifDsOCmCrnYGLZ0HE7zgnKPqpm98/QbPmWiiT98JfTsURz/ezbf1
         gfI3Yqcej4Av9SX0KLxY8rV26keXtLplNfDgDG14kYO83hmpzNYTPqUUTEIinAJSGUdG
         ScldUnFWtDQCntQ3L87zjdhWKcdtgCtxKiEYp8W0QB5A9bQc7mTPdQpmrrDHwJ8SngJw
         ZpnQ==
X-Gm-Message-State: AGi0PuZExyEcN/V5NlZpXtEdyKmAeJLfcH7veRwON0XGmdazi6u9sZ3c
        TaJ8IJsm5x9poM5ei2/idjkfQQ==
X-Google-Smtp-Source: APiQypI2HHesOzyHN/LU2g7osuTrzqPEGqEV+ENUUy1yzzVBfakVnOBDeZhU69EWGCUhkDUqbKn/Fw==
X-Received: by 2002:a05:6512:10d0:: with SMTP id k16mr3489149lfg.71.1588361509310;
        Fri, 01 May 2020 12:31:49 -0700 (PDT)
Received: from rad-H81M-S1.semihalf.local (193-106-246-138.noc.fibertech.net.pl. [193.106.246.138])
        by smtp.gmail.com with ESMTPSA id v17sm2789711lfe.34.2020.05.01.12.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 12:31:48 -0700 (PDT)
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
Subject: [PATCH V2] ASoC: Intel: boards: Use FS as nau8825 sysclk in nau88125_* machine
Date:   Fri,  1 May 2020 21:31:41 +0200
Message-Id: <20200501193141.30293-1-rad@semihalf.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This single fix address two issues on machines with nau88125:
1) Audio distortion, due to lack of required clock rate on MCLK line
2) Loud audible "pops" on headphones if there is no sysclk during nau8825
   playback power up sequence

Explanation for:
1) Due to Skylake HW limitation, MCLK pin can only output 24MHz clk
   rate (it can be only connected to XTAL parent clk). The BCLK pin
   can be driven by dividers and therefore FW is able to set it to rate
   required by chosen audio format. According to nau8825 datasheet, 256*FS
   sysclk gives the best audio quality and the only way to achieve this
   (taking into account the above limitations) its to regenerate the MCLK
   from BCLK on nau8825 side by FFL. Without required clk rate, audio is
   distorted by added harmonics.

2) Currently Skylake does not output MCLK/FS when the back-end DAI op
   hw_param is called, so we cannot switch to MCLK/FS in hw_param.  This
   patch reduces pop by letting nau8825 keep using its internal VCO clock
   during widget power up sequence, until SNDRV_PCM_TRIGGER_START when
   MCLK/FS is available. Once device resumes, the system will only enable
   power sequence for playback without doing hardware parameter, audio
   format, and PLL configure. In the mean time, the jack detecion sequence
   has changed PLL parameters and switched to internal clock. Thus, the
   playback signal distorted without correct PLL parameters.  That is why
   we need to configure the PLL again in SNDRV_PCM_TRIGGER_RESUME case.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: Yong Zhi <yong.zhi@intel.com>
Signed-off-by: Mac Chiang <mac.chiang@intel.com>
Signed-off-by: Ben Zhang <benzh@chromium.org>
Signed-off-by: Radoslaw Biernacki <rad@semihalf.com>
---
 .../soc/intel/boards/skl_nau88l25_max98357a.c | 72 +++++++++++++-----
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c | 73 ++++++++++++++-----
 2 files changed, 107 insertions(+), 38 deletions(-)

diff --git a/sound/soc/intel/boards/skl_nau88l25_max98357a.c b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
index d7b8154c43a4..0f3cea1342d1 100644
--- a/sound/soc/intel/boards/skl_nau88l25_max98357a.c
+++ b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
@@ -8,6 +8,7 @@
 
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/delay.h>
 #include <sound/core.h>
 #include <sound/jack.h>
 #include <sound/pcm.h>
@@ -47,7 +48,7 @@ enum {
 };
 
 static int platform_clock_control(struct snd_soc_dapm_widget *w,
-	struct snd_kcontrol *k, int  event)
+	struct snd_kcontrol *k, int event)
 {
 	struct snd_soc_dapm_context *dapm = w->dapm;
 	struct snd_soc_card *card = dapm->card;
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
@@ -292,24 +286,40 @@ static const struct snd_soc_ops skylake_nau8825_fe_ops = {
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
+	int ret = 0;
 
-	if (ret < 0)
-		dev_err(rtd->dev, "snd_soc_dai_set_sysclk err = %d\n", ret);
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
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
+	case SNDRV_PCM_TRIGGER_RESUME:
+		ret = snd_soc_dai_set_pll(codec_dai, 0, 0, runtime->rate,
+					  runtime->rate * 256);
+		if (ret < 0)
+			dev_err(codec_dai->dev, "can't set FLL: %d\n", ret);
+		msleep(20);
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
@@ -630,10 +640,34 @@ static int skylake_card_late_probe(struct snd_soc_card *card)
 	return hdac_hdmi_jack_port_init(component, &card->dapm);
 }
 
+static int __maybe_unused skylake_nau8825_resume_post(struct snd_soc_card *card)
+{
+	struct snd_soc_dai *codec_dai;
+
+	codec_dai = snd_soc_card_get_codec_dai(card, SKL_NUVOTON_CODEC_DAI);
+	if (!codec_dai) {
+		dev_err(card->dev, "Codec dai not found\n");
+		return -EIO;
+	}
+
+	dev_dbg(codec_dai->dev, "playback_active:%d playback_widget->active:%d codec_dai->rate:%d\n",
+		codec_dai->stream_active[SNDRV_PCM_STREAM_PLAYBACK],
+		codec_dai->playback_widget->active,
+		codec_dai->rate);
+
+	if (codec_dai->stream_active[SNDRV_PCM_STREAM_PLAYBACK] &&
+	    codec_dai->playback_widget->active)
+		snd_soc_dai_set_sysclk(codec_dai, NAU8825_CLK_FLL_FS, 0,
+				       SND_SOC_CLOCK_IN);
+
+	return 0;
+}
+
 /* skylake audio machine driver for SPT + NAU88L25 */
 static struct snd_soc_card skylake_audio_card = {
 	.name = "sklnau8825max",
 	.owner = THIS_MODULE,
+	.resume_post = skylake_nau8825_resume_post,
 	.dai_link = skylake_dais,
 	.num_links = ARRAY_SIZE(skylake_dais),
 	.controls = skylake_controls,
diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
index 4b317bcf6ea0..be44a40067f0 100644
--- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
+++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
@@ -12,6 +12,7 @@
 
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/delay.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
@@ -57,7 +58,7 @@ static const struct snd_kcontrol_new skylake_controls[] = {
 };
 
 static int platform_clock_control(struct snd_soc_dapm_widget *w,
-		struct snd_kcontrol *k, int  event)
+		struct snd_kcontrol *k, int event)
 {
 	struct snd_soc_dapm_context *dapm = w->dapm;
 	struct snd_soc_card *card = dapm->card;
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
 
@@ -344,24 +339,40 @@ static int skylake_dmic_fixup(struct snd_soc_pcm_runtime *rtd,
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
+	int ret = 0;
 
-	if (ret < 0)
-		dev_err(rtd->dev, "snd_soc_dai_set_sysclk err = %d\n", ret);
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
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
+	case SNDRV_PCM_TRIGGER_RESUME:
+		ret = snd_soc_dai_set_pll(codec_dai, 0, 0, runtime->rate,
+					  runtime->rate * 256);
+		if (ret < 0)
+			dev_err(codec_dai->dev, "can't set FLL: %d\n", ret);
+		msleep(20);
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
@@ -671,10 +682,34 @@ static int skylake_card_late_probe(struct snd_soc_card *card)
 	return hdac_hdmi_jack_port_init(component, &card->dapm);
 }
 
+static int __maybe_unused skylake_nau8825_resume_post(struct snd_soc_card *card)
+{
+	struct snd_soc_dai *codec_dai;
+
+	codec_dai = snd_soc_card_get_codec_dai(card, SKL_NUVOTON_CODEC_DAI);
+	if (!codec_dai) {
+		dev_err(card->dev, "Codec dai not found\n");
+		return -EIO;
+	}
+
+	dev_dbg(codec_dai->dev, "playback_active:%d playback_widget->active:%d codec_dai->rate:%d\n",
+		codec_dai->stream_active[SNDRV_PCM_STREAM_PLAYBACK],
+		codec_dai->playback_widget->active,
+		codec_dai->rate);
+
+	if (codec_dai->stream_active[SNDRV_PCM_STREAM_PLAYBACK] &&
+	    codec_dai->playback_widget->active)
+		snd_soc_dai_set_sysclk(codec_dai, NAU8825_CLK_FLL_FS, 0,
+				       SND_SOC_CLOCK_IN);
+
+	return 0;
+}
+
 /* skylake audio machine driver for SPT + NAU88L25 */
 static struct snd_soc_card skylake_audio_card = {
 	.name = "sklnau8825adi",
 	.owner = THIS_MODULE,
+	.resume_post = skylake_nau8825_resume_post,
 	.dai_link = skylake_dais,
 	.num_links = ARRAY_SIZE(skylake_dais),
 	.controls = skylake_controls,
-- 
2.17.1

