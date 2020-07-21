Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D11C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 21:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 456BF20717
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 21:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731365AbgGUVcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 17:32:24 -0400
Received: from mga18.intel.com ([134.134.136.126]:62112 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726658AbgGUVcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 17:32:22 -0400
IronPort-SDR: k65/b9l/Mk6bvJLPgRCvt3tSTJj8GpUEEwd1fNzk3XjLOa4swm71FMGgtaRPW9A8FtPKJTjheg
 B13q11vpJr1w==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="137737631"
X-IronPort-AV: E=Sophos;i="5.75,380,1589266800"; 
   d="scan'208";a="137737631"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 14:32:21 -0700
IronPort-SDR: ybNbB6Dp/FbRgWS2I2DqKRYKfFdSSNj7Qg2UfmHO8E9YpeoxpHhEBrXFDuOnGvyxQ6SYg2pGly
 lLywEmsGCTug==
X-IronPort-AV: E=Sophos;i="5.75,380,1589266800"; 
   d="scan'208";a="462222006"
Received: from mtchavar-mobl.amr.corp.intel.com (HELO [10.254.78.149]) ([10.254.78.149])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 14:32:20 -0700
Subject: Re: [PATCH v7] ASoC: Intel: kbl_rt5663_rt5514_max98927: Fix
 kabylake_ssp_fixup function
To:     Harsha Priya <harshapriya.n@intel.com>,
        alsa-devel@alsa-project.org, broonie@kernel.org
Cc:     lma@semihalf.com, yang.jie@linux.intel.com,
        liam.r.girdwood@linux.intel.com, rad@semihalf.com,
        zwisler@google.com, linux-kernel@vger.kernel.org,
        sathya.prakash.m.r@intel.com, brndt@google.com, mw@semihalf.com,
        levinale@chromium.org,
        Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>
References: <1595365649-8019-1-git-send-email-harshapriya.n@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <d72ea889-9820-880d-0207-6d2f0dc23bcc@linux.intel.com>
Date:   Tue, 21 Jul 2020 16:32:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1595365649-8019-1-git-send-email-harshapriya.n@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Harsha,
this looks mostly good to me, only have a couple of nit-picks below.
Thanks!

> kabylake_ssp_fixup function uses snd_soc_dpcm to identify the codecs DAIs.
> The hw parameters are changed based on the codec DAI,
> the stream is intended for. The earlier approach to get
> snd_soc_dpcm was using container_of() macro on snd_pcm_hw_params.
> The structures have been modified over time and snd_soc_dpcm does
> not have snd_pcm_hw_params as a reference but as a copy.
> This causes the current driver to crash when used.
> This patch changes the way snd_soc_dpcm is extracted.
> The snd_soc_pcm_runtime holds 2 dpcm
> instances (one for playback and one for capture).
> The 2 codecs on this SSP are dmic and speakers.
> One is for capture and one is for playback respectively.
> Based on the direction of the stream,
> the snd_soc_dpcm is extracted from the snd_soc_pcm_runtime structure.
> Tested for all use cases of the driver.

Maybe reformat a bit and add newlines, this is difficult to read.

> Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
> Signed-off-by: Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>
> Tested-by: Lukasz Majczak <lma@semihalf.com>

> diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> index 584e4f9cedc2..9f4b949cc39c 100644
> --- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> +++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> @@ -379,22 +379,42 @@ static int kabylake_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
>   	struct snd_interval *chan = hw_param_interval(params,
>   			SNDRV_PCM_HW_PARAM_CHANNELS);
>   	struct snd_mask *fmt = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
> -	struct snd_soc_dpcm *dpcm = container_of(
> -			params, struct snd_soc_dpcm, hw_params);
> -	struct snd_soc_dai_link *fe_dai_link = dpcm->fe->dai_link;
> -	struct snd_soc_dai_link *be_dai_link = dpcm->be->dai_link;
> +	struct snd_soc_dpcm *dpcm, *rtd_dpcm = NULL;

The idea of initializing was also to test before dereferencing this 
pointer. Without the test, this is somewhat useless, tools may still 
complain about dereferencing a NULL pointer?

> +
> +	/*
> +	 * The following loop will be called only for playback stream
> +	 * In this platform, there is only one playback device on every SSP
> +	 */
> +	for_each_dpcm_fe(rtd, SNDRV_PCM_STREAM_PLAYBACK, dpcm) {
> +		rtd_dpcm = dpcm;
> +		break;
> +	}
> +
> +	/*
> +	 * This following loop will be called only for capture stream
> +	 * In this platform, there is only one capture device on every SSP
> +	 */
> +	for_each_dpcm_fe(rtd, SNDRV_PCM_STREAM_CAPTURE, dpcm) {
> +		rtd_dpcm = dpcm;
> +		break;
> +	}

add if (!rtd_dpcm) return -EINVAL here?

> +	/*
> +	 * The above 2 loops are mutually exclusive based on the strem direction,

typo: stream

> +	 * thus rtd_dpcm variable will never be overwritten
> +	 */

