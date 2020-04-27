Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009C4C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 04:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C440B206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 04:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LKgiTjLn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgD0Ews (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 00:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726273AbgD0Ewr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 00:52:47 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D596AC061A0F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 21:52:46 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id l11so12677224lfc.5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 21:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NGlQ3C/ta2HjZVUKvLN7ukTHTpTh1FEmhkChtwgd5SI=;
        b=LKgiTjLngAySEuoE9XHfXTgHz6iHW3ahOb8J8NmYd/0AqtJfXne0KE+T1ULRGm0T6A
         7wXzsx5KnkLnsEuU/t/jjfcyBG5qBC14vfdpjlDLl7AXiM8p6O4rMzB5igE8EG7WOK60
         Z9tEvH7eFp5fIIc/l/UAQioBOvDEBkkK4TGGEPHxgr0ky3A+DYWplKGvzSI+kk8sfFJO
         Mfw0V18m6WHtzi2ZMbeZdoJ0minU2g7qgqCEeoNR0zTqnqCWYv6mmQyRjJK1VC4GX94I
         hV6VuXpMIqzyYLbN+ZHtHHMr4riWxXJRfHdCeUn92hAbPIMiOSXtHXqyWLDZl2FVl1Er
         Oujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NGlQ3C/ta2HjZVUKvLN7ukTHTpTh1FEmhkChtwgd5SI=;
        b=S60A/CYI3KS6f8jtR0a1QPmnNIAy4vxylalDmm6nWuaGD49TQj4bydjXw89pLNHC9E
         guWSJx3rdP2HIb0iXER4A39HfsMBuc+hH2wd+CNQP9lM25q3zXlXD4jYOf+B9/alHCLL
         nUeLr6/UoCgartmrVYXqzdAbORuUESmCCcFuQvM/ws2MUwQLB1w24B1flwvSUbY9+9aK
         VbRL5OhnllRuDmhFhxevwtHvgRtbDbJqCOGBYKLOMBr36kxanPFlmPXxqT8bFKWw9NGY
         DcV24141CuWW0AYceQeE2UkIBLPkzs1R9sYf+Jev5o/X0qzFlijBrRjS0Wi5cfpmFsCB
         aA9A==
X-Gm-Message-State: AGi0PuY6322WO349JAgY5bv6TxB3gC9ete6Z01har73USKllSj7VFD1D
        9RWIQgHMkJyn1vOLEZXHtoIJJzTSBbscz7an9IfkNg==
X-Google-Smtp-Source: APiQypIuLFyeIjy0XquNOeWfBKjhZKT0//ZD6fmYmQYd5pRUYS8wyZTeZbOZ9uQgZYeIJPlGUFwKXFxMwDLfBmwsCx0=
X-Received: by 2002:ac2:5544:: with SMTP id l4mr13589303lfk.122.1587963164995;
 Sun, 26 Apr 2020 21:52:44 -0700 (PDT)
MIME-Version: 1.0
References: <1587726554-32018-1-git-send-email-sumit.garg@linaro.org>
 <1587726554-32018-5-git-send-email-sumit.garg@linaro.org> <CAD=FV=VSrVnx_R=Y38tQ=bw_o22zxWmm=+M+AaqmEMAtK66b-Q@mail.gmail.com>
In-Reply-To: <CAD=FV=VSrVnx_R=Y38tQ=bw_o22zxWmm=+M+AaqmEMAtK66b-Q@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 27 Apr 2020 10:22:33 +0530
Message-ID: <CAFA6WYOorX8iRHhpOq26QCE8T1dKmXFUXVTxoWOP0OZErqJqBQ@mail.gmail.com>
Subject: Re: [RFC Patch v1 4/4] arm64: kgdb: Round up cpus using IPI_CALL_NMI_FUNC
To:     Doug Anderson <dianders@chromium.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, julien.thierry.kdev@gmail.com,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

Thanks for your comments.

On Sat, 25 Apr 2020 at 02:17, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Fri, Apr 24, 2020 at 4:11 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > arm64 platforms with GICv3 or later supports pseudo NMIs which can be
> > leveraged to round up CPUs which are stuck in hard lockup state with
> > interrupts disabled that wouldn't be possible with a normal IPI.
> >
> > So instead switch to round up CPUs using IPI_CALL_NMI_FUNC. And in
> > case a particular arm64 platform doesn't supports pseudo NMIs,
> > IPI_CALL_NMI_FUNC will act as a normal IPI which maintains existing
> > kgdb functionality.
> >
> > Also, one thing to note here is that with CPUs running in NMI context,
> > kernel has special handling for printk() which involves CPU specific
> > buffers and defering printk() until exit from NMI context. But with kgdb
> > we don't want to defer printk() especially backtrace on corresponding
> > CPUs. So switch to normal printk() context instead prior to entering
> > kgdb context.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  arch/arm64/kernel/kgdb.c | 15 +++++++++++++++
> >  arch/arm64/kernel/smp.c  | 17 ++++++++++++++---
> >  2 files changed, 29 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
> > index 4311992..0851ead 100644
> > --- a/arch/arm64/kernel/kgdb.c
> > +++ b/arch/arm64/kernel/kgdb.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/kgdb.h>
> >  #include <linux/kprobes.h>
> >  #include <linux/sched/task_stack.h>
> > +#include <linux/smp.h>
> >
> >  #include <asm/debug-monitors.h>
> >  #include <asm/insn.h>
> > @@ -353,3 +354,17 @@ int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
> >         return aarch64_insn_write((void *)bpt->bpt_addr,
> >                         *(u32 *)bpt->saved_instr);
> >  }
> > +
> > +#ifdef CONFIG_SMP
> > +void kgdb_roundup_cpus(void)
> > +{
> > +       struct cpumask mask;
> > +
> > +       cpumask_copy(&mask, cpu_online_mask);
> > +       cpumask_clear_cpu(raw_smp_processor_id(), &mask);
> > +       if (cpumask_empty(&mask))
> > +               return;
> > +
> > +       arch_send_call_nmi_func_ipi_mask(&mask);
> > +}
> > +#endif
> > diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> > index 27c8ee1..c7158f6e8 100644
> > --- a/arch/arm64/kernel/smp.c
> > +++ b/arch/arm64/kernel/smp.c
> > @@ -31,6 +31,7 @@
> >  #include <linux/of.h>
> >  #include <linux/irq_work.h>
> >  #include <linux/kexec.h>
> > +#include <linux/kgdb.h>
> >  #include <linux/kvm_host.h>
> >
> >  #include <asm/alternative.h>
> > @@ -976,9 +977,19 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
> >                 /* Handle it as a normal interrupt if not in NMI context */
> >                 if (!in_nmi())
> >                         irq_enter();
> > -
> > -               /* nop, IPI handlers for special features can be added here. */
> > -
> > +#ifdef CONFIG_KGDB
>
> My vote would be to keep "ifdef"s out of the middle of functions.  Can
> you put your code in "arch/arm64/kernel/kgdb.c" and then have a dummpy
> no-op function if "CONFIG_KGDB" isn't defined?
>

