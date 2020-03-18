Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4629C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA8FE20771
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pt3x+uRS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgCRL70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 07:59:26 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52632 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgCRL70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 07:59:26 -0400
Received: by mail-wm1-f67.google.com with SMTP id 11so2990893wmo.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 04:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YJqjwINizd0mjxU+F08RGbhSKRJRuplDkN1+krLz9Io=;
        b=Pt3x+uRS/li8KFYyqVdOwKOuFPdkPPdYK4iGxXkx22gyl8xyCbct2cPfaoHMyZTYcA
         rZ4PmmPl5FZqksFWOmKRomE++5WAbzGqPyB1/4OvnH3jwC7ZSPAnx0S9bTFX2gdarewb
         mw0ZJ0ED+uPoXQRtb6yWjQi2fbg5m+ybUvVV8kWXaQQRwm+nwjjjnkxTrFXa7TG06qoF
         TkGCnib1dFKSL9aszKx7MXcW/9pmyXBxb9lvqu2xiWEuSmbK99DPxDBrubMF8TQE1Z+z
         P0bEpXpewb3U5Aw53MTFc/7t3AA+cQ21vUnsQWR1727aeusgoaSVoT2lGfPcQi/FGbRb
         +1Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YJqjwINizd0mjxU+F08RGbhSKRJRuplDkN1+krLz9Io=;
        b=U6PQXVDAC9DhpWEXLIdBpjcaohSvP4ASlAD0RSajdVf/j8VgpS9sYdjG+a6GXgoKj6
         EZMmedRR4x/MNppIaT+ZLlPgOFPMNTcH9APcwLCD1AGWYjWijJDETkn7GLB2y+ER0Gj2
         azlKAVgeUH+xOL6bKo1Kir9vpM2EXCQ3Ubx51XUbs5lt+EB/aHf0rnk5iQTltTTsMyiX
         1hU2IfpAHTCyHB3KcOEB8GVNhxkkD8BlFWxj4fX5atGVEySo17gZlyQ3I53flw8s9Fs7
         bNXSL7OGamSYg1FdpUuQJFpgZHjKv4/mePM3LYJUHaNz0jJJMilwiZyUXKJJf49HlyQ5
         ZX+g==
X-Gm-Message-State: ANhLgQ1ZQF9i8Cc8YhSpxg1LAOgja0/OUtGEggyW3QzV6pfOP+2HqieP
        3M5fUeHRsAFGzRgbXIJgXCPwMg==
X-Google-Smtp-Source: ADFU+vvSL2S8Zk4kOLlmqKuwdQt3oO0VIUxIQXZukISeVwAVMKksfVbyrSNcY+B2b7oCBoxLUVTeYg==
X-Received: by 2002:a05:600c:2319:: with SMTP id 25mr4948012wmo.106.1584532763247;
        Wed, 18 Mar 2020 04:59:23 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id c4sm3653831wml.7.2020.03.18.04.59.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2020 04:59:22 -0700 (PDT)
Subject: Re: [PATCH 1/2] ASoC: qcom: sdm845: handle soundwire stream
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        linux-kernel@vger.kernel.org, vkoul@kernel.org
References: <20200317095351.15582-1-srinivas.kandagatla@linaro.org>
 <20200317095351.15582-2-srinivas.kandagatla@linaro.org>
 <8daeeb26-851b-8311-30f5-5d285ccbc255@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <69c72f5a-e72e-b7b3-90cb-a7354dcb175d@linaro.org>
