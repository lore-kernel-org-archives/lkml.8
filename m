Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9910DC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55A9920732
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbgIHU7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:59:46 -0400
Received: from mga07.intel.com ([134.134.136.100]:50044 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbgIHU7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 16:59:44 -0400
IronPort-SDR: yZeAniWVEx7njJKXmSX/giRFOck3OuhhcdWjDzjpgywznAFAjZ+zNNKhZT84GV9E3v+1uFPJFA
 JqQ3mzqCRofw==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="222430064"
X-IronPort-AV: E=Sophos;i="5.76,407,1592895600"; 
   d="scan'208";a="222430064"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 13:59:43 -0700
IronPort-SDR: y6hZDRdeztSDI9qEbOW7puJWdEwvMxonv1KDJltNB5uCftszS+MGKmKHSNxRlJQ8kXrPsfdSYF
 rHqN8Ota+BTQ==
X-IronPort-AV: E=Sophos;i="5.76,407,1592895600"; 
   d="scan'208";a="504506013"
Received: from mschen-mobl2.amr.corp.intel.com (HELO [10.213.174.122]) ([10.213.174.122])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 13:59:42 -0700
Subject: Re: [PATCH V3] ASoC: Intel: boards: Use FS as nau8825 sysclk in
 nau88125_* machine
To:     Radoslaw Biernacki <rad@semihalf.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Lech Betlej <Lech.Betlej@intel.com>, alsa-devel@alsa-project.org,
        Todd Broch <tbroch@google.com>,
        Harshapriya <harshapriya.n@intel.com>,
        John Hsu <KCHSU0@nuvoton.com>, linux-kernel@vger.kernel.org,
        michal.sienkiewicz@intel.com, Ben Zhang <benzh@chromium.org>,
        Mac Chiang <mac.chiang@intel.com>,
        Yong Zhi <yong.zhi@intel.com>, Marcin Wojtas <mw@semihalf.com>,
        Vamshi Krishna <vamshi.krishna.gopal@intel.com>,
        Alex Levin <levinale@google.com>
References: <20200908200314.22771-1-rad@semihalf.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <50db252a-1274-f681-d5e7-e7fba839c0ee@linux.intel.com>
Date:   Tue, 8 Sep 2020 15:59:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908200314.22771-1-rad@semihalf.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I couldn't resist adding three more comments to improve further:

> -static int skylake_nau8825_hw_params(struct snd_pcm_substream *substream,
> -	struct snd_pcm_hw_params *params)
> +static int skylake_nau8825_trigger(struct snd_pcm_substream *substream, int cmd)
>   {
>   	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_pcm_runtime *runtime = substream->runtime;
>   	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
> -	int ret;
> -
> -	ret = snd_soc_dai_set_sysclk(codec_dai,
> -			NAU8825_CLK_MCLK, 24000000, SND_SOC_CLOCK_IN);
> +	int ret = 0;
>   
> -	if (ret < 0)
> -		dev_err(rtd->dev, "snd_soc_dai_set_sysclk err = %d\n", ret);
> +	switch (cmd) {
> +	case SNDRV_PCM_TRIGGER_START:
> +		ret = snd_soc_dai_set_sysclk(codec_dai, NAU8825_CLK_FLL_FS, 0,
> +					     SND_SOC_CLOCK_IN);

Maybe a simple comment to explain what this does?

> +		if (ret < 0) {
> +			dev_err(codec_dai->dev, "can't set FS clock %d\n", ret);
> +			break;
> +		}
> +		ret = snd_soc_dai_set_pll(codec_dai, 0, 0, runtime->rate,
> +					  runtime->rate * 256);
> +		if (ret < 0)
> +			dev_err(codec_dai->dev, "can't set FLL: %d\n", ret);
> +		break;

You could replace this by a /* fallthrough */ statement?

> +	case SNDRV_PCM_TRIGGER_RESUME:
> +		ret = snd_soc_dai_set_pll(codec_dai, 0, 0, runtime->rate,
> +					  runtime->rate * 256);
> +		if (ret < 0)
> +			dev_err(codec_dai->dev, "can't set FLL: %d\n", ret);
> +		break;
> +	}

> +static int __maybe_unused skylake_nau8825_resume_post(struct snd_soc_card *card)
> +{
> +	struct snd_soc_dai *codec_dai;
> +
> +	codec_dai = snd_soc_card_get_codec_dai(card, SKL_NUVOTON_CODEC_DAI);
> +	if (!codec_dai) {
> +		dev_err(card->dev, "Codec dai not found\n");
> +		return -EIO;
> +	}
> +
> +	dev_dbg(codec_dai->dev, "playback_active:%d playback_widget->active:%d codec_dai->rate:%d\n",
> +		codec_dai->stream_active[SNDRV_PCM_STREAM_PLAYBACK],
> +		codec_dai->playback_widget->active,
> +		codec_dai->rate);
> +
> +	if (codec_dai->stream_active[SNDRV_PCM_STREAM_PLAYBACK] &&
> +	    codec_dai->playback_widget->active)
> +		snd_soc_dai_set_sysclk(codec_dai, NAU8825_CLK_FLL_FS, 0,
> +				       SND_SOC_CLOCK_IN);

And that part is also worthy of a comment, e.g. why not do this as part 
of the TRIGGER_RESUME and why only for playback?


> --- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
> +++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c

same comments for this other machine driver.

