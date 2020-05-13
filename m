Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A07C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 19:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F4CC2065F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 19:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="sgR1zSAR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390484AbgEMTUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 15:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390289AbgEMTUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 15:20:30 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FC4C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 12:20:28 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id j3so826357ljg.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 12:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xJ0/kVLgd2XGmGl/2Yf51DVqklc7Fd5xTLD8Gz5eOGs=;
        b=sgR1zSARIfNb5fmO42UIoCiOlBOwG/mW+CjWTciqdhRmacNax0zJx/8WqkW3M4LtvL
         iioqJ6NsaRunXfeiPr9NG/jArKqHdg2jNzHvOdJnqI813AK8ktGknxDkeDjYtqMTzrgt
         X6jAUwDbQURSF0gCNRt8YlUykbf+MxlnauLPHqUNMjWvBCckfwH5ISARtErxudxCwQRX
         St1fXVglOdzssSF2uGH8Od6/8Yx3aOJltIPPheBeqCGNhxaas/QirBJomNKVosyHPjnT
         zAgS2gRk3/Vo9xToor1UCNa9aXQ0V7msn3kiMNgSeUpZOUxNngUAX42VW9SJzjF3WhY0
         PYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xJ0/kVLgd2XGmGl/2Yf51DVqklc7Fd5xTLD8Gz5eOGs=;
        b=HD5NL6QA86PVoKX+jzz3qKB10/pJieYRxtE0AkQPABJr98how9tA9Asmte50Bzc+Ai
         08/fv4D6e7ZppaaNkf/ZzdwpT0ZS1s0c5zna+mKh9kAk1K9xLMQKNuiyXD84fr/HUnWI
         W8qR31mHO/cuveb9LnWB07VynlrXPpcQhSC9teMNZQjJvjuE+nhsCQ5gHeuI5JrKv2TQ
         tUwgcxOfGouHHJDg4qIYM3iKLhXR5/Z1NzyBBFyoT62tvonvpDA07kBYGV+atuMIySRi
         acvBalF1uQ8SmVAaIVDzjNbixgWHhxfEQnD+y/aE5E5xEHnPUX8253xBF5nrQ1Laa28l
         OcjA==
X-Gm-Message-State: AOAM531EQwlybiHv3aMOCGDXxawUxcc/2hHm06QFzT82cihfSNpgYLVy
        Vxo8/i7z410XumY8hPyKPeL5WQ==
X-Google-Smtp-Source: ABdhPJwW/lpo7amvDkWje0tqgAbIdqAjf3MAmxRXMtrXK4vDjdOhT9zw+Cb1MxqnGbgyJxozl1DWrg==
X-Received: by 2002:a05:651c:490:: with SMTP id s16mr374721ljc.152.1589397626676;
        Wed, 13 May 2020 12:20:26 -0700 (PDT)
Received: from deadpool.semihalf.local (89-70-221-122.dynamic.chello.pl. [89.70.221.122])
        by smtp.gmail.com with ESMTPSA id w24sm288397lfk.47.2020.05.13.12.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 12:20:26 -0700 (PDT)
From:   Lukasz Majczak <lma@semihalf.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>
Cc:     Bob Brandt <brndt@google.com>, Alex Levin <levinale@chromium.org>,
        Ross Zwisler <zwisler@google.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Radoslaw Biernacki <rad@semihalf.com>,
        Lukasz Majczak <lma@semihalf.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: Intel: kbl_rt5663_rt5514_max98927: Split be_hw_params_fixup function
Date:   Wed, 13 May 2020 21:20:20 +0200
Message-Id: <20200513192020.544928-1-lma@semihalf.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split be_hw_params_fixup function for different codecs as current common
function, leads to crash while trying to get snd_soc_dpcm with
container_of() macro in kabylake_ssp_fixup().
The crash call path looks as below:
soc_pcm_hw_params()
snd_soc_dai_hw_params(codec_dai, substream, &codec_params);
rtd->dai_link->be_hw_params_fixup(rtd, params)
kabylake_ssp_fixup()
In this case, codec_params is just a copy of an internal structure and is
not embedded into struct snd_soc_dpcm thus we cannot use
container_of() on it.

Signed-off-by: Lukasz Majczak <lma@semihalf.com>
---
 .../intel/boards/kbl_rt5663_rt5514_max98927.c | 68 +++++++++++--------
 1 file changed, 39 insertions(+), 29 deletions(-)

diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
index 1b1f8d7a4ea3..2e0ae724122c 100644
--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -328,46 +328,55 @@ static const struct snd_soc_ops kabylake_rt5663_fe_ops = {
 	.startup = kbl_fe_startup,
 };
 
