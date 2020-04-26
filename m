Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7A8C54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 13:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 418C12074F
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 13:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="QBM4aLep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgDZNTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 09:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726139AbgDZNTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 09:19:24 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CE9C061A0F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 06:19:24 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id c3so21319510otp.8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 06:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yYXwDqywnxQUI+vD+2dFTwtskNzX/fHxHB1snXxCfaI=;
        b=QBM4aLepspQnmt/hCdVncb4Nm2jwa33dteodt5D4QJgrWDRjxsY/azU1+iRaS7RD5P
         uN3BDlwcjb8od8YMXmyGkinlTdcpTo+JbWico1uGyvZd8Noji7JJmbMlD9NAA315AsJe
         EfUP/jrsZt6l8yJLyYnF92WUbNtlsuJJhMCtvittUjnYvOr6yhqSJnJpLs/anithK/OP
         m6SOft36UeWlCu0pGuoY3PbJDFhwwX2dRNlTrfZVp1uig2ndajCLaE3wpjHy00ntMioP
         C+Yi0kogh04QSLfgZkBvUxAnfX9elPT6AgBz/dhhIctvM1+nLhOCcOt3aVxPZTNWPj8X
         Kbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yYXwDqywnxQUI+vD+2dFTwtskNzX/fHxHB1snXxCfaI=;
        b=rUdLyhxKdCV46CBBN1POiSSseeY97QMOtTG3t/H12ywAtO/TQoR1rEw4G0GIKwskKa
         nQw/pFX3YT1hQvtZkMkWij9Y7vtRJM9jAtd5+cFvo5dPzeUmPCQL8F4n99dJXXr/Bs8F
         aNJ2imtTRU7rZHVc/H//y7YboynW+CDUWps/rGdCiWtKQzds/RzrdbBEV0bizDtbkaZd
         Olg8gRwBoyakC2qJbeNn0IgvVaU8YAhUUiwsNtgXYABINQwvsabGE8P0stRSc0ToUBFO
         ykcOf5ddHfyf+H622RD7+/Up7JHgs338HcEwjBbIBsSB1SQ98cnds+ZXC7+4QcbOFAG9
         nCBg==
X-Gm-Message-State: AGi0PuYo5VbGFEST84hozs9wcOs5f1vL7Ki/JcSxA0xkyCAoFwghwHDP
        YMNmua/1mHAVlo6WSslmhhDaCjE5ew7t6xCAjAHFR5+JZsU=
X-Google-Smtp-Source: APiQypLfr78a21DD+6mlktZjeVwVAlSQPDdwBgdv0hbHZ960IqxLv+kJOghJKo9ReWjoKv54vjdMCBzErF3UreLiBOo=
X-Received: by 2002:aca:5651:: with SMTP id k78mr5529295oib.32.1587907163563;
 Sun, 26 Apr 2020 06:19:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200426110740.123638-1-zong.li@sifive.com> <CAAhSdy3FCdzLV-nH03T=PBxB2tdZXhRrugcC2NcoA=22qpv+Lw@mail.gmail.com>
