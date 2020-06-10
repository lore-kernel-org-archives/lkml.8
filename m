Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C0BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 14:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51AAC2067B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 14:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729759AbgFJOMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 10:12:39 -0400
Received: from mga14.intel.com ([192.55.52.115]:34281 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbgFJOMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 10:12:39 -0400
IronPort-SDR: iQw7qB8FZPr5J8lFO0Ye9tmuq5h7XIpChO0/kp/8aLNKVwy4tf7FeKqXLwwoIjrbEktLljO+fy
 2ZKwTM6uV5Vw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 07:12:39 -0700
IronPort-SDR: fKrJXsTqhlPXdaj5uo+Plq6f24Ee0V34xRBDERFPAU1oT+dwqd1TjgEWVneFvEOvOqdcHz0O1c
 x2BU4QuL/X4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,496,1583222400"; 
   d="scan'208";a="473350013"
Received: from opolat-mobl.amr.corp.intel.com (HELO [10.251.2.3]) ([10.251.2.3])
  by fmsmga006.fm.intel.com with ESMTP; 10 Jun 2020 07:12:38 -0700
Subject: Re: [RFC PATCH] ALSA: compress: Fix gapless playback state machine
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.com, broonie@kernel.org
References: <20200610100729.362-1-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <694dd437-3453-7328-f544-28106c1c366d@linux.intel.com>
Date:   Wed, 10 Jun 2020 07:56:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200610100729.362-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/10/20 5:07 AM, Srinivas Kandagatla wrote:
> For gapless playback call to snd_compr_drain_notify() after
> partial drain should put the state to SNDRV_PCM_STATE_RUNNING
> rather than SNDRV_PCM_STATE_SETUP as the driver is ready to
> process the buffers for new track.
> 
> With existing code, if we are playing 3 tracks in gapless, after

The gapless playback only deals with transitions between two tracks of 
identical format. I am not sure what the reference to 3 tracks means.

> partial drain finished on previous track 1 the state is set to
> SNDRV_PCM_STATE_SETUP which is then moved to SNDRV_PCM_STATE_PREPARED
> after data write. With this state calls to snd_compr_next_track() and
> few other calls will fail as they expect the state to be in
> SNDRV_PCM_STATE_RUNNING.
> 
> Here is the sequence of events and state transitions:
> 
> 1. set_params (Track 1), state =  SNDRV_PCM_STATE_SETUP
> 2. set_metadata (Track 1), no state change, state = SNDRV_PCM_STATE_SETUP
> 3. fill and trigger start (Track 1), state = SNDRV_PCM_STATE_RUNNING
> 4. set_next_track (Track 2), state = SNDRV_PCM_STATE_RUNNING
> 5. partial_drain (Track 1), state = SNDRV_PCM_STATE_SETUP
> 6  snd_compr_drain_notify (Track 1), state = SNDRV_PCM_STATE_SETUP
> 7. fill data (Track 2), state = SNDRV_PCM_STATE_PREPARED
> 8. set_metadata (Track 3), no state change, state = SNDRV_PCM_STATE_PREPARED
> 9. set_next_track (Track 3), !! FAILURE as state != SNDRV_PCM_STATE_RUNNING
> 
> Fixes: f44f2a5417b2 ("ALSA: compress: fix drain calls blocking other compress functions (v6)")
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
> 
> I wonder who did gapless work on upstream so far?

IIRC the only users of gapless playback are Android platforms, where the 
HAL deals with the transitions. I am not aware of any plain vanilla 
Linux solution.

> 
>   include/sound/compress_driver.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/sound/compress_driver.h b/include/sound/compress_driver.h
> index 6ce8effa0b12..eabac33864c2 100644
> --- a/include/sound/compress_driver.h
> +++ b/include/sound/compress_driver.h
> @@ -182,7 +182,7 @@ static inline void snd_compr_drain_notify(struct snd_compr_stream *stream)
>   	if (snd_BUG_ON(!stream))
>   		return;
>   
> -	stream->runtime->state = SNDRV_PCM_STATE_SETUP;
> +	stream->runtime->state = SNDRV_PCM_STATE_RUNNING;
>   
>   	wake_up(&stream->runtime->sleep);
>   }
> 
