Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940CAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 16:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D91320748
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 16:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="MY6zs4LZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbgEUQ0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 12:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgEUQ0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 12:26:22 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C18C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 09:26:21 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 82so4820762lfh.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 09:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U9/periDH8UfNWS+nfaTMqExZdGPDGD6GSusPfDw/70=;
        b=MY6zs4LZhaRCsyF7UgDCRjc2UMi0QWWMNcScPT7hpcVAT2J1th3fZ+O0iVRy7F2+AP
         k+qFPkw4KCzAH9/mCYX2jW4uYdWIMqTJYGh1FaMMt9oBuvqLxpp3lf9N3SSyIw/YRubV
         H3nAo6lEfZZ1IiT/1A36PC7xdYTcR6lSwaAyoDGAO7ymaEBNi03SkmOzKxZmepwfDS1y
         A4D8FbkuZOXTcEo7oTPiwVJ7MaKtrcvbX9jkZkGlXwcqp49g+5PnU3zrLVC7mYX9IQvK
         4pdcEtPN00DJHLUtMmJqoaz3WoEBOxGPnninywoRQz2+e/gjLhoSzkfV0KVaswB8BuIP
         bR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U9/periDH8UfNWS+nfaTMqExZdGPDGD6GSusPfDw/70=;
        b=nrYf8o0DLkqvyw2D4csuZ1IW642EwZfZ8/xIIJMw5JAkeK5/0BMc/XdViMymL2c6mR
         Cqhe0m2zhpVWCHs6+yiLngTLUb9QS5h7xpggQHqacxjCP6ipYDPP2jK7GLwEQtzo1snz
         6Q+tXIDV5VyQ6clTWRN2mRGeKV/Fq+AOD66lzeDdkdCFTdJyE8zXgtd0AaNEGcjkyOGt
         Z07gZZRTI8GmZ32qqwrdHf3xUHL78vXg+tb5m40AZS7/d4zHv6t3J1KODKrk8rDuXTxA
         zDZnDw4iSIqj0mzI8H+f02FNkv/U9NSGBIfEp4ewhMChCWlzTsWaRdEPQLeCh/Jfe4X0
         MHuA==
X-Gm-Message-State: AOAM531shVNyYHQIWBhycF++2wFv0HFxOw2Y4qEn8jyXm5tLcR7Efg7p
        nd9vqxrVi30H8FtLTP8zgjPw/A==
X-Google-Smtp-Source: ABdhPJzx1yIyb5qLyd01JzMJ0tM71GTSAtTyKtIPcVKLiSU0oGNOkK++bi81UdUJ4ZmU/DW5tvbMdQ==
X-Received: by 2002:a05:6512:411:: with SMTP id u17mr5461789lfk.106.1590078379853;
        Thu, 21 May 2020 09:26:19 -0700 (PDT)
Received: from localhost.localdomain (89-70-221-122.dynamic.chello.pl. [89.70.221.122])
        by smtp.gmail.com with ESMTPSA id g3sm2089212ljk.27.2020.05.21.09.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 09:26:19 -0700 (PDT)
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
Subject: [PATCH v3] ASoC: Intel: kbl_rt5663_rt5514_max98927: Split be_hw_params_fixup function
Date:   Thu, 21 May 2020 18:25:18 +0200
Message-Id: <20200521162518.1809995-1-lma@semihalf.com>
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

v1 -> v2:
- Extract dmic from SSP0 as every BE should have own fixup function.
v2 -> v3:
- Restore naming in the dapm route table to not confuse with other
drivers
- Fixed indentations

Signed-off-by: Lukasz Majczak <lma@semihalf.com>
---
 .../intel/boards/kbl_rt5663_rt5514_max98927.c | 130 +++++++++++-------
 1 file changed, 84 insertions(+), 46 deletions(-)

diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
index 1b1f8d7a4ea3..b9596cf3a6c4 100644
--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -328,42 +328,51 @@ static const struct snd_soc_ops kabylake_rt5663_fe_ops = {
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
+
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
+	return 0;
+}
+
+static int kabylake_ssp1_fixup(struct snd_soc_pcm_runtime *rtd,
+	struct snd_pcm_hw_params *params)
+{
+
+	kabylake_ssp_fixup(rtd, params, SNDRV_PCM_FORMAT_S24_LE);
+	return 0;
+}
+
+static int kabylake_dmic_fixup(struct snd_soc_pcm_runtime *rtd,
+					struct snd_pcm_hw_params *params)
+{
+	struct snd_interval *channels = hw_param_interval(params,
+			SNDRV_PCM_HW_PARAM_CHANNELS);
+
+	if (params_channels(params) == 2 || DMIC_CH(dmic_constraints) == 2)
+		channels->min = channels->max = 2;
+	else
+		channels->min = channels->max = 4;
 
 	return 0;
 }