In-Reply-To: <CAAhSdy3FCdzLV-nH03T=PBxB2tdZXhRrugcC2NcoA=22qpv+Lw@mail.gmail.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Sun, 26 Apr 2020 21:19:13 +0800
Message-ID: <CANXhq0qW9ORoZ5qc5g8ikO9QdeYX=p0fwoP8pyFFkk02a7imnw@mail.gmail.com>
Subject: Re: [PATCH] irqchip/sifive-plic: allow many cores to handle IRQs
To:     Anup Patel <anup@brainfault.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 26, 2020 at 8:47 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Sun, Apr 26, 2020 at 4:37 PM Zong Li <zong.li@sifive.com> wrote:
> >
> > Currently, driver forces the IRQs to be handled by only one core. This
> > patch provides the way to enable others cores to handle IRQs if needed,
> > so users could decide how many cores they wanted on default by boot
> > argument.
> >
> > Use 'irqaffinity' boot argument to determine affinity. If there is no
> > irqaffinity in dts or kernel configuration, use irq default affinity,
> > so all harts would try to claim IRQ.
> >
> > For example, add irqaffinity=0 in chosen node to set irq affinity to
> > hart 0. It also supports more than one harts to handle irq, such as set
> > irqaffinity=0,3,4.
> >
> > You can change IRQ affinity from user-space using procfs. For example,
> > you can make CPU0 and CPU2 serve IRQ together by the following command:
> >
> > echo 4 > /proc/irq/<x>/smp_affinity
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >  drivers/irqchip/irq-sifive-plic.c | 21 +++++++--------------
> >  1 file changed, 7 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> > index d0a71febdadc..bc1440d54185 100644
> > --- a/drivers/irqchip/irq-sifive-plic.c
> > +++ b/drivers/irqchip/irq-sifive-plic.c
> > @@ -111,15 +111,12 @@ static inline void plic_irq_toggle(const struct cpumask *mask,
> >  static void plic_irq_unmask(struct irq_data *d)
> >  {
> >         struct cpumask amask;
> > -       unsigned int cpu;
> >         struct plic_priv *priv = irq_get_chip_data(d->irq);
> >
> >         cpumask_and(&amask, &priv->lmask, cpu_online_mask);
> > -       cpu = cpumask_any_and(irq_data_get_affinity_mask(d),
> > -                                          &amask);
> > -       if (WARN_ON_ONCE(cpu >= nr_cpu_ids))
> > -               return;
> > -       plic_irq_toggle(cpumask_of(cpu), d, 1);
> > +       cpumask_and(&amask, &amask, irq_data_get_affinity_mask(d));
> > +
> > +       plic_irq_toggle(&amask, d, 1);
> >  }
> >
> >  static void plic_irq_mask(struct irq_data *d)
> > @@ -133,24 +130,20 @@ static void plic_irq_mask(struct irq_data *d)
> >  static int plic_set_affinity(struct irq_data *d,
> >                              const struct cpumask *mask_val, bool force)
> >  {
> > -       unsigned int cpu;
> >         struct cpumask amask;
> >         struct plic_priv *priv = irq_get_chip_data(d->irq);
> >
> >         cpumask_and(&amask, &priv->lmask, mask_val);
> >
> >         if (force)
> > -               cpu = cpumask_first(&amask);
> > +               cpumask_copy(&amask, mask_val);
> >         else
> > -               cpu = cpumask_any_and(&amask, cpu_online_mask);
> > -
> > -       if (cpu >= nr_cpu_ids)
> > -               return -EINVAL;
> > +               cpumask_and(&amask, &amask, cpu_online_mask);
> >
> >         plic_irq_toggle(&priv->lmask, d, 0);
> > -       plic_irq_toggle(cpumask_of(cpu), d, 1);
> > +       plic_irq_toggle(&amask, d, 1);
> >
> > -       irq_data_update_effective_affinity(d, cpumask_of(cpu));
> > +       irq_data_update_effective_affinity(d, &amask);
> >
> >         return IRQ_SET_MASK_OK_DONE;
> >  }
> > --
> > 2.26.1
> >
>
> I strongly oppose (NACK) this patch due to performance reasons.
>
> In PLIC, if we enable an IRQ X for N CPUs then when IRQ X occurs:
> 1) All N CPUs will take interrupt
> 2) All N CPUs will try to read PLIC CLAIM register
> 3) Only one of the CPUs will see IRQ X using the CLAIM register
> but other N - 1 CPUs will see no interrupt and return back to what
> they were doing. In other words, N - 1 CPUs will just waste CPU
> every time IRQ X occurs.
>
> Example1, one Application doing heavy network traffic will
> degrade performance of other applications because with every
> network RX/TX interrupt N-1 CPUs will waste CPU trying to
> process network interrupt.
>
> Example1, one Application doing heavy MMC/SD traffic will
> degrade performance of other applications because with every
> SPI read/write interrupt N-1 CPUs will waste CPU trying to
> process it.
>
> In fact, the current PLIC approach is actually a performance
> optimization. This implementation also works fine with in-kernel
> load-balancer and user space load balancer.
>

Yes, it's exactly, I know what you pointed out. But the idea of this
patch is just providing a way that users could enable other cores if
they wanted, it could still enable only one core by this change. The
purpose here is thinking of flexible use, rather than limitation.
Maybe it would be a happy medium that we make the default case enable
only one core? It is a good open discussion.

> Regards,
> Anup
