Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF1BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 13:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9290207D8
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 13:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fzm2colE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbgESNvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 09:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbgESNvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 09:51:12 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5DEC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 06:51:12 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f134so3164922wmf.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 06:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ys7r3qotLzzWaWhq9vVdrgrhhROTJgno1lweCnsUlJA=;
        b=fzm2colEUsT+TUViv8WS4wjalsLOjeAfXbhlgm+V1KGZT4hDxaA2LWyEczY5Lu74aV
         4O7zsNC1i+IflOc1i1HkRWS2tXs7Z48MtQN+CcN76BK1EG92QH9CumZTwjtjQWMm2KnA
         KADgar5kGafqe4R0DWM1Jehr/cp3W45n5vmFFNg5Q4D6srgt033qR7HvK/2gTWChl87e
         CkAVs1e4y9JStKPiN3z+3vJcB2SVZDs/4zQjMb2V5e6l2JJYenPUKycVqZ9bIKclmfdi
         3XzOCC0BQM3AXy82C8lbXtG4aas2kuM/P0+zRc8sHO6FVfl/EvliKYbmwSE662rnEFtR
         2tJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ys7r3qotLzzWaWhq9vVdrgrhhROTJgno1lweCnsUlJA=;
        b=qZhShPABifaiDzAcSsphlzMKZjUYd0+5D46+FLx1AFwyGoY4SIc86t2clBqWlj2L9R
         p2Vz43O3m4/ilSTN1+gR6PwJ7cO880R9fJj15+AcO4aD5Ob4mb7qEHteMo7o38RE1qET
         gOiZDBYnv6bx9cPL7E3yjiIp3G+mx4vCyu1OT5Ff6LEV1Uiqb4ptk2UBsfiCVcgKJgQk
         JCSFUGzbb9i6o/pEZKxGvcgNAWS9c9bK7rZJTcYusjBzK8aRXhDUpPHKaBFBUWylxWni
         Nhxu4rgsjB3o7Wt3+IbQmekhBSAUnztlZh2WUb5x7LWQFtNGhwr20TWKBG1c+zwsqF2s
         i5vQ==
X-Gm-Message-State: AOAM5338VoSNkU7nshI8ZtWjwRTYHNSOkbfaM8/p0z8bbQ74f0iJ1Qzd
        vACeUvDiP+gSd+OJamVUw5U1hA==
X-Google-Smtp-Source: ABdhPJzs+51TVNZNv6Czy4tb35EXHHN6WGmkr18m2/J2dyfhi3Gk7Oj7qToikxglM6x4gLVmhP0CAA==
X-Received: by 2002:a7b:cc0e:: with SMTP id f14mr5620926wmh.39.1589896270455;
        Tue, 19 May 2020 06:51:10 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:e504:4297:986:ffb0? ([2a01:e34:ed2f:f020:e504:4297:986:ffb0])
        by smtp.googlemail.com with ESMTPSA id q17sm4243965wmk.36.2020.05.19.06.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 06:51:09 -0700 (PDT)
Subject: Re: [PATCH 09/10] timer-riscv: Fix undefined riscv_time_val
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, tglx@linutronix.de
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        hulkci@huawei.com
References: <mhng-0c491e9e-41fd-4f76-a048-55c03d9359f0@palmerdabbelt-glaptop1>
 <66121f9a-48f3-d3a5-7c96-d71397e12aed@linaro.org>
 <0bc3eb36-7b9d-7c86-130c-68b566e85c10@huawei.com>
 <e1916079-c209-bfad-6b0c-ccfb2e136ca4@linaro.org>
 <29dc112e-d8c2-2749-7f5d-7c0c19aa9092@huawei.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <8c5ecbd3-c23a-ccd4-b5d8-2e7d2bd10699@linaro.org>
Date:   Tue, 19 May 2020 15:51:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <29dc112e-d8c2-2749-7f5d-7c0c19aa9092@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/05/2020 14:39, Kefeng Wang wrote:
> 
> On 2020/5/19 4:23, Daniel Lezcano wrote:
>> Hi Kefeng,
>>
>> On 18/05/2020 17:40, Kefeng Wang wrote:
>>> On 2020/5/18 22:09, Daniel Lezcano wrote:
>>>> On 13/05/2020 23:14, Palmer Dabbelt wrote:
>>>>> On Sun, 10 May 2020 19:20:00 PDT (-0700), wangkefeng.wang@huawei.com
>>>>> wrote:
>>>>>> ERROR: modpost: "riscv_time_val" [crypto/tcrypt.ko] undefined!
>>>>>>
>>>>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>>>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>>>> ---
>>>>>>    drivers/clocksource/timer-riscv.c | 1 +
>>>>>>    1 file changed, 1 insertion(+)
>>>>>>
>>>>>> diff --git a/drivers/clocksource/timer-riscv.c
>>>>>> b/drivers/clocksource/timer-riscv.c
>>>>>> index c4f15c4068c0..071b8c144027 100644
>>>>>> --- a/drivers/clocksource/timer-riscv.c
>>>>>> +++ b/drivers/clocksource/timer-riscv.c
>>>>>> @@ -19,6 +19,7 @@
>>>>>>
>>>>>>    u64 __iomem *riscv_time_cmp;
>>>>>>    u64 __iomem *riscv_time_val;
>>>>>> +EXPORT_SYMBOL(riscv_time_val);
>>>>>>
>>>>>>    static inline void mmio_set_timer(u64 val)
>>>>>>    {
>>>>> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
>>>>> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
>>>>>
>>>>> Adding the clocksource maintainers.  Let me know if you want this
>>>>> through my
>>>>> tree, I'm assuming you want it through your tree.
>>>> How can we end up by an export symbol here ?!
>>> Hi Danile,
>> s/Danile/Daniel/
> Sorry for typing error.
>>
>>> Found this build error when CONFIG_RISCV_M_MODE=y and CONFIG_RISCV_SBI
>>> is not,
>>>
>>> see patch "4f9bbcefa142 riscv: add support for MMIO access to the timer
>>> registers"
>> Thanks for the pointer.
>>
>> The question still remains, how do we end up with this EXPORT_SYMBOL?
>>
>> There is something wrong if the fix is an EXPORT_SYMBOL for a global
>> variable.
> 
> Not very clear, there are some global variable( eg, acpi_disabled,
> memstart_addr in arm64,) is exported by EXPORT_SYMBOL,  do you mean that
> export riscv_time_val is wrong way?

I do not maintain acpi neither arm64.mm.

AFAICT, riscv_time_val is globally declared in
drivers/clocksource/timer-riscv.c

The driver does not use this variable at all. Then there is a readl on
it in the header file arch/riscv/include/asm/timex.h

And finally it is initialized in arch/riscv/kernel/clint.c

Same thing for riscv_time_cmp.

The correct fix is to initialize the variables in the place where they
belong to (drivers/clocksource/timer-riscv.c), create a function to read
their content and export-symbol-gpl the function.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
