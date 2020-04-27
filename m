Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B07C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 10:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1B03206A4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 10:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgD0K6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 06:58:53 -0400
Received: from mga06.intel.com ([134.134.136.31]:44601 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbgD0K6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 06:58:52 -0400
IronPort-SDR: plcXwN17sxvYU5WS5NdkwGaj0HvPnS37X1GMQlOmT2dEVD7MTvcxJh5vb8j64rAJD9M0HjqTG2
 y0IRKY0xJWHQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 03:58:51 -0700
IronPort-SDR: t2AoJtXKtF6iKW8T6Ypc8cCdIq9cDAiQUXNV6d208AOSMaqN8PO8/JLtN1sqKUod5leSmTxaCm
 jYYAarts2AGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,323,1583222400"; 
   d="scan'208";a="302340875"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.213.7.127]) ([10.213.7.127])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Apr 2020 03:58:48 -0700
Subject: Re: [PATCH 3/3] ASoC: broadwell: channel constraint support
To:     Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Ben Zhang <benzh@chromium.org>,
        Mac Chiang <mac.chiang@intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-kernel@vger.kernel.org
References: <1587976638-29806-1-git-send-email-brent.lu@intel.com>
 <1587976638-29806-4-git-send-email-brent.lu@intel.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <51b8fa84-5835-74e9-703f-30d608ace736@intel.com>
Date:   Mon, 27 Apr 2020 12:58:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1587976638-29806-4-git-send-email-brent.lu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-27 10:37, Brent Lu wrote:
> BDW boards using this machine driver supports only stereo capture and
> playback. Implement a constraint to enforce it.
> 

Title for the overall series fits better than the one chosen for actual 
patches. "channel constraint support" is misleading. Constraints are 
added or removed but certainly not supported.

> Signed-off-by: Brent Lu <brent.lu@intel.com>
> ---
>   sound/soc/intel/boards/broadwell.c | 33 +++++++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
> 
> diff --git a/sound/soc/intel/boards/broadwell.c b/sound/soc/intel/boards/broadwell.c
> index f9a8336..09347f2 100644
> --- a/sound/soc/intel/boards/broadwell.c
> +++ b/sound/soc/intel/boards/broadwell.c
> @@ -19,6 +19,8 @@
>   
>   #include "../../codecs/rt286.h"
>   
> +#define DUAL_CHANNEL 2
> +

Remove, we need not additional too-obvious macro. One could argue 
'STEREO' is a better choice too.

>   static struct snd_soc_jack broadwell_headset;
>   /* Headset jack detection DAPM pins */
>   static struct snd_soc_jack_pin broadwell_headset_pins[] = {
> @@ -143,6 +145,36 @@ static int broadwell_rtd_init(struct snd_soc_pcm_runtime *rtd)
>   }
>   #endif
>   
> +static const unsigned int channels[] = {
> +	DUAL_CHANNEL,

Inline as stated above.

> +};
> +
> +static const struct snd_pcm_hw_constraint_list constraints_channels = {
> +	.count = ARRAY_SIZE(channels),
> +	.list = channels,
> +	.mask = 0,
> +};
> +
> +static int broadwell_fe_startup(struct snd_pcm_substream *substream)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +
> +	/*
> +	 * On this platform for PCM device we support,
> +	 * stereo audio
> +	 */
> +

Sometimes you add a newline add and before, while other times just one, 
before the comment. Please streamline the format across all patches in 
the series. Comment can be more strict too
	/* Board supports stereo configuration only */

> +	runtime->hw.channels_max = DUAL_CHANNEL;

Inline. If you really want to avoid using 2, make use of 0-entry of 
constrains_channels array.

> +	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
> +					   &constraints_channels);
> +
> +	return 0;
> +}
> +
> +static const struct snd_soc_ops broadwell_fe_ops = {
> +	.startup = broadwell_fe_startup,
> +};
> +
>   SND_SOC_DAILINK_DEF(system,
>   	DAILINK_COMP_ARRAY(COMP_CPU("System Pin")));
>   
> @@ -180,6 +212,7 @@ static struct snd_soc_dai_link broadwell_rt286_dais[] = {
>   		.init = broadwell_rtd_init,
>   #endif
>   		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
> +		.ops = &broadwell_fe_ops,
>   		.dpcm_playback = 1,
>   		.dpcm_capture = 1,
>   		SND_SOC_DAILINK_REG(system, dummy, platform),
> 
