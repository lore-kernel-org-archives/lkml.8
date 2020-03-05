Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1E2C3F2D8
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A81F920637
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="A93gzN+Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbgCERXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 12:23:24 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37961 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbgCERXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 12:23:19 -0500
Received: by mail-lf1-f67.google.com with SMTP id x22so5289874lff.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 09:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=fPcaCIVhLaLkGll6nxgOHW5KQZcIBDxuWhoHfzoQVN0=;
        b=A93gzN+Zn4n6r51CIk1zU+p7sSs6MHMyNSevDZnnZZEu1MeBqkV5MxsmltQ8zkYhoV
         poNcTljr1IQ1u3tXPUeE5CYCAa/ERTJuTgCXXV6CQjn1ZF/y8TTTqOl25hxkR8/opX9h
         T2NKn1GvTVrWyHuRCWCfhRGwDenKqHGKYyDfae3kMCOAmosGzdzAbaHwpTA+O2E6srg4
         b44Nw3mfA0NRhqNr+8Mv9iU89qEV58OZrBG2wP7SohzKVz5lm1akkF15NTvQKvoohsYL
         mVlocBmDFWM2ruQj64AnISnwbVehPDNvXEAsN7uLZtLyFlWh48EqIwsBwz3NO2mp+JCG
         djZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fPcaCIVhLaLkGll6nxgOHW5KQZcIBDxuWhoHfzoQVN0=;
        b=KqtBB+Wk/kxIkHhKyHFe/dakX59R1gCbPtXlqVJ/Qae2cIcmbe0RHk2Rz3252yxMXc
         IrUf+MD2Pf12R+TGEtpW03zA6tGj9PH0Ct6vykGdwUN/0q8e/dLV/lXHeykCcvlQYBYU
         qvasD94ER4ueWu0m6z6WYqVKXMZ3UWG53ynNrOBVR3QdXgz+9WAhQpaO1DIW+GyxrWls
         LWddZvlz2zmjd0QXXsPRqnmotGOkKxReuNs26dgJl5diKfO9m1eD/tsuAako710ESi+Y
         xuubV7MF52mPiduJB1Mwr58ZHXP92at7Vmsbwtn2IL7BoxGXxzN6Z4vEjcc3vyvfineg
         Xegg==
X-Gm-Message-State: ANhLgQ0SvAujK/+0Vr3HIEup5RTKxEEx2Qu+iZRKrCtkLbZmjUtKioIT
        CbJPlyRKypNPTqCagy485hF6WA==
X-Google-Smtp-Source: ADFU+vsqiH7bKpeE49BGJmj5PDxA/JYqwdl/zBQkFoVsaIP8ZhQ8uEjo2q86RcuN2IJjBI9sjuNwXg==
X-Received: by 2002:ac2:58ee:: with SMTP id v14mr6276462lfo.62.1583428996947;
        Thu, 05 Mar 2020 09:23:16 -0800 (PST)
Received: from rad-H81M-S1.semihalf.local (31-172-191-173.noc.fibertech.net.pl. [31.172.191.173])
        by smtp.gmail.com with ESMTPSA id x23sm2377621ljj.8.2020.03.05.09.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 09:23:16 -0800 (PST)
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
Subject: [PATCH] ASoC: Intel: boards: Use FS as nau8825 sysclk in nau88125_ssm4567 machine
Date:   Thu,  5 Mar 2020 18:22:19 +0100
Message-Id: <eec72ad35e45a9898027f2d4da82c5c1998febad.1583356568.git.rad@semihalf.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Zhang <benzh@chromium.org>

This single fix address two issues on machine with nau88125 + ssm4567:
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
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c | 71 ++++++++++++++-----
 1 file changed, 52 insertions(+), 19 deletions(-)

diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
index c99c8b23e509..c5354da49670 100644
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
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
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
@@ -671,10 +682,32 @@ static int skylake_card_late_probe(struct snd_soc_card *card)
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
+		codec_dai->playback_active, codec_dai->playback_widget->active,
+		codec_dai->rate);
+
+	if (codec_dai->playback_active && codec_dai->playback_widget->active)
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

