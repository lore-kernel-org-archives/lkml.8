Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C048CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 20:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8370520643
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 20:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H1xrtfIJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgERUYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 16:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgERUYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 16:24:03 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCEFC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 13:24:02 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id i15so13305856wrx.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 13:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5B0bvyb+czYXibRbo3frDkeWMomKS71UWI1iUCkQxS8=;
        b=H1xrtfIJsEgJbCyguOTKrsaF7WUbw/aM1YPdMJ53dhZz2PctJVBahR4Dlix3h9RpPO
         TRfbTX5dArJn57NI+zOx8ju3PdHlAU5buJNt7sKD29mDpp4bk1b7q10o2qCe2CcG2SfF
         VvwHzCZSj+D+0KW3p+0UDYynUca0TMEXbP5ZBUkIn4hsiF5ahUNoOZ+7aR46RHos2hh7
         MiaGdLwfeMY4/4Kj9dwrknNyGleySWethq75DXFaopaLm4Jzc1De+HYw2Oh7hG7KKg9e
         jirlcwI6Qev8P8jee/iNmR95QtJtKnr5CCz96Bl0FECiHXOs+EpKD4+l5SKFbH6nvTc5
         oYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5B0bvyb+czYXibRbo3frDkeWMomKS71UWI1iUCkQxS8=;
        b=oTw4Pbazt2aC3Ao6qW+Zva2XBOxFcK7Xu3hfRwJ2RnjPr6bLScCAhZ2KLT/Ijk7UWn
         pwQqoXHU5z26JGiaHosC7Uz9kowpw7uymnS/DfD4SUbXm5IyP187xjbUxScbc/Sd0tZA
         qSBdrS1M2nja/xgtY3d43SG1mJapQtlExkBm+OxUDeyxckLB5f9Qh/zc0Vm1kSrO3kvn
         rDBG12scbwMZnRlzq9KIpDCmdMtDbNvKlY5E9UmRG6abGsonc/3sdz3kT2GEwjOn8lvj
         6QNU4SQFecgNLi490Sz75rTc5MqreRb5q6fiZDtVwArSzZ9Ye1U/OrpRGuqpbTapKkVI
         eq9Q==
X-Gm-Message-State: AOAM531ZRTzC9CEqQ9vzInC66vkRyPvlTA5DzzqGIDfvvkFWGq3Ngb5S
        4LF/LRafHNIVvn0WYCAPvAGywg==
X-Google-Smtp-Source: ABdhPJxnle0Ka9+nAQQbbufJUi1PeIgz/OINpBlvEqYX/F0IMX1TMNzubsaAi7WtxvNzOLQLCbVubg==
X-Received: by 2002:a5d:6605:: with SMTP id n5mr23240499wru.198.1589833441326;
        Mon, 18 May 2020 13:24:01 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:9e7:3ac5:a930:2cd8? ([2a01:e34:ed2f:f020:9e7:3ac5:a930:2cd8])
        by smtp.googlemail.com with ESMTPSA id w9sm19689253wrc.27.2020.05.18.13.24.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 13:24:00 -0700 (PDT)
Subject: Re: [PATCH 09/10] timer-riscv: Fix undefined riscv_time_val
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, tglx@linutronix.de
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        hulkci@huawei.com
References: <mhng-0c491e9e-41fd-4f76-a048-55c03d9359f0@palmerdabbelt-glaptop1>
 <66121f9a-48f3-d3a5-7c96-d71397e12aed@linaro.org>
 <0bc3eb36-7b9d-7c86-130c-68b566e85c10@huawei.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e1916079-c209-bfad-6b0c-ccfb2e136ca4@linaro.org>
Date:   Mon, 18 May 2020 22:23:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <0bc3eb36-7b9d-7c86-130c-68b566e85c10@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Kefeng,

On 18/05/2020 17:40, Kefeng Wang wrote:
> 
> On 2020/5/18 22:09, Daniel Lezcano wrote:
>> On 13/05/2020 23:14, Palmer Dabbelt wrote:
>>> On Sun, 10 May 2020 19:20:00 PDT (-0700), wangkefeng.wang@huawei.com
>>> wrote:
>>>> ERROR: modpost: "riscv_time_val" [crypto/tcrypt.ko] undefined!
>>>>
>>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>> ---
>>>>   drivers/clocksource/timer-riscv.c | 1 +
>>>>   1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/clocksource/timer-riscv.c
>>>> b/drivers/clocksource/timer-riscv.c
>>>> index c4f15c4068c0..071b8c144027 100644
>>>> --- a/drivers/clocksource/timer-riscv.c
>>>> +++ b/drivers/clocksource/timer-riscv.c
>>>> @@ -19,6 +19,7 @@
>>>>
>>>>   u64 __iomem *riscv_time_cmp;
>>>>   u64 __iomem *riscv_time_val;
>>>> +EXPORT_SYMBOL(riscv_time_val);
>>>>
>>>>   static inline void mmio_set_timer(u64 val)
>>>>   {
>>> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
>>> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
>>>
>>> Adding the clocksource maintainers.  Let me know if you want this
>>> through my
>>> tree, I'm assuming you want it through your tree.
>> How can we end up by an export symbol here ?!
> 
> Hi Danile,

s/Danile/Daniel/

> Found this build error when CONFIG_RISCV_M_MODE=y and CONFIG_RISCV_SBI
> is not,
> 
> see patch "4f9bbcefa142 riscv: add support for MMIO access to the timer
> registers"

Thanks for the pointer.

The question still remains, how do we end up with this EXPORT_SYMBOL?

There is something wrong if the fix is an EXPORT_SYMBOL for a global
variable.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
