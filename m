Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2B6C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F493206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587976048;
	bh=WlS5jPTB2ToO57TX6wf76UBIN8mQyKkRwqeX57hjmeM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=xwGlKUlsnNTWGLd5OspyYiiEArvDyq4tvZQO1Fr9ttkJ/nxGqOaTMs/G9kHijaaeT
	 YLtVqwshdJKPNqy/Ptk4STwE2naWd5O63+uNwNAUEQoUlPcG9XVnp7IdLtcnrGD9Q7
	 rGZbbnu26e+qC95UAalLRAz1jgsZLuqxVtPGWc+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgD0I11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 04:27:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:58488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbgD0I11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 04:27:27 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2913920661;
        Mon, 27 Apr 2020 08:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587976046;
        bh=WlS5jPTB2ToO57TX6wf76UBIN8mQyKkRwqeX57hjmeM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ut25FgrqyPtbjntQzmKBAd39JvOY/jqNVT5t86r9pJq6xhvLAyR+UcKRz4+lKcq1Q
         +ufIvuCsLXqK4vpmfbC4RrIAazS7STHkjD4hjfKhBDqR2M/gtsX3lJD2uZqvLBuYL+
         0sJHSAsMEq0UB2DgsKS/7wSpPinyxpbBouQNrJxM=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jSz6q-006fSJ-Eo; Mon, 27 Apr 2020 09:27:24 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 27 Apr 2020 09:27:24 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Zong Li <zong.li@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>
Subject: Re: [PATCH] irqchip/sifive-plic: allow many cores to handle IRQs
In-Reply-To: <CAAhSdy2f2-SQP6TdgxA0HM2ft3eBJd6kEkB--RH=2gUuLktXLQ@mail.gmail.com>
References: <20200426110740.123638-1-zong.li@sifive.com>
 <CAAhSdy3FCdzLV-nH03T=PBxB2tdZXhRrugcC2NcoA=22qpv+Lw@mail.gmail.com>
 <CANXhq0qW9ORoZ5qc5g8ikO9QdeYX=p0fwoP8pyFFkk02a7imnw@mail.gmail.com>
 <CAAhSdy2f2-SQP6TdgxA0HM2ft3eBJd6kEkB--RH=2gUuLktXLQ@mail.gmail.com>
Message-ID: <60083bbdfe6a6299efc8d07d8a02d647@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: anup@brainfault.org, zong.li@sifive.com, palmer@dabbelt.com, paul.walmsley@sifive.com, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, david.abdurachmanov@sifive.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anup,

On 2020-04-26 14:38, Anup Patel wrote:
> +Mark Z

s/k/c/ ;-)

