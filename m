Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FF6C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 12:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F89D21941
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 12:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="v/QZOfq2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbgIIM5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 08:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730207AbgIIMhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 08:37:39 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C2BC06179E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 05:27:43 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x14so2697161wrl.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 05:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CG2XT+84Wuj3Ax6i/HGPopfkMBRvTFKfxyuWD81FwW0=;
        b=v/QZOfq2rR+vBFSHYw3fFA87vCXZOjOYaWKvYFLJjYgo0x6ROxsVgz4SizRJvcD1R5
         7E/RVyQBToy4ffgDBrYFuMaOY8kl8/Pivxslpl+iCY+g5WUBmLzx06rS/iiVhBT+B2hJ
         5JwBrg+9/3rPnuXXcqBUsdnRT38vtgiPnODCFmNwupiPzn2Ux1tJdmQD6KmwcC+ZGMvb
         i6C+P8oJVjKH3sxx3NMdXwGEuSPjmqZJeoh/+ZIyJxu7lg3JqRsMFqhiKwUNB4gEnfFx
         hgn88oAniev6NNsySPeHUu8aWYnDZ02OzpLLkcRtqcxbtAKgYchgIVwI232h2KSIk7FK
         zKlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=CG2XT+84Wuj3Ax6i/HGPopfkMBRvTFKfxyuWD81FwW0=;
        b=nRU6fdRdOe/5ZSbHB5hE1PcG2VL7+KykJhwqyug+CyISmhNjAhQfXCyA4Yvh2jzyAU
         jtkcG9aaC+YM1/TGtQlaDqcaRS0+8EtvnFQTG3U7enCoE8QkT0NPbgT+krvE9VjPJYoZ
         D0+E+C721TmQKGrcaYPSItvXKWqzqH+u2ZbdSfT+zrFZP4exE0rCLiPXGexPaJzz2R8R
         zPYdk/WlltE2MYCq4u5ssrhAjpNwQqMLXsW9x+p6aRGcn+Mx5k6NIE1GLBN95sDX9DpB
         wwUI22k1vE7RnkjrxuEhegEM6BNiN7Z0wkjac1T6qkxZmzde+zFNfRVw2mP3PwtFwW0v
         IMLg==
X-Gm-Message-State: AOAM53221BXyovxAZiAKcOeqAZeEN/jCyQbIQYtpwsJFkvm3wKoUNkyb
        0KPFc11efXG3iCFTkMIJldNU4A==
X-Google-Smtp-Source: ABdhPJwWBciM90kw97SqdyeyvQi6l00nYeeWsJ2A63nI0lAvcriRvGbWG/95m43ZZUZQ26SkUU9vZA==
X-Received: by 2002:adf:f70d:: with SMTP id r13mr3717460wrp.317.1599654462504;
        Wed, 09 Sep 2020 05:27:42 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac? ([2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac])
        by smtp.gmail.com with ESMTPSA id a17sm4122938wra.24.2020.09.09.05.27.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 05:27:41 -0700 (PDT)
Subject: Re: [PATCH 4/5] drm/panfrost: add amlogic reset quirk callback
To:     Steven Price <steven.price@arm.com>, robh@kernel.org,
        tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
References: <20200908151853.4837-1-narmstrong@baylibre.com>
 <20200908151853.4837-5-narmstrong@baylibre.com>
 <5efe218c-19d5-c25b-74cc-e5ae5da418a2@arm.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 BSwxi7g3Mu7u5kUByanqHyA=
