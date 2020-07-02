Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFD2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C9C920836
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p3qEh2yu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgGBM3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 08:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728851AbgGBM3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 08:29:46 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF932C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 05:29:45 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f2so73484wrp.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 05:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F7ADKstiUA1jlXfnZezsRSHSfHeXBJYzWOck7lyLBO0=;
        b=p3qEh2yuP4idrIvPNJ2XymaB/KFwSNz8Q4nEP3+29yobB0KHxXczMWIfLb1R+hbtWZ
         MVH3eTJDp/jibT4bLSXsRkKWUobpuZ3K6kWUtngNsDQrjeaPjC/ShGqZIXDreUt7D/5t
         zX1VBnfYcDGIaVWiQXGdFTRQqdC474OI+CYVHaqMv6gbEgG9zvn/Eqxsr4FonV569veO
         rHc0J0GIBCy9m1HgZorXvdbAJnUeHNQeGeEBtGU0+vxyqJLCIRX7oihTplW3F5OGBKum
         XDgrDewTczRQbn4mcSwiKEDW33ACOsrFwUbYCl/Y+VIkhbUwh+Tgg8SeIQxEDFPTYdfI
         iLqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F7ADKstiUA1jlXfnZezsRSHSfHeXBJYzWOck7lyLBO0=;
        b=WUN0TvPOKMyW5KPnmS8KqXXvI94Pf8maptXybnOAFW8sfJjJz5jKmEeLCJi1n80pq1
         wl63+Oenk2Iu1MXeioRIMfLKyUafmkT1ij1KJTLdN8fjFPjJK/HkQ54QmvE/VD7OoqoI
         okUXHICoVBI+fyUzz1PbCqbK6kdityPi3CpmGFdsIwpAujM1w/dniB22cQyFhSldGY6M
         p7ssblYkYVBx2qkre4hk6bQGFBlpY139Gc4hzW9sbOfOIIr21lqEMA0LxecLJo5rAoWr
         zk1HGGEPzcwHpYGRtES3akRVRNq+nZMf5VttyAM7pniikv9/xOA/esMGmvZzxqjUCwD5
         wTqA==
X-Gm-Message-State: AOAM533B7h8uTpKEzBPwDO44TswYMoTt7CvpK4n7ssXmLzuPgDwyXkPz
        AchD52YLKg3M/8qhaCfeWWfObA==
X-Google-Smtp-Source: ABdhPJxU4y1UngKV/QTV/BKMqev/m67+73ckS++pCe3deSLEAG6wPcL6cPo0aXQUqzsX6Mvs+OyP0Q==
X-Received: by 2002:adf:84e2:: with SMTP id 89mr32755173wrg.139.1593692984581;
        Thu, 02 Jul 2020 05:29:44 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id u84sm10486458wme.42.2020.07.02.05.29.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jul 2020 05:29:43 -0700 (PDT)
Subject: Re: [RFC PATCH] ALSA: compress: add support to change codec profile
 in gapless playback
To:     Vinod Koul <vkoul@kernel.org>
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ckeepax@opensource.cirrus.com
References: <20200702111114.32217-1-srinivas.kandagatla@linaro.org>
 <20200702113602.GA273932@vkoul-mobl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <a67b809e-2a8d-20ed-c62a-e79a9315c953@linaro.org>
Date:   Thu, 2 Jul 2020 13:29:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200702113602.GA273932@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Vinod for quick review,

On 02/07/2020 12:36, Vinod Koul wrote:
> Hi Srini,
> 
> On 02-07-20, 12:11, Srinivas Kandagatla wrote:
>> For gapless playback its possible that each track can have different
> 
> s/its/it is
> 
>> codec profile with same decoder, for example we have WMA album,
>> we may have different tracks as WMA v9, WMA v10 and so on
>>
>> Existing code does not allow to change this profile while doing gapless
>> playback.
>>
>> This patch adds new SNDRV_COMPRESS_SET_CODEC_PARAMS IOCTL to allow
>> userspace to set this new parameters required for new codec profile.
> 
> Thanks, this looks good and in line with discussions done in Audio uConf
> 
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   include/sound/compress_driver.h       |  5 +++
>>   include/sound/soc-component.h         |  3 ++
>>   include/sound/soc-dai.h               |  5 +++
>>   include/uapi/sound/compress_offload.h |  1 +
>>   sound/core/compress_offload.c         | 54 ++++++++++++++++++++++++---
>>   sound/soc/soc-compress.c              | 30 +++++++++++++++
>>   sound/soc/soc-dai.c                   | 14 +++++++
> 
> Can we split the ALSA changes and ASoC changes to different patches
> please?
> 
> Also please post driver support for this API..
Yes, q6dsp gapless patches are the users for this api, I will include
them in next version.

