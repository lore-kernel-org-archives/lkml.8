Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CB1C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C11A6206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TyNk0pic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgD1OMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 10:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbgD1OMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 10:12:05 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11053C03C1A9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 07:12:05 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id f18so21627547lja.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 07:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9t0tu6yYKzN35uBYTbFFPc0dS5Ew+chbn+hE8zcVYWQ=;
        b=TyNk0pickYyy84k5NMTmvZ7WzQe7BnjIVvEcEofdf2pnFIF3UDagf9JUJ7ut92Rts+
         nXjwA9FP0UEvwZWuaI149nPEKt2yL8xUPonbQ9mtHTJjvMD/Ne/JMiOEcPscYQxC3BVd
         abFsVjRNuG1rglN1RNryTYcYXYInUM8AtHmY6EsqusqThuai3b1BiDUeb8DBaR3Mr8kf
         D9CZS48ljYs/GL52sBAI0g72KUUbAxeFaqGK+hw9/sGTqDJmNdX0D+nQKFKNj+3ua56o
         3qSpsNHTdHoduEWEIm2bb+bl32dw2mvf8MjPPX++HTjz3y89q2OJqYHsBwaDuCVI+U1T
         9/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9t0tu6yYKzN35uBYTbFFPc0dS5Ew+chbn+hE8zcVYWQ=;
        b=ZezoUP7ul6sQhrNsNJQO63Pjhrvl/Aim2jv1wmJWxjE2WbIwiGMGUQiub2NZOG+f+V
         cxZ7q5y9TEbqCAQ8nFtbKY0myvY2Zpb2CSARvrjQnyR44M5avvhYpf63VCbW/3o/+jOy
         GZTeD2Amp5o9UMdj5u5tUfaasa+uwV8rd6kcXb4UbHoEkfCE7GDd/9o9uA5wA5/SjtVW
         8GLrqqjKvnvIDynLaQ2nKoLf0EY0Ws+0J8n9c0WortVhnYZHSgu/nBmimrvPjOZJbsoh
         IPe+NxTz600f45tqXna++XDYfGg9qBv0ZxqG0gPYOA94GGaJSVV0ZjDraQMTL65dlXgU
         ivlA==
X-Gm-Message-State: AGi0PuY5esoHICZ2swFGiL6oCp1ZHkqU1ONJd4zxItHRNTdsEBkodn8J
        JFjXMJcAurdJKr35Ebi7Ik17T7g5LgKMtdfwXDUC1g==
X-Google-Smtp-Source: APiQypLKjTvcl707sIjTA8Gi7R58xVWA0sIpl7IXDlKPS6s5Rejq4xHZpXS8mo+iRC6XTT0VWMqVNlDJbIp6fcMI3sI=
X-Received: by 2002:a2e:3809:: with SMTP id f9mr17881928lja.281.1588083123472;
 Tue, 28 Apr 2020 07:12:03 -0700 (PDT)
MIME-Version: 1.0
References: <1587726554-32018-1-git-send-email-sumit.garg@linaro.org>
 <1587726554-32018-3-git-send-email-sumit.garg@linaro.org> <20200425112950.3a4815b6@why>
 <6fd3d96181ec53f735ef1b6a79d28da1@kernel.org>
In-Reply-To: <6fd3d96181ec53f735ef1b6a79d28da1@kernel.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 28 Apr 2020 19:41:50 +0530
Message-ID: <CAFA6WYPNNNZeX5zpadayfiZ7P_mHmiREpUd5LZ3Jp+TjGVqoEw@mail.gmail.com>
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

Thanks for your comments and apologies for my delayed response as I
was exploring ideas that you have shared.

