Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2F9C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 05:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0222206BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 05:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H3SECMdL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgGQF2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 01:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbgGQF2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 01:28:46 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED9FC061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 22:28:46 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 17so15463515wmo.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 22:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3R841zjQJ873CPLugpq+yROuqcowWRWOM1I9YnQC0yw=;
        b=H3SECMdLBtoMFmBF8gwG7s68I1WI9g2z6KWf3uQwmopAlMDMBluxJ+IEfjBJ99v07N
         /dKcpfxRDsYE5eMibCoLsQ315MiIT3MdOv4AxOaq/CGFZsyxa1xVF18O/WlhtHY7j4gp
         rIcwEd9JNllTxFbyuIbucoyE0hI9NMONm+3mQbPi71qD4veRNfgQfrqn8EuFBlby/qll
         kRzmBoJRsV0VuonT4YsYyNc8x1zazXe+/fu9Sr0NryKm0Bgo/QJ+I/sJSpD8dTHzvesy
         XDUMDDtJoEsmjETrFP5jc3Fqyg3xnfOZDZc5D3aWo66R+BPcpISpS+Uv1tjuDxq38m5l
         okYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3R841zjQJ873CPLugpq+yROuqcowWRWOM1I9YnQC0yw=;
        b=twM46ai86DtDP3UYkwgT5MSvw26K1lJwfY1/r6q1i0g8J7JosEmLD67yDNNI1IPNu+
         fTLg+J1RMG4QIaPbn8Lfn8J96xTPaHvV4yYlaGLXTF5waMlh8Zx+lccmcHxPTM1SZjzd
         6HBNd5Q8VXQqexmoMrEjbYlB5pjUlk/jShDWnYNLC502YMA5wv0/HbydhnNgapIrXWpe
         JH+Gf/FD0WsdBlHAy55Ik34C+ZmE7pzSRoF0NZ2v3oLxz/A9Mv2+x24G25lAyle+9TIK
         ZJFUcykY/vVeo3S4/GxqCwUi2MlJSKL85cIxMvro609ck73vmemNqYzZ2XD/eg3IGQp2
         l/4g==
X-Gm-Message-State: AOAM531muj5V5fjoGNr8XYYHdIdCGs5uglWoUysqR+kvIzs5APiLa+5E
        CPwUhEu8sARD08oPWoEW8NfZNw==
X-Google-Smtp-Source: ABdhPJxvGoh8uftGdmqMg5u8XecWSwJcj4NaXq0/cWbuqhlLaZUM5md9QxgWeBOhWPoDygZC0p00kw==
X-Received: by 2002:a1c:5453:: with SMTP id p19mr7244739wmi.41.1594963724692;
        Thu, 16 Jul 2020 22:28:44 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:9880:a643:3e69:6393? ([2a01:e34:ed2f:f020:9880:a643:3e69:6393])
        by smtp.googlemail.com with ESMTPSA id x1sm12158853wrp.10.2020.07.16.22.28.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 22:28:44 -0700 (PDT)
Subject: Re: [PATCH v3 2/4] clocksource/drivers: Add CLINT timer driver
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
        devicetree@vger.kernel.org
References: <20200715071506.10994-1-anup.patel@wdc.com>
 <20200715071506.10994-3-anup.patel@wdc.com>
 <9a36824c-ef23-de47-b52c-bf680067be6c@linaro.org>
 <CAAhSdy3iurBWELjrjKr4mWdueZqw3xmf2e6AD_Km0PE+5TZHWQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <212eb026-e063-2b64-757b-9ca0e3f430bf@linaro.org>
