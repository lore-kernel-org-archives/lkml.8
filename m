Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7C9C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 09:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 137F4207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 09:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EjVb3LY4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbgFSJN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 05:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728058AbgFSJN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 05:13:27 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B05C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 02:13:25 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x6so8909361wrm.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 02:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VIcO7Vu1hhhJkIDur8b5xWQbNX1N/JcmyVzMFWh9MWY=;
        b=EjVb3LY4k8M1L6gxe0H793lwu/EpD5t2rcogA1bWHCGVi6Ar1IUEdP1XHUSNR0wxWb
         ZaMAvUtyEp5hprgxFIHusZNuRecNuFJtaGTj5oV/Vyds13ybvKDTnJBbOz5irV2mzonW
         3G+yqdvnxqYNpwZT4mPv+sJf4E6P69ps2IY2I7OAKr/r+hRVu3DXIrSaUqQ0fALRC9Fr
         Kc0sDBrnl6//yggVqVmQtnspnXbZQhN4fBacTxbeSjMMr3iXMzgWSGFlY9jZvfooc1FR
         cmPdSj0JvOmyuNgt5p3TdkM/lLJzCb9HvT24MNkAhFMtyRPihI4dK1l3huLQnS2X5418
         xXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VIcO7Vu1hhhJkIDur8b5xWQbNX1N/JcmyVzMFWh9MWY=;
        b=P2wJxgwo3wde6KySX9ymPW33F7qDI7IP2nwZ60dXBHgg/9mY0MIIaCMZoHahsjUxTC
         6JB50IP44BZTvh+ofuq75KoPc6Ye4NkvhomTfFlhtlthXcebyv3+k5tTBayxOwP0tlS7
         unzlGgBRO5gbVap8HAym6/pqug0LWYpaTeEKh/bEFa9t2gGq11fKD35x6bzqKZ47s78z
         bNk8wZuSNMNiuhV8gw4Am1TymdvqWcCXBqPWUnJqHB6uDpBxQghv/O7lDgibFNh97CCH
         +c3efqDjeavMazwyfxnermKcZIPPIPYGzdu6Mt7vGbDIShcU7Tf7q4C3QKjxwtJ+DHuj
         My1A==
X-Gm-Message-State: AOAM533tPw86v3S4iAGNXr5g1/s38nZWaa8Rtf6vzDk7OqaRlSbqzS6N
        JLrePWZgeJcQl8w7kzwguBlgRfR5Wnk=
X-Google-Smtp-Source: ABdhPJwH5E0HbSyiE3hGibWdLtan8edy/4DSaUVUVwEvBiRWAtDZSPcOH0BFQA9z/NRFA5cLl+GhUQ==
X-Received: by 2002:adf:fc0c:: with SMTP id i12mr2966289wrr.365.1592558004100;
        Fri, 19 Jun 2020 02:13:24 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id f185sm6445708wmf.43.2020.06.19.02.13.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jun 2020 02:13:23 -0700 (PDT)
Subject: Re: [PATCH 3/3] ALSA: compress: fix partial_drain completion state
To:     Vinod Koul <vkoul@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20200619045449.3966868-1-vkoul@kernel.org>
 <20200619045449.3966868-4-vkoul@kernel.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <0a0fcd4c-40dd-621e-b0ad-51296178aa9e@linaro.org>
Date:   Fri, 19 Jun 2020 10:13:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200619045449.3966868-4-vkoul@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/06/2020 05:54, Vinod Koul wrote:
> On partial_drain completion we should be in SNDRV_PCM_STATE_RUNNING
> state, so set that for partially draining streams in
> snd_compr_drain_notify() and use a flag for partially draining streams
> 
> While at it, add locks for stream state change in
> snd_compr_drain_notify() as well.
> 
> Fixes: f44f2a5417b2 ("ALSA: compress: fix drain calls blocking other compress functions (v6)")
> Reported-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


>   include/sound/compress_driver.h | 12 +++++++++++-
>   sound/core/compress_offload.c   |  4 ++++
>   2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/include/sound/compress_driver.h b/include/sound/compress_driver.h
> index 3df8d8c90191..93a5897201ea 100644
> --- a/include/sound/compress_driver.h
> +++ b/include/sound/compress_driver.h
> @@ -66,6 +66,7 @@ struct snd_compr_runtime {
>    * @direction: stream direction, playback/recording
>    * @metadata_set: metadata set flag, true when set
>    * @next_track: has userspace signal next track transition, true when set
> + * @partial_drain: undergoing partial_drain for stream, true when set
>    * @private_data: pointer to DSP private data
>    * @dma_buffer: allocated buffer if any
>    */
> @@ -78,6 +79,7 @@ struct snd_compr_stream {
>   	enum snd_compr_direction direction;
>   	bool metadata_set;
>   	bool next_track;
> +	bool partial_drain;
>   	void *private_data;
>   	struct snd_dma_buffer dma_buffer;
>   };
> @@ -187,7 +189,15 @@ static inline void snd_compr_drain_notify(struct snd_compr_stream *stream)
>   	if (snd_BUG_ON(!stream))
>   		return;
>   
> -	stream->runtime->state = SNDRV_PCM_STATE_SETUP;
> +	mutex_lock(&stream->device->lock);
> +	/* for partial_drain case we are back to running state on success */
> +	if (stream->partial_drain) {
> +		stream->runtime->state = SNDRV_PCM_STATE_RUNNING;
> +		stream->partial_drain = false; /* clear this flag as well */
> +	} else {
> +		stream->runtime->state = SNDRV_PCM_STATE_SETUP;
> +	}
> +	mutex_unlock(&stream->device->lock);
>   
>   	wake_up(&stream->runtime->sleep);
>   }
> diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
> index e618580feac4..1c4b2cf450a0 100644
> --- a/sound/core/compress_offload.c
> +++ b/sound/core/compress_offload.c
> @@ -803,6 +803,9 @@ static int snd_compr_stop(struct snd_compr_stream *stream)
>   
>   	retval = stream->ops->trigger(stream, SNDRV_PCM_TRIGGER_STOP);
>   	if (!retval) {
> +		/* clear flags and stop any drain wait */
> +		stream->partial_drain = false;
> +		stream->metadata_set = false;
>   		snd_compr_drain_notify(stream);
>   		stream->runtime->total_bytes_available = 0;
>   		stream->runtime->total_bytes_transferred = 0;
> @@ -960,6 +963,7 @@ static int snd_compr_partial_drain(struct snd_compr_stream *stream)
>   	if (stream->next_track == false)
>   		return -EPERM;
>   
> +	stream->partial_drain = true;
>   	retval = stream->ops->trigger(stream, SND_COMPR_TRIGGER_PARTIAL_DRAIN);
>   	if (retval) {
>   		pr_debug("Partial drain returned failure\n");
> 
