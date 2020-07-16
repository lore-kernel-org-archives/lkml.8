Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A37C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 17:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA4842071B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 17:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbgGPRtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 13:49:14 -0400
Received: from mga01.intel.com ([192.55.52.88]:49940 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbgGPRtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 13:49:14 -0400
IronPort-SDR: DyGwkKbffdpAv+EvDuzi2JN2b/7zSUGIfRBd3qkUsoXSWY3rHUy+ZuMp/mFavuvDpYxAeNokC9
 2jcApfQKHleQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="167588403"
X-IronPort-AV: E=Sophos;i="5.75,360,1589266800"; 
   d="scan'208";a="167588403"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 10:49:13 -0700
IronPort-SDR: +FJMnqbi0e5opvXc/QNBLvyCHwRoCRa12NBi7JzCh7a/livn8ib1kDpO+9d2btffBpmf85sew7
 Cy+xleFVaiug==
X-IronPort-AV: E=Sophos;i="5.75,360,1589266800"; 
   d="scan'208";a="486691924"
Received: from unknown (HELO [10.254.114.13]) ([10.254.114.13])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 10:49:12 -0700
Subject: Re: [PATCH v6] ASoC: Intel: kbl_rt5663_rt5514_max98927: Fix
 kabylake_ssp_fixup function
To:     Harsha Priya <harshapriya.n@intel.com>,
        alsa-devel@alsa-project.org, broonie@kernel.org
Cc:     lma@semihalf.com, yang.jie@linux.intel.com,
        liam.r.girdwood@linux.intel.com, rad@semihalf.com,
        zwisler@google.com, linux-kernel@vger.kernel.org,
        sathya.prakash.m.r@intel.com, brndt@google.com, mw@semihalf.com,
        levinale@chromium.org,
        Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>
References: <1594919637-31460-1-git-send-email-harshapriya.n@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <48a6db3a-2aef-cfca-19ec-7825573fc3da@linux.intel.com>
Date:   Thu, 16 Jul 2020 12:49:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1594919637-31460-1-git-send-email-harshapriya.n@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> index 584e4f9cedc2..b261b1c466a8 100644
> --- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> +++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> @@ -379,22 +379,30 @@ static int kabylake_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
>   	struct snd_interval *chan = hw_param_interval(params,
>   			SNDRV_PCM_HW_PARAM_CHANNELS);
>   	struct snd_mask *fmt = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
> -	struct snd_soc_dpcm *dpcm = container_of(
> -			params, struct snd_soc_dpcm, hw_params);
> -	struct snd_soc_dai_link *fe_dai_link = dpcm->fe->dai_link;
> -	struct snd_soc_dai_link *be_dai_link = dpcm->be->dai_link;
> +	struct snd_soc_dpcm *dpcm, *rtd_dpcm;
> +
> +	/*
> +	 * This macro will be called for playback stream
> +	 */
> +	for_each_dpcm_fe(rtd, SNDRV_PCM_STREAM_PLAYBACK, dpcm)
> +		rtd_dpcm = dpcm;
> +	/*
> +	 * This macro will be called for capture stream
> +	 */
> +	for_each_dpcm_fe(rtd, SNDRV_PCM_STREAM_CAPTURE, dpcm)
> +		rtd_dpcm = dpcm;

is the assumption that both of those loops return the same pointer?
If yes, why not stop for the first non-NULL dpcm value?
Also wondering if you are using a loop because there's no other helper 
available?

>   
>   	/*
>   	 * The ADSP will convert the FE rate to 48k, stereo, 24 bit
>   	 */
> -	if (!strcmp(fe_dai_link->name, "Kbl Audio Port") ||
> -	    !strcmp(fe_dai_link->name, "Kbl Audio Headset Playback") ||
> -	    !strcmp(fe_dai_link->name, "Kbl Audio Capture Port")) {
> +	if (!strcmp(rtd_dpcm->fe->dai_link->name, "Kbl Audio Port") ||
> +	    !strcmp(rtd_dpcm->fe->dai_link->name, "Kbl Audio Headset Playback") ||
> +	    !strcmp(rtd_dpcm->fe->dai_link->name, "Kbl Audio Capture Port")) {
>   		rate->min = rate->max = 48000;
>   		chan->min = chan->max = 2;
>   		snd_mask_none(fmt);
>   		snd_mask_set_format(fmt, SNDRV_PCM_FORMAT_S24_LE);
> -	} else if (!strcmp(fe_dai_link->name, "Kbl Audio DMIC cap")) {
> +	} else if (!strcmp(rtd_dpcm->fe->dai_link->name, "Kbl Audio DMIC cap")) {
>   		if (params_channels(params) == 2 ||
>   				DMIC_CH(dmic_constraints) == 2)
>   			chan->min = chan->max = 2;
> @@ -405,7 +413,7 @@ static int kabylake_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
>   	 * The speaker on the SSP0 supports S16_LE and not S24_LE.
>   	 * thus changing the mask here
>   	 */
> -	if (!strcmp(be_dai_link->name, "SSP0-Codec"))
> +	if (!strcmp(rtd_dpcm->be->dai_link->name, "SSP0-Codec"))
>   		snd_mask_set_format(fmt, SNDRV_PCM_FORMAT_S16_LE);
>   
>   	return 0;
> 
