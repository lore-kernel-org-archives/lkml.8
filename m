Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628ECC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 08:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F0BE206B8
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 08:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599206425;
	bh=AjNgBeE5/eYX6ye9YG9OXW6qEYknDEvbo8qalHR4Aww=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=iMU0B2JsIvEhuOFjoFvtEy2f9PexLvGLJgNxzFO5CMByGoaIe464OynIPdOb7HgXc
	 1gCZKZLeJk9yaU1dntbt/feYe+2Hn/mLKNLd+9a+JXcWLJmP6zELmCbhShULsAtG3m
	 ZKIGaPFSfoz1elQLKeKhzBQR55qubmjwfOUYgXh8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbgIDIAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 04:00:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:55480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728588AbgIDIAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 04:00:19 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C610206A5;
        Fri,  4 Sep 2020 08:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599206418;
        bh=AjNgBeE5/eYX6ye9YG9OXW6qEYknDEvbo8qalHR4Aww=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OS9IXEEJEaiEDDTr+nbsUYaIfq8OLMeXmeIWWwOuvW/E7nfs0VRMPYVweghLq//Tk
         xz5dFHDbKw0JF1vty77DEhhLgxAVd6Jq0fmDyzAUo4y+KRGWHlzDE4cueA1Q4IqtZb
         HPdkIAKSgKzE5oK/qPfn3wDXsQ6nwudea2xU36c8=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kE6ds-0095rI-7e; Fri, 04 Sep 2020 09:00:16 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 04 Sep 2020 09:00:16 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Sumit Garg <sumit.garg@linaro.org>
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
Subject: Re: [PATCH v3 1/4] arm64: smp: Introduce a new IPI as
 IPI_CALL_NMI_FUNC
In-Reply-To: <CAFA6WYNYGGsFwOdh35o2zHZb8k7o8YQ3CPDi_A=5c+VBLY9w_w@mail.gmail.com>
References: <1599134712-30923-1-git-send-email-sumit.garg@linaro.org>
 <1599134712-30923-2-git-send-email-sumit.garg@linaro.org>
 <05a195374cc81008e95e258221fe7d2b@kernel.org>
 <CAFA6WYNYGGsFwOdh35o2zHZb8k7o8YQ3CPDi_A=5c+VBLY9w_w@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <6125bdeb9ebd0cb51aa85fe36dee841c@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: sumit.garg@linaro.org, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, tglx@linutronix.de, jason@lakedaemon.net, julien.thierry.kdev@gmail.com, dianders@chromium.org, daniel.thompson@linaro.org, jason.wessel@windriver.com, kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-04 06:30, Sumit Garg wrote:
