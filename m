Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB87C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 12:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1CE022BEF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 12:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Aasa/CzH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbgGUMQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 08:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728492AbgGUMP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 08:15:59 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9201CC0619D9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 05:15:59 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z15so20951428wrl.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 05:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UaIMmvkFPThAFCANB9tizwAb469qBmnRcxN8sd+XOMM=;
        b=Aasa/CzHTalCki8u/adk85kJFo3xim1tyv35dMUU0oq2MiirYVeJmH/6Y44iJUwswD
         3oltoMZSSlneuTEKdufd/cFf2vEQ/jOM7J/ib10LlGBfa3OAaV1qgzr1OhrCV7/RZ22r
         j4ISx/JB4yhAXQ8C2k4cHBPxGWd4vp413VZkW+zALMRp9QJZHLvqF1as42wESRpG+hpy
         UfVu9+cI3kn835q2hrhz+upTkn7sJAaPgE2xqHlIZt+xKvcsadCDtLOPrqtp+ls4ZSZJ
         VugQXNGOboiNvFqJz3knrbvNLNiOPSKSk6/j38DqvBw3wfoEyh97IGcVz7d0nyIyimj0
         ZZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UaIMmvkFPThAFCANB9tizwAb469qBmnRcxN8sd+XOMM=;
        b=Fo4AioXq2icz/nBSxrs12oNasjDe2dh/Lkw0G0TDXicT3BV/BmMTjhqOlCIRctf9s/
         QnqQVWo9DqKF3O5Kfbfi5GJwCSorNHxOAjubTS7vfqk/KDFoS6mdauL2smvMOe5atJsp
         R90SqtIL/nVIr/9Moy/O1FQozQYFdWs5MBprZEp/emFwOiXzNat7VEkhsXwaDM+RRMeJ
         BG1N+AEKH9W3EqcZLAxEg6/k4J9+z4UGKIEm5Wgj6gBdpqaPRnHM0BQvUIZuQGDNtb3S
         0aQn+mce9fAuV3zKmvP6SXdg7nsxlDcUEu1ROh0qXfRfCGcK3R0lC3hxt+FoIXx8hPfa
         EdYQ==
X-Gm-Message-State: AOAM532RUXip67GGSxrY8HCvXOMKTDUsDuD5OnL6FUMThbHhskiRAZaW
        L3WQeqLBPZKBdNuwfqneYF3Kdg==
X-Google-Smtp-Source: ABdhPJyhysNqfGgE9bSFwrQlNMQuwVOM9eQNPZY+iYSNYEnQokAHmy83ZbiEshAnmadHgHg9whUrLA==
X-Received: by 2002:a5d:4a0b:: with SMTP id m11mr6371761wrq.407.1595333758078;
        Tue, 21 Jul 2020 05:15:58 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:c144:5385:c824:85ce? ([2a01:e34:ed2f:f020:c144:5385:c824:85ce])
        by smtp.googlemail.com with ESMTPSA id p8sm25497574wrq.9.2020.07.21.05.15.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 05:15:57 -0700 (PDT)
Subject: Re: [PATCH v4 2/4] clocksource/drivers: Add CLINT timer driver
To:     Anup Patel <anup@brainfault.org>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Emil Renner Berhing <kernel@esmil.dk>
References: <20200717075101.263332-1-anup.patel@wdc.com>
 <20200717075101.263332-3-anup.patel@wdc.com>
 <63f65ddd-b7c4-b8fd-151c-a77e8c87efed@linaro.org>
 <CAAhSdy2oGAk6A6=SwgCgZ+trmzCMRPOCiB6ibDTL2A_1sUu1og@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <107e3ef3-9f61-05d1-7a91-95d0dc7ea7b8@linaro.org>
