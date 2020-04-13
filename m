Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F085BC38A2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 08:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0C342073E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 08:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbgDMIYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 04:24:49 -0400
Received: from mga03.intel.com ([134.134.136.65]:39213 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727971AbgDMIYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 04:24:49 -0400
IronPort-SDR: R6mhYIUAu2mc7PssFRcMuzIlQkAVc0WmroHYGHRmi++ZYGJCa+OHm2me+TMJULnKG5vM+fBxhc
 yr153wpGQx+A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 01:24:48 -0700
IronPort-SDR: 89OuDTtVm7GFv4SzRRMrenZSTb2zYhZCJ/a2q2ZWqGGEak0vg31sUCDLb6kKpDrKjcybHD+WQC
 xQNibDVPwHgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,378,1580803200"; 
   d="scan'208";a="454141300"
Received: from keyon-x299.sh.intel.com (HELO [10.239.159.75]) ([10.239.159.75])
  by fmsmga006.fm.intel.com with ESMTP; 13 Apr 2020 01:24:44 -0700
Subject: Re: [PATCH] ASoC: bdw-rt5650: incorrect rate of PCM data
To:     Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Ben Zhang <benzh@chromium.org>,
        Mac Chiang <mac.chiang@intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-kernel@vger.kernel.org
References: <1586765358-18474-1-git-send-email-brent.lu@intel.com>
From:   Keyon Jie <yang.jie@linux.intel.com>
Message-ID: <751b03e3-c4de-cbcb-e1b6-dc6f3f572aab@linux.intel.com>
Date:   Mon, 13 Apr 2020 16:35:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1586765358-18474-1-git-send-email-brent.lu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/4/13 下午4:09, Brent Lu wrote:
> Implement a constrain to exclude 3-channel capture since only 2 and 4
> channel capture are supported on the platform.

The patch looks good to me, except that the subject seems unrelated? you 
are changing the channel number, not the sample rate?

Thanks,
~Keyon

> 
> Signed-off-by: Brent Lu <brent.lu@intel.com>
> ---
>   sound/soc/intel/boards/bdw-rt5650.c | 31 +++++++++++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
> 
> diff --git a/sound/soc/intel/boards/bdw-rt5650.c b/sound/soc/intel/boards/bdw-rt5650.c
> index af2f502..eedbdad 100644
> --- a/sound/soc/intel/boards/bdw-rt5650.c
> +++ b/sound/soc/intel/boards/bdw-rt5650.c
> @@ -83,6 +83,36 @@ static struct snd_soc_jack_pin mic_jack_pin = {
>   	.mask	= SND_JACK_MICROPHONE,
>   };
>   
> +static const unsigned int channels[] = {
> +	2, 4,
> +};
> +
> +static const struct snd_pcm_hw_constraint_list constraints_channels = {
> +	.count = ARRAY_SIZE(channels),
> +	.list = channels,
> +	.mask = 0,
> +};
> +
> +static int bdw_fe_startup(struct snd_pcm_substream *substream)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +
> +	/*
> +	 * On this platform for PCM device we support,
> +	 * 2 or 4 channel capture
> +	 */
> +	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
> +		snd_pcm_hw_constraint_list(runtime, 0,
> +					   SNDRV_PCM_HW_PARAM_CHANNELS,
> +					   &constraints_channels);
> +
> +	return 0;
> +}
> +
> +static const struct snd_soc_ops bdw_rt5650_fe_ops = {
> +	.startup = bdw_fe_startup,
> +};
> +
>   static int broadwell_ssp0_fixup(struct snd_soc_pcm_runtime *rtd,
>   			struct snd_pcm_hw_params *params)
>   {
> @@ -234,6 +264,7 @@ static struct snd_soc_dai_link bdw_rt5650_dais[] = {
>   		.name = "System PCM",
>   		.stream_name = "System Playback",
>   		.dynamic = 1,
> +		.ops = &bdw_rt5650_fe_ops,
>   #if !IS_ENABLED(CONFIG_SND_SOC_SOF_BROADWELL)
>   		.init = bdw_rt5650_rtd_init,
>   #endif
> 