> On Thu, 3 Sep 2020 at 22:06, Marc Zyngier <maz@kernel.org> wrote:
>> 
>> On 2020-09-03 13:05, Sumit Garg wrote:
>> > Introduce a new inter processor interrupt as IPI_CALL_NMI_FUNC that
>> > can be invoked to run special handlers in NMI context. One such handler
>> > example is kgdb_nmicallback() which is invoked in order to round up
>> > CPUs
>> > to enter kgdb context.
>> >
>> > As currently pseudo NMIs are supported on specific arm64 platforms
>> > which
>> > incorporates GICv3 or later version of interrupt controller. In case a
>> > particular platform doesn't support pseudo NMIs, IPI_CALL_NMI_FUNC will
>> > act as a normal IPI which can still be used to invoke special handlers.
>> >
>> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>> > ---
>> >  arch/arm64/include/asm/smp.h |  1 +
>> >  arch/arm64/kernel/smp.c      | 11 +++++++++++
>> >  2 files changed, 12 insertions(+)
>> >
>> > diff --git a/arch/arm64/include/asm/smp.h
>> > b/arch/arm64/include/asm/smp.h
>> > index 2e7f529..e85f5d5 100644
>> > --- a/arch/arm64/include/asm/smp.h
>> > +++ b/arch/arm64/include/asm/smp.h
>> > @@ -89,6 +89,7 @@ extern void secondary_entry(void);
>> >
>> >  extern void arch_send_call_function_single_ipi(int cpu);
>> >  extern void arch_send_call_function_ipi_mask(const struct cpumask
>> > *mask);
>> > +extern void arch_send_call_nmi_func_ipi_mask(const struct cpumask
>> > *mask);
>> >
>> >  #ifdef CONFIG_ARM64_ACPI_PARKING_PROTOCOL
>> >  extern void arch_send_wakeup_ipi_mask(const struct cpumask *mask);
>> > diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
>> > index b6bde26..1b4c07c 100644
>> > --- a/arch/arm64/kernel/smp.c
>> > +++ b/arch/arm64/kernel/smp.c
>> > @@ -74,6 +74,7 @@ enum ipi_msg_type {
>> >       IPI_TIMER,
>> >       IPI_IRQ_WORK,
>> >       IPI_WAKEUP,
>> > +     IPI_CALL_NMI_FUNC,
>> >       NR_IPI
>> >  };
>> >
>> > @@ -793,6 +794,7 @@ static const char *ipi_types[NR_IPI]
>> > __tracepoint_string = {
>> >       S(IPI_TIMER, "Timer broadcast interrupts"),
>> >       S(IPI_IRQ_WORK, "IRQ work interrupts"),
>> >       S(IPI_WAKEUP, "CPU wake-up interrupts"),
>> > +     S(IPI_CALL_NMI_FUNC, "NMI function call interrupts"),
>> >  };
>> >
>> >  static void smp_cross_call(const struct cpumask *target, unsigned int
>> > ipinr);
>> > @@ -840,6 +842,11 @@ void arch_irq_work_raise(void)
>> >  }
>> >  #endif
>> >
>> > +void arch_send_call_nmi_func_ipi_mask(const struct cpumask *mask)
>> > +{
>> > +     smp_cross_call(mask, IPI_CALL_NMI_FUNC);
>> > +}
>> > +
>> >  static void local_cpu_stop(void)
>> >  {
>> >       set_cpu_online(smp_processor_id(), false);
>> > @@ -932,6 +939,10 @@ static void do_handle_IPI(int ipinr)
>> >               break;
>> >  #endif
>> >
>> > +     case IPI_CALL_NMI_FUNC:
>> > +             /* nop, IPI handlers for special features can be added here. */
>> > +             break;
>> > +
>> >       default:
>> >               pr_crit("CPU%u: Unknown IPI message 0x%x\n", cpu, ipinr);
>> >               break;
>> 
>> I'm really not keen on adding more IPIs to the SMP code. One of the
>> main reasons for using these SGIs as normal IRQs was to make them
>> "requestable" from non-arch code as if they were standard percpu
>> interrupts.
>> 
>> What prevents you from moving that all the way to the kgdb code?
>> 
> 
> Since we only have one SGI left (SGI7) which this patch reserves for
> NMI purposes, I am not sure what value add do you see to make it
> requestable from non-arch code.

We have one *guaranteed* SGI left. Potentially another 8 which we
could dynamically discover (reading the priority registers should
be enough to weed out the secure SGIs). And I'd like to keep that
last interrupt "just in case" we'd need it to workaround something.

> Also, allocating SGI7 entirely to kgdb would not allow us to leverage
> it for NMI backtrace support via magic sysrq. But with current
> implementation we should be able to achieve that.

I'd argue that there is no need for this interrupt to be a "well known
number". Maybe putting this code in the kgdb code is one step too far,
but keeping out of the arm64 SMP code is IMO the right thing to do.
And if NMI backtracing is a thing, then we should probably implement
that first.

> Moreover, irq ids for normal interrupts are assigned via DT/ACPI, how
> do you envision this for SGIs?

Nothing could be further from the truth. How do you think MSIs work?
We'd just bolt an allocator for non-arch IPIs.

         M.
-- 
Jazz is not dead. It just smells funny...
