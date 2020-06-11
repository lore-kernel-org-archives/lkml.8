Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D427C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 10:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29F922078D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 10:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="LK9HwhOI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgFKKk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 06:40:59 -0400
Received: from mail1.perex.cz ([77.48.224.245]:42354 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbgFKKk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 06:40:57 -0400
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 28CC4A0040;
        Thu, 11 Jun 2020 12:40:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 28CC4A0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1591872054; bh=DwzRYk4RWjYp+Vj1nO3V2LYlM4Go4n5SvcpAu4c3ZZg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LK9HwhOIXTUqmdhONs3IB+irxcwKiU+DEpd3dKQyOO022jZEKH+R5goXc2rWVyeQF
         2OA6LCk8dnqGkyxV16xd9+ht6DE9i61nGjZH8B8mGPXSRFWMNIpYg1YxpNReIrJHXN
         PmydBBr435ULE823AdjPSBxwQzPSEPVC94pwNG5s=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Thu, 11 Jun 2020 12:40:47 +0200 (CEST)
Subject: Re: [RFC PATCH] ALSA: compress: Fix gapless playback state machine
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, broonie@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        tiwai@suse.com, linux-kernel@vger.kernel.org
References: <20200610100729.362-1-srinivas.kandagatla@linaro.org>
 <817d009e-fa09-e897-cfc3-997bf1dd5e30@perex.cz>
 <20200610105820.GA1393454@vkoul-mobl>
 <20200611084659.GO71940@ediswmail.ad.cirrus.com>
 <6a984302-ff01-e326-d338-e50e1f532cd9@perex.cz>
 <20200611094423.GB1393454@vkoul-mobl>
From:   Jaroslav Kysela <perex@perex.cz>
Message-ID: <8bba7e36-af15-33ac-bfc7-d436030f08b7@perex.cz>
Date:   Thu, 11 Jun 2020 12:40:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200611094423.GB1393454@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 11. 06. 20 v 11:44 Vinod Koul napsal(a):
> On 11-06-20, 11:09, Jaroslav Kysela wrote:
>> Dne 11. 06. 20 v 10:46 Charles Keepax napsal(a):
>>> On Wed, Jun 10, 2020 at 04:28:20PM +0530, Vinod Koul wrote:
>>>> On 10-06-20, 12:40, Jaroslav Kysela wrote:
>>>>> Dne 10. 06. 20 v 12:07 Srinivas Kandagatla napsal(a):
>>>>>> For gapless playback call to snd_compr_drain_notify() after
>>>>>> partial drain should put the state to SNDRV_PCM_STATE_RUNNING
>>>>>> rather than SNDRV_PCM_STATE_SETUP as the driver is ready to
>>>>>> process the buffers for new track.
>>>>>>
>>>>>> With existing code, if we are playing 3 tracks in gapless, after
>>>>>> partial drain finished on previous track 1 the state is set to
>>>>>> SNDRV_PCM_STATE_SETUP which is then moved to SNDRV_PCM_STATE_PREPARED
>>>>>> after data write. With this state calls to snd_compr_next_track() and
>>>>>> few other calls will fail as they expect the state to be in
>>>>>> SNDRV_PCM_STATE_RUNNING.
>>>>>>
>>>>>> Here is the sequence of events and state transitions:
>>>>>>
>>>>>> 1. set_params (Track 1), state =  SNDRV_PCM_STATE_SETUP
>>>>>> 2. set_metadata (Track 1), no state change, state = SNDRV_PCM_STATE_SETUP
>>>>>> 3. fill and trigger start (Track 1), state = SNDRV_PCM_STATE_RUNNING
>>>>>> 4. set_next_track (Track 2), state = SNDRV_PCM_STATE_RUNNING
>>>>>> 5. partial_drain (Track 1), state = SNDRV_PCM_STATE_SETUP
>>>>>> 6  snd_compr_drain_notify (Track 1), state = SNDRV_PCM_STATE_SETUP
>>>>>> 7. fill data (Track 2), state = SNDRV_PCM_STATE_PREPARED
>>>>>> 8. set_metadata (Track 3), no state change, state = SNDRV_PCM_STATE_PREPARED
>>>>>> 9. set_next_track (Track 3), !! FAILURE as state != SNDRV_PCM_STATE_RUNNING
>>>>>
>>>>>
>>>>> The snd_compr_drain_notify() is called only from snd_compr_stop(). Something
>>>>> is missing in this sequence?
>>>>
>>>> It is supposed to be invoked by driver when partial drain is complete..
>>>> both intel and sprd driver are calling this. snd_compr_stop is stop
>>>> while draining case so legit
>>>>
>>>
>>> Not sure I follow this statement, could you elaborate a bit?
>>> snd_compr_stop putting the state to RUNNING seems fundamentally
>>> broken to me, the whole point of snd_compr_stop is to take the
>>> state out of RUNNING.
>>
>> Yes. I agree. It seems that the acknowledge for the partial drain should be
>> handled differently.
> 
> Yeah sorry I overlooked that case and was thinking of it being invoked
> from driver!
> 
> Yes this would make the snd_compr_stop() behave incorrectly.. so this
> cant be done as proposed.
> 
> But we still need to set the draining stream state properly and I am
> thinking below now:
> 
> diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
> index 509290f2efa8..9aba851732d7 100644
> --- a/sound/core/compress_offload.c
> +++ b/sound/core/compress_offload.c
> @@ -929,7 +929,9 @@ static int snd_compr_partial_drain(struct snd_compr_stream *stream)
>          }
>   
>          stream->next_track = false;
> -       return snd_compress_wait_for_drain(stream);
> +       retval = snd_compress_wait_for_drain(stream);
> +       stream->runtime->state = SNDRV_PCM_STATE_RUNNING;
> +       return retval;
>   }

I see a race possibility when the last track is too small and the driver 
signals the end-of-track twice. In this case the partial drain should not end 
with the running state. It would be probably better to separate partial / last 
track acknowledgements.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
