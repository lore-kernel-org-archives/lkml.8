Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790A0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C2B420786
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o8yOtFI6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbgGHPXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 11:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729206AbgGHPXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 11:23:22 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246C5C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 08:23:22 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z2so27172391wrp.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 08:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4K7L/GW11mYIN1OtKYlNsLhV4IcqYsnyxX2a+Ockc1I=;
        b=o8yOtFI6+REhecX7ZnGxb1qEoTgbZBucQLhRZxk+fLSTLGAq8evEqQMryZswQUJU4z
         4e577wf+wlNaejHt6awzranbAQUZtGblLDbGSEiffSHHFVSzeG/3meDM+xbIwl2HGNji
         NxtBDO9VdPLh6Mq1T8+nTuJyQkwIltI+xY1sdwygbno1jlz6Cqne+iG0lRZt7V3+pdX8
         KB1toneZe1KJInzVGpmJLNzfAspke5G5YKhMYHJtcfjmMdWY/IlGOVowOFikvOyElovR
         0TOrctVohUM/55anrb5TMLbeFd+gYua9EBIg10ZhB7jo7eoT2BAfuc+EjlON5zGY96g4
         8GqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4K7L/GW11mYIN1OtKYlNsLhV4IcqYsnyxX2a+Ockc1I=;
        b=ngyzaQDQavaHQ0o8QPXqbir0f8JMcOU18BY5MPH8H9DhaywgppLVpdI9Mis+GOxGyX
         POYktZFKLhAKWriH8bVuZpLBs+1rCcYyy8Tgm9HA4Hrti5mm2NpJEMfHuNPBg6xzbQFz
         8N1C72HEj9R3ARdCZBJvn1RJbCC2jMDBVC4t+1e6CRzdPN/ZIzTlBaGt+0JBa/iCxZUc
         7DwPfLV1RUdhIIb/1IYoWfrTVCBaIDPi2EyBgog5qXL/yE9uhapThhp85s1dqJ2cNJ58
         hli3wJs2pZQXvWT3Md9ppcZeiODYFAGZuamKMGCVYCUwSXHVrbInjP/HSsR+hwNdaAH3
         EtBA==
X-Gm-Message-State: AOAM533I2CEogWRpRqZHJN6UGqnWJm5iNbgWYMHqpyyfuJEsDHnlZUiK
        30URRfJVuDrgKt6SOocC7SnJqw==
X-Google-Smtp-Source: ABdhPJwkNOp0LosvyzGEmFauWFstpbAEsr7ggYQjTwCu7z1MaeGgvrpsD7efnIo4dNrHpLeov5tveA==
X-Received: by 2002:adf:c441:: with SMTP id a1mr58320397wrg.130.1594221800814;
        Wed, 08 Jul 2020 08:23:20 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id n16sm425790wrq.39.2020.07.08.08.23.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2020 08:23:20 -0700 (PDT)
Subject: Re: [PATCH 10/11] ASoC: qdsp6-dai: add gapless support
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com,
        tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        vkoul@kernel.org
References: <20200707163641.17113-1-srinivas.kandagatla@linaro.org>
 <20200707163641.17113-11-srinivas.kandagatla@linaro.org>
 <62af11d3-db26-a31b-00c8-9d78b11862cc@linux.intel.com>
 <04a7f696-e23d-5563-7cc3-aedfaf2c7636@linaro.org>
 <cf9b2d33-9b63-f3d2-2e51-a88c528dad53@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <e6d10009-d01e-d506-1aa3-a915ef42a693@linaro.org>
Date:   Wed, 8 Jul 2020 16:23:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <cf9b2d33-9b63-f3d2-2e51-a88c528dad53@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/07/2020 14:32, Pierre-Louis Bossart wrote:
> 
>>>> Add support to gapless playback by implementing metadata,
>>>> next_track, drain and partial drain support.
>>>>
>>>> Gapless on Q6ASM is implemented by opening 2 streams in a single asm 
>>>> stream
>>>
>>> What does 'in a single asm stream' means?
>>
>>
>> So in QDSP6 ASM (Audio Stream Manager) terminology we have something 
>> called "asm session" for each ASoC FE DAI, Each asm session can be 
>> connected with multiple streams (upto 8 I think). However there will 
>> be only one active stream at anytime. Also there only single data 
>> buffer associated with each asm session.
>>
>> For Gapless usecase, we can keep two streams open for one asm-session, 
>> allowing us to fill in data on second stream while first stream is 
>> playing.
> 
> Ah, that's interesting, thanks for the details. So you have one DMA 
> transfer and the data from the previous and next track are provided in 
> consecutive bytes in a ring buffer, but at the DSP level you have a 
> switch that will feed data for the previous and next tracks into 
> different decoders, yes?

Yes, that's true, we can drain and stop first stream and start next 
stream which will do the switch!

> 
> If that is the case, indeed the extension you suggested earlier to 
> change the profile is valid. You could even change the format I guess.
> 

Exactly, we did test this patchset along with the extension suggested!


> To avoid confusion I believe the capabilities would need to be extended 
> so that applications know that gapless playback is supported across 
> unrelated profiles/formats. The point is that you don't want a 
> traditional implementation to use a capability that isn't supported in 
> hardware or will lead to audio issues.
>  >>>> and toggling them on next track.
>>>
>>> It really seems to me that you have two streams at the lowest level, 
>>> along with the knowledge of how many samples to remove/insert and 
>>> hence could do a much better job - including gapless support between 
>>> unrelated profiles and cross-fading - without the partial drain and 
>>> next_track mechanism that was defined assuming a single stream/profile.
>> At the end of the day its a single session with one data buffer but 
>> with multiple streams.
>>
>> Achieving cross fade should be easy with this design.
> 
> looks like it indeed.
> 
>> We need those hooks for partial drain and next track to allow us to 
>> switch between streams and pass silence information to respective 
>> stream ids.
> 
> right, but the key point is 'switch between streams'. That means a more 
> complex/capable implementation that should be advertised as such to 
> applications. This is not the default behavior assumed initially: to 
> allow for minimal implementations in memory-constrained devices, we 
> assumed gapless was supported with a single decoder.
> 
> Maybe the right way to do this is extend the snd_compr_caps structure:
> 
> /**
>   * struct snd_compr_caps - caps descriptor
>   * @codecs: pointer to array of codecs
>   * @direction: direction supported. Of type snd_compr_direction
>   * @min_fragment_size: minimum fragment supported by DSP
>   * @max_fragment_size: maximum fragment supported by DSP
>   * @min_fragments: min fragments supported by DSP
>   * @max_fragments: max fragments supported by DSP
>   * @num_codecs: number of codecs supported
>   * @reserved: reserved field
>   */
> struct snd_compr_caps {
>      __u32 num_codecs;
>      __u32 direction;
>      __u32 min_fragment_size;
>      __u32 max_fragment_size;
>      __u32 min_fragments;
>      __u32 max_fragments;
>      __u32 codecs[MAX_NUM_CODECS];
>      __u32 reserved[11];
> } __attribute__((packed, aligned(4)));
> 
> 
> and use a reserved field to provide info on capabilities, and filter the 
> set_codec_params() addition based this capability - i.e. return -ENOTSUP 
> in 'traditional' implementations based on a single 'stream'/decoder 
> instance.
Sounds good!
I will give it a go and see how it ends up!


--srini

