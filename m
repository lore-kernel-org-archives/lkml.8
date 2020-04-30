Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9B5C83001
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 07:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A45620838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 07:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VfgVR9kK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgD3HUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 03:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726412AbgD3HUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 03:20:43 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CE7C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 00:20:42 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id b2so5346860ljp.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 00:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sZr1+3vRqE2FhkSDX5CtrXLEsRTbr/eXU3dnq5Mc93U=;
        b=VfgVR9kKpczFIeN8+LnvP75Wr/OHUdd2lCZEgYm3svO+8+riMTwzBRxO3Cq9J/TmLy
         ChH42dOaLXAXEjr5NC5/1e8eDGNWYtF6C0jm+iiDKuZkbZQPWzgw7D3QEc//FdP1Jsf6
         4666lNVgzk7UM9nzTjLN0iJ+ibaKAS3FF48QAuNBMS7GvyxtQqRiGa42vUoO1TIWK4gT
         iQkBiiMKb0BIJStddAjAiqa0Z/KOZSANm/AiLNWfKVkVCqHX9I5BMPlA6jCtli3TGAkr
         brC3qTzapu8AcZ/0uZv78PL84nfqYZkh7DV5N5duQi/Y91l4Mxab5cIqLrjZh7Z4JuFw
         +0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sZr1+3vRqE2FhkSDX5CtrXLEsRTbr/eXU3dnq5Mc93U=;
        b=feEN1ShRp2APWRbNFI58X4RJs8/NERZUQVqKlAmQrHmnuZTks/yGJeyoPRuuC8YUv0
         g04HsRukotB1A4hxF8HLS7vgpbUqnSfakAFbIq+mOIOvz3oOYWqWac8l6Kf6+5EpVzqM
         0ff0hUvqdoeoXdLYuViG71FmM6Zpvlq+Ckp9z40TmU9ZTVN7R9j6Xj0f+5hs85ri9p0L
         OGcJEvR4CgdQiZ36Hg1lGK26ITUrAyvEpfNdH/THHU1vxTYEnxz6/P406RcUirpcStSn
         tI9GyHrGLDm/GWYee90w9jpYcM36wCwXc8qcaoxsthC/RK1ZxBWNQLSB2/3B02IKFU2M
         6NFA==
X-Gm-Message-State: AGi0PuYogNDDu+67x0ffKV/fzrqFkLDHWQ37uOy7Ae8r6n0EB+Ps6GN8
        sFC4390azTsfeFl+8JY1OHVp+ODH+0RV9z/RjNQQdg==
X-Google-Smtp-Source: APiQypK4Y04DV3XhNEdb66Dsm96rNOrnM5vyzC6FyLQ9pLxPdGP3mKpGyotMazaX8TgXg6B+lWsEIipHmTHJXN1XPRQ=
X-Received: by 2002:a2e:a365:: with SMTP id i5mr1242958ljn.293.1588231241153;
 Thu, 30 Apr 2020 00:20:41 -0700 (PDT)
MIME-Version: 1.0
References: <1587726554-32018-1-git-send-email-sumit.garg@linaro.org>
 <1587726554-32018-3-git-send-email-sumit.garg@linaro.org> <20200425112950.3a4815b6@why>
 <6fd3d96181ec53f735ef1b6a79d28da1@kernel.org> <CAFA6WYPNNNZeX5zpadayfiZ7P_mHmiREpUd5LZ3Jp+TjGVqoEw@mail.gmail.com>
 <ac57cb4bbb6507ee98f199d68a514503@kernel.org>
In-Reply-To: <ac57cb4bbb6507ee98f199d68a514503@kernel.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 30 Apr 2020 12:50:28 +0530
Message-ID: <CAFA6WYMheJxeKVC_YWN9owNJhcWTBsaOCvZXxq=GVj5ROJ0cvg@mail.gmail.com>
Subject: Re: [RFC Patch v1 2/4] irqchip/gic-v3: Add support to handle SGI as
 pseudo NMI
