Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FA0C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29A3D20720
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbgGFPlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 11:41:49 -0400
Received: from mga03.intel.com ([134.134.136.65]:51569 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729197AbgGFPlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 11:41:49 -0400
IronPort-SDR: vv1X7PVlbeKfqyLy7laK+6GyqVqLvMvtXVaOPA4QFd0nadVwLHC4WfZkCwiu/f5F9aZfaBPz54
 QCEitdglni2w==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="147442225"
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="147442225"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 08:41:49 -0700
IronPort-SDR: AS0HeRsqQZt0NvwtBpVT084SnSxbfpTRzLF4kAisPpb/x+Zo9438wtNF1Cuj6SmOBZvJiBxi/V
 RbpnIUrH4/lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="313997880"
Received: from aislam-mobl1.amr.corp.intel.com ([10.212.167.133])
  by orsmga008.jf.intel.com with ESMTP; 06 Jul 2020 08:41:47 -0700
Subject: Re: [PATCH v4] ASoC: Intel: kbl_rt5663_rt5514_max98927: Fix
 kabylake_ssp_fixup function
To:     Lukasz Majczak <lma@semihalf.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Harsha Priya <harshapriya.n@intel.com>
Cc:     alsa-devel@alsa-project.org, Radoslaw Biernacki <rad@semihalf.com>,
        Ross Zwisler <zwisler@google.com>,
        linux-kernel@vger.kernel.org,
        Sathya Prakash <sathya.prakash.m.r@intel.com>,
        Bob Brandt <brndt@google.com>, Marcin Wojtas <mw@semihalf.com>,
        Alex Levin <levinale@chromium.org>,
        Gopal Vamshi Krishna <vamshi.krishna.gopal@intel.com>
References: <20200521162518.1809995-1-lma@semihalf.com>
 <20200703121650.547944-1-lma@semihalf.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <5dfc3678-0f12-7823-2571-ab0dff250d15@linux.intel.com>
Date:   Mon, 6 Jul 2020 10:41:47 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200703121650.547944-1-lma@semihalf.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/20 7:16 AM, Lukasz Majczak wrote:
> Fix kabylake_ssp_fixup function to distinguish codecs DAIs by names,
> as current approach, leads to crash while trying to get snd_soc_dpcm with
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
> v1 -> v2:
> - Extract dmic from SSP0 as every BE should have own fixup function.
> v2 -> v3:
> - Restore naming in the dapm route table to not confuse with other
> drivers
> - Fixed indentations
> v3 -> v4:
> - Updated code and commit description according to
> solution proposed by Harsha

Looks good Lukasz but you need to move the information on changes below 
the --- marker (~4 lines below).

> 
> Signed-off-by: Lukasz Majczak <lma@semihalf.com>
> Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
> ---
>   .../intel/boards/kbl_rt5663_rt5514_max98927.c | 28 ++++++++-----------
>   1 file changed, 12 insertions(+), 16 deletions(-)
> 
> diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> index b34cf6cf11395..df454de40739a 100644
> --- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> +++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> @@ -333,36 +333,32 @@ static int kabylake_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
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
> +	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
>   
>   	/*
>   	 * The ADSP will convert the FE rate to 48k, stereo, 24 bit
>   	 */
> -	if (!strcmp(fe_dai_link->name, "Kbl Audio Port") ||
> -	    !strcmp(fe_dai_link->name, "Kbl Audio Headset Playback") ||
> -	    !strcmp(fe_dai_link->name, "Kbl Audio Capture Port")) {
> +
> +	if (!strcmp(codec_dai->name, KBL_REALTEK_DMIC_CODEC_DAI)) {
> +		if (params_channels(params) == 2 ||
> +			DMIC_CH(dmic_constraints) == 2)
> +			channels->min = channels->max = 2;
> +		else
> +			channels->min = channels->max = 4;
> +	} else {
>   		rate->min = rate->max = 48000;
> -		chan->min = chan->max = 2;
> +		channels->min = channels->max = 2;
>   		snd_mask_none(fmt);
>   		snd_mask_set_format(fmt, SNDRV_PCM_FORMAT_S24_LE);
> -	} else if (!strcmp(fe_dai_link->name, "Kbl Audio DMIC cap")) {
> -		if (params_channels(params) == 2 ||
> -				DMIC_CH(dmic_constraints) == 2)
> -			chan->min = chan->max = 2;
> -		else
> -			chan->min = chan->max = 4;
>   	}
>   	/*
>   	 * The speaker on the SSP0 supports S16_LE and not S24_LE.
>   	 * thus changing the mask here
>   	 */
> -	if (!strcmp(be_dai_link->name, "SSP0-Codec"))
> +	if (!strcmp(codec_dai->name, KBL_MAXIM_CODEC_DAI))
>   		snd_mask_set_format(fmt, SNDRV_PCM_FORMAT_S16_LE);
>   
>   	return 0;
> 

