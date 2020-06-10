Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0A4C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFF7520656
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="Q8uprEIr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbgFJKkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 06:40:19 -0400
Received: from mail1.perex.cz ([77.48.224.245]:38358 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728149AbgFJKkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 06:40:17 -0400
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id C6155A0040;
        Wed, 10 Jun 2020 12:40:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz C6155A0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1591785614; bh=EW5ZZRE11geM839WuxiRNw/v/ifrFWfnEj6JsntviJU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Q8uprEIrtzo6p9TBtk05Tgqmlw5MpoKSgDfXteNJ2w7ho4BQPot0luBb61kw0zexl
         oFUAW3dSAnHJTMREJUK5zd1DfTEfLl1VroTitDNKRjbIPoY05xxtHLfG+o7mCIT4MC
         polnbaCshEUPoajBxDsohkZy22K7WR9+uNFnJmGg=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Wed, 10 Jun 2020 12:40:08 +0200 (CEST)
Subject: Re: [RFC PATCH] ALSA: compress: Fix gapless playback state machine
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org
Cc:     tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, broonie@kernel.org
References: <20200610100729.362-1-srinivas.kandagatla@linaro.org>
From:   Jaroslav Kysela <perex@perex.cz>
Message-ID: <817d009e-fa09-e897-cfc3-997bf1dd5e30@perex.cz>
Date:   Wed, 10 Jun 2020 12:40:08 +0200
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

Dne 10. 06. 20 v 12:07 Srinivas Kandagatla napsal(a):
> For gapless playback call to snd_compr_drain_notify() after
> partial drain should put the state to SNDRV_PCM_STATE_RUNNING
> rather than SNDRV_PCM_STATE_SETUP as the driver is ready to
> process the buffers for new track.
> 
> With existing code, if we are playing 3 tracks in gapless, after
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


The snd_compr_drain_notify() is called only from snd_compr_stop(). Something 
is missing in this sequence?

					Jaroslav



> 
> Fixes: f44f2a5417b2 ("ALSA: compress: fix drain calls blocking other compress functions (v6)")
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
> 
> I wonder who did gapless work on upstream so far?
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


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