Organization: Baylibre
Message-ID: <617f6e6b-1171-782a-135a-e3d1a957ef44@baylibre.com>
Date:   Wed, 9 Sep 2020 14:27:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5efe218c-19d5-c25b-74cc-e5ae5da418a2@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On 09/09/2020 14:23, Steven Price wrote:
> On 08/09/2020 16:18, Neil Armstrong wrote:
>> The T820, G31 & G52 GPUs integratewd by Amlogic in the respective GXM, G12A/SM1 & G12B
>> SoCs needs a quirk in the PWR registers at the GPU reset time.
>>
>> Since the documentation of the GPU cores are not public, we do not know what does these
>> values, but they permit having a fully functional GPU running with Panfrost.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>   drivers/gpu/drm/panfrost/panfrost_gpu.c  | 13 +++++++++++++
>>   drivers/gpu/drm/panfrost/panfrost_gpu.h  |  2 ++
>>   drivers/gpu/drm/panfrost/panfrost_regs.h |  3 +++
>>   3 files changed, 18 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
>> index c129aaf77790..018737bd4ac6 100644
>> --- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
>> +++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
>> @@ -80,6 +80,19 @@ int panfrost_gpu_soft_reset(struct panfrost_device *pfdev)
>>       return 0;
>>   }
>>   +void panfrost_gpu_amlogic_quirks(struct panfrost_device *pfdev)
>> +{
>> +    /*
>> +     * The Amlogic integrated Mali-T820, Mali-G31 & Mali-G52 needs
>> +     * these undocumented bits to be set in order to operate
>> +     * correctly.
>> +     * These GPU_PWR registers contains:
>> +     * "device-specific power control value"
>> +     */
>> +    gpu_write(pfdev, GPU_PWR_KEY, 0x2968A819);
> 
> As Alyssa has mentioned this magic value is not Amlogic specific, but is just the unlock key value, so please add the define in panfrost-gpu.h

Acked

> 
>> +    gpu_write(pfdev, GPU_PWR_OVERRIDE1, 0xfff | (0x20 << 16));
> 
> But PWR_OVERRIDE1 is indeed device specific so I can't offer an insight here.

Yep.

> 
>> +}
>> +
>>   static void panfrost_gpu_init_quirks(struct panfrost_device *pfdev)
>>   {
>>       u32 quirks = 0;
>> diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.h b/drivers/gpu/drm/panfrost/panfrost_gpu.h
>> index 4112412087b2..a881d7dc812f 100644
>> --- a/drivers/gpu/drm/panfrost/panfrost_gpu.h
>> +++ b/drivers/gpu/drm/panfrost/panfrost_gpu.h
>> @@ -16,4 +16,6 @@ int panfrost_gpu_soft_reset(struct panfrost_device *pfdev);
>>   void panfrost_gpu_power_on(struct panfrost_device *pfdev);
>>   void panfrost_gpu_power_off(struct panfrost_device *pfdev);
>>   +void panfrost_gpu_amlogic_reset_quirk(struct panfrost_device *pfdev);
> 
> You need to be consistent about the name - this has _reset_, the above function doesn't.

Yep, will be fixed in next version.

Thanks for the review,
Neil

> 
> Steve
> 
>> +
>>   #endif
>> diff --git a/drivers/gpu/drm/panfrost/panfrost_regs.h b/drivers/gpu/drm/panfrost/panfrost_regs.h
>> index ea38ac60581c..fa0d02f3c830 100644
>> --- a/drivers/gpu/drm/panfrost/panfrost_regs.h
>> +++ b/drivers/gpu/drm/panfrost/panfrost_regs.h
>> @@ -51,6 +51,9 @@
>>   #define GPU_STATUS            0x34
>>   #define   GPU_STATUS_PRFCNT_ACTIVE    BIT(2)
>>   #define GPU_LATEST_FLUSH_ID        0x38
>> +#define GPU_PWR_KEY            0x050    /* (WO) Power manager key register */
>> +#define GPU_PWR_OVERRIDE0        0x054    /* (RW) Power manager override settings */
>> +#define GPU_PWR_OVERRIDE1        0x058    /* (RW) Power manager override settings */
>>   #define GPU_FAULT_STATUS        0x3C
>>   #define GPU_FAULT_ADDRESS_LO        0x40
>>   #define GPU_FAULT_ADDRESS_HI        0x44
>>
> 

