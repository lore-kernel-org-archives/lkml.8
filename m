Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0D8C2BA16
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 03:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA86E2076E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 03:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DHKeeqH6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgDHDwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 23:52:00 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36001 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbgDHDv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 23:51:59 -0400
Received: by mail-ot1-f66.google.com with SMTP id l23so5496247otf.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 20:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xw2rI/jmpxVQh3fg5HZvbuztTOiWeSN/YRHbSv4sdDQ=;
        b=DHKeeqH6Q3E68LNdbDbqIx4CouB3Y8X149/xttc6yHxlRm60ztbyCGSaM+cEHF0wHj
         La2e1NkGONdfQnkTbxjnzu+jVp6+5ttGid5efU8OkQB0csXNWo5wfG8u1NGd449UkjFL
         4GE4vzyn3TcXMrQdNaZjZFCkf2cc+yaV1PyYB2qBtpF3i5Di3ell7tOE8ksK1AJdfiDr
         pTsLn0YZv3Cff6BJEtbw8md+RHTwObf3MHY3H+6SPyQVfT//leSdLXG54SUMlCEL1wUb
         DD/71WuhEA4GusruqLRrfQukgrWvrwTvWYc7jnfvVIJ8xMf5LgXGghIF+jK4svC8Ou9R
         6gsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xw2rI/jmpxVQh3fg5HZvbuztTOiWeSN/YRHbSv4sdDQ=;
        b=OVjKIFmeODXOeU3AMd/JA4/Fwg3Lg+CDBPixJJmE4PxevlZVjd/v7FB5UZ0svnbaU1
         NIdoFME0WmTG2PFdGjeWxpvqG17o8umavyIGd6Py/WP6FgMsBCqBirR3HEwn9CsFYxsK
         svoWcl7Z/4KCMzC/yetf0nwcbDbK841l5xROz90/wjfppwRnRirLbIMV79Ndd4nHoBR7
         9B01CyFCQKfeAu/tPY1sPPC40v+kiVw7OO0VVYZ/VFH12WIKF/lr0g54K5K74m7MrSsS
         I7Qu1+gd9pU3Lra7aZfZFcmzTky6knkRktHf1wncrHbZVlUYyX7Ije6NYspTvYVbAY/z
         znUA==
X-Gm-Message-State: AGi0Pubpv8omC8o2C/yw1JjCt4w91fiyC2aQJg34GKS6age9ws1+kTAD
        Yom5rEyPdm/Vpu5UI8HV2NNWGne49hy9cay5ZZ7zXQ==
X-Google-Smtp-Source: APiQypKidIcy81Re1WUxWRaaF/ZfKWH4GrAhl8S4y6oJIoAmx0g/bqCZFCYAWXXPw3xD9LnSCoCtQMpILlRwfxJ3QxM=
X-Received: by 2002:a9d:2002:: with SMTP id n2mr4457288ota.127.1586317916395;
 Tue, 07 Apr 2020 20:51:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1586265122.git.zong.li@sifive.com> <a491ce48973a0b4f0eed3fe4e97d6a07cb6d6ae8.1586265122.git.zong.li@sifive.com>
 <20200408005850.5e1a7666013f080ff60020e2@kernel.org>
In-Reply-To: <20200408005850.5e1a7666013f080ff60020e2@kernel.org>
From:   Zong Li <zong.li@sifive.com>
Date:   Wed, 8 Apr 2020 11:51:46 +0800
Message-ID: <CANXhq0oYbF17wL9eYfdN_N9ofCpvUwi4Reyf145YHJTpDOsjTA@mail.gmail.com>
Subject: Re: [PATCH v4 2/9] riscv: introduce interfaces to patch kernel code
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

On Tue, Apr 7, 2020 at 11:58 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Hi Zong,
>
> On Tue,  7 Apr 2020 22:46:47 +0800
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
> > Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
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
> > index 000000000000..9a7d7346001e
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
> > +int patch_text_nosync(void *addr, const void *insns, size_t len);
> > +int patch_text(void *addr, u32 insn);
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
> > index 000000000000..5b4f0d37097f
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
> > +struct patch_insn_patch {
> > +     void *addr;
> > +     u32 insn;
> > +     atomic_t cpu_count;
> > +};
> > +
> > +#ifdef CONFIG_MMU
> > +static void *patch_map(void *addr, int fixmap)
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
> > +NOKPROBE_SYMBOL(patch_map);
> > +
> > +static void patch_unmap(int fixmap)
> > +{
> > +     clear_fixmap(fixmap);
> > +}
> > +NOKPROBE_SYMBOL(patch_unmap);
> > +
>
> Please leave a comment here about text_mutex,
>
> > +static int patch_insn_write(void *addr, const void *insn, size_t len)
> > +{
> > +     void *waddr = addr;
> > +     bool across_pages = (((uintptr_t) addr & ~PAGE_MASK) + len) > PAGE_SIZE;
> > +     int ret;
>
> Or use lockdep_assert_held(&text_mutex); here so that user can easily
> understand they have to lock the text_mutex before calling this.
>

OK, it seems to me that both could be added in the next version. Thanks.

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
> > +     return ret;
> > +}
> > +NOKPROBE_SYMBOL(patch_insn_write);
> > +#else
> > +static int patch_insn_write(void *addr, const void *insn, size_t len)
> > +{
> > +     return probe_kernel_write(addr, insn, len);
> > +}
> > +NOKPROBE_SYMBOL(patch_insn_write);
> > +#endif /* CONFIG_MMU */
> > +
> > +int patch_text_nosync(void *addr, const void *insns, size_t len)
> > +{
> > +     u32 *tp = addr;
> > +     int ret;
> > +
> > +     ret = patch_insn_write(tp, insns, len);
> > +
> > +     if (!ret)
> > +             flush_icache_range((uintptr_t) tp, (uintptr_t) tp + len);
> > +
> > +     return ret;
> > +}
> > +NOKPROBE_SYMBOL(patch_text_nosync);
> > +
> > +static int patch_text_cb(void *data)
> > +{
> > +     struct patch_insn_patch *patch = data;
> > +     int ret = 0;
> > +
> > +     if (atomic_inc_return(&patch->cpu_count) == 1) {
> > +             ret =
> > +                 patch_text_nosync(patch->addr, &patch->insn,
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
> > +NOKPROBE_SYMBOL(patch_text_cb);
> > +
> > +int patch_text(void *addr, u32 insn)
> > +{
> > +     struct patch_insn_patch patch = {
> > +             .addr = addr,
> > +             .insn = insn,
> > +             .cpu_count = ATOMIC_INIT(0),
> > +     };
> > +
> > +     return stop_machine_cpuslocked(patch_text_cb,
> > +                                    &patch, cpu_online_mask);
> > +}
> > +NOKPROBE_SYMBOL(patch_text);
> > --
> > 2.26.0
> >
>
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>