> 
> Lastly, documentation needs update about this call
> 
I will fix these in next version!

>>   7 files changed, 106 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/sound/compress_driver.h b/include/sound/compress_driver.h
>> index 70cbc5095e72..8d23351f7ad7 100644
>> --- a/include/sound/compress_driver.h
>> +++ b/include/sound/compress_driver.h
>> @@ -93,6 +93,9 @@ struct snd_compr_stream {
>>    * @set_params: Sets the compressed stream parameters, mandatory
>>    * This can be called in during stream creation only to set codec params
>>    * and the stream properties
>> + * @set_codec_params: Sets the compressed stream codec parameters, mandatory
> 
> This should be optional as gapless is optional
> 
>> --- a/include/uapi/sound/compress_offload.h
>> +++ b/include/uapi/sound/compress_offload.h
>> @@ -172,6 +172,7 @@ struct snd_compr_metadata {
>>   						 struct snd_compr_metadata)
>>   #define SNDRV_COMPRESS_GET_METADATA	_IOWR('C', 0x15,\
>>   						 struct snd_compr_metadata)
>> +#define SNDRV_COMPRESS_SET_CODEC_PARAMS	_IOW('C', 0x16, struct snd_codec)
>>   #define SNDRV_COMPRESS_TSTAMP		_IOR('C', 0x20, struct snd_compr_tstamp)
>>   #define SNDRV_COMPRESS_AVAIL		_IOR('C', 0x21, struct snd_compr_avail)
>>   #define SNDRV_COMPRESS_PAUSE		_IO('C', 0x30)
> 
> I think we should bump the compress version too for checking in userland
> about this support
Sure!

> 
>>   static int snd_compress_check_input(struct snd_compr_params *params)
>>   {
>>   	/* first let's check the buffer parameter's */
>> @@ -574,14 +586,41 @@ static int snd_compress_check_input(struct snd_compr_params *params)
>>   	    params->buffer.fragments == 0)
>>   		return -EINVAL;
>>   
>> -	/* now codec parameters */
>> -	if (params->codec.id == 0 || params->codec.id > SND_AUDIOCODEC_MAX)
>> -		return -EINVAL;
>> +	return snd_compress_check_codec_params(&params->codec);
> 
> Can this be 1st patch to prepare for this change?
> 
>>   
>> -	if (params->codec.ch_in == 0 || params->codec.ch_out == 0)
>> -		return -EINVAL;
>> +}
>>   
>> -	return 0;
>> +static int snd_compr_set_codec_params(struct snd_compr_stream *stream,
>> +				      unsigned long arg)
>> +{
>> +	struct snd_codec *params;
>> +	int retval;
>> +
>> +	if (!stream->ops->set_codec_params)
>> +		return -EPERM;
>> +
>> +	if (stream->runtime->state != SNDRV_PCM_STATE_RUNNING)
>> +		return -EPERM;
>> +
>> +	/* codec params can be only set when next track has been signalled */
>> +	if (stream->next_track == false)
>> +		return -EPERM;
>> +
>> +	params = memdup_user((void __user *)arg, sizeof(*params));
>> +	if (IS_ERR(params))
>> +		return PTR_ERR(params);
>> +
>> +	retval = snd_compress_check_codec_params(params);
>> +	if (retval)
>> +		goto out;
>> +
>> +	retval = stream->ops->set_codec_params(stream, params);
>> +	if (retval)
>> +		goto out;
> 
> this jump is superfluous
yes, we could just remove the check!

> 
>> +
>> +out:
>> +	kfree(params);
>> +	return retval;
>>   }
> 
> ...
> 
>> +static int soc_compr_set_codec_params(struct snd_compr_stream *cstream,
>> +				      struct snd_codec *codec)
>> +{
>> +	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
>> +	struct snd_soc_component *component;
>> +	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
>> +	int i, ret;
>> +
>> +	mutex_lock_nested(&rtd->card->pcm_mutex, rtd->card->pcm_subclass);
>> +
>> +	ret = snd_soc_dai_compr_set_codec_params(cpu_dai, cstream, codec);
>> +	if (ret < 0)
>> +		goto err;
>> +
>> +	for_each_rtd_components(rtd, i, component) {
>> +		if (!component->driver->compress_ops ||
>> +		    !component->driver->compress_ops->set_codec_params)
>> +			continue;
>> +
>> +		ret = component->driver->compress_ops->set_codec_params(component, cstream,
>> +								     codec);
> 
> maybe use a compress_ops pointer to make this look and read better :)

Sure will do that!

--srini

> 
