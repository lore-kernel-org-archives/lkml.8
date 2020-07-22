Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACE9C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DE1A20792
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VAvweHh0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731112AbgGVJAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 05:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbgGVJAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 05:00:09 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DDAC0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 02:00:09 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f18so1126289wrs.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 02:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=viwrfw8KEMKzrFAX4HsIdV71gHSjggqFirGu7bOpKxM=;
        b=VAvweHh0K18OzsxaUwUXODY2GPMO+phWjiTnS8bxL3RUm0G9wdiXt3pRP72pIA2He0
         MICc2zftfwQdpnaX76IOnVvRwLDq5HWIkMcpfPY34NV6YeFLyVqd8s0Qv1rq9u4Co0X7
         xfVmwHkrzA3K+z259LsBWfW2RZOLCjBjAOHBhHcZjJtyKJ9M4QQlyEx80kt0wPRWdVVT
         pe3Nd0oE2RQxZHkG+lbUaPpwYQgRAcUhxxT8X/VgDxM3PnutTZtrJcEHqOFlQDF37piF
         BEAPT0OSp4reLGJsyRfq/K/4WyJC8P+1f+pZn6JjWegSV1t++nrsIAAABrvQ7sa1NCpT
         nRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=viwrfw8KEMKzrFAX4HsIdV71gHSjggqFirGu7bOpKxM=;
        b=s1+P4uUM5A05FsKMtgNiKszuBRzPkLfVaEADkgng0kV2wQtvZyktDNEHlg8kTPxqHF
         aFSlb6xt5ZtoM0GOIqBpmCIc9GgJdWsTNt3j9s8qvqxcN8MQ4maUe6Al7q7oIhF3y6Mx
         R7+cWsaDF+7yiMLtp9QZuggFPltdLiFO+Yoc6x1iBpSqNoktSPrXxJ3L9eOYZMR+xZB2
         2olU8joj0CcicwYDDRRsOZZy1kmEQEClWyH+aUDqI88Fm1ioyX8T7b3jBZn/KvZkWMSx
         plSCOj/Ug/CjKjWszU761Gw6XYeBJ+GYGKBwWWIzstijMb0ZobSA+aFS0tZiAVZCglU2
         6C4A==
X-Gm-Message-State: AOAM532iIifATn2cvQsiohuqwv4+0lkAg0jLU5V9r4b2UG+6DsvWwGD1
        QgfKyjVmryaY/IEeq8vyekEcNh2ceUA=
X-Google-Smtp-Source: ABdhPJwoe6hVilS2purieMiuQ2ShzDAtmGD3gQ4qUVlBrrL3Creahr4G/TknG+3Tcag8Jdb3k4yY+Q==
X-Received: by 2002:adf:f4ca:: with SMTP id h10mr5091697wrp.355.1595408407816;
        Wed, 22 Jul 2020 02:00:07 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id t202sm6716731wmt.20.2020.07.22.02.00.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jul 2020 02:00:07 -0700 (PDT)
Subject: Re: [PATCH v2 8/9] ASoC: qdsp6-dai: add gapless support
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com,
        tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        vkoul@kernel.org
References: <20200721165306.29082-1-srinivas.kandagatla@linaro.org>
 <20200721165306.29082-9-srinivas.kandagatla@linaro.org>
 <868d9768-a4c4-71c1-28fd-ca0e2f6564bf@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <eadfd218-be93-0dc9-df94-a64ea494c6bf@linaro.org>
Date:   Wed, 22 Jul 2020 10:00:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <868d9768-a4c4-71c1-28fd-ca0e2f6564bf@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Pierre for quick review!

