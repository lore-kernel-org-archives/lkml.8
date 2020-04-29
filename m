Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E08AC83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 08:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41BB3205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 08:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588148612;
	bh=0UVv0Dm6NAErwc46CCRtkpaSdr1MlLFvEVwXEGbstNA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=wOg2ukOlniD3nHXLf4fG5Rc17wafnJQVZPbVGd8THDr33UR/T2aVi8HnFzGHx4cbW
	 DJc6Ivi+KZjFttVhF6DopgYNOa5JptwjeGt2d8Lmoh4KekPSvcMhDbiI2QcShNqwYv
	 Rxkge95NXNyL2Qy5GunilFgFXQO6KIhEAlFrQ318=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgD2IXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 04:23:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:36332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbgD2IXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 04:23:30 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFE0F2083B;
        Wed, 29 Apr 2020 08:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588148610;
        bh=0UVv0Dm6NAErwc46CCRtkpaSdr1MlLFvEVwXEGbstNA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aoLDgHdyIr+7W5xjns+neFIwh9hDaeAV6+CyFVferesQpAFjCj0WnD1g+EpqRxgLr
         FdtauSNQC/wUywx9rIB7VqSy9flTvXwa5TK2V8DtppAObzKxeGnHjX/RcHjTIRU5hP
         z+3pVZemfC5CO5EY9/MPNz6kQ7cfs+0vbvHBrBlo=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jTi08-007e8O-7P; Wed, 29 Apr 2020 09:23:28 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 29 Apr 2020 09:23:28 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Douglas Anderson <dianders@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, julien.thierry.kdev@gmail.com
Subject: Re: [RFC Patch v1 2/4] irqchip/gic-v3: Add support to handle SGI as
 pseudo NMI
In-Reply-To: <CAFA6WYPNNNZeX5zpadayfiZ7P_mHmiREpUd5LZ3Jp+TjGVqoEw@mail.gmail.com>
References: <1587726554-32018-1-git-send-email-sumit.garg@linaro.org>
 <1587726554-32018-3-git-send-email-sumit.garg@linaro.org>
 <20200425112950.3a4815b6@why> <6fd3d96181ec53f735ef1b6a79d28da1@kernel.org>
 <CAFA6WYPNNNZeX5zpadayfiZ7P_mHmiREpUd5LZ3Jp+TjGVqoEw@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.3
Message-ID: <ac57cb4bbb6507ee98f199d68a514503@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: sumit.garg@linaro.org, daniel.thompson@linaro.org, jason@lakedaemon.net, catalin.marinas@arm.com, dianders@chromium.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jason.wessel@windriver.com, kgdb-bugreport@lists.sourceforge.net, tglx@linutronix.de, will@kernel.org, julien.thierry.kdev@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sumit,