Date:   Tue, 21 Jul 2020 14:15:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAhSdy2oGAk6A6=SwgCgZ+trmzCMRPOCiB6ibDTL2A_1sUu1og@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2020 13:49, Anup Patel wrote:
> On Tue, Jul 21, 2020 at 4:32 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 17/07/2020 09:50, Anup Patel wrote:
>>> We add a separate CLINT timer driver for Linux RISC-V M-mode (i.e.
>>> RISC-V NoMMU kernel).
>>>
>>> The CLINT MMIO device provides three things:
>>> 1. 64bit free running counter register
>>> 2. 64bit per-CPU time compare registers
>>> 3. 32bit per-CPU inter-processor interrupt registers
>>>
>>> Unlike other timer devices, CLINT provides IPI registers along with
>>> timer registers. To use CLINT IPI registers, the CLINT timer driver
>>> provides IPI related callbacks to arch/riscv.
>>>
>>> Signed-off-by: Anup Patel <anup.patel@wdc.com>
>>> Tested-by: Emil Renner Berhing <kernel@esmil.dk>
>>> ---
>>>  drivers/clocksource/Kconfig       |   9 ++
>>>  drivers/clocksource/Makefile      |   1 +
>>>  drivers/clocksource/timer-clint.c | 231 ++++++++++++++++++++++++++++++
>>>  include/linux/cpuhotplug.h        |   1 +
>>>  4 files changed, 242 insertions(+)
>>>  create mode 100644 drivers/clocksource/timer-clint.c
>>>
>>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>>> index 91418381fcd4..e1ce0d510a03 100644
>>> --- a/drivers/clocksource/Kconfig
>>> +++ b/drivers/clocksource/Kconfig
>>> @@ -658,6 +658,15 @@ config RISCV_TIMER
>>>         is accessed via both the SBI and the rdcycle instruction.  This is
>>>         required for all RISC-V systems.
>>>
>>> +config CLINT_TIMER
>>> +     bool "Timer for the RISC-V platform"
>>> +     depends on GENERIC_SCHED_CLOCK && RISCV_M_MODE
>>> +     select TIMER_PROBE
>>> +     select TIMER_OF
>>> +     help
>>> +       This option enables the CLINT timer for RISC-V systems. The CLINT
>>> +       driver is usually used for NoMMU RISC-V systems.
>>
>> V3 has a comment about fixing the Kconfig option.
> 
> I have removed "default y" from the Kconfig option as-per your suggestions.
> 
> I looked at other Timer Kconfig options. Most of them have menuconfig name.
> Also, we can certainly have different timer MMIO timer drivers in future. Do
> you still insist on making this kconfig option totally silent ??

Yes, and there is an effort to change the entries to be silent as much
as possible.

Just add:

	bool "Timer for the RISC-V platform" if COMPILE_TEST

and remove the RISCV_M_MODE dependency.

Or alternatively:

replace the RISCV_M_MODE dependency with COMPILE_TEST

The goal is to be able to compile the driver on different platforms for
compilation test covering.

Then when more mmio drivers will added we will figure out.

>> [ ... ]
>>
>>> +{
>>> +     bool *registered = per_cpu_ptr(&clint_clock_event_registered, cpu);
>>> +     struct clock_event_device *ce = per_cpu_ptr(&clint_clock_event, cpu);
>>> +
>>> +     if (!(*registered)) {
>>> +             ce->cpumask = cpumask_of(cpu);
>>> +             clockevents_config_and_register(ce, clint_timer_freq, 200,
>>> +                                              ULONG_MAX);
>>> +             *registered = true;
>>> +     }
>>
>>
>> I was unsure about the clockevents_config_and_register() multiple calls
>> when doing the comment. It seems like it is fine to call it several
>> times and that is done in several places like riscv or arch_arm_timer.
>>
>> It is probably safe to drop the 'registered' code here, sorry for the
>> confusion.
> 
> Okay, will revert these changes.
> 
>>
>>> +     enable_percpu_irq(clint_timer_irq,
>>> +                       irq_get_trigger_type(clint_timer_irq));
>>> +     return 0;
>>> +}
>>> +
>>
>> [ ... ]
>>
>>
>> --
>> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro-blog/> Blog
> 
> Regards,
> Anup
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
