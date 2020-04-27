Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A505FC5519A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 10:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B8A9206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 10:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgD0K6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 06:58:46 -0400
Received: from mga04.intel.com ([192.55.52.120]:54245 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726504AbgD0K6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 06:58:46 -0400
IronPort-SDR: LKWNzK98fce8dozLNJEHY1hjMTOVgXWjQp093evzBgtQXVDXGCW+lSLHCtP5ZMtezzPAYcqWER
 tzXvRyT5wE9w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 03:58:45 -0700
IronPort-SDR: /VxuhP7/0fY2Rl+Xtnu7E/Iqt4QccWwkH0YPxd1SHVuRptIaVtx9bKCeRZBO98W066wv3Ml9tx
 v25cl6sXNh0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,323,1583222400"; 
   d="scan'208";a="302340862"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.213.7.127]) ([10.213.7.127])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Apr 2020 03:58:42 -0700
Subject: Re: [PATCH 2/3] ASoC: bdw-rt5650: channel constraint support
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
 <1587976638-29806-3-git-send-email-brent.lu@intel.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <dc30437d-440b-937b-910f-6876bbc7cf56@intel.com>
Date:   Mon, 27 Apr 2020 12:58:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1587976638-29806-3-git-send-email-brent.lu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-27 10:37, Brent Lu wrote:
> BDW boards using this machine driver supports only 2 or 4-channel capture.
> Implement a constraint to enforce it.
> 

What about playback configurations?

Title for the overall series fits better than the one chosen for actual 
patches. "channel constraint support" is misleading. Constraints are 
added or removed but certainly not supported.

> Signed-off-by: Brent Lu <brent.lu@intel.com>
> ---
>   sound/soc/intel/boards/bdw-rt5650.c | 34 ++++++++++++++++++++++++++++++++++
>   1 file changed, 34 insertions(+)
> 
> diff --git a/sound/soc/intel/boards/bdw-rt5650.c b/sound/soc/intel/boards/bdw-rt5650.c
> index af2f502..dd4f219 100644
> --- a/sound/soc/intel/boards/bdw-rt5650.c
> +++ b/sound/soc/intel/boards/bdw-rt5650.c
> @@ -21,6 +21,9 @@
>   
>   #include "../../codecs/rt5645.h"
>   
> +#define DUAL_CHANNEL 2
> +#define QUAD_CHANNEL 4
> +

Remove, we need not additional too-obvious macro. One could argue 
'STEREO' is a better choice for '2' channel configuration too.

>   struct bdw_rt5650_priv {
>   	struct gpio_desc *gpio_hp_en;
>   	struct snd_soc_component *component;
> @@ -162,6 +165,36 @@ static int bdw_rt5650_rtd_init(struct snd_soc_pcm_runtime *rtd)
>   }
>   #endif
>   
> +static const unsigned int channels[] = {
> +	DUAL_CHANNEL, QUAD_CHANNEL,

Inline as stated above.

> +};
> +
> +static const struct snd_pcm_hw_constraint_list constraints_channels = {
> +	.count = ARRAY_SIZE(channels),
> +	.list = channels,
> +	.mask = 0,
> +};
> +
> +static int bdw_fe_startup(struct snd_pcm_substream *substream)

Entire file uses 'bdw_rt5650_' naming convention. Let's not stray away 
from that path now.

> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +

Missing hw.channels_max assignment from rt5677 - inconsistency/ copy error?

> +	/*
> +	 * On this platform for PCM device we support,
> +	 * 2 or 4 channel capture
> +	 */

Sometimes you add a newline add and before, while other times just one, 
before the comment. Please streamline the format across all patches in 
the series. Comment can be more strict too
	/* Board supports stereo and quad configurations */

> +	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
> +		snd_pcm_hw_constraint_list(runtime, 0,
> +					   SNDRV_PCM_HW_PARAM_CHANNELS,
> +					   &constraints_channels);

Redesign to reduce indentation and improve readability -
	if (stream != capture)
		return 0;

	return snd_pcm_hw_contraint_list(...);

> +
> +	return 0;
> +}
> +
> +static const struct snd_soc_ops bdw_rt5650_fe_ops = {
> +	.startup = bdw_fe_startup,
> +};
> +
>   static int bdw_rt5650_init(struct snd_soc_pcm_runtime *rtd)
>   {
>   	struct bdw_rt5650_priv *bdw_rt5650 =
> @@ -234,6 +267,7 @@ static struct snd_soc_dai_link bdw_rt5650_dais[] = {
>   		.name = "System PCM",
>   		.stream_name = "System Playback",
>   		.dynamic = 1,
> +		.ops = &bdw_rt5650_fe_ops,
>   #if !IS_ENABLED(CONFIG_SND_SOC_SOF_BROADWELL)
>   		.init = bdw_rt5650_rtd_init,
>   #endif
> 