Sure.

>
> > +               if (atomic_read(&kgdb_active) != -1) {
> > +                       /*
> > +                        * For kgdb to work properly, we need printk to operate
> > +                        * in normal context.
> > +                        */
> > +                       if (in_nmi())
> > +                               printk_nmi_exit();
>
> It feels like all the printk management belongs in kgdb_nmicallback().
> ...or is there some reason that this isn't a problem for other
> platforms using NMI?  Maybe it's just that nobody has noticed it yet?
>

Initially I was skeptical of moving this printk handling in the common
kgdb framework but after exploring other platforms like x86 (probably
unnoticed bug), I agree with you that it belongs to
kgdb_nmicallback(). So I will move it there.

>
> > +                       kgdb_nmicallback(raw_smp_processor_id(), regs);
>
> Why do you need to call raw_smp_processor_id()?  Are you expecting a
> different value than the local variable "cpu"?

Ah, no. Will use the local variable "cpu" instead.

>
>
> > +                       if (in_nmi())
> > +                               printk_nmi_enter();
> > +               }
> > +#endif
> >                 if (!in_nmi())
> >                         irq_exit();
> >                 break;
>
> Not that I really know what I'm talking about since I really don't
> know arm64 at this level very well, but I'll ask anyway and probably
> look like a fool...  I had a note that said:
>
> * Will Deacon says:
> *
> * the whole roundup code is sketchy and it's the only place in the kernel
> * which tries to perform I-cache maintenance with irqs disabled, leading
> * to this nasty hack in the arch code:
> *
> * https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/include/asm/cacheflush.h#n74
>
> I presume that, if nothing else, the comment needs to be updated.
> ...but is the situation any better (or worse?) with your new solution?

I think the situation remains the same with new solution as well. As
either we use IPI being a pseudo NMI or a normal IRQ to roundup CPUs,
kgdb still does I-cache maintenance with irqs disabled which could
lead to a deadlock trying to IPI the secondary CPUs without this nasty
hack in the arch code.

-Sumit

>
> -Doug
