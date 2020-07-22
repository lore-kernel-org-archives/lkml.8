Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A1BC433ED
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95F5220792
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F8CTMULF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731015AbgGVI7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 04:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbgGVI7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 04:59:54 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766B5C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 01:59:54 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id b6so1088821wrs.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 01:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F5fdDXlwfjwIinCr8su6jkG9d0SAhaK9tLXOO3l7hIE=;
        b=F8CTMULFLzaFjIJ7+GwGlU2MUkJ1AUy0wyKX5EjDTQRi0H7mDwjpZdhr2w7fl993fA
         gPQEqFDtN8Md7QihaN/WgOiTyR4PUX7IK8UMiBa4BIQATy1996tbDMDaQoTj7gTsp6yr
         ka0cb7nMcIHpxihoPxxO4JjzjsRqnjTK8Ao2yOckwYFGzKOLLOJP3dgJ+J5tgT7noQ2z
         MIC9Ns2MIs3bRqR+Ul6yfnvgfZopdO/N95oioHCMbj3nm/S5qn3GRx1TAl5ZoD9pr6KL
         jDx1IFyJ3P6S1ggft6hDordP2BgEn/YnTIzL2vw6e0DY5Kl6XX/6zU9HUpLMCskUeL/E
         PUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F5fdDXlwfjwIinCr8su6jkG9d0SAhaK9tLXOO3l7hIE=;
        b=ogPzz65efq+QjjT6W0ZKNEhlS8d9lwz7uS5eHOhL9zXaKi24bgf9Pz8Rtrxpp0sNSP
         cOak/Zyw4C8rH81rQAwNSPsdF0IggZmVB77rjyuOxhFEBkhEPVqu7rcT1pyZN14xbtuC
         +iFZ5kf2V983UznonMBiY6xMXb9h94GkbZPmYQ49BZuu2Kwn4pmiywgiN9JygVBWbJ+k
         T1B2dBJiCZ5DIQMSr+ACEusxxGbJy/8McNTulPJR75VSvUWBBNtdy2UQE6SqaAIkoRZi
         y3jmnp1CHMZNT0CA4jwB1oXOgpOR6OmUmvhGls+zDp4mTFZwil/AIUUKUU+CSXm8WzFz
         gDpg==
X-Gm-Message-State: AOAM533WK42S0uHcCP/0ANENQGA8g/Oj0laWxJ4LmT7NoFwJisodyXsD
        K7m+AYbsJz0giN4468cBskEdFm5ZeqI=
X-Google-Smtp-Source: ABdhPJz5pnDLlqGufOGNaHfWViUPSnadwn3IJj6U3cxvEwG4ZWCyJKVpmL3uCTm09bH2LYUGThMBjw==
X-Received: by 2002:a05:6000:1cf:: with SMTP id t15mr32364208wrx.180.1595408393160;
        Wed, 22 Jul 2020 01:59:53 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id 1sm6402337wmf.0.2020.07.22.01.59.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jul 2020 01:59:52 -0700 (PDT)
Subject: Re: [RFC PATCH v2 6/6] ASoC: q6asm-dai: add support to
 set_codec_params
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com,
        tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        vkoul@kernel.org
References: <20200721170007.4554-1-srinivas.kandagatla@linaro.org>
 <20200721170007.4554-7-srinivas.kandagatla@linaro.org>
 <970e7065-4731-e553-f07f-896aaa57c5dc@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <13cb597d-996a-1772-e3db-ffece4a70fb8@linaro.org>
Date:   Wed, 22 Jul 2020 09:59:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <970e7065-4731-e553-f07f-896aaa57c5dc@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Thanks Pierre for quick review.

On 21/07/2020 21:09, Pierre-Louis Bossart wrote:
> 
> 
> On 7/21/20 12:00 PM, Srinivas Kandagatla wrote:
>> Make use of new set_codec_params callback to allow decoder switching
>> during gapless playback.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   sound/soc/qcom/qdsp6/q6asm-dai.c | 33 ++++++++++++++++++++++++++++++++
>>   1 file changed, 33 insertions(+)
>>
>> diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c 
>> b/sound/soc/qcom/qdsp6/q6asm-dai.c
>> index b5c719682919..a8cfb1996614 100644
>> --- a/sound/soc/qcom/qdsp6/q6asm-dai.c
>> +++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
>> @@ -876,6 +876,37 @@ static int 
>> __q6asm_dai_compr_set_codec_params(struct snd_soc_component *componen
>>       return 0;
>>   }
>> +static int q6asm_dai_compr_set_codec_params(struct snd_soc_component 
>> *component,
>> +                        struct snd_compr_stream *stream,
>> +                        struct snd_codec *codec)
>> +{
>> +    struct snd_compr_runtime *runtime = stream->runtime;
>> +    struct q6asm_dai_rtd *prtd = runtime->private_data;
>> +    int ret;
>> +
>> +    ret = q6asm_open_write(prtd->audio_client, 
>> prtd->next_track_stream_id,
>> +                   codec->id, codec->profile, prtd->bits_per_sample,
>> +                   true);
>> +    if (ret < 0) {
>> +        pr_err("q6asm_open_write failed\n");
>> +        return ret;
>> +    }
>> +
>> +    ret = __q6asm_dai_compr_set_codec_params(component, stream, codec,
>> +                         prtd->next_track_stream_id);
>> +    if (ret < 0) {
>> +        pr_err("q6asm_open_write failed\n");
>> +        return ret;
>> +    }
>> +
>> +    ret = q6asm_stream_remove_initial_silence(prtd->audio_client,
>> +                           prtd->next_track_stream_id,
>> +                           prtd->initial_samples_drop);
>> +    prtd->next_track_stream_id = 0;
> 
> same comment as in the other patchset, the stream_id toggles between 1 
> and 2, it's not clear to me what 0 means.

Valid stream ids start from 1. to achieve gapless we toggle between 1 and 2.

--srini


> 
> off-by-one bug or feature?