> 
> On Sun, Apr 26, 2020 at 6:49 PM Zong Li <zong.li@sifive.com> wrote:
>> 
>> On Sun, Apr 26, 2020 at 8:47 PM Anup Patel <anup@brainfault.org> 
>> wrote:
>> >
>> > On Sun, Apr 26, 2020 at 4:37 PM Zong Li <zong.li@sifive.com> wrote:
>> > >
>> > > Currently, driver forces the IRQs to be handled by only one core. This
>> > > patch provides the way to enable others cores to handle IRQs if needed,
>> > > so users could decide how many cores they wanted on default by boot
>> > > argument.
>> > >
>> > > Use 'irqaffinity' boot argument to determine affinity. If there is no
>> > > irqaffinity in dts or kernel configuration, use irq default affinity,
>> > > so all harts would try to claim IRQ.
>> > >
>> > > For example, add irqaffinity=0 in chosen node to set irq affinity to
>> > > hart 0. It also supports more than one harts to handle irq, such as set
>> > > irqaffinity=0,3,4.
>> > >
>> > > You can change IRQ affinity from user-space using procfs. For example,
>> > > you can make CPU0 and CPU2 serve IRQ together by the following command:
>> > >
>> > > echo 4 > /proc/irq/<x>/smp_affinity
>> > >
>> > > Signed-off-by: Zong Li <zong.li@sifive.com>
>> > > ---
>> > >  drivers/irqchip/irq-sifive-plic.c | 21 +++++++--------------
>> > >  1 file changed, 7 insertions(+), 14 deletions(-)
>> > >
>> > > diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
>> > > index d0a71febdadc..bc1440d54185 100644
>> > > --- a/drivers/irqchip/irq-sifive-plic.c
>> > > +++ b/drivers/irqchip/irq-sifive-plic.c
>> > > @@ -111,15 +111,12 @@ static inline void plic_irq_toggle(const struct cpumask *mask,
>> > >  static void plic_irq_unmask(struct irq_data *d)
>> > >  {
>> > >         struct cpumask amask;
>> > > -       unsigned int cpu;
>> > >         struct plic_priv *priv = irq_get_chip_data(d->irq);
>> > >
>> > >         cpumask_and(&amask, &priv->lmask, cpu_online_mask);
>> > > -       cpu = cpumask_any_and(irq_data_get_affinity_mask(d),
>> > > -                                          &amask);
>> > > -       if (WARN_ON_ONCE(cpu >= nr_cpu_ids))
>> > > -               return;
>> > > -       plic_irq_toggle(cpumask_of(cpu), d, 1);
>> > > +       cpumask_and(&amask, &amask, irq_data_get_affinity_mask(d));
>> > > +
>> > > +       plic_irq_toggle(&amask, d, 1);
>> > >  }
>> > >
>> > >  static void plic_irq_mask(struct irq_data *d)
>> > > @@ -133,24 +130,20 @@ static void plic_irq_mask(struct irq_data *d)
>> > >  static int plic_set_affinity(struct irq_data *d,
>> > >                              const struct cpumask *mask_val, bool force)
>> > >  {
>> > > -       unsigned int cpu;
>> > >         struct cpumask amask;
>> > >         struct plic_priv *priv = irq_get_chip_data(d->irq);
>> > >
>> > >         cpumask_and(&amask, &priv->lmask, mask_val);
>> > >
>> > >         if (force)
>> > > -               cpu = cpumask_first(&amask);
>> > > +               cpumask_copy(&amask, mask_val);
>> > >         else
>> > > -               cpu = cpumask_any_and(&amask, cpu_online_mask);
>> > > -
>> > > -       if (cpu >= nr_cpu_ids)
>> > > -               return -EINVAL;
>> > > +               cpumask_and(&amask, &amask, cpu_online_mask);
>> > >
>> > >         plic_irq_toggle(&priv->lmask, d, 0);
>> > > -       plic_irq_toggle(cpumask_of(cpu), d, 1);
>> > > +       plic_irq_toggle(&amask, d, 1);
>> > >
>> > > -       irq_data_update_effective_affinity(d, cpumask_of(cpu));
>> > > +       irq_data_update_effective_affinity(d, &amask);
>> > >
>> > >         return IRQ_SET_MASK_OK_DONE;
>> > >  }
>> > > --
>> > > 2.26.1
>> > >
>> >
>> > I strongly oppose (NACK) this patch due to performance reasons.
>> >
>> > In PLIC, if we enable an IRQ X for N CPUs then when IRQ X occurs:
>> > 1) All N CPUs will take interrupt
>> > 2) All N CPUs will try to read PLIC CLAIM register
>> > 3) Only one of the CPUs will see IRQ X using the CLAIM register
>> > but other N - 1 CPUs will see no interrupt and return back to what
>> > they were doing. In other words, N - 1 CPUs will just waste CPU
>> > every time IRQ X occurs.
>> >
>> > Example1, one Application doing heavy network traffic will
>> > degrade performance of other applications because with every
>> > network RX/TX interrupt N-1 CPUs will waste CPU trying to
>> > process network interrupt.
>> >
>> > Example1, one Application doing heavy MMC/SD traffic will
>> > degrade performance of other applications because with every
>> > SPI read/write interrupt N-1 CPUs will waste CPU trying to
>> > process it.
>> >
>> > In fact, the current PLIC approach is actually a performance
>> > optimization. This implementation also works fine with in-kernel
>> > load-balancer and user space load balancer.
>> >
>> 
>> Yes, it's exactly, I know what you pointed out. But the idea of this
>> patch is just providing a way that users could enable other cores if
>> they wanted, it could still enable only one core by this change. The
>> purpose here is thinking of flexible use, rather than limitation.
>> Maybe it would be a happy medium that we make the default case enable
>> only one core? It is a good open discussion.
> 
> Making the default case as enable only one core is just a work-around.
> 
> As-per my understanding, if we set affinity mask of N CPUs for IRQ X
> then it does not mean all N CPUs should receive IRQ X rather it means
> that exactly one of the N CPUs will receive IRQ X and the IRQ receiving
> CPU will be fixed (reflected by effective affinity returned by the 
> driver).
> 
> If we ignore above semantics and still provide a mechanism to target
> IRQ X to N CPUs then most likely someone will try and run into
> performance issues.
> 
> Please don't go this path. The performance impact in case of Guest/VM
> is even worst because PLIC is trap-n-emulated by hypervisors as MMIO
> device.

Just to add my view on this, as we get the same request on the ARM side
once every other year:

- the "broadcast" aspect of the interrupt signalling is usually a waste
   of CPU cycles on all CPUs but the one that has actually takes it.

- the fact that you have to use MMIO to interact with the interrupt
   controller potentially makes this even worse if you don't have some
   per-CPU datapath that will handle this really fast.

- not hitting the same CPU at all times for a given interrupt means that
   the caches are usually cold for this interrupt, meaning the gain in
   latency is pretty dubious.

There is a very small (but also very vocal) fringe of users that insist
that they cannot live without this broadcast aspect, because it allows
them to shave a couple of cycles off a trivial interrupt handler on 
systems
that are otherwise mostly idle.

My answer to this is that Linux is a general purpose OS, and not a
glorified interrupt handler. We aim to have balanced response times, and
give *userspace* control over where the interrupt happens in the long 
run.

HTH,

         M.
-- 
Jazz is not dead. It just smells funny...
