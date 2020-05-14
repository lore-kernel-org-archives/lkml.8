Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B97C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 464DE2065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgENMrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 08:47:11 -0400
Received: from mga17.intel.com ([192.55.52.151]:8972 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgENMrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 08:47:10 -0400
IronPort-SDR: VOzoPN31QcvJx73rKnjaX+ye2l/qFwLksJQpaLbAdlTUlFhIwPCDlmz2VwpFkOmDZR/igvhj3i
 uEuj/QF8yGfg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 05:47:09 -0700
IronPort-SDR: av5Re4jD3u5L9XXPeZB1/hAQvfb+CJci9mOlMSaJ00Dzx2Wy4tlhk/hoZ52eB/2otlGoCaoyqv
 wtUvbIlVDLsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,391,1583222400"; 
   d="scan'208";a="262824607"
Received: from dpschroe-mobl1.amr.corp.intel.com (HELO [10.254.66.46]) ([10.254.66.46])
  by orsmga003.jf.intel.com with ESMTP; 14 May 2020 05:47:08 -0700
Subject: Re: [PATCH] ASoC: Intel: kbl_rt5663_rt5514_max98927: Split
 be_hw_params_fixup function
To:     Lukasz Majczak <lma@semihalf.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, Radoslaw Biernacki <rad@semihalf.com>,
        Ross Zwisler <zwisler@google.com>,
        linux-kernel@vger.kernel.org, Bob Brandt <brndt@google.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Alex Levin <levinale@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
References: <20200513192020.544928-1-lma@semihalf.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <52ab4557-e551-ce20-247c-681c2a0d1ad1@linux.intel.com>
Date:   Thu, 14 May 2020 07:47:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513192020.544928-1-lma@semihalf.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/13/20 2:20 PM, Lukasz Majczak wrote:
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

This looks like a nice/welcome change, we've had these unexplained 
crashes on KBL since 4.19 (reported by Guenter and me). I thought they 
were topology related.

If indeed this fixes the issue, it might be worth applying in to all 
stable releases?

Since we have the same code structure for the other kbl drivers, would 
it also make sense to apply the same fixes there:

kbl_da7219_max98927.c:  struct snd_soc_dpcm *dpcm = container_of(
kbl_rt5663_max98927.c:  struct snd_soc_dpcm *dpcm = container_of(


> 
> Signed-off-by: Lukasz Majczak <lma@semihalf.com>
> ---
>   .../intel/boards/kbl_rt5663_rt5514_max98927.c | 68 +++++++++++--------
>   1 file changed, 39 insertions(+), 29 deletions(-)
> 
> diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> index 1b1f8d7a4ea3..2e0ae724122c 100644
> --- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> +++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> @@ -328,46 +328,55 @@ static const struct snd_soc_ops kabylake_rt5663_fe_ops = {
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
> -		if (params_channels(params) == 2 ||
> -				DMIC_CH(dmic_constraints) == 2)
> -			chan->min = chan->max = 2;
> -		else
> -			chan->min = chan->max = 4;
> -	}
> -	/*
> -	 * The speaker on the SSP0 supports S16_LE and not S24_LE.
> -	 * thus changing the mask here
> -	 */
> -	if (!strcmp(be_dai_link->name, "SSP0-Codec"))
> -		snd_mask_set_format(fmt, SNDRV_PCM_FORMAT_S16_LE);
>   
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
>   	return 0;
>   }
>   
> +static int kabylake_ssp1_fixup(struct snd_soc_pcm_runtime *rtd,
> +	struct snd_pcm_hw_params *params)
> +{
> +
> +	kabylake_ssp_fixup(rtd, params, SNDRV_PCM_FORMAT_S24_LE);
> +	return 0;
> +}
> +
> +static int kabylake_dmic_cap_fixup(struct snd_soc_pcm_runtime *rtd,
> +	struct snd_pcm_hw_params *params)
> +{
> +	struct snd_interval *channels = hw_param_interval(params,
> +			SNDRV_PCM_HW_PARAM_CHANNELS);
> +
> +	if (params_channels(params) == 2 ||
> +			DMIC_CH(dmic_constraints) == 2)
> +		channels->min = channels->max = 2;
> +	else
> +		channels->min = channels->max = 4;
> +
> +	return 0;
> +}
>   static int kabylake_rt5663_hw_params(struct snd_pcm_substream *substream,
>   	struct snd_pcm_hw_params *params)
>   {
> @@ -582,6 +591,7 @@ static struct snd_soc_dai_link kabylake_dais[] = {
>   		.dpcm_capture = 1,
>   		.nonatomic = 1,
>   		.dynamic = 1,
> +		.be_hw_params_fixup = kabylake_dmic_cap_fixup,
>   		.ops = &kabylake_dmic_ops,
>   		SND_SOC_DAILINK_REG(dmic, dummy, platform),
>   	},
> @@ -618,7 +628,7 @@ static struct snd_soc_dai_link kabylake_dais[] = {
>   			SND_SOC_DAIFMT_NB_NF |
>   			SND_SOC_DAIFMT_CBS_CFS,
>   		.ignore_pmdown_time = 1,
> -		.be_hw_params_fixup = kabylake_ssp_fixup,
> +		.be_hw_params_fixup = kabylake_ssp0_fixup,
>   		.dpcm_playback = 1,
>   		.dpcm_capture = 1,
>   		.ops = &kabylake_ssp0_ops,
> @@ -632,7 +642,7 @@ static struct snd_soc_dai_link kabylake_dais[] = {
>   		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
>   			SND_SOC_DAIFMT_CBS_CFS,
>   		.ignore_pmdown_time = 1,
> -		.be_hw_params_fixup = kabylake_ssp_fixup,
> +		.be_hw_params_fixup = kabylake_ssp1_fixup,
>   		.ops = &kabylake_rt5663_ops,
>   		.dpcm_playback = 1,
>   		.dpcm_capture = 1,
> 
