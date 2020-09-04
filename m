Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89E3C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 11:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7794C206B7
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 11:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mSdxz4fg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730182AbgIDLdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 07:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730105AbgIDLcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 07:32:16 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AE8C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 04:32:15 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id w3so7521772ljo.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 04:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3zA99aEMQ+GSN3rlEJk+n2U8t/Kxnc6IxQCFC33HIVA=;
        b=mSdxz4fgtsgSS2l9njzIYvSmIlX80hvCnTvP/OgE02oJ4nDD6UKwizm4D7pYEV9/oB
         tEbt7dHQNZO90wBDaS9dLTOH3TjgVJK62Qdxp3nj989prYsaxM5XJE20K/8QK3/7SqZW
         Rs4zfFheOchEGYvixvNV8Dl6RNgZp5wwVcRUbWZDg+FvS8e7MMS5G3GTA1pvFe4Sn9IK
         Iw+PG4lHpcmVmI5ZudeQeOLTrfqnwRivA7UeFYXQF7BLJ8gw/QPEIugIuJnobfN3dhDg
         veR63F4DQdtkKOBLjGfzzJqrJW4/JaXH9pA+ARPCeGL0/34Rp9ZXyk+2jLpYybARdMQ9
         q+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3zA99aEMQ+GSN3rlEJk+n2U8t/Kxnc6IxQCFC33HIVA=;
        b=kc73QxtBxqnQCKkQUBjwv0A4DsdqwEy2im9kmn6I5lLbxidUJZBU2QbjwxbabL+G/Y
         joXXwvWreh2E8Pwrxn/IUBXQAWZZo2h7MuGCDoK2GypTK5xIxCv4fC4Q44+yx40IKQGV
         08utIL5X/UMv216biheM45ogzY1HNbmzu2wpJ+VLPuRufPFCds0tFxuM/bk00VcAkN0F
         O9TVQS9tuhe21wbtUDTzJT5e8avjJukxC5DXhVPlLKM3ahab0e91UiChv6F8jVKAwCe8
         N7LKKLaJ0WHucAeoZleu5mVVDoaLxiFYj1JKvfsU0yhvlgTpVfIa+0qPjFh2hViHQ7hf
         SKBA==
X-Gm-Message-State: AOAM5300Y8cV0hDhgtdo4rk3Rr2jyr4UJ7Ni6TYdtSOGFxLp0FdbD5kv
        gjmsPabPr2oZ+nZT65UrRJHJJoIuVOZQ7n8RknsNlIxzKcKB6Q==
X-Google-Smtp-Source: ABdhPJw6mw/bMokIo9Rs/jiLGSH2soJ9lHD4kwKbbHitnqslUJIg+RrmP0RYM6dir4mKgHThQjhIaXEzNK+sM2Hafq4=
X-Received: by 2002:a2e:9ad9:: with SMTP id p25mr3319272ljj.256.1599219133711;
 Fri, 04 Sep 2020 04:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <1599134712-30923-1-git-send-email-sumit.garg@linaro.org>
 <1599134712-30923-2-git-send-email-sumit.garg@linaro.org> <05a195374cc81008e95e258221fe7d2b@kernel.org>
 <CAFA6WYNYGGsFwOdh35o2zHZb8k7o8YQ3CPDi_A=5c+VBLY9w_w@mail.gmail.com> <6125bdeb9ebd0cb51aa85fe36dee841c@kernel.org>
In-Reply-To: <6125bdeb9ebd0cb51aa85fe36dee841c@kernel.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 4 Sep 2020 17:02:02 +0530
Message-ID: <CAFA6WYNe_x7oCvN6uysXJ0sFBDzLk49-p5uxUydzdUv5zimwsQ@mail.gmail.com>
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

