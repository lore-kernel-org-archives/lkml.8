Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDEBC433ED
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2712620704
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A96Tg//m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbgGQICl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 04:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgGQICk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 04:02:40 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80EEC061755
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 01:02:39 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o2so15935119wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 01:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ed5EvL3G9gT1l44x09gniqXiVev2natp2bMJdHLtU0o=;
        b=A96Tg//maHu+0r1sZYW1Ue25KfWch0FmJByHKRbbGdCZLEyFbyYCgjh+yEpebUYuhP
         sVBFGM0Rv9SC0s5Hyf2RUqR60aqdjqI5yJbSEW+TpWa69Buiki0xrIllt1ILdng8tHDg
         SaL3iuhh3Dtm5ldLttOzoUmwWw6NALo7Ucl2qoZ5XI0e1uXAB4ZaWggfAJThmVotT9FU
         GiZ+1qc+idffTup29WieIrRRXtb3fxvCrPeG9UCUfyVd+OcEhFL7UC/CY5hCTiNxE9xD
         OtS5JSbPWQ0wEdvZiAtd+9JinNj8iPUMwUTFZRXbkrQFBZSE7CS1QbUvgsLTKjk2+ZKG
         KwqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ed5EvL3G9gT1l44x09gniqXiVev2natp2bMJdHLtU0o=;
        b=mLUR/dqXQRBUsYSpn3LVcvrpldKPjokoUkLptzhRJfVo8p/KuVPQ9OllORvVkRWemT
         SPLlKH1VIwnBylz0jQQscFR7iGMvmEoOtAE/NrJ0UBruwMIkW06RgtwyKAu70yMWRNSS
         fbZ5CF0vsC+AcYr5qX8pcRsLHhhUB/Ih0Mjd+gm+XHJ4/oh8XwMO9F8qJta1C8IaF+YX
         KgabC7T0yHlRrY1WD+vnRxStSsX1MmpUQXtOSI7vUn1J5u54dPiDh5DEJe3fr3u3mNmW
         GkAKsuewjz/7WYux4/RqugWkBOneTU1196IfjNyIGWXaVvVnJn0jQoDmrsCLipY6HE9i
         m7Ug==
X-Gm-Message-State: AOAM533WPF1codaE7sNFtaeOZHlSYmh0EkxHfZIiUNM5NrcfF9a2hytH
        la152phuEJ/G5utexmEKtaeSig==
X-Google-Smtp-Source: ABdhPJwEUuzQn7dxmY0LfNwT3P0HP5hKgtS03Hyj6N+HTykWyP6bVZy+El0o2zqUhbn+j7AdPI1W6A==
X-Received: by 2002:a7b:c185:: with SMTP id y5mr8318269wmi.85.1594972958083;
        Fri, 17 Jul 2020 01:02:38 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:9880:a643:3e69:6393? ([2a01:e34:ed2f:f020:9880:a643:3e69:6393])
        by smtp.googlemail.com with ESMTPSA id d13sm12833406wrq.89.2020.07.17.01.02.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 01:02:37 -0700 (PDT)
Subject: Re: [PATCH v6 2/2] clocksource: Ingenic: Add support for the Ingenic
 X1000 OST.
To:     Zhou Yanjie <zhouyanjie@wanyeetech.com>,
        linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org, tglx@linutronix.de,
        paul@crapouillou.net, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com
References: <20200710170259.29028-1-zhouyanjie@wanyeetech.com>
 <20200710170259.29028-3-zhouyanjie@wanyeetech.com>
 <dd01a117-265a-e64b-5871-22f0f752834a@linaro.org>
 <f0dd2ea5-0627-35cf-5a58-aaff0bcb22cd@wanyeetech.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <9c64bc35-c043-6e4b-cfc3-50f19e4cb315@linaro.org>
