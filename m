Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F0FC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDDBC2080D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="nDMU+vQz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbgGULtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 07:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbgGULtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 07:49:17 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFFDC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 04:49:15 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id b6so20874113wrs.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 04:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YhhhVF8z1SLInJUZAiDAnUC6bgocyhhgqr0w45WOgKE=;
        b=nDMU+vQzOjCBxZoK6uTXWTLLlkjbn/xqdnt0a9+YzT7k59y3jQCMaQAe+lzs4f1Las
         XDwKkAOt7VTkpqUppn/Ui+XJtYhVaSXB0vyxysiL4kRDOisE/ROVpZ3AoIZdTplZBmqu
         Lhhk9rAkBsz8ok9kvWiUTc+PNvZ6t5yWrw5aJ+Kwzrc6DEqD1Bdq5gpDmnH2flD+V2/1
         Xt+HuqKywm++0CeGmTJDxv9g4hdcRFwvkolInSoU/r0RMWb2MXaDyVkcFHyvNA6zKHZs
         GR6cOef7oKX74v1/UyuvC3SjbMs+8wP7Q7TBvDEbEOm6e2vukNUll5XyaWU/AaSnmzXX
         cFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YhhhVF8z1SLInJUZAiDAnUC6bgocyhhgqr0w45WOgKE=;
        b=QSfzDi85jhAAALj3mqZrXhbwmvKj79xy1SHBtPAHverS2z1COP5maIOWYz3j1Oz7OP
         L3zRlc6q6VAyl9Pb+tWWRL/WxJbfErD7//F6remBwfLaTLoO7PWrrT/GXWqw1PF1A68a
         e8fTvoLixS82zL4ISGiehPfVi0TGx9HGllkjkI3+kub1XRX/ayVdSwmErqZErnOZBqOP
         JZ3nyF3cs4mh8R804nUX5AHN27Dwuz3j6yBgxlTetso4YP0MBWK9lpS+N/VmXVG8pR/m
         Y0WYEEnfnv4SaypIlS8Z3f0kfSf3jI5aa24mME38W4rvtbgqiEETAytBQlwEleQfECon
         ClUQ==
X-Gm-Message-State: AOAM533aS0wdxEa+qqqy7Nfv17NFmHKzyhOCRz7CtJKgjE0q68pCZ8zX
        gCF3CVswKOX/cv5gnmp217bYKDU1BEILFKiFQ6rJeQ==
X-Google-Smtp-Source: ABdhPJwnJ+R0C8R5YU7vymVo3liRSIKqHF7p4MjG+BEHOSmembqsmAxdRbwISiIAZG5h1Pdnx0zrtLa0KOAKAefsGPE=
X-Received: by 2002:adf:9203:: with SMTP id 3mr9713351wrj.144.1595332154204;
 Tue, 21 Jul 2020 04:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200717075101.263332-1-anup.patel@wdc.com> <20200717075101.263332-3-anup.patel@wdc.com>
 <63f65ddd-b7c4-b8fd-151c-a77e8c87efed@linaro.org>
In-Reply-To: <63f65ddd-b7c4-b8fd-151c-a77e8c87efed@linaro.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 21 Jul 2020 17:19:02 +0530
Message-ID: <CAAhSdy2oGAk6A6=SwgCgZ+trmzCMRPOCiB6ibDTL2A_1sUu1og@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] clocksource/drivers: Add CLINT timer driver
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Emil Renner Berhing <kernel@esmil.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 4:32 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 17/07/2020 09:50, Anup Patel wrote:
> > We add a separate CLINT timer driver for Linux RISC-V M-mode (i.e.
> > RISC-V NoMMU kernel).
> >
> > The CLINT MMIO device provides three things:
> > 1. 64bit free running counter register
> > 2. 64bit per-CPU time compare registers
> > 3. 32bit per-CPU inter-processor interrupt registers
> >
> > Unlike other timer devices, CLINT provides IPI registers along with
> > timer registers. To use CLINT IPI registers, the CLINT timer driver
> > provides IPI related callbacks to arch/riscv.
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > Tested-by: Emil Renner Berhing <kernel@esmil.dk>
> > ---
> >  drivers/clocksource/Kconfig       |   9 ++
> >  drivers/clocksource/Makefile      |   1 +
> >  drivers/clocksource/timer-clint.c | 231 ++++++++++++++++++++++++++++++
> >  include/linux/cpuhotplug.h        |   1 +
> >  4 files changed, 242 insertions(+)
> >  create mode 100644 drivers/clocksource/timer-clint.c
> >
> > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> > index 91418381fcd4..e1ce0d510a03 100644
> > --- a/drivers/clocksource/Kconfig
> > +++ b/drivers/clocksource/Kconfig
> > @@ -658,6 +658,15 @@ config RISCV_TIMER
> >         is accessed via both the SBI and the rdcycle instruction.  This=
 is
> >         required for all RISC-V systems.
> >
> > +config CLINT_TIMER
> > +     bool "Timer for the RISC-V platform"
> > +     depends on GENERIC_SCHED_CLOCK && RISCV_M_MODE
> > +     select TIMER_PROBE
> > +     select TIMER_OF
> > +     help
> > +       This option enables the CLINT timer for RISC-V systems. The CLI=
NT
> > +       driver is usually used for NoMMU RISC-V systems.
>
> V3 has a comment about fixing the Kconfig option.

I have removed "default y" from the Kconfig option as-per your suggestions.

I looked at other Timer Kconfig options. Most of them have menuconfig name.
Also, we can certainly have different timer MMIO timer drivers in future. D=
o
you still insist on making this kconfig option totally silent ??

>
> [ ... ]
>
> > +{
> > +     bool *registered =3D per_cpu_ptr(&clint_clock_event_registered, c=
pu);
> > +     struct clock_event_device *ce =3D per_cpu_ptr(&clint_clock_event,=
 cpu);
> > +
> > +     if (!(*registered)) {
> > +             ce->cpumask =3D cpumask_of(cpu);
> > +             clockevents_config_and_register(ce, clint_timer_freq, 200=
,
> > +                                              ULONG_MAX);
> > +             *registered =3D true;
> > +     }
>
>
> I was unsure about the clockevents_config_and_register() multiple calls
> when doing the comment. It seems like it is fine to call it several
> times and that is done in several places like riscv or arch_arm_timer.
>
> It is probably safe to drop the 'registered' code here, sorry for the
> confusion.

Okay, will revert these changes.

>
> > +     enable_percpu_irq(clint_timer_irq,
> > +                       irq_get_trigger_type(clint_timer_irq));
> > +     return 0;
> > +}
> > +
>
> [ ... ]
>
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog

Regards,
Anup
