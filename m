Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07B2C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 10:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 730D820878
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 10:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="gvLcAle4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgEaKGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 06:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727887AbgEaKGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 06:06:23 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABA3C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 03:06:21 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id n5so8492172wmd.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 03:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2hPeXGDljymjoN8cxh2DsvjXD31g09/x8EqEDUlr2Cs=;
        b=gvLcAle4FOVMTZ4Ko1hxhk71DlaCLYZJAMxcJeowYNUkUwx9IiyifHx+bndCRzZa+e
         T5H7XF44coZYUmYSArfEgHOm2BkVqv/w21FT5IHjZ9JZvVbYbI22oNC4S2J+mBzeMvE+
         +sKfmYZQPInVjwtfuekdp7iKKZiPmjMgqnkTJPRCgYSVKKaPIGhKugNam2UiBQ4qjh2k
         YGOKYVpq13Sqx6O4BX4cXf5EZ4mK55gqpMJ7PhwFScqwrbXkOOUzFRstGmNdgBx1D/D+
         rBiVKbCiIwrY6F9YoMrI32gMWskoTNhNerRFVRonGWOCCg9KTzZANIj1ibLzxUxh2BBx
         ccdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2hPeXGDljymjoN8cxh2DsvjXD31g09/x8EqEDUlr2Cs=;
        b=LnrDhfrrGvzkHEDx6/S8IP8tiGYuLVkVNRf7/HtMGZwTq3zAZWLM6Qiy/ztBqh9Qdy
         XxuVM6B5a7oSU7pt/reGw2GSx+nT3VcZZsz4COVyxwBIMvCaj+Lrwht6/IXb9XXVWGQe
         vgurC+Yd2aJHosQ2W0gemVZQwYwqO8AO6n/3lytZKKF6XQ/AtApbLjml2TFfJIZta9Ni
         QeTUiTmj65Zq7Rg/Me+VQEnIWjIrR52Mm5Vt44wx/2Yr1p5COKmGtYVbQMQS948+7yS3
         rBizqEdB1eRRU/PsGNFHPcvUnIFlY08qSr2reRppTTFXrhqecFEFPj2Ro9LIIiHTKotF
         ZU4Q==
X-Gm-Message-State: AOAM5328C3XwAm+PZ4EPZefSmfpsbzdoCsqDwqgs2ktH5vkwshBQo/X+
        /Gal7MKF/etPJCJ+O1J4CjfJYw8UZKZtxaFQKzjDyQ==
X-Google-Smtp-Source: ABdhPJxJ2FPXa9Nr1myO0y2r9HfyzVcfviGIX3PrtHiaVKQVCVHp/aGHpXMEGZ4xcyhSPC5dEdWerG/g610dIjt6hcw=
X-Received: by 2002:a1c:1b17:: with SMTP id b23mr16536717wmb.3.1590919580005;
 Sun, 31 May 2020 03:06:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200530100725.265481-1-anup.patel@wdc.com> <20200530100725.265481-4-anup.patel@wdc.com>
 <cd4a5513197b73e3b8d335f09117bb8d@kernel.org> <CAAhSdy3cnZwnjpqWkixmZ5-fi=GK1cSUsjah=P3Yp5hjv382hg@mail.gmail.com>
 <a5f1346544aec6e6da69836b7a6e0a6e@kernel.org>
In-Reply-To: <a5f1346544aec6e6da69836b7a6e0a6e@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Sun, 31 May 2020 15:36:08 +0530
Message-ID: <CAAhSdy2fJ1cd2OjAWODOmSbkWUBfvvr4rvsTqh4qNxZjTTKo5A@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] irqchip: RISC-V per-HART local interrupt
 controller driver
To:     Marc Zyngier <maz@kernel.org>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 31, 2020 at 3:03 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On 2020-05-31 06:36, Anup Patel wrote:
> > On Sat, May 30, 2020 at 5:31 PM Marc Zyngier <maz@kernel.org> wrote:
>
> [...]
>
> >> >       plic_set_threshold(handler, PLIC_DISABLE_THRESHOLD);
> >>
> >> Why do you need to both disable the interrupt *and* change the
> >> priority
> >> threshold? It seems to be that one of them should be enough, but my
> >> kno9wledge of the PLIC is limited. In any case, this would deserve a
> >> comment.
> >
> > Okay, I will test and remove "disable the interrupt" part from
> > plic_dying_cpu().
>
> Be careful, as interrupt enabling/disabling is refcounted in order
> to allow nesting. If you only enable on CPU_ON and not disable
> on CPU_OFF, you will end-up with a depth that only increases,
> up to the point where you hit the roof (it will take a while though).
>
> I would keep the enable/disable as is, and drop the priority
> setting from the CPU_OFF path.

The PLIC threshold is like GICv2 CPU interface enable/disable.

Based on your comment, we should only program the PLIC threshold
in CPU_ON and don't touch the PLIC threshold in CPU_OFF. Right??

>
> >> >       return 0;
> >> > @@ -260,7 +266,11 @@ static int plic_starting_cpu(unsigned int cpu)
> >> >  {
> >> >       struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
> >> >
> >> > -     csr_set(CSR_IE, IE_EIE);
> >> > +     if (plic_parent_irq)
> >> > +             enable_percpu_irq(plic_parent_irq,
> >> > +                               irq_get_trigger_type(plic_parent_irq));
> >> > +     else
> >> > +             pr_warn("cpu%d: parent irq not available\n");
> >>
> >> What does it mean to carry on if the interrupt cannot be signaled?
> >> Shouldn't you error out instead, and leave the CPU dead?
> >
> > The CPU is not dead if we cannot enable RISC-V INTC external
> > interrupt because the Timer and IPIs interrupts are always through
> > RISC-V INTC. The PLIC external interrupt not present for a CPU
> > only means that that CPU cannot receive peripherial interrupts.
> >
> > On a sane RISC-V system, if PLIC is present then all CPUs should
> > be able to get RISC-V INTC external interrupt. Base on this rationale,
> > I have put a warning for plic_parent_irq == 0.
>
> Fair enough.
>
>          M.
> --
> Jazz is not dead. It just smells funny...

Regards,
Anup
