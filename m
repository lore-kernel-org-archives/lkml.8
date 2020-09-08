Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AA7C2BC11
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 22:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6647A2075A
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 22:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AInFNOYL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbgIHWr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 18:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728442AbgIHWrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 18:47:52 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E571C061755
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 15:47:50 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id i1so729522edv.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 15:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VRxAb4sSeTWgSZoJEmEpicMjsCQqRWVgihxxxfCY+8k=;
        b=AInFNOYLEiGa8ZYHJ+PrI8RgfzTLqmCerGMHATQhjM8e/J8sMTkvFzyrpxNquoa9Lm
         BtkcXxcrdo/xq6R7ez41eLN7hF6bOEA6IXaJI0PY3tD/4k2hSOzXqrwpjaYOcD6NiHHz
         6hVOnNIeALhlI8tW7qUq86krZzamNKA7IZOTAzv6l0j+o/iuApEteq7Je8bQvyZwQQj/
         xakUoBpSJYS//M5r0zf7kfEh9vXrK2Y2kKDvtXPV3m4zrYClHg7U3/HJJ2ZzNH0i3o13
         /T1Ptq6FcTT8LLgHI3iMCzBo7HIm9lgRmgwrVZDahwrAJcQ1KYhC8TlVaa1J67Z4kvDJ
         GgOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VRxAb4sSeTWgSZoJEmEpicMjsCQqRWVgihxxxfCY+8k=;
        b=OQIsEeBl5L/9Lnr0P7A4aWBoUGnJQ/0xwTC+x9FLVlJcAep0v45CSuULT8HYFND2sY
         bFgI+ElHdX0SFIoCQscAsOzLGL4H/ePYpESLDZqoju2hyaMg0BRO5HNnWt+kM/SxXGE9
         Niv5T+S1hTWeEPj5SJLzXoxNGJGvQueIysOZgcgSVs5VicdP0xkw4i00BE8QXglij7Bm
         Qg/YJtQR38l1Dn+zHXPuTPvGDKt4VGDO3vWgNSwquJtT0rVcB9eG7JCIZd/qEfJS5mHm
         mNIoDy+P9e36WQpMSDb025m7NlTYvnTnSNPWRaRCzuaWKf5fUpJr8kDvQMHPxvAg3AtM
         jhng==
X-Gm-Message-State: AOAM533yvzs78XtEwAoMbOVdiNMJ9g/EyJd67o0C3B65+jlcZJi43E1a
        bXxQ54AT6tYjs8EmaaEVU1EHfA==
X-Google-Smtp-Source: ABdhPJyBVcQuoFsZ0wvTWVT1hoz1fMF/ozEdUm0gl1e7OpLSLPkXfxN3ZE8OKYkSifBDes5JCPP8NQ==
X-Received: by 2002:a05:6402:1d05:: with SMTP id dg5mr1262004edb.67.1599605267971;
        Tue, 08 Sep 2020 15:47:47 -0700 (PDT)
Received: from [192.168.1.6] ([195.24.90.54])
        by smtp.googlemail.com with ESMTPSA id lo25sm404818ejb.53.2020.09.08.15.47.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 15:47:47 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] venus: firmware: Set virtual address ranges
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Elliot Berman <eberman@codeaurora.org>,
        Andy Gross <agross@kernel.org>
References: <20200817082723.17458-1-stanimir.varbanov@linaro.org>
 <20200817082723.17458-3-stanimir.varbanov@linaro.org>
 <20200908143954.GK3715@yoga>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <83573727-3cf1-27bc-f13e-d81657d16327@linaro.org>
Date:   Wed, 9 Sep 2020 01:47:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908143954.GK3715@yoga>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/8/20 5:39 PM, Bjorn Andersson wrote:
> On Mon 17 Aug 03:27 CDT 2020, Stanimir Varbanov wrote:
> 
>> In order to boot some of the new Venus firmware versions TZ call to set
>> virtual address ranges is needed. Add virtual address ranges for CP and
>> CP_NONPIX in resource structure and use them when loading and booting
>> the firmware on remote processor.
>>
>> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>> ---
>>  drivers/media/platform/qcom/venus/core.c     |  4 ++++
>>  drivers/media/platform/qcom/venus/core.h     |  4 ++++
>>  drivers/media/platform/qcom/venus/firmware.c | 18 +++++++++++++++++-
>>  3 files changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
>> index 203c6538044f..5f8f7b72731c 100644
>> --- a/drivers/media/platform/qcom/venus/core.c
>> +++ b/drivers/media/platform/qcom/venus/core.c
>> @@ -527,6 +527,10 @@ static const struct venus_resources sdm845_res_v2 = {
>>  	.vmem_size = 0,
>>  	.vmem_addr = 0,
>>  	.dma_mask = 0xe0000000 - 1,
>> +	.cp_start = 0,
>> +	.cp_size = 0x70800000,
>> +	.cp_nonpixel_start = 0x1000000,
>> +	.cp_nonpixel_size = 0x24800000,
>>  	.fwname = "qcom/venus-5.2/venus.mdt",
>>  };
>>  
>> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
>> index 7118612673c9..8c88516e4694 100644
>> --- a/drivers/media/platform/qcom/venus/core.h
>> +++ b/drivers/media/platform/qcom/venus/core.h
>> @@ -68,6 +68,10 @@ struct venus_resources {
>>  	unsigned int vmem_id;
>>  	u32 vmem_size;
>>  	u32 vmem_addr;
>> +	u32 cp_start;
>> +	u32 cp_size;
>> +	u32 cp_nonpixel_start;
>> +	u32 cp_nonpixel_size;
>>  	const char *fwname;
>>  };
>>  
>> diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
>> index 8801a6a7543d..ac906ffc608f 100644
>> --- a/drivers/media/platform/qcom/venus/firmware.c
>> +++ b/drivers/media/platform/qcom/venus/firmware.c
>> @@ -181,6 +181,7 @@ static int venus_shutdown_no_tz(struct venus_core *core)
>>  int venus_boot(struct venus_core *core)
>>  {
>>  	struct device *dev = core->dev;
>> +	const struct venus_resources *res = core->res;
>>  	phys_addr_t mem_phys;
>>  	size_t mem_size;
>>  	int ret;
>> @@ -200,7 +201,22 @@ int venus_boot(struct venus_core *core)
>>  	else
>>  		ret = venus_boot_no_tz(core, mem_phys, mem_size);
>>  
>> -	return ret;
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (core->use_tz && res->cp_size) {
>> +		ret = qcom_scm_mem_protect_video_var(res->cp_start,
>> +						     res->cp_size,
>> +						     res->cp_nonpixel_start,
>> +						     res->cp_nonpixel_size);
>> +		if (ret) {
>> +			dev_err(dev, "set virtual address ranges fail (%d)\n",
>> +				ret);
>> +			return ret;
> 
> Afaict venus_probe() will tear down clocks and power of the now running
> Venus core when you return an error here. Isn't it necessary to stop the
> core here as well?

I guess by "stop the core" you mean a call to qcom_scm_pas_shutdown() ?
If so, I think it makes sense.

-- 
regards,
Stan