Date:   Wed, 18 Mar 2020 11:59:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8daeeb26-851b-8311-30f5-5d285ccbc255@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/03/2020 13:07, Pierre-Louis Bossart wrote:
> 
>> @@ -45,11 +48,20 @@ static int sdm845_slim_snd_hw_params(struct 
>> snd_pcm_substream *substream,
>>       struct snd_soc_pcm_runtime *rtd = substream->private_data;
>>       struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
>>       struct snd_soc_dai *codec_dai;
>> +    struct sdm845_snd_data *pdata = snd_soc_card_get_drvdata(rtd->card);
>>       u32 rx_ch[SLIM_MAX_RX_PORTS], tx_ch[SLIM_MAX_TX_PORTS];
>> +    struct sdw_stream_runtime *sruntime;
>>       u32 rx_ch_cnt = 0, tx_ch_cnt = 0;
>>       int ret = 0, i;
>>       for_each_rtd_codec_dais(rtd, i, codec_dai) {
>> +        sruntime = snd_soc_dai_get_sdw_stream(codec_dai,
>> +                              substream->stream);
>> +        if (sruntime != ERR_PTR(-ENOTSUPP))
>> +            pdata->sruntime[cpu_dai->id] = sruntime;
>> +        else
>> +            pdata->sruntime[cpu_dai->id] = NULL;
>> +
> 
> Can you explain this part?
> The get_sdw_stream() is supposed to return what was set by 
> set_sdw_stream(), so if it's not supported isn't this an error?

In this case its not an error because we have
totally 3 codecs in this path.
One wcd934x Slimbus codec and two wsa881x Soundwire Codec.

wcd934x codec side will return ENOTSUPP which is not an error.

> 
>>           ret = snd_soc_dai_get_channel_map(codec_dai,
>>                   &tx_ch_cnt, tx_ch, &rx_ch_cnt, rx_ch);
>> @@ -425,8 +437,65 @@ static void  sdm845_snd_shutdown(struct 
>> snd_pcm_substream *substream)
>>       }
>>   }
>> +static int sdm845_snd_prepare(struct snd_pcm_substream *substream)
>> +{
>> +    struct snd_soc_pcm_runtime *rtd = substream->private_data;
>> +    struct sdm845_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
>> +    struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
>> +    struct sdw_stream_runtime *sruntime = data->sruntime[cpu_dai->id];
>> +    int ret;
>> +
>> +    if (!sruntime)
>> +        return 0;
> 
> same here, isn't this an error?

These callbacks are used for other dais aswell in this case
HDMI, Slimbus and Soundwire, so sruntime being null is not treated as error.

> 
>> +    if (data->stream_prepared[cpu_dai->id]) {
>> +        sdw_disable_stream(sruntime);
>> +        sdw_deprepare_stream(sruntime);
>> +        data->stream_prepared[cpu_dai->id] = false;
>> +    }
>> +
>> +    ret = sdw_prepare_stream(sruntime);
>> +    if (ret)
>> +        return ret;
>> +
>> +    /**
>> +     * NOTE: there is a strict hw requirement about the ordering of port
>> +     * enables and actual WSA881x PA enable. PA enable should only 
>> happen
>> +     * after soundwire ports are enabled if not DC on the line is
>> +     * accumulated resulting in Click/Pop Noise
>> +     * PA enable/mute are handled as part of codec DAPM and digital 
>> mute.
>> +     */
>> +
>> +    ret = sdw_enable_stream(sruntime);
>> +    if (ret) {
>> +        sdw_deprepare_stream(sruntime);
>> +        return ret;
>> +    }
>> +    data->stream_prepared[cpu_dai->id] = true;
>> +
>> +    return ret;
>> +}
>> +
>> +static int sdm845_snd_hw_free(struct snd_pcm_substream *substream)
>> +{
>> +    struct snd_soc_pcm_runtime *rtd = substream->private_data;
>> +    struct sdm845_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
>> +    struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
>> +    struct sdw_stream_runtime *sruntime = data->sruntime[cpu_dai->id];
>> +
>> +    if (sruntime && data->stream_prepared[cpu_dai->id]) {
> 
> and here?
> 
> Really wondering where the stream is actually allocated and set.

Controller is allocating the runtime in this case.

> 
>> +        sdw_disable_stream(sruntime);
>> +        sdw_deprepare_stream(sruntime);
>> +        data->stream_prepared[cpu_dai->id] = false;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   static const struct snd_soc_ops sdm845_be_ops = {
>>       .hw_params = sdm845_snd_hw_params,
>> +    .hw_free = sdm845_snd_hw_free,
>> +    .prepare = sdm845_snd_prepare,
>>       .startup = sdm845_snd_startup,
>>       .shutdown = sdm845_snd_shutdown,
>>   };
>>