To:     Marc Zyngier <maz@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Wed, 29 Apr 2020 at 13:53, Marc Zyngier <maz@kernel.org> wrote:
>
> Hi Sumit,
>
> On 2020-04-28 15:11, Sumit Garg wrote:
> > Hi Marc,
> >
> > Thanks for your comments and apologies for my delayed response as I
> > was exploring ideas that you have shared.
> >
> > On Sat, 25 Apr 2020 at 20:02, Marc Zyngier <maz@kernel.org> wrote:
> >>
> >> On 2020-04-25 11:29, Marc Zyngier wrote:
> >> > On Fri, 24 Apr 2020 16:39:12 +0530
> >> > Sumit Garg <sumit.garg@linaro.org> wrote:
> >> >
> >> > Hi Sumit,
> >> >
> >> >> With pseudo NMIs enabled, interrupt controller can be configured to
> >> >> deliver SGI as a pseudo NMI. So add corresponding handling for SGIs.
> >> >>
> >> >> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> >> >> ---
> >> >>  drivers/irqchip/irq-gic-v3.c | 22 +++++++++++++++++-----
> >> >>  1 file changed, 17 insertions(+), 5 deletions(-)
> >> >>
> >> >> diff --git a/drivers/irqchip/irq-gic-v3.c
> >> >> b/drivers/irqchip/irq-gic-v3.c
> >> >> index d7006ef..be361bf 100644
> >> >> --- a/drivers/irqchip/irq-gic-v3.c
> >> >> +++ b/drivers/irqchip/irq-gic-v3.c
> >> >> @@ -609,17 +609,29 @@ static inline void gic_handle_nmi(u32 irqnr,
> >> >> struct pt_regs *regs)
> >> >>      if (irqs_enabled)
> >> >>              nmi_enter();
> >> >>
> >> >> -    if (static_branch_likely(&supports_deactivate_key))
> >> >> -            gic_write_eoir(irqnr);
> >> >>      /*
> >> >>       * Leave the PSR.I bit set to prevent other NMIs to be
> >> >>       * received while handling this one.
> >> >>       * PSR.I will be restored when we ERET to the
> >> >>       * interrupted context.
> >> >>       */
> >> >> -    err = handle_domain_nmi(gic_data.domain, irqnr, regs);
> >> >> -    if (err)
> >> >> -            gic_deactivate_unhandled(irqnr);
> >> >> +    if (likely(irqnr > 15)) {
> >> >> +            if (static_branch_likely(&supports_deactivate_key))
> >> >> +                    gic_write_eoir(irqnr);
> >> >> +
> >> >> +            err = handle_domain_nmi(gic_data.domain, irqnr, regs);
> >> >> +            if (err)
> >> >> +                    gic_deactivate_unhandled(irqnr);
> >> >> +    } else {
> >> >> +            gic_write_eoir(irqnr);
> >> >> +            if (static_branch_likely(&supports_deactivate_key))
> >> >> +                    gic_write_dir(irqnr);
> >> >> +#ifdef CONFIG_SMP
> >> >> +            handle_IPI(irqnr, regs);
> >> >> +#else
> >> >> +            WARN_ONCE(true, "Unexpected SGI received!\n");
> >> >> +#endif
> >> >> +    }
> >> >>
> >> >>      if (irqs_enabled)
> >> >>              nmi_exit();
> >> >
> >> > If there is one thing I would like to avoid, it is to add more ugly
> >> > hacks to the way we handle SGIs. There is very little reason why SGIs
> >> > should be handled differently from all other interrupts. They have the
> >> > same properties, and it is only because of the 32bit legacy that we
> >> > deal
> >> > with them in such a cumbersome way. Nothing that we cannot fix though.
> >> >
> >> > What I would really like to see is first a conversion of the SGIs to
> >> > normal, full fat interrupts. These interrupts can then be configured as
> >> > NMI using the normal API.
> >> >
> >> > I think Julien had something along these lines (or was that limited to
> >> > the PMU?). Otherwise, I'll happily help you with that.
> >>
> >> OK, to give you an idea of what I am after, here's a small series[1]
> >> that
> >> can be used as a base (it has been booted exactly *once* on a model,
> >> and
> >> is thus absolutely perfect ;-).
> >
> > Thanks for this series. I have re-based my patch-set on top of this
> > series [1] and just dropped this patch #2. It works fine for me.
>
> I just had a look.
>
> "irqchip/gic-v3: Enable arch specific IPI as pseudo NMI" is still done
> the wrong way, I'm afraid. You directly poke into the GIC configuration,
> which isn't acceptable, as you leave the rest of the kernel completely
> unaware that this is a NMI. You should make the interrupt a NMI as it
> is being configured in gic_smp_init(), calling request_nmi() at this
> stage.

