Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78913C54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 12:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 484812071C
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 12:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="qWKvpQKh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgDZMrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 08:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725972AbgDZMrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 08:47:05 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2729C061A0F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 05:47:04 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u127so17135547wmg.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 05:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=15N0AMALEEQtdmDZbhxqjR5vrw9NC2Tzc+/LVSacRkg=;
        b=qWKvpQKhhsmD797vQVIN5JK4iKB9E8RGZuUIyQ6XkQkftoQ7V64AYQ0Y5llUdLW0Qs
         +cA4patiUjfaLpKEhdJ0qkFAT1iNG5amjHaM2p3X+CXATyx0QjToiLiOkqu0GNEWHTKR
         7W5MsH42/tj28f3o//avZg+pNlHwz/OkANqFmP/HUSAjDb80ei8R0clBZ7u4dxgrU5Lj
         iAazhoYzVMM8WPQCsMKA9GKTQVvphaHeM68WFxUKeYP5LkwtDDYc3Zkzq81w49576Wq1
         m1F6ZCEI2cpILiOAYkrMeJLtWj2GDHrSmpGTs/SxgHutzkQA64tTLBMSXeO6gC0g6QET
         wmNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=15N0AMALEEQtdmDZbhxqjR5vrw9NC2Tzc+/LVSacRkg=;
        b=i5PFANt2Amtu2oHyjB7UOo80nEsaQnElcw33qENLFLIA6JFzjudJAuxEhbzHgYvmcJ
         WoGXPWy2/HjpLFGIk/K7lcK573kS+E231lss4eWQzznTWobBtfBWsGuRzNHA8dm/4s6+
         C1LOE3hMx5oaJXc5Lj+me20Igdrhitz+uIG68PZzijKQzJO/D5/lKdNpGsGkow03neNJ
         kSJbKeLWmeRTJEqVgO5ZVSXwkP+TdKe6rvNk1vu7+dPDHYfigAUnWXjsZutwn1mlEG/2
         QxRDdM6U6yc32veNvPUrfbzXdzq4qGKy5F+OK4IRq8x4Qpfi10QZ6tRiES6irucCYI10
         sx9A==
X-Gm-Message-State: AGi0Puat6Gm1a+lGxXqh5y7wS4ZNWKtS9HKwbd6zbwUetH2zbpyyv1zB
        +CTZyTIygshlUT2AVSe2s7UtoG7zE55rUzatHxtM2ihzjLMGhA==
X-Google-Smtp-Source: APiQypKHFGfELiOhf2nbbLO9DxHSjZooeTDd/7cXifOp4XF9bEFMbHSX/tnL2qyQCzjUGhLPItH1Pfc42y1pTTx69QE=
X-Received: by 2002:a1c:4144:: with SMTP id o65mr21894889wma.78.1587905223357;
 Sun, 26 Apr 2020 05:47:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200426110740.123638-1-zong.li@sifive.com>
In-Reply-To: <20200426110740.123638-1-zong.li@sifive.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Sun, 26 Apr 2020 18:16:52 +0530
Message-ID: <CAAhSdy3FCdzLV-nH03T=PBxB2tdZXhRrugcC2NcoA=22qpv+Lw@mail.gmail.com>
Subject: Re: [PATCH] irqchip/sifive-plic: allow many cores to handle IRQs
To:     Zong Li <zong.li@sifive.com>
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

On Sun, Apr 26, 2020 at 4:37 PM Zong Li <zong.li@sifive.com> wrote:
>
> Currently, driver forces the IRQs to be handled by only one core. This
> patch provides the way to enable others cores to handle IRQs if needed,
> so users could decide how many cores they wanted on default by boot
> argument.
>
> Use 'irqaffinity' boot argument to determine affinity. If there is no
> irqaffinity in dts or kernel configuration, use irq default affinity,
> so all harts would try to claim IRQ.
>
> For example, add irqaffinity=0 in chosen node to set irq affinity to
> hart 0. It also supports more than one harts to handle irq, such as set
> irqaffinity=0,3,4.
>
> You can change IRQ affinity from user-space using procfs. For example,
> you can make CPU0 and CPU2 serve IRQ together by the following command:
>
> echo 4 > /proc/irq/<x>/smp_affinity
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  drivers/irqchip/irq-sifive-plic.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index d0a71febdadc..bc1440d54185 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -111,15 +111,12 @@ static inline void plic_irq_toggle(const struct cpumask *mask,
>  static void plic_irq_unmask(struct irq_data *d)
>  {
>         struct cpumask amask;
> -       unsigned int cpu;
>         struct plic_priv *priv = irq_get_chip_data(d->irq);
>
>         cpumask_and(&amask, &priv->lmask, cpu_online_mask);
> -       cpu = cpumask_any_and(irq_data_get_affinity_mask(d),
> -                                          &amask);
> -       if (WARN_ON_ONCE(cpu >= nr_cpu_ids))
> -               return;
> -       plic_irq_toggle(cpumask_of(cpu), d, 1);
> +       cpumask_and(&amask, &amask, irq_data_get_affinity_mask(d));
> +
> +       plic_irq_toggle(&amask, d, 1);
>  }
>
>  static void plic_irq_mask(struct irq_data *d)
> @@ -133,24 +130,20 @@ static void plic_irq_mask(struct irq_data *d)
>  static int plic_set_affinity(struct irq_data *d,
>                              const struct cpumask *mask_val, bool force)
>  {
> -       unsigned int cpu;
>         struct cpumask amask;
>         struct plic_priv *priv = irq_get_chip_data(d->irq);
>
>         cpumask_and(&amask, &priv->lmask, mask_val);
>
>         if (force)
> -               cpu = cpumask_first(&amask);
> +               cpumask_copy(&amask, mask_val);
>         else
> -               cpu = cpumask_any_and(&amask, cpu_online_mask);
> -
> -       if (cpu >= nr_cpu_ids)
> -               return -EINVAL;
> +               cpumask_and(&amask, &amask, cpu_online_mask);
>
>         plic_irq_toggle(&priv->lmask, d, 0);
> -       plic_irq_toggle(cpumask_of(cpu), d, 1);
> +       plic_irq_toggle(&amask, d, 1);
>
> -       irq_data_update_effective_affinity(d, cpumask_of(cpu));
> +       irq_data_update_effective_affinity(d, &amask);
>
>         return IRQ_SET_MASK_OK_DONE;
>  }
> --
> 2.26.1
>

I strongly oppose (NACK) this patch due to performance reasons.

In PLIC, if we enable an IRQ X for N CPUs then when IRQ X occurs:
1) All N CPUs will take interrupt
2) All N CPUs will try to read PLIC CLAIM register
3) Only one of the CPUs will see IRQ X using the CLAIM register
but other N - 1 CPUs will see no interrupt and return back to what
they were doing. In other words, N - 1 CPUs will just waste CPU
every time IRQ X occurs.

Example1, one Application doing heavy network traffic will
degrade performance of other applications because with every
network RX/TX interrupt N-1 CPUs will waste CPU trying to
process network interrupt.

Example1, one Application doing heavy MMC/SD traffic will
degrade performance of other applications because with every
SPI read/write interrupt N-1 CPUs will waste CPU trying to
process it.

In fact, the current PLIC approach is actually a performance
optimization. This implementation also works fine with in-kernel
load-balancer and user space load balancer.

Regards,
Anup
