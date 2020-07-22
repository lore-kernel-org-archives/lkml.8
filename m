Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34983C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0896020787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M4C+ZODB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731069AbgGVJAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 05:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbgGVJAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 05:00:03 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB218C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 02:00:02 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y3so1111744wrl.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 02:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vEurh4VLUZ8RQchp/nZukq9HgvAFG/riRsef7JlAm2g=;
        b=M4C+ZODBdCX7zNkJ/IbfXpaaNE2kidJCTZUSur0UicCWZAkzLX1G06l9y+CKC5eVvR
         rsgIuelUOYK2MQkfN8g3TX7hXt7EYdc7UGzFKYL9P0uw8j4UnVJaupRah9W3Zu0lW2s8
         lG6JTPuc2B/j9eM33DuEXX1eiK85Q6wh07wDLhFRga8Sleg/RMNUbRJDhzYfdoxjejWA
         C806h4znm9hB1t1QSWRqX093eMydW44pFwwnbD5+TybK3V86JDrP/ZX+HwsqhxQUXqKy
         11SGBDcoYQn66zdF6U0T+G66WAiW98e1IUOuK8S/y9edFAJoXUFAiKfJ/SmfWYE/0JGG
         Cnzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vEurh4VLUZ8RQchp/nZukq9HgvAFG/riRsef7JlAm2g=;
        b=t3LYiEULJa7UOENhIbBSCBJg+PkPphrf/cstGwqSgynfDjRNW0CYDMp40sNzjFx8pF
         cA8OZ4RHMLsnj/JIxVwVJXjiGuJBbdrWNGGh82iqeoxNjpSsm+/2q3ihejB9ydYJDenO
         SRqw9sLvRZzmSOhlJ01H69JS/YW+K8VRJ9VV6pX3Ou/ScnqN1hw9tiT18VxE5bBL/ER+
         KiuFJnIj4k44A7J0AFYAQY8pKXw6jXbU+4pZGRvmwkNdy0YPM/AowQAbnAp47RPsXki/
         cdepzXMIb40AaoeGrXJRDKWzBTkrAiVbRKzagQg0ARA5ci3LW5IIpxm8uxY8jjxwvmvY
         hJuQ==
X-Gm-Message-State: AOAM532/PvxjYSl16LIXnOLg1fJcGYMaZU22D4O54WPnUCwcq7R95uB5
        JNaP6FaHpQ4zHo5NddakJ/21fA==
X-Google-Smtp-Source: ABdhPJzcngyS0WMyfwBqxzzteoncRL6n3m7nbTadp0pXZyIDMhEKrztRiYPDtfC+9R8Fg3A+bYA6xg==
X-Received: by 2002:a5d:4283:: with SMTP id k3mr29734493wrq.322.1595408400486;
        Wed, 22 Jul 2020 02:00:00 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id f9sm40793497wru.47.2020.07.22.01.59.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jul 2020 01:59:59 -0700 (PDT)
Subject: Re: [RFC PATCH v2 2/6] ALSA: compress: add new ioctl for setting
 codec parameters
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com,
        tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        vkoul@kernel.org
References: <20200721170007.4554-1-srinivas.kandagatla@linaro.org>
 <20200721170007.4554-3-srinivas.kandagatla@linaro.org>
 <ee2dc239-c1a7-f48f-c6f0-ec6e61ccdda6@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <9bbfebf9-9a70-46e3-1808-413d04aa6b2c@linaro.org>
Date:   Wed, 22 Jul 2020 09:59:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ee2dc239-c1a7-f48f-c6f0-ec6e61ccdda6@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/07/2020 21:05, Pierre-Louis Bossart wrote:
> 
> 
> On 7/21/20 12:00 PM, Srinivas Kandagatla wrote:
>> For gapless playback it is possible that each track can have different
>> codec profile with same decoder, for example we have WMA album,
>> we may have different tracks as WMA v9, WMA v10 and so on
>>
>> Or if DSP's like QDSP have abililty to switch decoders on single stream
> 
> ability
> 
>> for each track, then this call could be used to set new codec parameters.
>>
>> Existing code does not allow to change this profile while doing gapless
>> playback.
>>
>> This patch adds new SNDRV_COMPRESS_SET_CODEC_PARAMS IOCTL to allow
>> userspace to set this new parameters required for new codec profile.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   .../sound/designs/compress-offload.rst        |  6 ++++
>>   include/sound/compress_driver.h               |  5 +++
>>   include/uapi/sound/compress_offload.h         |  1 +
>>   sound/core/compress_offload.c                 | 34 +++++++++++++++++++
>>   4 files changed, 46 insertions(+)
>>
>> diff --git a/Documentation/sound/designs/compress-offload.rst 
>> b/Documentation/sound/designs/compress-offload.rst
>> index 935f325dbc77..305ccc7bfdd9 100644
>> --- a/Documentation/sound/designs/compress-offload.rst
>> +++ b/Documentation/sound/designs/compress-offload.rst
>> @@ -128,6 +128,12 @@ set_params
>>     cases decoders will ignore other fields, while encoders will strictly
>>     comply to the settings
>> +set_codec_params
>> +  This routine is very much simillar to set_params but exculding stream
> 
> typos: similar, excluding
> 
>> +  information. Only codec related information is set as part of this.
>> +  It is used in gapless playback where its required to change decoder
>> +  or its parameters for next track. This is optional.
>> +
>>   get_params
>>     This routines returns the actual settings used by the DSP. Changes to
>>     the settings should remain the exception.
>> diff --git a/include/sound/compress_driver.h 
>> b/include/sound/compress_driver.h
>> index 70cbc5095e72..d9c00bcfce9b 100644
>> --- a/include/sound/compress_driver.h
>> +++ b/include/sound/compress_driver.h
>> @@ -93,6 +93,9 @@ struct snd_compr_stream {
>>    * @set_params: Sets the compressed stream parameters, mandatory
>>    * This can be called in during stream creation only to set codec 
>> params
>>    * and the stream properties
>> + * @set_codec_params: Sets the compressed stream codec parameters, 
>> Optional
>> + * This can be called in during gapless next track codec change only 
>> to set
>> + * codec params
> 
> Would it be clearer if this was called set_next_codec_params()? or 
> set_next_track_codec_params()?
> 
> Having set_params() and set_codec_params() is a bit confusing since the 
> semantic difference is not captured in the callback name.

set_next_track_codec_params seems more sensible as its next track params.
Will change this in next version!

--srini

> 