On 2020-04-28 15:11, Sumit Garg wrote:
> Hi Marc,
> 
> Thanks for your comments and apologies for my delayed response as I
> was exploring ideas that you have shared.
> 
> On Sat, 25 Apr 2020 at 20:02, Marc Zyngier <maz@kernel.org> wrote:
>> 
>> On 2020-04-25 11:29, Marc Zyngier wrote:
>> > On Fri, 24 Apr 2020 16:39:12 +0530
>> > Sumit Garg <sumit.garg@linaro.org> wrote:
>> >
>> > Hi Sumit,
>> >
>> >> With pseudo NMIs enabled, interrupt controller can be configured to
>> >> deliver SGI as a pseudo NMI. So add corresponding handling for SGIs.
>> >>
>> >> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>> >> ---
>> >>  drivers/irqchip/irq-gic-v3.c | 22 +++++++++++++++++-----
>> >>  1 file changed, 17 insertions(+), 5 deletions(-)
>> >>
>> >> diff --git a/drivers/irqchip/irq-gic-v3.c
>> >> b/drivers/irqchip/irq-gic-v3.c
>> >> index d7006ef..be361bf 100644
>> >> --- a/drivers/irqchip/irq-gic-v3.c
>> >> +++ b/drivers/irqchip/irq-gic-v3.c
>> >> @@ -609,17 +609,29 @@ static inline void gic_handle_nmi(u32 irqnr,
>> >> struct pt_regs *regs)
>> >>      if (irqs_enabled)
>> >>              nmi_enter();
>> >>
>> >> -    if (static_branch_likely(&supports_deactivate_key))
>> >> -            gic_write_eoir(irqnr);
>> >>      /*
>> >>       * Leave the PSR.I bit set to prevent other NMIs to be
>> >>       * received while handling this one.
>> >>       * PSR.I will be restored when we ERET to the
>> >>       * interrupted context.
>> >>       */
>> >> -    err = handle_domain_nmi(gic_data.domain, irqnr, regs);
>> >> -    if (err)
>> >> -            gic_deactivate_unhandled(irqnr);
>> >> +    if (likely(irqnr > 15)) {
>> >> +            if (static_branch_likely(&supports_deactivate_key))
>> >> +                    gic_write_eoir(irqnr);
>> >> +
>> >> +            err = handle_domain_nmi(gic_data.domain, irqnr, regs);
>> >> +            if (err)
>> >> +                    gic_deactivate_unhandled(irqnr);
>> >> +    } else {
>> >> +            gic_write_eoir(irqnr);
>> >> +            if (static_branch_likely(&supports_deactivate_key))
>> >> +                    gic_write_dir(irqnr);
>> >> +#ifdef CONFIG_SMP
>> >> +            handle_IPI(irqnr, regs);
>> >> +#else
>> >> +            WARN_ONCE(true, "Unexpected SGI received!\n");
>> >> +#endif
>> >> +    }
>> >>
>> >>      if (irqs_enabled)
>> >>              nmi_exit();
>> >
>> > If there is one thing I would like to avoid, it is to add more ugly
>> > hacks to the way we handle SGIs. There is very little reason why SGIs
>> > should be handled differently from all other interrupts. They have the
>> > same properties, and it is only because of the 32bit legacy that we
>> > deal
>> > with them in such a cumbersome way. Nothing that we cannot fix though.
>> >
>> > What I would really like to see is first a conversion of the SGIs to
>> > normal, full fat interrupts. These interrupts can then be configured as
>> > NMI using the normal API.
>> >
>> > I think Julien had something along these lines (or was that limited to
>> > the PMU?). Otherwise, I'll happily help you with that.
>> 
>> OK, to give you an idea of what I am after, here's a small series[1]
>> that
>> can be used as a base (it has been booted exactly *once* on a model, 
>> and
>> is thus absolutely perfect ;-).
> 
> Thanks for this series. I have re-based my patch-set on top of this
> series [1] and just dropped this patch #2. It works fine for me.

I just had a look.

"irqchip/gic-v3: Enable arch specific IPI as pseudo NMI" is still done
the wrong way, I'm afraid. You directly poke into the GIC configuration,
which isn't acceptable, as you leave the rest of the kernel completely
unaware that this is a NMI. You should make the interrupt a NMI as it
is being configured in gic_smp_init(), calling request_nmi() at this 
stage.

>> 
>> There is still a bit of work to be able to actually request a SGI 
>> (they
>> are hard-wired as chained interrupts so far, as this otherwise changes
>> the output of /proc/interrupts, among other things), but you will
>> hopefully see what I'm aiming for.
> 
> I was exploring this idea: "request a SGI". I guess here you meant to
> request a new SGI as a normal NMI/IRQ via common APIs such as
> request_percpu_nmi() or request_percpu_irq() rather than statically
> adding a new IPI as per this patch [2], correct? If yes, then I have
> following follow up queries:
> 
> 1. Do you envision any drivers to use SGIs in a similar manner as they
> use SPIs or PPIs?

No. SGIs are already pretty much all allocated for the kernel's internal
needs and once we allocate an additional one for this KGDB feature,
we're out of non-secure SGIs. We could start a multiplexing scheme to
overcome this, but the kernel already has plenty of other mechanisms
for internal communication. After all, why would you need anything more
than smp_call_function()?

The single use case I can imagine is that you'd want to signal a CPU
that isn't running Linux. This would require a lot more work than
just an interrupt, and is out of scope for the time being.

> 2. How do you envision allocation of SGIs as currently they are
> hardcoded in an arch specific file (like arch/arm64/kernel/smp.c
> +794)?

What I would like is for the arch code to request these interrupts as
normal interrupts, for which there is one problem to solve: how do you
find out about the Linux IRQ number for a given IPI. Or rather, how
do you get rid of the requirement to have IPI numbers at all and just
say "give me a per-cpu interrupt that I can use as an IPI, and by the
way here's the handler you can call".

And I insist: this is only for the arch code. Nothing else.

> 3. AFAIK, the major difference among SGIs and SPIs or PPIs is the
> trigger method where SGIs are software triggered and SPIs or PPIs are
> hardware triggered. And I couldn't find a generalized method across
> architectures to invoke SGIs. So how do you envision drivers to invoke
> SGIs in an architecture agnostic manner?

Well, SGIs are not architecture agnostic. They are fundamentally part of
the GIC architecture, which only exists for the two ARM architectures.

SGIs are not a general purpose mechanism. IPIs are, and we have services
on top of IPIs, such as invoking a function on a remote CPU. What else
do you need?

Thanks,

          M.
-- 
Jazz is not dead. It just smells funny...
