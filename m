Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66966C2D0E7
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 07:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B13220787
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 07:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="cX1j4qWp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731914AbgDAHmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 03:42:42 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43723 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731680AbgDAHml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 03:42:41 -0400
Received: by mail-oi1-f196.google.com with SMTP id k5so11733478oiw.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 00:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5zndDsQln1VoSVFlMkMCJI03Gbtn5PtDAwUVsnQmjxQ=;
        b=cX1j4qWpwmJ/bHORXMzQ4c06zQ5KJnzXeiOGcNznoQ2fL2E8pH/eguAoikndZINMh+
         rBWWSJ25bSgG1YVo8C63Ro+FxazwOPxZAPWrlCcqiopARRwok3YT4UUr4uQWxFJwVmId
         DSQW/cCWXyjFdEq8oz+tGS0yR5rsYKkdc95JqLb2WSoLLVTBSt8mAmCtSBKn6Qddg5ls
         ve9WUzDVF3ZZ79hWZqYh6gItTBdufEiT8vUgSDpgKReIUmRwZyNpp3bSW2T2stMg+Hvt
         QoifQqZ6+RSpU9VDxRFFh5KNCab3HIRxsH6YPAX40p9e5sR4VbL4mfH83JMH0IFooaEj
         9zng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5zndDsQln1VoSVFlMkMCJI03Gbtn5PtDAwUVsnQmjxQ=;
        b=icQ2hmFq7y98kCYWO/hD4Gb9YZzo2dfzYT/UsaE5US1zTuSGO/PW3TKNf8iHcysJBg
         opIKV8q+GNiYLXUAmFQU4oE3g2NggEEmLipXO8s+DnvEfvBZ7+TZsQk8maKOj4fzfVri
         S9B59yrF6nL3zVFPQRqw8eRvCb2F3y4Tcs5NXEfR5ISs5pn69HAqnTvk2uCn9p2Fv5FV
         MRiWojG+duVA5wWuiU1zp8DIn8AgRAdIMjAbUIq7BA4/LdPZRZ0XKOFGnRe7JsDxeAvY
         sQm0JId8gxgv8ziYp+y5cI0k8Ece4Km+nqmBy2L+mX35jLd2O6Be5wZW5EU6e2YkYk9Z
         vp4g==
X-Gm-Message-State: AGi0PuYQ50nd1HDO3CBN/smzEF1wNcrXFL3ijoIKdqrGrhVHZt0hyu6w
        I4HDVAorIeQjqFd49r1SeLL9VGECbsuPHTLcDzpNdA==
X-Google-Smtp-Source: APiQypKUboWmyYsWOwLgZoc81Kd2SK0D/JT5cFztNiE88xtaN2VlFrVhCy8cBNxe43frHK5Uqd2DeS7HjXFsxRdPj3M=
X-Received: by 2002:a05:6808:56:: with SMTP id v22mr1802866oic.116.1585726960387;
 Wed, 01 Apr 2020 00:42:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583772574.git.zong.li@sifive.com> <d27d9e68491e1df67dbee6c22df6a72ff95bab18.1583772574.git.zong.li@sifive.com>
 <20200401003233.17fe4b6f7075e5b8f0ed5114@kernel.org>
