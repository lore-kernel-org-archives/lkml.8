Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A56C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 05:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3160206C9
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 05:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w0fjOYCZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgIDFal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 01:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgIDFai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 01:30:38 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F120C061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 22:30:37 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id b19so6424062lji.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 22:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0wsiRp9bi1K3s4KVn3/DmIOjF5/zAHr2ju+az3903zs=;
        b=w0fjOYCZipZfEHhJc0Y5DPKT0RTYpveldC5G2xqoQ4bih4ZPmHo8ixIac1IhY9kt8y
         7+TpxFs7tOgUytAoKVXbLed1w5ykFgWYImg9UAfkMQWYRNhMgEdd3CWiqT4+zqYrkivc
         huLEJtBE5mVged44dR/tpHrKZornIvHnXRQbozVLp9m70p3NfPat03+7nUbo56lw7Dkz
         b18ncRSgHBrinZrkZ735Brvo1tqMQ+rIKTmkqShN/pmXm1WCEyUBht+M3nQpCJI5IDBL
         gem/MIOevTQd2cdfhxxuYk1UqgabbEIppSdoGVayDG051YU5cT2Ur6XnXUSexbouYmt8
         hkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0wsiRp9bi1K3s4KVn3/DmIOjF5/zAHr2ju+az3903zs=;
        b=NM7OY69VQj6LIFcNTS4KqQZiZr+qdGmPs+VktOUFmnou7ffko1vPeZy46539mHRNWm
         kcmylY9smcJI+lH5XcpbBA5KEFPua8UpaoNUIJ4ZAXX6GOgWxNoDknI2qAex8v+yvd6T
         hevRNmpcSD1sNZxUixon/pdQFl0NQaEK3h2RRVGZTfdzfVxzkw5pQP8GfuMOiIZAPkl9
         srA92a2jVqDi9ZDOFLIIGqFD7SD90kSSR1DQhEOP0wEAam8w7TukY/MCSAgk1uYQuobb
         WoFxmw0u/uhnrcVZ2j0kD6+6d+TYz4Y7RW0KEYnvG7ZKlOV5P3vCzzJjAN2obO7PeD9K
         ixOA==
X-Gm-Message-State: AOAM530lrQ0UCpGDiHSTCE4Tx+Jp3QSt+y5j8Qjuh/9kWYHMWKUyKm42
        dGS66cY/ia+SJ9bcWRF/E6aWnmVr7tLmV3Lq9s1diQ==
X-Google-Smtp-Source: ABdhPJyOrGZp+4ZDzbrU8Nm9uPBQEGqLZYon2HxfACgx8oQrE7Sx+ARY0l92/X1M4b6M4Quee59yWdf9EeFShPxICDA=
X-Received: by 2002:a2e:8046:: with SMTP id p6mr2812710ljg.372.1599197433659;
 Thu, 03 Sep 2020 22:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <1599134712-30923-1-git-send-email-sumit.garg@linaro.org>
 <1599134712-30923-2-git-send-email-sumit.garg@linaro.org> <05a195374cc81008e95e258221fe7d2b@kernel.org>