@@ -400,20 +409,6 @@ static int kabylake_ssp0_hw_params(struct snd_pcm_substream *substream,
 	int ret = 0, j;
 
 	for_each_rtd_codec_dais(rtd, j, codec_dai) {
-		if (!strcmp(codec_dai->component->name, RT5514_DEV_NAME)) {
-			ret = snd_soc_dai_set_tdm_slot(codec_dai, 0xF, 0, 8, 16);
-			if (ret < 0) {
-				dev_err(rtd->dev, "set TDM slot err:%d\n", ret);
-				return ret;
-			}
-
-			ret = snd_soc_dai_set_sysclk(codec_dai,
-				RT5514_SCLK_S_MCLK, 24576000, SND_SOC_CLOCK_IN);
-			if (ret < 0) {
-				dev_err(rtd->dev, "set sysclk err: %d\n", ret);
-				return ret;
-			}
-		}
 		if (!strcmp(codec_dai->component->name, MAXIM_DEV0_NAME)) {
 			ret = snd_soc_dai_set_tdm_slot(codec_dai, 0x30, 3, 8, 16);
 			if (ret < 0) {
@@ -433,10 +428,36 @@ static int kabylake_ssp0_hw_params(struct snd_pcm_substream *substream,
 	return ret;
 }
 
+static int kabylake_dmic01_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	int ret = 0;
+
+	ret = snd_soc_dai_set_tdm_slot(rtd->codec_dai, 0xF, 0, 8, 16);
+	if (ret < 0) {
+		dev_err(rtd->dev, "set TDM slot err:%d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_dai_set_sysclk(rtd->codec_dai,
+		RT5514_SCLK_S_MCLK, 24576000, SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		dev_err(rtd->dev, "set sysclk err: %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
 static struct snd_soc_ops kabylake_ssp0_ops = {
 	.hw_params = kabylake_ssp0_hw_params,
 };
 
+static struct snd_soc_ops kabylake_dmic01_ops = {
+	.hw_params = kabylake_dmic01_hw_params,
+};
+
 static const unsigned int channels_dmic[] = {
 	4,
 };
@@ -507,14 +528,19 @@ SND_SOC_DAILINK_DEF(ssp0_pin,
 SND_SOC_DAILINK_DEF(ssp0_codec,
 	DAILINK_COMP_ARRAY(
 	/* Left */ COMP_CODEC(MAXIM_DEV0_NAME, KBL_MAXIM_CODEC_DAI),
-	/* Right */COMP_CODEC(MAXIM_DEV1_NAME, KBL_MAXIM_CODEC_DAI),
-	/* dmic */ COMP_CODEC(RT5514_DEV_NAME, KBL_REALTEK_DMIC_CODEC_DAI)));
+	/* Right */COMP_CODEC(MAXIM_DEV1_NAME, KBL_MAXIM_CODEC_DAI)));
 
 SND_SOC_DAILINK_DEF(ssp1_pin,
 	DAILINK_COMP_ARRAY(COMP_CPU("SSP1 Pin")));
 SND_SOC_DAILINK_DEF(ssp1_codec,
 	DAILINK_COMP_ARRAY(COMP_CODEC(RT5663_DEV_NAME, KBL_REALTEK_CODEC_DAI)));
 
+SND_SOC_DAILINK_DEF(dmic01_pin,
+	DAILINK_COMP_ARRAY(COMP_CPU("DMIC01 Pin")));
+SND_SOC_DAILINK_DEF(dmic01_codec,
+	DAILINK_COMP_ARRAY(
+		COMP_CODEC(RT5514_DEV_NAME, KBL_REALTEK_DMIC_CODEC_DAI)));
+
 SND_SOC_DAILINK_DEF(idisp1_pin,
 	DAILINK_COMP_ARRAY(COMP_CPU("iDisp1 Pin")));
 SND_SOC_DAILINK_DEF(idisp1_codec,
@@ -618,9 +644,8 @@ static struct snd_soc_dai_link kabylake_dais[] = {
 			SND_SOC_DAIFMT_NB_NF |
 			SND_SOC_DAIFMT_CBS_CFS,
 		.ignore_pmdown_time = 1,
-		.be_hw_params_fixup = kabylake_ssp_fixup,
+		.be_hw_params_fixup = kabylake_ssp0_fixup,
 		.dpcm_playback = 1,
-		.dpcm_capture = 1,
 		.ops = &kabylake_ssp0_ops,
 		SND_SOC_DAILINK_REG(ssp0_pin, ssp0_codec, platform),
 	},
@@ -632,12 +657,25 @@ static struct snd_soc_dai_link kabylake_dais[] = {
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			SND_SOC_DAIFMT_CBS_CFS,
 		.ignore_pmdown_time = 1,
-		.be_hw_params_fixup = kabylake_ssp_fixup,
+		.be_hw_params_fixup = kabylake_ssp1_fixup,
 		.ops = &kabylake_rt5663_ops,
 		.dpcm_playback = 1,
 		.dpcm_capture = 1,
 		SND_SOC_DAILINK_REG(ssp1_pin, ssp1_codec, platform),
 	},
+	{
+		.name = "dmic01",
+		.id = 2,
+		.no_pcm = 1,
+		.dai_fmt = SND_SOC_DAIFMT_DSP_B |
+			SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_CBS_CFS,
+		.ignore_pmdown_time = 1,
+		.be_hw_params_fixup = kabylake_dmic_fixup,
+		.dpcm_capture = 1,
+		.ops = &kabylake_dmic01_ops,
+		SND_SOC_DAILINK_REG(dmic01_pin, dmic01_codec, platform),
+	},
 	{
 		.name = "iDisp1",
 		.id = 3,

base-commit: a4f6fc98cd2fa1774bcaeb248c67156ef9402a56
-- 
2.25.1