On Sat, 25 Apr 2020 at 20:02, Marc Zyngier <maz@kernel.org> wrote:
>
> On 2020-04-25 11:29, Marc Zyngier wrote:
> > On Fri, 24 Apr 2020 16:39:12 +0530
> > Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Hi Sumit,
> >
> >> With pseudo NMIs enabled, interrupt controller can be configured to
> >> deliver SGI as a pseudo NMI. So add corresponding handling for SGIs.
> >>
> >> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> >> ---
> >>  drivers/irqchip/irq-gic-v3.c | 22 +++++++++++++++++-----
> >>  1 file changed, 17 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/irqchip/irq-gic-v3.c
> >> b/drivers/irqchip/irq-gic-v3.c
> >> index d7006ef..be361bf 100644
> >> --- a/drivers/irqchip/irq-gic-v3.c
> >> +++ b/drivers/irqchip/irq-gic-v3.c
> >> @@ -609,17 +609,29 @@ static inline void gic_handle_nmi(u32 irqnr,
> >> struct pt_regs *regs)
> >>      if (irqs_enabled)
> >>              nmi_enter();
> >>
> >> -    if (static_branch_likely(&supports_deactivate_key))
> >> -            gic_write_eoir(irqnr);
> >>      /*
> >>       * Leave the PSR.I bit set to prevent other NMIs to be
> >>       * received while handling this one.
> >>       * PSR.I will be restored when we ERET to the
> >>       * interrupted context.
> >>       */
> >> -    err = handle_domain_nmi(gic_data.domain, irqnr, regs);
> >> -    if (err)
> >> -            gic_deactivate_unhandled(irqnr);
> >> +    if (likely(irqnr > 15)) {
> >> +            if (static_branch_likely(&supports_deactivate_key))
> >> +                    gic_write_eoir(irqnr);
> >> +
> >> +            err = handle_domain_nmi(gic_data.domain, irqnr, regs);
> >> +            if (err)
> >> +                    gic_deactivate_unhandled(irqnr);
> >> +    } else {
> >> +            gic_write_eoir(irqnr);
> >> +            if (static_branch_likely(&supports_deactivate_key))
> >> +                    gic_write_dir(irqnr);
> >> +#ifdef CONFIG_SMP
> >> +            handle_IPI(irqnr, regs);
> >> +#else
> >> +            WARN_ONCE(true, "Unexpected SGI received!\n");
> >> +#endif
> >> +    }
> >>
> >>      if (irqs_enabled)
> >>              nmi_exit();
> >
> > If there is one thing I would like to avoid, it is to add more ugly
> > hacks to the way we handle SGIs. There is very little reason why SGIs
> > should be handled differently from all other interrupts. They have the
> > same properties, and it is only because of the 32bit legacy that we
> > deal
> > with them in such a cumbersome way. Nothing that we cannot fix though.
> >
> > What I would really like to see is first a conversion of the SGIs to
> > normal, full fat interrupts. These interrupts can then be configured as
> > NMI using the normal API.
> >
> > I think Julien had something along these lines (or was that limited to
> > the PMU?). Otherwise, I'll happily help you with that.
>
> OK, to give you an idea of what I am after, here's a small series[1]
> that
> can be used as a base (it has been booted exactly *once* on a model, and
> is thus absolutely perfect ;-).

Thanks for this series. I have re-based my patch-set on top of this
series [1] and just dropped this patch #2. It works fine for me.

>
> There is still a bit of work to be able to actually request a SGI (they
> are hard-wired as chained interrupts so far, as this otherwise changes
> the output of /proc/interrupts, among other things), but you will
> hopefully see what I'm aiming for.

I was exploring this idea: "request a SGI". I guess here you meant to
request a new SGI as a normal NMI/IRQ via common APIs such as
request_percpu_nmi() or request_percpu_irq() rather than statically
adding a new IPI as per this patch [2], correct? If yes, then I have
following follow up queries:

1. Do you envision any drivers to use SGIs in a similar manner as they
use SPIs or PPIs?
2. How do you envision allocation of SGIs as currently they are
hardcoded in an arch specific file (like arch/arm64/kernel/smp.c
+794)?
3. AFAIK, the major difference among SGIs and SPIs or PPIs is the
trigger method where SGIs are software triggered and SPIs or PPIs are
hardware triggered. And I couldn't find a generalized method across
architectures to invoke SGIs. So how do you envision drivers to invoke
SGIs in an architecture agnostic manner?

[1] https://git.linaro.org/people/sumit.garg/linux.git/?h=kgdb-nmi
[2] https://git.linaro.org/people/sumit.garg/linux.git/commit/?h=kgdb-nmi&id=fc89e5f395f89966110554a15ab0fa0f0d471132

-Sumit

>
> Thanks,
>
>          M.
>
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=irq/gic-sgi
> --
> Jazz is not dead. It just smells funny...