In-Reply-To: <05a195374cc81008e95e258221fe7d2b@kernel.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 4 Sep 2020 11:00:22 +0530
Message-ID: <CAFA6WYNYGGsFwOdh35o2zHZb8k7o8YQ3CPDi_A=5c+VBLY9w_w@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] arm64: smp: Introduce a new IPI as IPI_CALL_NMI_FUNC
To:     Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        julien.thierry.kdev@gmail.com,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Sep 2020 at 22:06, Marc Zyngier <maz@kernel.org> wrote:
>
> On 2020-09-03 13:05, Sumit Garg wrote:
> > Introduce a new inter processor interrupt as IPI_CALL_NMI_FUNC that
> > can be invoked to run special handlers in NMI context. One such handler
> > example is kgdb_nmicallback() which is invoked in order to round up
> > CPUs
> > to enter kgdb context.
> >
> > As currently pseudo NMIs are supported on specific arm64 platforms
> > which
> > incorporates GICv3 or later version of interrupt controller. In case a
> > particular platform doesn't support pseudo NMIs, IPI_CALL_NMI_FUNC will
> > act as a normal IPI which can still be used to invoke special handlers.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  arch/arm64/include/asm/smp.h |  1 +
> >  arch/arm64/kernel/smp.c      | 11 +++++++++++
> >  2 files changed, 12 insertions(+)
> >
> > diff --git a/arch/arm64/include/asm/smp.h
> > b/arch/arm64/include/asm/smp.h
> > index 2e7f529..e85f5d5 100644
> > --- a/arch/arm64/include/asm/smp.h
> > +++ b/arch/arm64/include/asm/smp.h
> > @@ -89,6 +89,7 @@ extern void secondary_entry(void);
> >
> >  extern void arch_send_call_function_single_ipi(int cpu);
> >  extern void arch_send_call_function_ipi_mask(const struct cpumask
> > *mask);
> > +extern void arch_send_call_nmi_func_ipi_mask(const struct cpumask
> > *mask);
> >
> >  #ifdef CONFIG_ARM64_ACPI_PARKING_PROTOCOL
> >  extern void arch_send_wakeup_ipi_mask(const struct cpumask *mask);
> > diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> > index b6bde26..1b4c07c 100644
> > --- a/arch/arm64/kernel/smp.c
> > +++ b/arch/arm64/kernel/smp.c
> > @@ -74,6 +74,7 @@ enum ipi_msg_type {
> >       IPI_TIMER,
> >       IPI_IRQ_WORK,
> >       IPI_WAKEUP,
> > +     IPI_CALL_NMI_FUNC,
> >       NR_IPI
> >  };
> >
> > @@ -793,6 +794,7 @@ static const char *ipi_types[NR_IPI]
> > __tracepoint_string = {
> >       S(IPI_TIMER, "Timer broadcast interrupts"),
> >       S(IPI_IRQ_WORK, "IRQ work interrupts"),
> >       S(IPI_WAKEUP, "CPU wake-up interrupts"),
> > +     S(IPI_CALL_NMI_FUNC, "NMI function call interrupts"),
> >  };
> >
> >  static void smp_cross_call(const struct cpumask *target, unsigned int
> > ipinr);
> > @@ -840,6 +842,11 @@ void arch_irq_work_raise(void)
> >  }
> >  #endif
> >
> > +void arch_send_call_nmi_func_ipi_mask(const struct cpumask *mask)
> > +{
> > +     smp_cross_call(mask, IPI_CALL_NMI_FUNC);
> > +}
> > +
> >  static void local_cpu_stop(void)
> >  {
> >       set_cpu_online(smp_processor_id(), false);
> > @@ -932,6 +939,10 @@ static void do_handle_IPI(int ipinr)
> >               break;
> >  #endif
> >
> > +     case IPI_CALL_NMI_FUNC:
> > +             /* nop, IPI handlers for special features can be added here. */
> > +             break;
> > +
> >       default:
> >               pr_crit("CPU%u: Unknown IPI message 0x%x\n", cpu, ipinr);
> >               break;
>
> I'm really not keen on adding more IPIs to the SMP code. One of the
> main reasons for using these SGIs as normal IRQs was to make them
> "requestable" from non-arch code as if they were standard percpu
> interrupts.
>
> What prevents you from moving that all the way to the kgdb code?
>

Since we only have one SGI left (SGI7) which this patch reserves for
NMI purposes, I am not sure what value add do you see to make it
requestable from non-arch code.

Also, allocating SGI7 entirely to kgdb would not allow us to leverage
it for NMI backtrace support via magic sysrq. But with current
implementation we should be able to achieve that.

Moreover, irq ids for normal interrupts are assigned via DT/ACPI, how
do you envision this for SGIs?

-Sumit

>          M.
> --
> Jazz is not dead. It just smells funny...
