Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF973C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 855E82067D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eeQgPn+a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgGHJof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 05:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgGHJoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 05:44:34 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F00EC08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 02:44:34 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z2so25884619wrp.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 02:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=28TRzizaHBVpjH6czUv7ZtbAVDNr9yU2x2TvbmxMq78=;
        b=eeQgPn+a90jRBRUN0qWGh9W9OdKK9z446y/+iUDQtB37paKO5BrdXOEFvVmfJJl3sZ
         Y2uYynUIpfiDPWCtPkVB5ALF+mvaHUTaJWvy5+BFNJ80K9PiVJOR4vduykMQak6JZkGC
         giWqOp+dJ8oew4W993KAwHTGgWMmrJkZJRqaTFawiwA3V5MPktfYP60VBfLxuU2bHbzX
         tGuUgErzXdVj8ZRk+pMrkUDBi9O3EsOA76QE+KKHxvv+lB7tXOliRy3xWmixkM385tQ5
         x1bSaBj8vCPCQC9UFFBQszr3+8eB8G7or5nwtf4pjtg+y5Ox44W1yVeYIj0d6FZnSEo8
         ULBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=28TRzizaHBVpjH6czUv7ZtbAVDNr9yU2x2TvbmxMq78=;
        b=nk5a+dkcHGJ889AM3b3GH1j+M/mnpNuKuEu6Do3AU1i6Uq1L/VKt/kmwb5Z1k5soFJ
         9Am7HA1KSezoZkUhnFmn5ty8cXJAIY5RmMFHXggAyjsmVD6TJeWJwqTbV81Hw+cRRzpD
         OV+DgAFzC8QN00w/enpD0ZxvqCL+sCeX/t+RlQSMX8SHi/VVLB/ZA9DM//fvdEtwosvB
         /oCVdipQ79UX6Rz6wBE3JP/c2wKDAE1Y/BqC3vX/lsu8DFcWBNYq3sK7OB8TqDFFsFVB
         Sd+EYYB2y1xE+7OE2ZH2/u/IZUkRb81UW4wg+A+mW+zGlXZfu3xv+H7XIAadgtcoPws3
         ZqsQ==
X-Gm-Message-State: AOAM5328J9uHxDnJTLtSdxJ30fgW1I/kEa21uw9C6721u/xDCUFeIPH5
        IL+D2HjRKfHg4cvH87QRX3CciQ==
X-Google-Smtp-Source: ABdhPJwm1lt3Qt9DvGjT5KOrVNSqCsDaKUpYSqtqUMEKvXpLKrFkzTQ9W3GnGGDp/sjHQemaY7gRTw==
X-Received: by 2002:a5d:5642:: with SMTP id j2mr57503290wrw.19.1594201473237;
        Wed, 08 Jul 2020 02:44:33 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id a22sm4788792wmb.4.2020.07.08.02.44.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2020 02:44:32 -0700 (PDT)
Subject: Re: [PATCH 07/11] ASoC: q6asm: add support to gapless flag in asm
 open
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com,
        tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        vkoul@kernel.org
References: <20200707163641.17113-1-srinivas.kandagatla@linaro.org>
 <20200707163641.17113-8-srinivas.kandagatla@linaro.org>
 <b05e5503-6a47-5b52-1339-f1243d952cea@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <b2738e18-ba99-978a-0fef-395ad9428cc6@linaro.org>
Date:   Wed, 8 Jul 2020 10:44:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b05e5503-6a47-5b52-1339-f1243d952cea@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks Pierre for review,

On 07/07/2020 17:57, Pierre-Louis Bossart wrote:
> 
>> diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c 
>> b/sound/soc/qcom/qdsp6/q6asm-dai.c
>> index c3558288242a..8c214436a2c2 100644
>> --- a/sound/soc/qcom/qdsp6/q6asm-dai.c
>> +++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
>> @@ -258,7 +258,7 @@ static int q6asm_dai_prepare(struct 
>> snd_soc_component *component,
>>       if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>>           ret = q6asm_open_write(prtd->audio_client, prtd->stream_id,
>>                          FORMAT_LINEAR_PCM,
>> -                       0, prtd->bits_per_sample);
>> +                       0, prtd->bits_per_sample, false);
> 
> nit-pick: it's a bit ironic that is_gapless is false for PCM, when there 
> is no gap in the first place..

I think this is to do with same apis reused for both compressed and pcm.

Probably we can live with it for now!

--srini
> 
>>       } else if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
>>           ret = q6asm_open_read(prtd->audio_client, prtd->stream_id,
>>                         FORMAT_LINEAR_PCM,
>> @@ -685,7 +685,7 @@ static int q6asm_dai_compr_set_params(struct 
>> snd_soc_component *component,
>>       if (dir == SND_COMPRESS_PLAYBACK) {
>>           ret = q6asm_open_write(prtd->audio_client, prtd->stream_id,
>>                          params->codec.id, params->codec.profile,
>> -                       prtd->bits_per_sample);
>> +                       prtd->bits_per_sample, true);
