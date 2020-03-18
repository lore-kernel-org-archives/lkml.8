Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75E3C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 15:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82CF42076D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 15:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgCRP20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 11:28:26 -0400
Received: from mga09.intel.com ([134.134.136.24]:57410 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726856AbgCRP2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 11:28:25 -0400
IronPort-SDR: IW4kkBh5jYk0Yjc90q7dM3pWANifmshJsWOuZHI6w1Oy4Dcgdrbe2MAVSwSk1UgZzqZzXgeonD
 xnkG8ovF+3Vg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2020 08:28:25 -0700
IronPort-SDR: G42k5j9C+Udeti2e8o0QxUDv4p9YSyXsUyVWRcMeC8ssQM82hCw3eerjprY4E8Jg44CfvLbpHS
 NC3hIwhi0zZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,568,1574150400"; 
   d="scan'208";a="417985195"
Received: from nali1-mobl3.amr.corp.intel.com (HELO [10.255.33.194]) ([10.255.33.194])
  by orsmga005.jf.intel.com with ESMTP; 18 Mar 2020 08:28:24 -0700
Subject: Re: [PATCH 1/2] ASoC: qcom: sdm845: handle soundwire stream
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        linux-kernel@vger.kernel.org, vkoul@kernel.org
References: <20200317095351.15582-1-srinivas.kandagatla@linaro.org>
 <20200317095351.15582-2-srinivas.kandagatla@linaro.org>
 <8daeeb26-851b-8311-30f5-5d285ccbc255@linux.intel.com>
 <69c72f5a-e72e-b7b3-90cb-a7354dcb175d@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <cbc6cc9b-24f5-8c2a-b60d-b5dab08c128e@linux.intel.com>
Date:   Wed, 18 Mar 2020 10:26:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <69c72f5a-e72e-b7b3-90cb-a7354dcb175d@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>>>       for_each_rtd_codec_dais(rtd, i, codec_dai) {
>>> +        sruntime = snd_soc_dai_get_sdw_stream(codec_dai,
>>> +                              substream->stream);
>>> +        if (sruntime != ERR_PTR(-ENOTSUPP))
>>> +            pdata->sruntime[cpu_dai->id] = sruntime;
>>> +        else
>>> +            pdata->sruntime[cpu_dai->id] = NULL;
>>> +
>>
>> Can you explain this part?
>> The get_sdw_stream() is supposed to return what was set by 
>> set_sdw_stream(), so if it's not supported isn't this an error?
> 
> In this case its not an error because we have
> totally 3 codecs in this path.
> One wcd934x Slimbus codec and two wsa881x Soundwire Codec.
> 
> wcd934x codec side will return ENOTSUPP which is not an error.

I must admit I am quite confused here.
After reading your response, I thought this was a case of codec-to-codec 
dailink, but then you also have a notion of cpu_dai?

>>
>>>           ret = snd_soc_dai_get_channel_map(codec_dai,
>>>                   &tx_ch_cnt, tx_ch, &rx_ch_cnt, rx_ch);
>>> @@ -425,8 +437,65 @@ static void  sdm845_snd_shutdown(struct 
>>> snd_pcm_substream *substream)
>>>       }
>>>   }
>>> +static int sdm845_snd_prepare(struct snd_pcm_substream *substream)
>>> +{
>>> +    struct snd_soc_pcm_runtime *rtd = substream->private_data;
>>> +    struct sdm845_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
>>> +    struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
>>> +    struct sdw_stream_runtime *sruntime = data->sruntime[cpu_dai->id];
>>> +    int ret;
>>> +
>>> +    if (!sruntime)
>>> +        return 0;
>>
>> same here, isn't this an error?
> 
> These callbacks are used for other dais aswell in this case
> HDMI, Slimbus and Soundwire, so sruntime being null is not treated as 
> error.

Same comment, how does the notion of cpu_dai come in the picture for a 
SoundWire dailink?
Would you mind listing what the components of the dailinks are?
