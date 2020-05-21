Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CA5C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 16:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A71B720826
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 16:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbgEUQcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 12:32:31 -0400
Received: from mga07.intel.com ([134.134.136.100]:19996 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726938AbgEUQc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 12:32:29 -0400
IronPort-SDR: FVnr8EENxCndTxyp3z72lBa1qmUiaSAlcjQ3fRifnq4YlHDgO0/pQ+4M6fcLUYprAMSFoqdMmG
 6N3kv84toBsQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 09:32:28 -0700
IronPort-SDR: RXLazYsH1pbpXyIUtm12IXZUbPqpKI479aw0yhJV5rReRQaAPpmmynHiOMPCKCTp/Ns1ZAP71L
 OskRImsJbdew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,418,1583222400"; 
   d="scan'208";a="254027709"
Received: from dsrao-mobl.amr.corp.intel.com (HELO [10.255.229.80]) ([10.255.229.80])
  by orsmga007.jf.intel.com with ESMTP; 21 May 2020 09:32:27 -0700
Subject: Re: [PATCH v3] ASoC: Intel: kbl_rt5663_rt5514_max98927: Split
 be_hw_params_fixup function
To:     Lukasz Majczak <lma@semihalf.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>
Cc:     Bob Brandt <brndt@google.com>, Alex Levin <levinale@chromium.org>,
        Ross Zwisler <zwisler@google.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Radoslaw Biernacki <rad@semihalf.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20200521162518.1809995-1-lma@semihalf.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <3c89e614-81f5-ba87-19a9-fbe9f5c73925@linux.intel.com>
Date:   Thu, 21 May 2020 11:32:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200521162518.1809995-1-lma@semihalf.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/21/20 11:25 AM, Lukasz Majczak wrote:
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
> v1 -> v2:
> - Extract dmic from SSP0 as every BE should have own fixup function.
> v2 -> v3:
> - Restore naming in the dapm route table to not confuse with other
> drivers
> - Fixed indentations

you need the changelog to be below the --- marker two lines down.

> 
> Signed-off-by: Lukasz Majczak <lma@semihalf.com>
> ---

[...]

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
>   static const unsigned int channels_dmic[] = {
>   	4,
>   };
> @@ -507,14 +528,19 @@ SND_SOC_DAILINK_DEF(ssp0_pin,
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
> @@ -618,9 +644,8 @@ static struct snd_soc_dai_link kabylake_dais[] = {
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
> @@ -632,12 +657,25 @@ static struct snd_soc_dai_link kabylake_dais[] = {
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

don't add a new dailink, this is not right.

>   	{
>   		.name = "iDisp1",
>   		.id = 3,
> 
> base-commit: a4f6fc98cd2fa1774bcaeb248c67156ef9402a56
> 