On Fri, 4 Sep 2020 at 13:30, Marc Zyngier <maz@kernel.org> wrote:
>
> On 2020-09-04 06:30, Sumit Garg wrote:
> > On Thu, 3 Sep 2020 at 22:06, Marc Zyngier <maz@kernel.org> wrote:
> >>
> >> On 2020-09-03 13:05, Sumit Garg wrote:
> >> > Introduce a new inter processor interrupt as IPI_CALL_NMI_FUNC that
> >> > can be invoked to run special handlers in NMI context. One such handler
> >> > example is kgdb_nmicallback() which is invoked in order to round up
> >> > CPUs
> >> > to enter kgdb context.
> >> >
> >> > As currently pseudo NMIs are supported on specific arm64 platforms
> >> > which
> >> > incorporates GICv3 or later version of interrupt controller. In case a
> >> > particular platform doesn't support pseudo NMIs, IPI_CALL_NMI_FUNC will
> >> > act as a normal IPI which can still be used to invoke special handlers.
> >> >
> >> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> >> > ---
> >> >  arch/arm64/include/asm/smp.h |  1 +
> >> >  arch/arm64/kernel/smp.c      | 11 +++++++++++
> >> >  2 files changed, 12 insertions(+)
> >> >
> >> > diff --git a/arch/arm64/include/asm/smp.h
> >> > b/arch/arm64/include/asm/smp.h
> >> > index 2e7f529..e85f5d5 100644
> >> > --- a/arch/arm64/include/asm/smp.h
> >> > +++ b/arch/arm64/include/asm/smp.h
> >> > @@ -89,6 +89,7 @@ extern void secondary_entry(void);
> >> >
> >> >  extern void arch_send_call_function_single_ipi(int cpu);
> >> >  extern void arch_send_call_function_ipi_mask(const struct cpumask
> >> > *mask);
> >> > +extern void arch_send_call_nmi_func_ipi_mask(const struct cpumask
> >> > *mask);
> >> >
> >> >  #ifdef CONFIG_ARM64_ACPI_PARKING_PROTOCOL
> >> >  extern void arch_send_wakeup_ipi_mask(const struct cpumask *mask);
> >> > diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> >> > index b6bde26..1b4c07c 100644
> >> > --- a/arch/arm64/kernel/smp.c
> >> > +++ b/arch/arm64/kernel/smp.c
> >> > @@ -74,6 +74,7 @@ enum ipi_msg_type {
> >> >       IPI_TIMER,
> >> >       IPI_IRQ_WORK,
> >> >       IPI_WAKEUP,
> >> > +     IPI_CALL_NMI_FUNC,
> >> >       NR_IPI
> >> >  };
> >> >
> >> > @@ -793,6 +794,7 @@ static const char *ipi_types[NR_IPI]
> >> > __tracepoint_string = {
> >> >       S(IPI_TIMER, "Timer broadcast interrupts"),
> >> >       S(IPI_IRQ_WORK, "IRQ work interrupts"),
> >> >       S(IPI_WAKEUP, "CPU wake-up interrupts"),
> >> > +     S(IPI_CALL_NMI_FUNC, "NMI function call interrupts"),
> >> >  };
> >> >
> >> >  static void smp_cross_call(const struct cpumask *target, unsigned int
> >> > ipinr);
> >> > @@ -840,6 +842,11 @@ void arch_irq_work_raise(void)
> >> >  }
> >> >  #endif
> >> >
> >> > +void arch_send_call_nmi_func_ipi_mask(const struct cpumask *mask)
> >> > +{
> >> > +     smp_cross_call(mask, IPI_CALL_NMI_FUNC);
> >> > +}
> >> > +
> >> >  static void local_cpu_stop(void)
> >> >  {
> >> >       set_cpu_online(smp_processor_id(), false);
> >> > @@ -932,6 +939,10 @@ static void do_handle_IPI(int ipinr)
> >> >               break;
> >> >  #endif
> >> >
> >> > +     case IPI_CALL_NMI_FUNC:
> >> > +             /* nop, IPI handlers for special features can be added here. */
> >> > +             break;
> >> > +
> >> >       default:
> >> >               pr_crit("CPU%u: Unknown IPI message 0x%x\n", cpu, ipinr);
> >> >               break;
> >>
> >> I'm really not keen on adding more IPIs to the SMP code. One of the
> >> main reasons for using these SGIs as normal IRQs was to make them
> >> "requestable" from non-arch code as if they were standard percpu
> >> interrupts.
> >>
> >> What prevents you from moving that all the way to the kgdb code?
> >>
> >
> > Since we only have one SGI left (SGI7) which this patch reserves for
> > NMI purposes, I am not sure what value add do you see to make it
> > requestable from non-arch code.
>
> We have one *guaranteed* SGI left. Potentially another 8 which we
> could dynamically discover (reading the priority registers should
> be enough to weed out the secure SGIs). And I'd like to keep that
> last interrupt "just in case" we'd need it to workaround something.
>
> > Also, allocating SGI7 entirely to kgdb would not allow us to leverage
> > it for NMI backtrace support via magic sysrq. But with current
> > implementation we should be able to achieve that.
>
> I'd argue that there is no need for this interrupt to be a "well known
> number". Maybe putting this code in the kgdb code is one step too far,
> but keeping out of the arm64 SMP code is IMO the right thing to do.

IIUC, you would prefer to only allocate SGI7 (only one left) if there
is a corresponding user. And I agree that kgdb isn't commonly active
for most users. But I think magic sysrq is enabled for most users and
supporting NMI backtrace would be quite useful while debugging systems
in the field as well.

So if you like, I can create a separate file like
"arch/arm64/kernel/ipi_nmi.c" for this implementation.

> And if NMI backtracing is a thing, then we should probably implement
> that first.

Have a look at IPI_CPU_BACKTRACE implementation for arm [1]. Similar
implementation would be required for arm64 but now with IPI turned as
a pseudo NMI. So I will try to add corresponding support.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/kernel/smp.c#n72

>
> > Moreover, irq ids for normal interrupts are assigned via DT/ACPI, how
> > do you envision this for SGIs?
>
> Nothing could be further from the truth. How do you think MSIs work?
> We'd just bolt an allocator for non-arch IPIs.
>

Okay.

-Sumit

>          M.
> --
> Jazz is not dead. It just smells funny...
