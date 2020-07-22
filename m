Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831BAC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 03:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AAB120714
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 03:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="n5kU7X/C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731919AbgGVDgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 23:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731781AbgGVDgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 23:36:38 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CE2C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 20:36:37 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 17so579100wmo.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 20:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZYjf/M8LtGnB4n0AyVVMXshArfiVRiM4rRLy+QhAdfs=;
        b=n5kU7X/CI3Z5fW6+a551VM3WKGThHB5ECCmvscA5jslOS6TIK8br9x2moqjvPMW/cO
         4IROMHQFonmY+VuZyRzuCUu0Br+fXUw4ZZh9w+kNVins/sX+FDLeCUpDLXWopq4L4KKR
         JJwgau3DxCOp6ISAphnMaIyhgaekZHeFaBxBcykEqImIhN5bxU5bUFH/nihdD8K5vnv3
         1ohikFnZFDtlWYURDzaqbbthwJJijaRT2nDXJbRxgS25kCrD7dM0khqGcZl59dAyAxR1
         7YuAlnecgKJrux+CpYjmP4mCDKs634ykK+DO0MEpxfSao+US+//ueJcWdf6vHNJyYdBU
         Z3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZYjf/M8LtGnB4n0AyVVMXshArfiVRiM4rRLy+QhAdfs=;
        b=TfRTRjWNvbM5yw/jZjW+2lHI24hkTVpQJ0/fhThdZPfuU9ulEdosb4ri37cepGYgHr
         8hdqWKozt3UGmxWjW9K8ueh/5zuUE6MhxitIEYEITRXUOsfQROqDrhvgMJ5X5fvjNVP9
         1dn5i3M5AVX31YVneWDWWCYNdrMs8xDqMDaP77hrOe6rCAXn0edwv9nyz5KBOdc6Y3dM
         whWKwW5uRtlstHPRgHYn+1s6iVDK4STfqSQAdHVRY9cRUX469BxGerm3qYynZYTR/+vt
         5TxvM0zTvwVHofAj/M/z262s1X6qUH9qMNHXaIbky2WN6s5fjiwHm3XqQLB8Bv0FDKpV
         2LVw==
X-Gm-Message-State: AOAM530PHC0nSeplDPCI0DFxy5k57iUQ9Vcqop/o3PAw71/KfcSMeqiC
        RMiN3QkK7HmqklZFKLJvpVpVNjjduOb97C83/USf1w==
X-Google-Smtp-Source: ABdhPJz1xTvLXcoVhk8ZPc7aGEiWIeZd45I4TtCBSHOm9CSA0MqoCjl6Ufc6dKkEIUr4LC9xvkDrLWvqNuc1sdfLi/k=
X-Received: by 2002:a1c:8117:: with SMTP id c23mr6252105wmd.157.1595388996424;
 Tue, 21 Jul 2020 20:36:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200717075101.263332-1-anup.patel@wdc.com> <20200717075101.263332-3-anup.patel@wdc.com>
 <63f65ddd-b7c4-b8fd-151c-a77e8c87efed@linaro.org> <CAAhSdy2oGAk6A6=SwgCgZ+trmzCMRPOCiB6ibDTL2A_1sUu1og@mail.gmail.com>
 <107e3ef3-9f61-05d1-7a91-95d0dc7ea7b8@linaro.org>
In-Reply-To: <107e3ef3-9f61-05d1-7a91-95d0dc7ea7b8@linaro.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 22 Jul 2020 09:06:24 +0530
Message-ID: <CAAhSdy0fmtaExqEx-7qW6Bpzu23d6A4OnUY7b785VJW_5a6rdA@mail.gmail.com>
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