Date:   Fri, 17 Jul 2020 10:02:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f0dd2ea5-0627-35cf-5a58-aaff0bcb22cd@wanyeetech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2020 08:13, Zhou Yanjie wrote:
> Hi Daniel,
> 
> 在 2020/7/17 下午12:20, Daniel Lezcano 写道:
>> On 10/07/2020 19:02, 周琰杰 (Zhou Yanjie) wrote:
>>> X1000 and SoCs after X1000 (such as X1500 and X1830) had a separate
>>> OST, it no longer belongs to TCU. This driver will register both a
>>> clocksource and a sched_clock to the system.
>>>
>>> Tested-by: 周正 (Zhou Zheng) <sernia.zhou@foxmail.com>
>>> Co-developed-by: 漆鹏振 (Qi Pengzhen) <aric.pzqi@ingenic.com>
>>> Signed-off-by: 漆鹏振 (Qi Pengzhen) <aric.pzqi@ingenic.com>
>>> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
>>> Reviewed-by: Paul Cercueil <paul@crapouillou.net>
>>> ---
>>>
>>> Notes:
>>>      v1->v2:
>>>      Fix compile warnings.
>>>      Reported-by: kernel test robot <lkp@intel.com>
>>>           v2->v3:
>>>      No change.
>>>           v3->v4:
>>>      1.Rename "ost" to "sysost"
>>>      1.Remove unrelated changes.
>>>      2.Remove ost_clock_parent enum.
>>>      3.Remove ost->percpu_timer_channel/ost->global_timer_channel.
>>>      4.Set up independent .recalc_rate/.set_rate for percpu/global
>>> timer.
>>>      5.No longer call functions in variable declarations.
>>>           v4->v5:
>>>      Use "of_io_request_and_map()" instead "of_iomap()".
>>>      Suggested-by: Paul Cercueil <paul@crapouillou.net>
>>>           v5->v6:
>>>      No change.
>>>
>>>   drivers/clocksource/Kconfig          |  11 +
>>>   drivers/clocksource/Makefile         |   1 +
>>>   drivers/clocksource/ingenic-sysost.c | 539
>>> +++++++++++++++++++++++++++++++++++
>>>   3 files changed, 551 insertions(+)
>>>   create mode 100644 drivers/clocksource/ingenic-sysost.c
>>>
>>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>>> index 91418381fcd4..1bca8b8fb30f 100644
>>> --- a/drivers/clocksource/Kconfig
>>> +++ b/drivers/clocksource/Kconfig
>>> @@ -696,6 +696,17 @@ config INGENIC_TIMER
>>>       help
>>>         Support for the timer/counter unit of the Ingenic JZ SoCs.
>>>   +config INGENIC_SYSOST
>>> +    bool "Clocksource/timer using the SYSOST in Ingenic X SoCs"
>> We usually use silent options and let the platform's Kconfig enable it.
>> We show up the option only when COMPILE_TEST is enabled.
>>
>> Is there a reason to do it differently?
> 
> 
> Do you mean
> 
> bool "Clocksource/timer using the SYSOST in Ingenic X SoCs"
> 
> or
> 
> default MACH_INGENIC ?

Both, no default here.

eg.

bool "Clocksource/timer using the SYSOST in Ingenic X SoCs" if COMPILE_TEST

and

in arch/mips/Kconfig in the config MACH_INGENIC section :

...
select INGENIC_SYSOST
...

> This driver has some origins from "INGENIC_TIMER" driver and
> "INGENIC_OST" driver.
> Early Ingenic processors used TCU (timer/counter unit, has 6 or 8
> generic timer channels) to provide clocksource and clockevent (both with
> only 16bit precision). This part of the processor can only use
> "INGENIC_TIMER" driver.
> 
> Later processors provide an independent 32bit or 64bit timer channel
> (still under TCU, known as ost channel, this channel can not generate
> interrupt) to provid higher precision clocksource. The "INGENIC_OST"
> driver is for this channel. These processors can use "INGENIC_TIMER"
> driver, but using "INGENIC_OST" driver to provide higher precision
> clocksource would be a better choice (clockevent still needs to be
> provided by generic timer channel of TCU, and still 16bit precision).
> 
> And the recent processors provide a SYSOST components, it is independent
> from TCU, including a 64bit timer channel for clocksource and a 32bit
> timer channel for clockevent. Although these processors can also use
> "INGENIC_TIMER" driver, but the better choice is completely independent
> use of "INGENIC_SYSOST" driver to provide higher precision clocksource
> and clockevent.

Ok, the rating should do the job then.

Thanks for the explanation.

> You may have already noticed that this independent SYSOST component is
> like an upgraded and streamlined TCU, which only retains one generic
> timer channel that can generate interrupts, upgrade it from 16bit to
> 32bit, and then retain the 64bit ost channel. so the driver code and
> Kconfig code of this patch is largely referenced
> "INGENIC_TIMER" driver and "INGENIC_OST" driver.
> 
> Thanks and best regards!
> 
>>> +    default MACH_INGENIC
>>> +    depends on MIPS || COMPILE_TEST
>>> +    depends on COMMON_CLK
>>> +    select MFD_SYSCON
>>> +    select TIMER_OF
>>> +    select IRQ_DOMAIN
>>> +    help
>>> +      Support for the SYSOST of the Ingenic X Series SoCs.
>>> +
>> [ ... ]
>>
>>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