Sure, I will try to follow your suggestion. But I think it's better to
first generalize the base IPI allocation scheme.

>
> >>
> >> There is still a bit of work to be able to actually request a SGI
> >> (they
> >> are hard-wired as chained interrupts so far, as this otherwise changes
> >> the output of /proc/interrupts, among other things), but you will
> >> hopefully see what I'm aiming for.
> >
> > I was exploring this idea: "request a SGI". I guess here you meant to
> > request a new SGI as a normal NMI/IRQ via common APIs such as
> > request_percpu_nmi() or request_percpu_irq() rather than statically
> > adding a new IPI as per this patch [2], correct? If yes, then I have
> > following follow up queries:
> >
> > 1. Do you envision any drivers to use SGIs in a similar manner as they
> > use SPIs or PPIs?
>
> No. SGIs are already pretty much all allocated for the kernel's internal
> needs and once we allocate an additional one for this KGDB feature,
> we're out of non-secure SGIs. We could start a multiplexing scheme to
> overcome this, but the kernel already has plenty of other mechanisms
> for internal communication. After all, why would you need anything more
> than smp_call_function()?
>
> The single use case I can imagine is that you'd want to signal a CPU
> that isn't running Linux. This would require a lot more work than
> just an interrupt, and is out of scope for the time being.

Thanks for the clarification.

>
> > 2. How do you envision allocation of SGIs as currently they are
> > hardcoded in an arch specific file (like arch/arm64/kernel/smp.c
> > +794)?
>
> What I would like is for the arch code to request these interrupts as
> normal interrupts, for which there is one problem to solve: how do you
> find out about the Linux IRQ number for a given IPI. Or rather, how
> do you get rid of the requirement to have IPI numbers at all and just
> say "give me a per-cpu interrupt that I can use as an IPI, and by the
> way here's the handler you can call".

I think what you are looking for here is something that could be
sufficed via enabling "CONFIG_GENERIC_IRQ_IPI" framework for arm64/arm
architectures. It's currently used for mips architecture. Looking at
its implementation, I think it should be possible to hook up SGIs
under new IPI irq_domain for GICv2/v3.

So with this framework we should be able to dynamically allocate IPIs
and use common APIs such as request_irq()/request_nmi() to tell IPI
specific handlers.

If this approach looks sane to you then I can start working on a PoC
implementation for arm64.

>
> And I insist: this is only for the arch code. Nothing else.
>

Makes sense.

> > 3. AFAIK, the major difference among SGIs and SPIs or PPIs is the
> > trigger method where SGIs are software triggered and SPIs or PPIs are
> > hardware triggered. And I couldn't find a generalized method across
> > architectures to invoke SGIs. So how do you envision drivers to invoke
> > SGIs in an architecture agnostic manner?
>
> Well, SGIs are not architecture agnostic. They are fundamentally part of
> the GIC architecture, which only exists for the two ARM architectures.
>
> SGIs are not a general purpose mechanism. IPIs are, and we have services
> on top of IPIs, such as invoking a function on a remote CPU. What else
> do you need?

Yeah that was mine understanding as well. But I was just clarifying if
you have any further use-cases in mind for IPIs.

-Sunit

>
> Thanks,
>
>           M.
> --
> Jazz is not dead. It just smells funny...
