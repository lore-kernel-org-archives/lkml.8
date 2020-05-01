Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82122C35280
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 633C72137B
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgEAUQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 16:16:38 -0400
Received: from mga17.intel.com ([192.55.52.151]:39412 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgEAUQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 16:16:38 -0400
IronPort-SDR: JCnf0JR6QjquQtyWCvLzQybgHnCl2d0RNKxW2ix3/l1F5v9oDrFlOYPf28b4cRw559gxgBz4N3
 fscpww/woeAg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2020 13:16:37 -0700
IronPort-SDR: 1GzbZ0PLz8ewGXbhrI0UK885C79CRjvVf7gZORcwqO/LIVMBQf1s9CM8kxn22edyQqKkH8TQnh
 F4Um4u0bLAMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,340,1583222400"; 
   d="scan'208";a="276914737"
Received: from srodrig5-mobl2.amr.corp.intel.com (HELO [10.254.111.158]) ([10.254.111.158])
  by orsmga002.jf.intel.com with ESMTP; 01 May 2020 13:16:35 -0700
Subject: Re: [PATCH V2] ASoC: Intel: boards: Use FS as nau8825 sysclk in
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
References: <20200501193141.30293-1-rad@semihalf.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <3ad44b75-387f-da75-d7b2-3a16ed00550c@linux.intel.com>
Date:   Fri, 1 May 2020 15:16:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200501193141.30293-1-rad@semihalf.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/1/20 2:31 PM, Radoslaw Biernacki wrote:
> This single fix address two issues on machines with nau88125:
> 1) Audio distortion, due to lack of required clock rate on MCLK line
> 2) Loud audible "pops" on headphones if there is no sysclk during nau8825
>     playback power up sequence
> 
> Explanation for:
> 1) Due to Skylake HW limitation, MCLK pin can only output 24MHz clk
>     rate (it can be only connected to XTAL parent clk). The BCLK pin
>     can be driven by dividers and therefore FW is able to set it to rate
>     required by chosen audio format. According to nau8825 datasheet, 256*FS
>     sysclk gives the best audio quality and the only way to achieve this
>     (taking into account the above limitations) its to regenerate the MCLK
>     from BCLK on nau8825 side by FFL. Without required clk rate, audio is
>     distorted by added harmonics.

The BCLK is going to be a multiple of 50 * Fs due to clocking 
restrictions. Can the codec regenerate a good-enough sysclk from this?
> 
> 2) Currently Skylake does not output MCLK/FS when the back-end DAI op
>     hw_param is called, so we cannot switch to MCLK/FS in hw_param.  This
>     patch reduces pop by letting nau8825 keep using its internal VCO clock
>     during widget power up sequence, until SNDRV_PCM_TRIGGER_START when
>     MCLK/FS is available. Once device resumes, the system will only enable
>     power sequence for playback without doing hardware parameter, audio
>     format, and PLL configure. In the mean time, the jack detecion sequence
>     has changed PLL parameters and switched to internal clock. Thus, the
>     playback signal distorted without correct PLL parameters.  That is why
>     we need to configure the PLL again in SNDRV_PCM_TRIGGER_RESUME case.

IIRC the FS can be controlled with the clk_ api with the Skylake driver, 
as done for some KBL platforms. Or is this not supported by the firmware 
used by this machine?

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
> +		if (ret < 0) {
> +			dev_err(codec_dai->dev, "can't set FS clock %d\n", ret);
> +			break;
> +		}
> +		ret = snd_soc_dai_set_pll(codec_dai, 0, 0, runtime->rate,
> +					  runtime->rate * 256);
> +		if (ret < 0)
> +			dev_err(codec_dai->dev, "can't set FLL: %d\n", ret);
> +		break;
> +	case SNDRV_PCM_TRIGGER_RESUME:
> +		ret = snd_soc_dai_set_pll(codec_dai, 0, 0, runtime->rate,
> +					  runtime->rate * 256);
> +		if (ret < 0)
> +			dev_err(codec_dai->dev, "can't set FLL: %d\n", ret);
> +		msleep(20);

is there a reason why you'd need a msleep for resume and not for start?