On 21/07/2020 20:53, Pierre-Louis Bossart wrote:
> 
> 
> 
> 
>>       case ASM_CLIENT_EVENT_CMD_EOS_DONE:
>> -        prtd->state = Q6ASM_STREAM_STOPPED;
>> +        spin_lock_irqsave(&prtd->lock, flags);
>> +        if (prtd->notify_on_drain) {
>> +            if (substream->partial_drain) {
>> +                /**
> 
> why the kernel-doc style comment?
> 
Nothing intentional, will fix this!

> [...]

> 
>> -static int q6asm_dai_compr_set_params(struct snd_soc_component 
>> *component,
>> -                      struct snd_compr_stream *stream,
>> -                      struct snd_compr_params *params)
>> +static int __q6asm_dai_compr_set_codec_params(struct 
>> snd_soc_component *component,
>> +                          struct snd_compr_stream *stream,
>> +                          struct snd_codec *codec,
>> +                          int stream_id)
> 
> not sure I get why you added the __ prefix, does it have any semantic 
> meaning?
Nope, just to mark them it as internal function, as the function name is 
very much similar to q6asm_dai_compr_set_params() callback!
I will try to come up with better naming and also move the indirection 
changes to a separate patch!

> 
>>   {
>>       struct snd_compr_runtime *runtime = stream->runtime;
>>       struct q6asm_dai_rtd *prtd = runtime->private_data;
>> -    struct snd_soc_pcm_runtime *rtd = stream->private_data;
>> -    int dir = stream->direction;
>> -    struct q6asm_dai_data *pdata;
>>       struct q6asm_flac_cfg flac_cfg;
>>       struct q6asm_wma_cfg wma_cfg;
>>       struct q6asm_alac_cfg alac_cfg;
>> @@ -667,53 +718,18 @@ static int q6asm_dai_compr_set_params(struct 
>> snd_soc_component *component,
>>       struct snd_dec_alac *alac;
>>       struct snd_dec_ape *ape;
>> -    codec_options = &(prtd->codec_param.codec.options);
>> -
>> -
>> -    memcpy(&prtd->codec_param, params, sizeof(*params));
>> -
>> -    pdata = snd_soc_component_get_drvdata(component);
>> -    if (!pdata)
>> -        return -EINVAL;
>> -
>> -    if (!prtd || !prtd->audio_client) {
>> -        dev_err(dev, "private data null or audio client freed\n");
>> -        return -EINVAL;
>> -    }
>> -
>> -    prtd->periods = runtime->fragments;
>> -    prtd->pcm_count = runtime->fragment_size;
>> -    prtd->pcm_size = runtime->fragments * runtime->fragment_size;
>> -    prtd->bits_per_sample = 16;
>> -    if (dir == SND_COMPRESS_PLAYBACK) {
>> -        ret = q6asm_open_write(prtd->audio_client, prtd->stream_id,
>> -                       params->codec.id, params->codec.profile,
>> -                       prtd->bits_per_sample, true);
>> -
>> -        if (ret < 0) {
>> -            dev_err(dev, "q6asm_open_write failed\n");
>> -            q6asm_audio_client_free(prtd->audio_client);
>> -            prtd->audio_client = NULL;
>> -            return ret;
>> -        }
>> -    }
>> +    codec_options = &(prtd->codec.options);
>> -    prtd->session_id = q6asm_get_session_id(prtd->audio_client);
>> -    ret = q6routing_stream_open(rtd->dai_link->id, LEGACY_PCM_MODE,
>> -                  prtd->session_id, dir);
>> -    if (ret) {
>> -        dev_err(dev, "Stream reg failed ret:%d\n", ret);
>> -        return ret;
>> -    }
>> +    memcpy(&prtd->codec, codec, sizeof(*codec));
>> -    switch (params->codec.id) {
>> +    switch (codec->id) {
>>       case SND_AUDIOCODEC_FLAC:
>>           memset(&flac_cfg, 0x0, sizeof(struct q6asm_flac_cfg));
>>           flac = &codec_options->flac_d;
>> -        flac_cfg.ch_cfg = params->codec.ch_in;
>> -        flac_cfg.sample_rate =  params->codec.sample_rate;
> 
> all these indirection changes could have gone in a earlier patch, this 
> adds a lot of changes that make this patch long to review. Same comment 
> for all formats
> 
>> +        flac_cfg.ch_cfg = codec->ch_in;
>> +        flac_cfg.sample_rate = codec->sample_rate;
>>           flac_cfg.stream_info_present = 1;
>>           flac_cfg.sample_size = flac->sample_size;
>>           flac_cfg.min_blk_size = flac->min_blk_size;
> 
> [...]
> 
...

>> @@ -917,6 +1018,14 @@ static int q6asm_dai_compr_trigger(struct 
>> snd_soc_component *component,
>>           ret = q6asm_cmd_nowait(prtd->audio_client, prtd->stream_id,
>>                          CMD_PAUSE);
>>           break;
>> +    case SND_COMPR_TRIGGER_NEXT_TRACK:
>> +        prtd->next_track = true;
>> +        prtd->next_track_stream_id = (prtd->stream_id == 1 ? 2 : 1);
> 
> it's rather odd, the initialization above uses next_track_stream_id = 0?

Vaild stream ids start from 1, So we are toggling this between 1 and 2.
So when we set next_track_stream_id to 0, that means we have opened the 
new next stream id and is set to prtd->stream_id. This logic is to 
ensure that we are not going to open next stream id twice!

> 
>> +        break;
>> +    case SND_COMPR_TRIGGER_DRAIN:
>> +    case SND_COMPR_TRIGGER_PARTIAL_DRAIN:
>> +        prtd->notify_on_drain = true;
>> +        break;
>>       default:
>>           ret = -EINVAL;
>>           break;
>> diff --git a/sound/soc/qcom/qdsp6/q6asm.h b/sound/soc/qcom/qdsp6/q6asm.h
>> index 69513ac1fa55..a8dddfeb28da 100644
>> --- a/sound/soc/qcom/qdsp6/q6asm.h
>> +++ b/sound/soc/qcom/qdsp6/q6asm.h
>> @@ -34,6 +34,7 @@ enum {
>>   #define MAX_SESSIONS    8
>>   #define NO_TIMESTAMP    0xFF00
>>   #define FORMAT_LINEAR_PCM   0x0000
>> +#define ASM_LAST_BUFFER_FLAG           BIT(30)
>>   struct q6asm_flac_cfg {
>>           u32 sample_rate;
>>
