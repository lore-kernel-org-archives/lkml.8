Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F417CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAEEF2074B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rW5B41js"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbgFJK5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 06:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbgFJK5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 06:57:01 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBABCC03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 03:57:00 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x6so1708335wrm.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 03:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Gaoy82nx63ddYrD03WQdgMSQz0m1g7Mo1K4KeYxZPTk=;
        b=rW5B41jsRaHDL4Q3LVL6RPpznlkcuO9V/zbKOO5L/lfYeO86WLBOxNKT3/qYBJgPcZ
         XRZxbI8MOiCIMjV9LphZJCQMNxqZFrlKgBxhZissCgOQ6/wbmRwbEAfe+n1t6crxYn/F
         veHME6FuvAnjJ563h9YvBAJoWxWTPSUV0w4LdsLAY+uV9h9CiWsCLZOydAX9ctORnjDf
         FRP3Gj0gKrjTzV4I99uWAkZEcFm+t1dy6YX2Ky5nzL6QlK7JIEzCWOedl830AYNbbTYg
         K4VMnQHO8LiMy7RY/6Y28MhZ+ocOzEdPhTbvZ6M5MtiPPUesNMNhEjjw/R77vlGgSa6W
         XR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Gaoy82nx63ddYrD03WQdgMSQz0m1g7Mo1K4KeYxZPTk=;
        b=FzasT4hwDdh4wGQu4yesdySEx8NswJ1im7TiAJH7tafzRJtQV4SF7zl6xTUHgSFASm
         wemMvCqKhJ9m0C7XbjoIAQn1Ev4ozX61wZEo8B3yFnPuWbhwXGCIXUwwuv+/RjBYf99y
         BG15CwrcWm1Jgok0dPWsoahi9EWFE84aPjjunnAkhHxKUWsR5nWkOQLAP385H97AoMMW
         QZscVqe5ch33qBBMsgr5eJ0ccTHdf67yQE6Rk6L08+YsTx4jpnq4lrG7PRSvmgwKB4Qr
         HkRXoqY1AD4J2/dw+mRfALr/Ws2IHL0QR6jgXyYv0F7RUiProVwjCeNrYBVry1n/gUaM
         KoOg==
X-Gm-Message-State: AOAM53131JsF+H+k0bmDMta8Rvo38Yw6KVYTLbRChSFKZ1R+n73tLL6D
        pEf968DHH7nO66St+paLjSeKbg==
X-Google-Smtp-Source: ABdhPJy4IM5bOvr7G6mlIHkpIOr41yEzVIj2vB8swuFXNsuJQPwgY7PM1mFFLKX31Wm1APL7x/v9CQ==
X-Received: by 2002:a5d:4a04:: with SMTP id m4mr3293394wrq.153.1591786619510;
        Wed, 10 Jun 2020 03:56:59 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id b19sm6988807wmj.0.2020.06.10.03.56.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jun 2020 03:56:58 -0700 (PDT)
Subject: Re: [RFC PATCH] ALSA: compress: Fix gapless playback state machine
To:     Jaroslav Kysela <perex@perex.cz>, vkoul@kernel.org
Cc:     tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, broonie@kernel.org
References: <20200610100729.362-1-srinivas.kandagatla@linaro.org>
 <817d009e-fa09-e897-cfc3-997bf1dd5e30@perex.cz>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <683a67bc-44e8-1e2b-b9a4-29e71ce86fdc@linaro.org>
Date:   Wed, 10 Jun 2020 11:56:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <817d009e-fa09-e897-cfc3-997bf1dd5e30@perex.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/06/2020 11:40, Jaroslav Kysela wrote:
> Dne 10. 06. 20 v 12:07 Srinivas Kandagatla napsal(a):
>> For gapless playback call to snd_compr_drain_notify() after
>> partial drain should put the state to SNDRV_PCM_STATE_RUNNING
>> rather than SNDRV_PCM_STATE_SETUP as the driver is ready to
>> process the buffers for new track.
>>
>> With existing code, if we are playing 3 tracks in gapless, after
>> partial drain finished on previous track 1 the state is set to
>> SNDRV_PCM_STATE_SETUP which is then moved to SNDRV_PCM_STATE_PREPARED
>> after data write. With this state calls to snd_compr_next_track() and
>> few other calls will fail as they expect the state to be in
>> SNDRV_PCM_STATE_RUNNING.
>>
>> Here is the sequence of events and state transitions:
>>
>> 1. set_params (Track 1), state =  SNDRV_PCM_STATE_SETUP
>> 2. set_metadata (Track 1), no state change, state = SNDRV_PCM_STATE_SETUP
>> 3. fill and trigger start (Track 1), state = SNDRV_PCM_STATE_RUNNING
>> 4. set_next_track (Track 2), state = SNDRV_PCM_STATE_RUNNING
>> 5. partial_drain (Track 1), state = SNDRV_PCM_STATE_SETUP
>> 6  snd_compr_drain_notify (Track 1), state = SNDRV_PCM_STATE_SETUP
>> 7. fill data (Track 2), state = SNDRV_PCM_STATE_PREPARED
>> 8. set_metadata (Track 3), no state change, state = 
>> SNDRV_PCM_STATE_PREPARED
>> 9. set_next_track (Track 3), !! FAILURE as state != 
>> SNDRV_PCM_STATE_RUNNING
> 
> 
> The snd_compr_drain_notify() is called only from snd_compr_stop(). 
> Something is missing in this sequence?

snd_compr_drain_notify() can also be called by drivers to notify when 
partial drain is finished. In this case its called from qcom compress 
driver.

--srini

> 
>                      Jaroslav
> 
> 
> 
>>
>> Fixes: f44f2a5417b2 ("ALSA: compress: fix drain calls blocking other 
>> compress functions (v6)")
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>
>> I wonder who did gapless work on upstream so far?
>>
>>   include/sound/compress_driver.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/sound/compress_driver.h 
>> b/include/sound/compress_driver.h
>> index 6ce8effa0b12..eabac33864c2 100644
>> --- a/include/sound/compress_driver.h
>> +++ b/include/sound/compress_driver.h
>> @@ -182,7 +182,7 @@ static inline void snd_compr_drain_notify(struct 
>> snd_compr_stream *stream)
>>       if (snd_BUG_ON(!stream))
>>           return;
>> -    stream->runtime->state = SNDRV_PCM_STATE_SETUP;
>> +    stream->runtime->state = SNDRV_PCM_STATE_RUNNING;
>>       wake_up(&stream->runtime->sleep);
>>   }
>>
> 
> 
