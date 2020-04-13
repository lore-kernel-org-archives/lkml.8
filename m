Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F8AC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 10:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1EDE20753
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 10:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbgDMKrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 06:47:05 -0400
Received: from mga17.intel.com ([192.55.52.151]:27392 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727776AbgDMKrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 06:47:03 -0400
IronPort-SDR: eWyaVDbvZjQG7skr/aXffuFAzuV+pCra6EJTM5TiW3UovssO+o59KR/Cru9f4mZnscxYWH4YHE
 ZvrtVtnO7hGA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 03:47:02 -0700
IronPort-SDR: ayMz8icoKuu1Cou9MhiqAeFL4MrjUzbHqplQK9F8EJo6KijVa0uvvgu/BoL+PHlCTnE7p2iB+x
 OduldT/7UWAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,378,1580803200"; 
   d="scan'208";a="243507850"
Received: from ftehrig-mobl.amr.corp.intel.com (HELO [10.209.82.92]) ([10.209.82.92])
  by fmsmga007.fm.intel.com with ESMTP; 13 Apr 2020 03:47:00 -0700
Subject: Re: [PATCH v2] ASoC: bdw-rt5650: remove 3-channel capture support
To:     Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
Cc:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Ben Zhang <benzh@chromium.org>,
        Mac Chiang <mac.chiang@intel.com>,
        Mark Brown <broonie@kernel.org>
References: <1586766533-18557-1-git-send-email-brent.lu@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <9a484795-ea4a-e559-4ea9-3de24417ec9b@linux.intel.com>
Date:   Mon, 13 Apr 2020 05:18:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1586766533-18557-1-git-send-email-brent.lu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/13/20 3:28 AM, Brent Lu wrote:
> Implement a constrain to exclude 3-channel capture since only 2 and 4
> channel capture are supported on the platform.

That looks like an error caught by the ALSA conformance tool?

What are the odds that we have a similar issue with the other broadwell 
drivers which don't have a constraint on the number of channels either 
on their 'System PCM' dailink?

Thanks
-Pierre

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