In-Reply-To: <20200401003233.17fe4b6f7075e5b8f0ed5114@kernel.org>
From:   Zong Li <zong.li@sifive.com>
Date:   Wed, 1 Apr 2020 15:42:30 +0800
Message-ID: <CANXhq0ra3o+mgenbYLq_q0eZY2KiXNpWmo2V0amD0cFDqCQkXw@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] riscv: introduce interfaces to patch kernel code
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 11:32 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Hi,
>
> On Tue, 10 Mar 2020 00:55:43 +0800
> Zong Li <zong.li@sifive.com> wrote:
>
> > On strict kernel memory permission, we couldn't patch code without
> > writable permission. Preserve two holes in fixmap area, so we can map
> > the kernel code temporarily to fixmap area, then patch the instructions.
> >
> > We need two pages here because we support the compressed instruction, so
> > the instruction might be align to 2 bytes. When patching the 32-bit
> > length instruction which is 2 bytes alignment, it will across two pages.
> >
> > Introduce two interfaces to patch kernel code:
> > riscv_patch_text_nosync:
> >  - patch code without synchronization, it's caller's responsibility to
> >    synchronize all CPUs if needed.
> > riscv_patch_text:
> >  - patch code and always synchronize with stop_machine()
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >  arch/riscv/include/asm/fixmap.h |   2 +
> >  arch/riscv/include/asm/patch.h  |  12 ++++
> >  arch/riscv/kernel/Makefile      |   4 +-
> >  arch/riscv/kernel/patch.c       | 120 ++++++++++++++++++++++++++++++++
> >  4 files changed, 137 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/riscv/include/asm/patch.h
> >  create mode 100644 arch/riscv/kernel/patch.c
> >
> > diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
> > index 42d2c42f3cc9..2368d49eb4ef 100644
> > --- a/arch/riscv/include/asm/fixmap.h
> > +++ b/arch/riscv/include/asm/fixmap.h
> > @@ -27,6 +27,8 @@ enum fixed_addresses {
> >       FIX_FDT = FIX_FDT_END + FIX_FDT_SIZE / PAGE_SIZE - 1,
> >       FIX_PTE,
> >       FIX_PMD,
> > +     FIX_TEXT_POKE1,
> > +     FIX_TEXT_POKE0,
> >       FIX_EARLYCON_MEM_BASE,
> >       __end_of_fixed_addresses
> >  };
> > diff --git a/arch/riscv/include/asm/patch.h b/arch/riscv/include/asm/patch.h
> > new file mode 100644
> > index 000000000000..b5918a6e0615
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/patch.h
> > @@ -0,0 +1,12 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (C) 2020 SiFive
> > + */
> > +
> > +#ifndef _ASM_RISCV_PATCH_H
> > +#define _ASM_RISCV_PATCH_H
> > +
> > +int riscv_patch_text_nosync(void *addr, const void *insns, size_t len);
> > +int riscv_patch_text(void *addr, u32 insn);
> > +
> > +#endif /* _ASM_RISCV_PATCH_H */
> > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > index f40205cb9a22..d189bd3d8501 100644
> > --- a/arch/riscv/kernel/Makefile
> > +++ b/arch/riscv/kernel/Makefile
> > @@ -4,7 +4,8 @@
> >  #
> >
> >  ifdef CONFIG_FTRACE
> > -CFLAGS_REMOVE_ftrace.o = -pg
> > +CFLAGS_REMOVE_ftrace.o       = -pg
> > +CFLAGS_REMOVE_patch.o        = -pg
> >  endif
> >
> >  extra-y += head.o
> > @@ -26,6 +27,7 @@ obj-y       += traps.o
> >  obj-y        += riscv_ksyms.o
> >  obj-y        += stacktrace.o
> >  obj-y        += cacheinfo.o
> > +obj-y        += patch.o
> >  obj-$(CONFIG_MMU) += vdso.o vdso/
> >
> >  obj-$(CONFIG_RISCV_M_MODE)   += clint.o
> > diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> > new file mode 100644
> > index 000000000000..8a4fc65ee022
> > --- /dev/null
> > +++ b/arch/riscv/kernel/patch.c
> > @@ -0,0 +1,120 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2020 SiFive
> > + */
> > +
> > +#include <linux/spinlock.h>
> > +#include <linux/mm.h>
> > +#include <linux/uaccess.h>
> > +#include <linux/stop_machine.h>
> > +#include <asm/kprobes.h>
> > +#include <asm/cacheflush.h>
> > +#include <asm/fixmap.h>
> > +
> > +struct riscv_insn_patch {
> > +     void *addr;
> > +     u32 insn;
> > +     atomic_t cpu_count;
> > +};
> > +
> > +#ifdef CONFIG_MMU
> > +static DEFINE_RAW_SPINLOCK(patch_lock);
> > +
> > +static void __kprobes *patch_map(void *addr, int fixmap)
>
> Please use NOKPROBE_SYMBOL() instead of __kprobes. __kprobes is old style.
>
> > +{
> > +     uintptr_t uintaddr = (uintptr_t) addr;
> > +     struct page *page;
> > +
> > +     if (core_kernel_text(uintaddr))
> > +             page = phys_to_page(__pa_symbol(addr));
> > +     else if (IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
> > +             page = vmalloc_to_page(addr);
> > +     else
> > +             return addr;
> > +
> > +     BUG_ON(!page);
> > +
> > +     return (void *)set_fixmap_offset(fixmap, page_to_phys(page) +
> > +                                      (uintaddr & ~PAGE_MASK));
> > +}
> > +
> > +static void __kprobes patch_unmap(int fixmap)
> > +{
> > +     clear_fixmap(fixmap);
> > +}
> > +
> > +static int __kprobes riscv_insn_write(void *addr, const void *insn, size_t len)
>
> Why would you add "riscv_" prefix for those functions? It seems a bit odd.

There is no particular reason, I just was used to adding a prefix for
arch-related stuff. I have no preference here, it's OK to me to remove
the prefix of these functions, do you think we need to remove them?

>
> > +{
> > +     void *waddr = addr;
> > +     bool across_pages = (((uintptr_t) addr & ~PAGE_MASK) + len) > PAGE_SIZE;
> > +     unsigned long flags = 0;
> > +     int ret;
> > +
> > +     raw_spin_lock_irqsave(&patch_lock, flags);
>
> This looks a bit odd since stop_machine() is protected by its own mutex,
> and also the irq is already disabled here.

We need it because we don't always enter the riscv_patch_text_nosync()
through stop_machine mechanism. If we call the
riscv_patch_text_nosync() directly, we need a lock to protect the
page.

>
> Thank you,
>
> > +
> > +     if (across_pages)
> > +             patch_map(addr + len, FIX_TEXT_POKE1);
> > +
> > +     waddr = patch_map(addr, FIX_TEXT_POKE0);
> > +
> > +     ret = probe_kernel_write(waddr, insn, len);
> > +
> > +     patch_unmap(FIX_TEXT_POKE0);
> > +
> > +     if (across_pages)
> > +             patch_unmap(FIX_TEXT_POKE1);
> > +
> > +     raw_spin_unlock_irqrestore(&patch_lock, flags);
> > +
> > +     return ret;
> > +}
> > +#else
> > +static int __kprobes riscv_insn_write(void *addr, const void *insn, size_t len)
> > +{
> > +     return probe_kernel_write(addr, insn, len);
> > +}
> > +#endif /* CONFIG_MMU */
> > +
> > +int __kprobes riscv_patch_text_nosync(void *addr, const void *insns, size_t len)
> > +{
> > +     u32 *tp = addr;
> > +     int ret;
> > +
> > +     ret = riscv_insn_write(tp, insns, len);
> > +
> > +     if (!ret)
> > +             flush_icache_range((uintptr_t) tp, (uintptr_t) tp + len);
> > +
> > +     return ret;
> > +}
> > +
> > +static int __kprobes riscv_patch_text_cb(void *data)
> > +{
> > +     struct riscv_insn_patch *patch = data;
> > +     int ret = 0;
> > +
> > +     if (atomic_inc_return(&patch->cpu_count) == 1) {
> > +             ret =
> > +                 riscv_patch_text_nosync(patch->addr, &patch->insn,
> > +                                         GET_INSN_LENGTH(patch->insn));
> > +             atomic_inc(&patch->cpu_count);
> > +     } else {
> > +             while (atomic_read(&patch->cpu_count) <= num_online_cpus())
> > +                     cpu_relax();
> > +             smp_mb();
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +int __kprobes riscv_patch_text(void *addr, u32 insn)
> > +{
> > +     struct riscv_insn_patch patch = {
> > +             .addr = addr,
> > +             .insn = insn,
> > +             .cpu_count = ATOMIC_INIT(0),
> > +     };
> > +
> > +     return stop_machine_cpuslocked(riscv_patch_text_cb,
> > +                                    &patch, cpu_online_mask);
> > +}
> > --
> > 2.25.1
> >
>
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>