Date:   Fri, 17 Jul 2020 07:28:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAhSdy3iurBWELjrjKr4mWdueZqw3xmf2e6AD_Km0PE+5TZHWQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2020 07:21, Anup Patel wrote:
> On Fri, Jul 17, 2020 at 2:57 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>>
>> Hi Anup,
>>
>>
>> On 15/07/2020 09:15, Anup Patel wrote:
>>> The TIME CSR and SBI calls are not available in RISC-V M-mode so we
>>> separate add CLINT driver for Linux RISC-V M-mode (i.e. RISC-V NoMMU
>>> kernel).
>>
>> The description is confusing, please reword it and give a bit more
>> information about the timer itself, especially, the IPI thing.
> 
> Okay, will update.
> 
>>
>>> Signed-off-by: Anup Patel <anup.patel@wdc.com>
>>> ---
>>>  drivers/clocksource/Kconfig       |  10 ++
>>>  drivers/clocksource/Makefile      |   1 +
>>>  drivers/clocksource/timer-clint.c | 229 ++++++++++++++++++++++++++++++
>>>  include/linux/cpuhotplug.h        |   1 +
>>>  4 files changed, 241 insertions(+)
>>>  create mode 100644 drivers/clocksource/timer-clint.c
>>>
>>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>>> index 91418381fcd4..eabcf1cfb0c0 100644
>>> --- a/drivers/clocksource/Kconfig
>>> +++ b/drivers/clocksource/Kconfig
>>> @@ -658,6 +658,16 @@ config RISCV_TIMER
>>>         is accessed via both the SBI and the rdcycle instruction.  This is
>>>         required for all RISC-V systems.
>>>
>>> +config CLINT_TIMER
>>> +     bool "Timer for the RISC-V platform"
>>> +     depends on GENERIC_SCHED_CLOCK && RISCV_M_MODE
>>> +     default y
>>> +     select TIMER_PROBE
>>> +     select TIMER_OF
>>> +     help
>>> +       This option enables the CLINT timer for RISC-V systems. The CLINT
>>> +       driver is usually used for NoMMU RISC-V systems.
>>
>> For the timer, we do silent option and let the platform config select
>> it. Please refer to other timer option below as reference.
> 
> Okay, I will use "default RISCV" instead of "default y" (just like other
> timer Kconfig options).

Preferably, select it from the platform's Kconfig.

