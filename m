Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044FEC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C56FE206D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgEUOZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 10:25:37 -0400
Received: from mga12.intel.com ([192.55.52.136]:65302 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727889AbgEUOZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 10:25:36 -0400
IronPort-SDR: jL4osm3/1UOaXDwUVR0TftgRk1F+CRwMYusuprI5BLmRwss8UrdwG0v+oulpwaY7j9GBiTEdnx
 WvwtjlzYGxLw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 07:25:36 -0700
IronPort-SDR: RDDj0EDNuzQYfX8MNN5Jau+khGpuCiHr0bJlLrHAHv57RfeJGr7MXQPIQA0HYsANhQQV/pzpQw
 59Jdy23mnQmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,417,1583222400"; 
   d="scan'208";a="253983710"
Received: from dsrao-mobl.amr.corp.intel.com (HELO [10.255.229.80]) ([10.255.229.80])
  by orsmga007.jf.intel.com with ESMTP; 21 May 2020 07:25:35 -0700
Subject: Re: [PATCH] ASoC: Intel: kbl_rt5663_rt5514_max98927: Split
 be_hw_params_fixup function
To:     Lukasz Majczak <lma@semihalf.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, Radoslaw Biernacki <rad@semihalf.com>,
        Ross Zwisler <zwisler@google.com>,
        linux-kernel@vger.kernel.org, Bob Brandt <brndt@google.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Alex Levin <levinale@chromium.org>
References: <20200521134700.1035657-1-lma@semihalf.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <964af231-0bce-1bb2-ea0c-b8bc423eb916@linux.intel.com>
Date:   Thu, 21 May 2020 09:25:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200521134700.1035657-1-lma@semihalf.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/21/20 8:47 AM, Lukasz Majczak wrote:
> Split be_hw_params_fixup function for different codecs as current common
> function, leads to crash while trying to get snd_soc_dpcm with
> container_of() macro in kabylake_ssp_fixup().
> The crash call path looks as below:
> soc_pcm_hw_params()
> snd_soc_dai_hw_params(codec_dai, substream, &codec_params);
> rtd->dai_link->be_hw_params_fixup(rtd, params)
> kabylake_ssp_fixup()
> In this case, codec_params is just a copy of an internal structure and is
> not embedded into struct snd_soc_dpcm thus we cannot use
> container_of() on it.
> 
> Signed-off-by: Lukasz Majczak <lma@semihalf.com>
> ---
>   .../intel/boards/kbl_rt5663_rt5514_max98927.c | 130 ++++++++++++------
>   1 file changed, 85 insertions(+), 45 deletions(-)
> 
> diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> index 1b1f8d7a4ea3..12a9983979e0 100644
> --- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> +++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> @@ -171,8 +171,8 @@ static const struct snd_soc_dapm_route kabylake_map[] = {
>   	{ "hs_in", NULL, "ssp1 Rx" },
>   	{ "ssp1 Rx", NULL, "AIF Capture" },
>   
> -	{ "codec1_in", NULL, "ssp0 Rx" },
> -	{ "ssp0 Rx", NULL, "AIF1 Capture" },
> +	{ "codec1_in", NULL, "DMIC01 Rx" },
> +	{ "DMIC01 Rx", NULL, "AIF1 Capture" },

This doesn't seem right. This board uses DMICs attached to the codec so 
we should not make references to routes that are used for PCH-attached 
dmics in all other machine drivers:

	{ "dmic01_hifi", NULL, "DMIC01 Rx" },
	{ "DMIC01 Rx", NULL, "DMIC AIF" },

>   
>   	/* IV feedback path */
>   	{ "codec0_fb_in", NULL, "ssp0 Rx"},
> @@ -328,42 +328,52 @@ static const struct snd_soc_ops kabylake_rt5663_fe_ops = {
>   	.startup = kbl_fe_startup,
>   };
>   
> -static int kabylake_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
> -					struct snd_pcm_hw_params *params)
> +static void kabylake_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
> +	struct snd_pcm_hw_params *params, snd_pcm_format_t pcm_fmt)
>   {
>   	struct snd_interval *rate = hw_param_interval(params,
>   			SNDRV_PCM_HW_PARAM_RATE);
> -	struct snd_interval *chan = hw_param_interval(params,
> +	struct snd_interval *channels = hw_param_interval(params,
>   			SNDRV_PCM_HW_PARAM_CHANNELS);
>   	struct snd_mask *fmt = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
> -	struct snd_soc_dpcm *dpcm = container_of(
> -			params, struct snd_soc_dpcm, hw_params);
> -	struct snd_soc_dai_link *fe_dai_link = dpcm->fe->dai_link;
> -	struct snd_soc_dai_link *be_dai_link = dpcm->be->dai_link;
>   
>   	/*
>   	 * The ADSP will convert the FE rate to 48k, stereo, 24 bit
>   	 */
> -	if (!strcmp(fe_dai_link->name, "Kbl Audio Port") ||
> -	    !strcmp(fe_dai_link->name, "Kbl Audio Headset Playback") ||
> -	    !strcmp(fe_dai_link->name, "Kbl Audio Capture Port")) {
> -		rate->min = rate->max = 48000;
> -		chan->min = chan->max = 2;
> -		snd_mask_none(fmt);
> -		snd_mask_set_format(fmt, SNDRV_PCM_FORMAT_S24_LE);
> -	} else if (!strcmp(fe_dai_link->name, "Kbl Audio DMIC cap")) {
> +
> +	rate->min = rate->max = 48000;
> +	channels->min = channels->max = 2;
> +
> +	snd_mask_none(fmt);
> +	snd_mask_set_format(fmt, pcm_fmt);
> +}
> +
> +static int kabylake_ssp0_fixup(struct snd_soc_pcm_runtime *rtd,
> +	struct snd_pcm_hw_params *params)
> +{
> +	kabylake_ssp_fixup(rtd, params, SNDRV_PCM_FORMAT_S16_LE);
> +	return 0;
> +}
> +
> +static int kabylake_ssp1_fixup(struct snd_soc_pcm_runtime *rtd,
> +	struct snd_pcm_hw_params *params)
> +{
> +
> +	kabylake_ssp_fixup(rtd, params, SNDRV_PCM_FORMAT_S24_LE);
> +	return 0;
> +}
> +
> +static int kabylake_dmic_fixup(struct snd_soc_pcm_runtime *rtd,
> +					struct snd_pcm_hw_params *params)
> +{
> +	struct snd_interval *channels = hw_param_interval(params,
> +			SNDRV_PCM_HW_PARAM_CHANNELS);
> +
>   		if (params_channels(params) == 2 ||
>   				DMIC_CH(dmic_constraints) == 2)
> -			chan->min = chan->max = 2;
> +			channels->min = channels->max = 2;
>   		else
> -			chan->min = chan->max = 4;
> -	}
> -	/*
> -	 * The speaker on the SSP0 supports S16_LE and not S24_LE.
> -	 * thus changing the mask here
> -	 */
> -	if (!strcmp(be_dai_link->name, "SSP0-Codec"))
> -		snd_mask_set_format(fmt, SNDRV_PCM_FORMAT_S16_LE);
> +			channels->min = channels->max = 4;
>   
>   	return 0;
>   }
> @@ -400,20 +410,6 @@ static int kabylake_ssp0_hw_params(struct snd_pcm_substream *substream,
>   	int ret = 0, j;
>   
>   	for_each_rtd_codec_dais(rtd, j, codec_dai) {
> -		if (!strcmp(codec_dai->component->name, RT5514_DEV_NAME)) {
> -			ret = snd_soc_dai_set_tdm_slot(codec_dai, 0xF, 0, 8, 16);
> -			if (ret < 0) {
> -				dev_err(rtd->dev, "set TDM slot err:%d\n", ret);
> -				return ret;
> -			}
> -
> -			ret = snd_soc_dai_set_sysclk(codec_dai,
> -				RT5514_SCLK_S_MCLK, 24576000, SND_SOC_CLOCK_IN);
> -			if (ret < 0) {
> -				dev_err(rtd->dev, "set sysclk err: %d\n", ret);
> -				return ret;
> -			}
> -		}
>   		if (!strcmp(codec_dai->component->name, MAXIM_DEV0_NAME)) {
>   			ret = snd_soc_dai_set_tdm_slot(codec_dai, 0x30, 3, 8, 16);
>   			if (ret < 0) {
> @@ -433,10 +429,37 @@ static int kabylake_ssp0_hw_params(struct snd_pcm_substream *substream,
>   	return ret;
>   }
>   
> +static int kabylake_dmic01_hw_params(struct snd_pcm_substream *substream,
> +	struct snd_pcm_hw_params *params)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	int ret = 0;
> +
> +	ret = snd_soc_dai_set_tdm_slot(rtd->codec_dai, 0xF, 0, 8, 16);
> +	if (ret < 0) {
> +		dev_err(rtd->dev, "set TDM slot err:%d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = snd_soc_dai_set_sysclk(rtd->codec_dai,
> +		RT5514_SCLK_S_MCLK, 24576000, SND_SOC_CLOCK_IN);
> +	if (ret < 0) {
> +		dev_err(rtd->dev, "set sysclk err: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
>   static struct snd_soc_ops kabylake_ssp0_ops = {
>   	.hw_params = kabylake_ssp0_hw_params,
>   };
>   
> +static struct snd_soc_ops kabylake_dmic01_ops = {
> +	.hw_params = kabylake_dmic01_hw_params,
> +};
> +
> +
>   static const unsigned int channels_dmic[] = {
>   	4,
>   };
> @@ -507,14 +530,19 @@ SND_SOC_DAILINK_DEF(ssp0_pin,
>   SND_SOC_DAILINK_DEF(ssp0_codec,
>   	DAILINK_COMP_ARRAY(
>   	/* Left */ COMP_CODEC(MAXIM_DEV0_NAME, KBL_MAXIM_CODEC_DAI),
> -	/* Right */COMP_CODEC(MAXIM_DEV1_NAME, KBL_MAXIM_CODEC_DAI),
> -	/* dmic */ COMP_CODEC(RT5514_DEV_NAME, KBL_REALTEK_DMIC_CODEC_DAI)));
> +	/* Right */COMP_CODEC(MAXIM_DEV1_NAME, KBL_MAXIM_CODEC_DAI)));
>   
>   SND_SOC_DAILINK_DEF(ssp1_pin,
>   	DAILINK_COMP_ARRAY(COMP_CPU("SSP1 Pin")));
>   SND_SOC_DAILINK_DEF(ssp1_codec,
>   	DAILINK_COMP_ARRAY(COMP_CODEC(RT5663_DEV_NAME, KBL_REALTEK_CODEC_DAI)));
>   
> +SND_SOC_DAILINK_DEF(dmic01_pin,
> +	DAILINK_COMP_ARRAY(COMP_CPU("DMIC01 Pin")));
> +SND_SOC_DAILINK_DEF(dmic01_codec,
> +	DAILINK_COMP_ARRAY(
> +		COMP_CODEC(RT5514_DEV_NAME, KBL_REALTEK_DMIC_CODEC_DAI)));
> +
>   SND_SOC_DAILINK_DEF(idisp1_pin,
>   	DAILINK_COMP_ARRAY(COMP_CPU("iDisp1 Pin")));
>   SND_SOC_DAILINK_DEF(idisp1_codec,
> @@ -618,9 +646,8 @@ static struct snd_soc_dai_link kabylake_dais[] = {
>   			SND_SOC_DAIFMT_NB_NF |
>   			SND_SOC_DAIFMT_CBS_CFS,
>   		.ignore_pmdown_time = 1,
> -		.be_hw_params_fixup = kabylake_ssp_fixup,
> +		.be_hw_params_fixup = kabylake_ssp0_fixup,
>   		.dpcm_playback = 1,
> -		.dpcm_capture = 1,
>   		.ops = &kabylake_ssp0_ops,
>   		SND_SOC_DAILINK_REG(ssp0_pin, ssp0_codec, platform),
>   	},
> @@ -632,12 +659,25 @@ static struct snd_soc_dai_link kabylake_dais[] = {
>   		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
>   			SND_SOC_DAIFMT_CBS_CFS,
>   		.ignore_pmdown_time = 1,
> -		.be_hw_params_fixup = kabylake_ssp_fixup,
> +		.be_hw_params_fixup = kabylake_ssp1_fixup,
>   		.ops = &kabylake_rt5663_ops,
>   		.dpcm_playback = 1,
>   		.dpcm_capture = 1,
>   		SND_SOC_DAILINK_REG(ssp1_pin, ssp1_codec, platform),
>   	},
> +	{
> +		.name = "dmic01",
> +		.id = 2,
> +		.no_pcm = 1,
> +		.dai_fmt = SND_SOC_DAIFMT_DSP_B |
> +			SND_SOC_DAIFMT_NB_NF |
> +			SND_SOC_DAIFMT_CBS_CFS,
> +		.ignore_pmdown_time = 1,
> +		.be_hw_params_fixup = kabylake_dmic_fixup,
> +		.dpcm_capture = 1,
> +		.ops = &kabylake_dmic01_ops,
> +		SND_SOC_DAILINK_REG(dmic01_pin, dmic01_codec, platform),
> +	},
>   	{
>   		.name = "iDisp1",
>   		.id = 3,
> 
> base-commit: a4f6fc98cd2fa1774bcaeb248c67156ef9402a56
> 
