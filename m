Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9288DC433FB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C7B822B4B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbgG0OJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:09:47 -0400
Received: from mga03.intel.com ([134.134.136.65]:12471 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729675AbgG0OJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:09:44 -0400
IronPort-SDR: hMLBCNFjZ2UOpqvdOHS16f4r3XkGSBFVtz1JyGKgxzPj585QiqJqy7Xbz1tP4mTTd1qYX/rlwX
 bKoaV2hIXyZQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9694"; a="150999341"
X-IronPort-AV: E=Sophos;i="5.75,402,1589266800"; 
   d="scan'208";a="150999341"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2020 07:09:41 -0700
IronPort-SDR: TteHECRx2z8pElXEkov08M+PbVBtWngjBskOFUpL4BVnmJcFp1UnVeZf4MHtlf6s5hX1B1yDBG
 F8P+M2f4mb7Q==
X-IronPort-AV: E=Sophos;i="5.75,402,1589266800"; 
   d="scan'208";a="464070925"
Received: from pdewan-mobl1.amr.corp.intel.com (HELO [10.255.228.220]) ([10.255.228.220])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2020 07:09:34 -0700
Subject: Re: [PATCH] ASoC: Intel: Atom: use hardware counter to update hw_ptr
To:     Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
References: <1595779727-31404-1-git-send-email-brent.lu@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <7dec7fcd-0381-d279-4dac-77c27ea5f6fe@linux.intel.com>
Date:   Mon, 27 Jul 2020 09:09:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1595779727-31404-1-git-send-email-brent.lu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/26/20 11:08 AM, Brent Lu wrote:
> The ring buffer counter runs faster than hardware counter if the
> period size in hw_param is larger than 240. Although the differce is
> not much (around 2k frames), it causes false underrun in CRAS
> sometimes because it's using 256 frames as period size in hw_param.

All the Atom firmware assumes data chunks in multiples of 1ms (typically 
5, 10 or 20ms). I have never seen anyone use 256 frames, that's asking 
for trouble really.

it's actually the same with Skylake and SOF in most cases.

Is this a 'real' problem or a problem detected by the Chrome ALSA 
compliance tests, in the latter case that would hint at a too generic 
value of min_period.

> Using the hardware counter could provide precise hw_ptr to user space
> and avoid the false underrun in CRAS.
> 
> Signed-off-by: Brent Lu <brent.lu@intel.com>
> ---
>   sound/soc/intel/atom/sst/sst_drv_interface.c | 15 +++------------
>   1 file changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/sound/soc/intel/atom/sst/sst_drv_interface.c b/sound/soc/intel/atom/sst/sst_drv_interface.c
> index 7624953..1949ad9 100644
> --- a/sound/soc/intel/atom/sst/sst_drv_interface.c
> +++ b/sound/soc/intel/atom/sst/sst_drv_interface.c
> @@ -485,7 +485,6 @@ static inline int sst_calc_tstamp(struct intel_sst_drv *ctx,
>   		struct snd_pcm_substream *substream,
>   		struct snd_sst_tstamp *fw_tstamp)
>   {
> -	size_t delay_bytes, delay_frames;
>   	size_t buffer_sz;
>   	u32 pointer_bytes, pointer_samples;
>   
> @@ -493,22 +492,14 @@ static inline int sst_calc_tstamp(struct intel_sst_drv *ctx,
>   			fw_tstamp->ring_buffer_counter);
>   	dev_dbg(ctx->dev, "mrfld hardware_counter %llu in bytes\n",
>   			 fw_tstamp->hardware_counter);
> -	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> -		delay_bytes = (size_t) (fw_tstamp->ring_buffer_counter -
> -					fw_tstamp->hardware_counter);
> -	else
> -		delay_bytes = (size_t) (fw_tstamp->hardware_counter -
> -					fw_tstamp->ring_buffer_counter);
> -	delay_frames = bytes_to_frames(substream->runtime, delay_bytes);
> +
>   	buffer_sz = snd_pcm_lib_buffer_bytes(substream);
> -	div_u64_rem(fw_tstamp->ring_buffer_counter, buffer_sz, &pointer_bytes);
> +	div_u64_rem(fw_tstamp->hardware_counter, buffer_sz, &pointer_bytes);
>   	pointer_samples = bytes_to_samples(substream->runtime, pointer_bytes);
>   
> -	dev_dbg(ctx->dev, "pcm delay %zu in bytes\n", delay_bytes);
> -
>   	info->buffer_ptr = pointer_samples / substream->runtime->channels;
> +	info->pcm_delay = 0;

and that seems also wrong? Why would the delay be zero?

> -	info->pcm_delay = delay_frames;
>   	dev_dbg(ctx->dev, "buffer ptr %llu pcm_delay rep: %llu\n",
>   			info->buffer_ptr, info->pcm_delay);
>   	return 0;
> 