-static int kabylake_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
-					struct snd_pcm_hw_params *params)
+static void kabylake_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
+	struct snd_pcm_hw_params *params, snd_pcm_format_t pcm_fmt)
 {
 	struct snd_interval *rate = hw_param_interval(params,
 			SNDRV_PCM_HW_PARAM_RATE);
-	struct snd_interval *chan = hw_param_interval(params,
+	struct snd_interval *channels = hw_param_interval(params,
 			SNDRV_PCM_HW_PARAM_CHANNELS);
 	struct snd_mask *fmt = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
-	struct snd_soc_dpcm *dpcm = container_of(
-			params, struct snd_soc_dpcm, hw_params);
-	struct snd_soc_dai_link *fe_dai_link = dpcm->fe->dai_link;
-	struct snd_soc_dai_link *be_dai_link = dpcm->be->dai_link;
 
 	/*
 	 * The ADSP will convert the FE rate to 48k, stereo, 24 bit
 	 */
-	if (!strcmp(fe_dai_link->name, "Kbl Audio Port") ||
-	    !strcmp(fe_dai_link->name, "Kbl Audio Headset Playback") ||
-	    !strcmp(fe_dai_link->name, "Kbl Audio Capture Port")) {
-		rate->min = rate->max = 48000;
-		chan->min = chan->max = 2;
-		snd_mask_none(fmt);
-		snd_mask_set_format(fmt, SNDRV_PCM_FORMAT_S24_LE);
-	} else if (!strcmp(fe_dai_link->name, "Kbl Audio DMIC cap")) {
-		if (params_channels(params) == 2 ||
-				DMIC_CH(dmic_constraints) == 2)
-			chan->min = chan->max = 2;
-		else
-			chan->min = chan->max = 4;
-	}
-	/*
-	 * The speaker on the SSP0 supports S16_LE and not S24_LE.
-	 * thus changing the mask here
-	 */
-	if (!strcmp(be_dai_link->name, "SSP0-Codec"))
-		snd_mask_set_format(fmt, SNDRV_PCM_FORMAT_S16_LE);
 
+	rate->min = rate->max = 48000;
+	channels->min = channels->max = 2;
+
+	snd_mask_none(fmt);
+	snd_mask_set_format(fmt, pcm_fmt);
+}
+
+static int kabylake_ssp0_fixup(struct snd_soc_pcm_runtime *rtd,
+	struct snd_pcm_hw_params *params)
+{
+	kabylake_ssp_fixup(rtd, params, SNDRV_PCM_FORMAT_S16_LE);
 	return 0;
 }
 
+static int kabylake_ssp1_fixup(struct snd_soc_pcm_runtime *rtd,
+	struct snd_pcm_hw_params *params)
+{
+
+	kabylake_ssp_fixup(rtd, params, SNDRV_PCM_FORMAT_S24_LE);
+	return 0;
+}
+
+static int kabylake_dmic_cap_fixup(struct snd_soc_pcm_runtime *rtd,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_interval *channels = hw_param_interval(params,
+			SNDRV_PCM_HW_PARAM_CHANNELS);
+
+	if (params_channels(params) == 2 ||
+			DMIC_CH(dmic_constraints) == 2)
+		channels->min = channels->max = 2;
+	else
+		channels->min = channels->max = 4;
+
+	return 0;
+}
 static int kabylake_rt5663_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
@@ -582,6 +591,7 @@ static struct snd_soc_dai_link kabylake_dais[] = {
 		.dpcm_capture = 1,
 		.nonatomic = 1,
 		.dynamic = 1,
+		.be_hw_params_fixup = kabylake_dmic_cap_fixup,
 		.ops = &kabylake_dmic_ops,
 		SND_SOC_DAILINK_REG(dmic, dummy, platform),
 	},
@@ -618,7 +628,7 @@ static struct snd_soc_dai_link kabylake_dais[] = {
 			SND_SOC_DAIFMT_NB_NF |
 			SND_SOC_DAIFMT_CBS_CFS,
 		.ignore_pmdown_time = 1,
-		.be_hw_params_fixup = kabylake_ssp_fixup,
+		.be_hw_params_fixup = kabylake_ssp0_fixup,
 		.dpcm_playback = 1,
 		.dpcm_capture = 1,
 		.ops = &kabylake_ssp0_ops,
@@ -632,7 +642,7 @@ static struct snd_soc_dai_link kabylake_dais[] = {
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			SND_SOC_DAIFMT_CBS_CFS,
 		.ignore_pmdown_time = 1,
-		.be_hw_params_fixup = kabylake_ssp_fixup,
+		.be_hw_params_fixup = kabylake_ssp1_fixup,
 		.ops = &kabylake_rt5663_ops,
 		.dpcm_playback = 1,
 		.dpcm_capture = 1,
-- 
2.25.1