>>
>>>  config CSKY_MP_TIMER
>>>       bool "SMP Timer for the C-SKY platform" if COMPILE_TEST
>>>       depends on CSKY
>>> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
>>> index bdda1a2e4097..18e700e703a0 100644
>>> --- a/drivers/clocksource/Makefile
>>> +++ b/drivers/clocksource/Makefile
>>> @@ -87,6 +87,7 @@ obj-$(CONFIG_CLKSRC_ST_LPC)         += clksrc_st_lpc.o
>>>  obj-$(CONFIG_X86_NUMACHIP)           += numachip.o
>>>  obj-$(CONFIG_ATCPIT100_TIMER)                += timer-atcpit100.o
>>>  obj-$(CONFIG_RISCV_TIMER)            += timer-riscv.o
>>> +obj-$(CONFIG_CLINT_TIMER)            += timer-clint.o
>>>  obj-$(CONFIG_CSKY_MP_TIMER)          += timer-mp-csky.o
>>>  obj-$(CONFIG_GX6605S_TIMER)          += timer-gx6605s.o
>>>  obj-$(CONFIG_HYPERV_TIMER)           += hyperv_timer.o
>>> diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
>>> new file mode 100644
>>> index 000000000000..bfc38bb5a589
>>> --- /dev/null
>>> +++ b/drivers/clocksource/timer-clint.c
>>> @@ -0,0 +1,229 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Copyright (C) 2020 Western Digital Corporation or its affiliates.
>>> + *
>>> + * Most of the M-mode (i.e. NoMMU) RISC-V systems usually have a
>>> + * CLINT MMIO timer device.
>>> + */
>>> +
>>> +#define pr_fmt(fmt) "clint: " fmt
>>> +#include <linux/bitops.h>
>>> +#include <linux/clocksource.h>
>>> +#include <linux/clockchips.h>
>>> +#include <linux/cpu.h>
>>> +#include <linux/delay.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of_address.h>
>>> +#include <linux/sched_clock.h>
>>> +#include <linux/io-64-nonatomic-lo-hi.h>
>>> +#include <linux/interrupt.h>
>>> +#include <linux/of_irq.h>
>>> +#include <linux/smp.h>
>>> +
>>> +#define CLINT_IPI_OFF                0
>>> +#define CLINT_TIMER_CMP_OFF  0x4000
>>> +#define CLINT_TIMER_VAL_OFF  0xbff8
>>> +
>>> +/* CLINT manages IPI and Timer for RISC-V M-mode  */
>>> +static u32 __iomem *clint_ipi_base;
>>> +static u64 __iomem *clint_timer_cmp;
>>> +static u64 __iomem *clint_timer_val;
>>> +static unsigned long clint_timer_freq;
>>> +static unsigned int clint_timer_irq;
>>> +
>>> +static void clint_send_ipi(const struct cpumask *target)
>>> +{
>>> +     unsigned int cpu;
>>> +
>>> +     for_each_cpu(cpu, target)
>>> +             writel(1, clint_ipi_base + cpuid_to_hartid_map(cpu));
>>> +}
>>> +
>>> +static void clint_clear_ipi(void)
>>> +{
>>> +     writel(0, clint_ipi_base + cpuid_to_hartid_map(smp_processor_id()));
>>> +}
>>> +
>>> +static struct riscv_ipi_ops clint_ipi_ops = {
>>> +     .ipi_inject = clint_send_ipi,
>>> +     .ipi_clear = clint_clear_ipi,
>>> +};
>>> +
>>> +#ifdef CONFIG_64BIT
>>> +#define clint_get_cycles()   readq_relaxed(clint_timer_val)
>>> +#else
>>> +#define clint_get_cycles()   readl_relaxed(clint_timer_val)
>>> +#define clint_get_cycles_hi()        readl_relaxed(((u32 *)clint_timer_val) + 1)
>>> +#endif
>>> +
>>> +#ifdef CONFIG_64BIT
>>> +static u64 clint_get_cycles64(void)
>>> +{
>>> +     return clint_get_cycles();
>>> +}
>>> +#else /* CONFIG_64BIT */
>>> +static u64 clint_get_cycles64(void)
>>> +{
>>> +     u32 hi, lo;
>>> +
>>> +     do {
>>> +             hi = clint_get_cycles_hi();
>>> +             lo = clint_get_cycles();
>>> +     } while (hi != clint_get_cycles_hi());
>>> +
>>> +     return ((u64)hi << 32) | lo;
>>> +}
>>> +#endif /* CONFIG_64BIT */
>>> +static int clint_clock_next_event(unsigned long delta,
>>> +                                struct clock_event_device *ce)
>>> +{
>>> +     void __iomem *r = clint_timer_cmp +
>>> +                       cpuid_to_hartid_map(smp_processor_id());
>>> +
>>> +     csr_set(CSR_IE, IE_TIE);
>>> +     writeq_relaxed(clint_get_cycles64() + delta, r);
>>> +     return 0;
>>> +}
>>> +
>>> +static DEFINE_PER_CPU(struct clock_event_device, clint_clock_event) = {
>>> +     .name                   = "clint_clockevent",
>>> +     .features               = CLOCK_EVT_FEAT_ONESHOT,
>>> +     .rating         = 100,
>>> +     .set_next_event = clint_clock_next_event,
>>> +};
>>> +
>>> +static u64 clint_rdtime(struct clocksource *cs)
>>> +{
>>> +     return readq_relaxed(clint_timer_val);
>>> +}
>>> +
>>> +static u64 notrace clint_sched_clock(void)
>>> +{
>>> +     return readq_relaxed(clint_timer_val);
>>> +}
>>> +
>>> +static struct clocksource clint_clocksource = {
>>> +     .name           = "clint_clocksource",
>>> +     .rating = 300,
>>> +     .mask           = CLOCKSOURCE_MASK(64),
>>> +     .flags          = CLOCK_SOURCE_IS_CONTINUOUS,
>>> +     .read           = clint_rdtime,
>>
>> What if !CONFIG_64BIT
> 
> The CLINT counter is 64bit for both 32bit and 64bit systems
> but I should have used clint_get_cycles64() in clint_rdtime().
> I will update it.
> 
>>
>>> +};
>>> +
>>> +static int clint_timer_starting_cpu(unsigned int cpu)
>>> +{
>>> +     struct clock_event_device *ce = per_cpu_ptr(&clint_clock_event, cpu);
>>> +
>>> +     ce->cpumask = cpumask_of(cpu);
>>> +     clockevents_config_and_register(ce, clint_timer_freq, 200, ULONG_MAX);
>>
>> The function is not immune against registering the same clockevents. If
>> the CPU is hotplugged several times, this function will be called again
>> and again. Why not rely on a for_each_possible_cpu loop in the init
>> function ?
>>
>>> +     enable_percpu_irq(clint_timer_irq,
>>> +                       irq_get_trigger_type(clint_timer_irq));
>>
>> Why do you want to enable / disable the interrrupts ? The should be
>> already handle by the hotplug framework no ?
> 
> The perCPU interrupts are not enabled by default. We have to
> explicitly enable/disable perCPU interrupts in CPU hotplug callbacks.
> 

Isn't is possible to do that in the probe/init function ?



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