On Tue, Jul 21, 2020 at 5:45 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 21/07/2020 13:49, Anup Patel wrote:
> > On Tue, Jul 21, 2020 at 4:32 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 17/07/2020 09:50, Anup Patel wrote:
> >>> We add a separate CLINT timer driver for Linux RISC-V M-mode (i.e.
> >>> RISC-V NoMMU kernel).
> >>>
> >>> The CLINT MMIO device provides three things:
> >>> 1. 64bit free running counter register
> >>> 2. 64bit per-CPU time compare registers
> >>> 3. 32bit per-CPU inter-processor interrupt registers
> >>>
> >>> Unlike other timer devices, CLINT provides IPI registers along with
> >>> timer registers. To use CLINT IPI registers, the CLINT timer driver
> >>> provides IPI related callbacks to arch/riscv.
> >>>
> >>> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> >>> Tested-by: Emil Renner Berhing <kernel@esmil.dk>
> >>> ---
> >>>  drivers/clocksource/Kconfig       |   9 ++
> >>>  drivers/clocksource/Makefile      |   1 +
> >>>  drivers/clocksource/timer-clint.c | 231 ++++++++++++++++++++++++++++=
++
> >>>  include/linux/cpuhotplug.h        |   1 +
> >>>  4 files changed, 242 insertions(+)
> >>>  create mode 100644 drivers/clocksource/timer-clint.c
> >>>
> >>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfi=
g
> >>> index 91418381fcd4..e1ce0d510a03 100644
> >>> --- a/drivers/clocksource/Kconfig
> >>> +++ b/drivers/clocksource/Kconfig
> >>> @@ -658,6 +658,15 @@ config RISCV_TIMER
> >>>         is accessed via both the SBI and the rdcycle instruction.  Th=
is is
> >>>         required for all RISC-V systems.
> >>>
> >>> +config CLINT_TIMER
> >>> +     bool "Timer for the RISC-V platform"
> >>> +     depends on GENERIC_SCHED_CLOCK && RISCV_M_MODE
> >>> +     select TIMER_PROBE
> >>> +     select TIMER_OF
> >>> +     help
> >>> +       This option enables the CLINT timer for RISC-V systems. The C=
LINT
> >>> +       driver is usually used for NoMMU RISC-V systems.
> >>
> >> V3 has a comment about fixing the Kconfig option.
> >
> > I have removed "default y" from the Kconfig option as-per your suggesti=
ons.
> >
> > I looked at other Timer Kconfig options. Most of them have menuconfig n=
ame.
> > Also, we can certainly have different timer MMIO timer drivers in futur=
e. Do
> > you still insist on making this kconfig option totally silent ??
>
> Yes, and there is an effort to change the entries to be silent as much
> as possible.
>
> Just add:
>
>         bool "Timer for the RISC-V platform" if COMPILE_TEST

Okay, I will update.

>
> and remove the RISCV_M_MODE dependency.

CLINT driver depends on RISC-V specific symbols from asm/smp.h
so we should at least have "depends on RISCV" so that compile
test does not fail.

Agree ??

>
> Or alternatively:
>
> replace the RISCV_M_MODE dependency with COMPILE_TEST
>
> The goal is to be able to compile the driver on different platforms for
> compilation test covering.

Please see the above comment.

>
> Then when more mmio drivers will added we will figure out.
>
> >> [ ... ]
> >>
> >>> +{
> >>> +     bool *registered =3D per_cpu_ptr(&clint_clock_event_registered,=
 cpu);
> >>> +     struct clock_event_device *ce =3D per_cpu_ptr(&clint_clock_even=
t, cpu);
> >>> +
> >>> +     if (!(*registered)) {
> >>> +             ce->cpumask =3D cpumask_of(cpu);
> >>> +             clockevents_config_and_register(ce, clint_timer_freq, 2=
00,
> >>> +                                              ULONG_MAX);
> >>> +             *registered =3D true;
> >>> +     }
> >>
> >>
> >> I was unsure about the clockevents_config_and_register() multiple call=
s
> >> when doing the comment. It seems like it is fine to call it several
> >> times and that is done in several places like riscv or arch_arm_timer.
> >>
> >> It is probably safe to drop the 'registered' code here, sorry for the
> >> confusion.
> >
> > Okay, will revert these changes.
> >
> >>
> >>> +     enable_percpu_irq(clint_timer_irq,
> >>> +                       irq_get_trigger_type(clint_timer_irq));
> >>> +     return 0;
> >>> +}
> >>> +
> >>
> >> [ ... ]
> >>
> >>
> >> --
> >> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs
> >>
> >> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> >> <http://twitter.com/#!/linaroorg> Twitter |
> >> <http://www.linaro.org/linaro-blog/> Blog
> >
> > Regards,
> > Anup
> >
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
