Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FF5C433E1
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 14:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB4A12068F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 14:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593958609;
	bh=Wz6tmJZ7X6vLJFgWNa4oF4UuJ7+Eb1kGF2rczNiaB5g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XZLhEOh9gvF/maq0pIT/BoqFY8vFE+FeqUPTulV9nb3eDDmL8M3/ZbIVrHEifWW7t
	 13OwKTUoM1npVL57XOSxbUkVZuAF1vMU/vKcUXxY0yV3vfipMCr4a9B/pG6ZkbR4fc
	 JAF4KezdPVBhTtEaVvaZgMDkvVybFVheX0sM74v4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgGEOQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 10:16:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726538AbgGEOQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 10:16:47 -0400
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0E97208D5;
        Sun,  5 Jul 2020 14:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593958607;
        bh=Wz6tmJZ7X6vLJFgWNa4oF4UuJ7+Eb1kGF2rczNiaB5g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hjNqScfasUzOcxbE8S7M8xKI9Yc/aWMmWGfCSmkAHPTCaohVrm0edmqSca4yFlalt
         HPO8QNirKUedOWHnjk4rEil/Nh0Bjv5PLsCh9uQNH0T5oHlPVqonThB7+jvxkpa1IM
         iWVJcEXcoKMbEmzqEfRKx1xkvP3C1LFoMtCfCfCk=
Received: by mail-lj1-f182.google.com with SMTP id n23so42295853ljh.7;
        Sun, 05 Jul 2020 07:16:46 -0700 (PDT)
X-Gm-Message-State: AOAM532qlxk+vTIPpX547w7La916DR6SbtZN/oFrWOtF5FNYKaTHspLu
        JaAb/5oLeOZnIICr8PU5heJzhyOcAKcJHiElfA0=
X-Google-Smtp-Source: ABdhPJzOPwNtu8aM2X+c8NB4WS8eePD9/vHUi3xAaqCbYxF0wbpU9DWEDf+I1RNMWWggfT6/FhQ05llzyWCn/y8YIiA=
X-Received: by 2002:a2e:7e08:: with SMTP id z8mr19960078ljc.66.1593958604762;
 Sun, 05 Jul 2020 07:16:44 -0700 (PDT)
MIME-Version: 1.0
References: <1593930255-12378-1-git-send-email-guoren@kernel.org> <202007042350.4C153C4F8@keescook>
In-Reply-To: <202007042350.4C153C4F8@keescook>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 5 Jul 2020 22:16:14 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQFqH7GMvRgmtb=hBwvUy6NZyM8xLqOsUTvnYhO48tQbg@mail.gmail.com>
Message-ID: <CAJF2gTQFqH7GMvRgmtb=hBwvUy6NZyM8xLqOsUTvnYhO48tQbg@mail.gmail.com>
Subject: Re: [PATCH] riscv: Add STACKPROTECTOR supported
To:     Kees Cook <keescook@chromium.org>
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Zong Li <zong.li@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        Greentime Hu <green.hu@gmail.com>,
        Atish Patra <atish.patra@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

On Sun, Jul 5, 2020 at 2:53 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Sun, Jul 05, 2020 at 06:24:15AM +0000, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > The -fstack-protector & -fstack-protector-strong features are from
> > gcc. The patch only add basic kernel support to stack-protector
> > feature and some arch could have its own solution such as
> > ARM64_PTR_AUTH.
> >
> > After enabling STACKPROTECTOR and STACKPROTECTOR_STRONG, the .text
> > size is expanded from  0x7de066 to 0x81fb32 (only 5%) to add canary
> > checking code.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Cc: Paul Walmsley <paul.walmsley@sifive.com>
> > Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> > Cc: Albert Ou <aou@eecs.berkeley.edu>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com>
> > Cc: Greentime Hu <green.hu@gmail.com>
> > Cc: Atish Patra <atish.patra@wdc.com>
> > ---
> >  arch/riscv/Kconfig                      |  1 +
> >  arch/riscv/include/asm/stackprotector.h | 29 +++++++++++++++++++++++++=
++++
> >  arch/riscv/kernel/process.c             |  6 ++++++
> >  3 files changed, 36 insertions(+)
> >  create mode 100644 arch/riscv/include/asm/stackprotector.h
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index f927a91..4b0e308 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -63,6 +63,7 @@ config RISCV
> >       select HAVE_PERF_EVENTS
> >       select HAVE_PERF_REGS
> >       select HAVE_PERF_USER_STACK_DUMP
> > +     select HAVE_STACKPROTECTOR
> >       select HAVE_SYSCALL_TRACEPOINTS
> >       select IRQ_DOMAIN
> >       select MODULES_USE_ELF_RELA if MODULES
> > diff --git a/arch/riscv/include/asm/stackprotector.h b/arch/riscv/inclu=
de/asm/stackprotector.h
> > new file mode 100644
> > index 00000000..5962f88
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/stackprotector.h
> > @@ -0,0 +1,29 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#ifndef _ASM_RISCV_STACKPROTECTOR_H
> > +#define _ASM_RISCV_STACKPROTECTOR_H
> > +
> > +#include <linux/random.h>
> > +#include <linux/version.h>
> > +
> > +extern unsigned long __stack_chk_guard;
> > +
> > +/*
> > + * Initialize the stackprotector canary value.
> > + *
> > + * NOTE: this must only be called from functions that never return,
> > + * and it must always be inlined.
> > + */
> > +static __always_inline void boot_init_stack_canary(void)
> > +{
> > +     unsigned long canary;
> > +
> > +     /* Try to get a semi random initial value. */
> > +     get_random_bytes(&canary, sizeof(canary));
> > +     canary ^=3D LINUX_VERSION_CODE;
> > +     canary &=3D CANARY_MASK;
>
> Does riscv have any kind of instruction counters or other trivial timers
> that could be mixed in here? (e.g. x86's TSC)
Do you mean:
  get_random_bytes(&canary, sizeof(canary));
+ canary +=3D get_cycles64() + (get_cycles64() << 32UL);
  canary ^=3D LINUX_VERSION_CODE;
  canary &=3D CANARY_MASK;

Ok ?

>
> > +
> > +     current->stack_canary =3D canary;
> > +     __stack_chk_guard =3D current->stack_canary;
>
> What's needed for riscv to support a per-task canary? (e.g. x86's TLS or
> arm64's register-specific methods)
Some archs change __stack_chk_guard in _switch_to of entry.S, but it
depends on !CONFIG_SMP.

#if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_SMP)
        get  value  from next_task->stack_canary
        store  value to __stack_chk_guard
#endif

It's a so limitation solution for per-task canary, so I didn't copy it
into riscv?

For the register-specific, I prefer arm64's then x86, let's continue
talk in this mail thread:

https://lore.kernel.org/linux-riscv/1593958397-62466-1-git-send-email-guore=
n@kernel.org/T/#u

>
> > +}
> > +#endif /* _ASM_RISCV_STACKPROTECTOR_H */
> > diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> > index 824d117..6548929 100644
> > --- a/arch/riscv/kernel/process.c
> > +++ b/arch/riscv/kernel/process.c
> > @@ -24,6 +24,12 @@
> >
> >  register unsigned long gp_in_global __asm__("gp");
> >
> > +#ifdef CONFIG_STACKPROTECTOR
> > +#include <linux/stackprotector.h>
> > +unsigned long __stack_chk_guard __read_mostly;
> > +EXPORT_SYMBOL(__stack_chk_guard);
> > +#endif
> > +
> >  extern asmlinkage void ret_from_fork(void);
> >  extern asmlinkage void ret_from_kernel_thread(void);
> >
> > --
> > 2.7.4
> >
>
> But yes, as a starting point, better to have a single per-boot global
> canary than none at all. :)
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
Thank you :)

--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
