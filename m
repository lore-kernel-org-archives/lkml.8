Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0055AC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 04:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD98E22522
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 04:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="l/+3rQ6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgA1EbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 23:31:23 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34524 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgA1EbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 23:31:22 -0500
Received: by mail-wm1-f67.google.com with SMTP id s144so874796wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 20:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fRsUnXBUE4PZHTWQPpeYq1ZjUN3os/yERYKuiBu0EAk=;
        b=l/+3rQ6l256sMBhkUCGKUq3xBEevdA/KmXxwfTKI+qErQKWSwCbKB/2sd9G1fgzhV5
         8L/g5Q3ZxFyNzk/T6GncfI64bWz+G0TRU7LVYo89pKoSOnUHhkM7JFsINVDAQrkfhVSj
         f1HEya4cQMGok6ObDv/jUtoIp3tymidVJm0aS4oyL3tJcf0SJmVTFumLYB0Ws6RuueyJ
         B78rJ8epmu6mlocV4g0OUZfQ9GnIp0ZlLv/Y8R/hdJ4yBPkmehKx1JYSu50cogXvJaiR
         8YQpoPiCaJTVFZ8XkUb/NVOVJTfW9aODzRA4UskganRqbistb8P80MQiTbvQwaVLQD1g
         /iOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fRsUnXBUE4PZHTWQPpeYq1ZjUN3os/yERYKuiBu0EAk=;
        b=nsHhWuuY61RmyfoAH3Q91P48s7OhizZX40pXSMLyQIzI2pusnwNqHnLCnzsmFSpszQ
         zflBjdVEzVbp4C0JqpX744rNIQqarovx0iERyIbUYDWmrXuw6PeWqQRxC+U9+X9zKADV
         /7nydbOyxhvs548YjBXPd1cLrd6YiBpEKZcsIunGdxcxbJgfCWhtZo1supleHrf7JZBc
         lKEOV7XvZYooSo+ZOI3Yoh5XlfRTqIj9ZPEkqA6TIdsSiEsm8hnR0CfCYR/3jWKerCBl
         Tzn+hzMgwh4ejPwoj8ZqXVs/ZO6syhKHHQQwIk2MO6cqHi+O4LR+Y/VziA61TGC5vzbx
         qlDA==
X-Gm-Message-State: APjAAAVuhbY40saIbi72OYU5EpE+2KZU9HvNMhOvoglaAlqFdytRT16O
        H2Kq1VQgg32mOVCYwZSzZMLpr0FI7iw9VuQNyngPvXVVHIFRng==
X-Google-Smtp-Source: APXvYqzOxpasv/CFJ6oKkot/L6ks7/kh+ytnkcxTtueG43hwPwMbkz6Nra7XqSgI0BBpniO3V3nB1EobQzAX7UefMJo=
X-Received: by 2002:a1c:9c87:: with SMTP id f129mr2461194wme.26.1580185878641;
 Mon, 27 Jan 2020 20:31:18 -0800 (PST)
MIME-Version: 1.0
References: <20200128022737.15371-1-atish.patra@wdc.com> <20200128022737.15371-7-atish.patra@wdc.com>
In-Reply-To: <20200128022737.15371-7-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 28 Jan 2020 10:01:07 +0530
Message-ID: <CAAhSdy3BcVCKnWb3RcbyaQHfmCHZycajLJvZ-hmn6v8_g0i_BA@mail.gmail.com>
Subject: Re: [PATCH v7 06/10] RISC-V: Add cpu_ops and modify default booting method
To:     Atish Patra <atish.patra@wdc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Borislav Petkov <bp@suse.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Mao Han <han_mao@c-sky.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <vincent.chen@sifive.com>,
        Abner Chang <abner.chang@hpe.com>, Chester Lin <clin@suse.com>,
        nickhu@andestech.com, Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 7:58 AM Atish Patra <atish.patra@wdc.com> wrote:
>
> Currently, all non-booting harts start booting after the booting hart
> updates the per-hart stack pointer. This is done in a way that, it's
> difficult to implement any other booting method without breaking the
> backward compatibility.
>
> Define a cpu_ops method that allows to introduce other booting methods
> in future. Modify the current booting method to be compatible with
> cpu_ops.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/include/asm/cpu_ops.h | 31 ++++++++++++++++
>  arch/riscv/kernel/Makefile       |  1 +
>  arch/riscv/kernel/cpu_ops.c      | 61 ++++++++++++++++++++++++++++++++
>  arch/riscv/kernel/setup.c        |  4 ++-
>  arch/riscv/kernel/smpboot.c      | 52 ++++++++++++++++-----------
>  5 files changed, 127 insertions(+), 22 deletions(-)
>  create mode 100644 arch/riscv/include/asm/cpu_ops.h
>  create mode 100644 arch/riscv/kernel/cpu_ops.c

This has to be more modular considering the fact that CONFIG_RISCV_SBI
can be disabled.

I have few suggestions on how to break cpu_ops.c

>
> diff --git a/arch/riscv/include/asm/cpu_ops.h b/arch/riscv/include/asm/cpu_ops.h
> new file mode 100644
> index 000000000000..27e9dfee5460
> --- /dev/null
> +++ b/arch/riscv/include/asm/cpu_ops.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2019 Western Digital Corporation or its affiliates.
> + * Based on arch/arm64/include/asm/cpu_ops.h
> + */
> +#ifndef __ASM_CPU_OPS_H
> +#define __ASM_CPU_OPS_H
> +
> +#include <linux/init.h>
> +#include <linux/threads.h>
> +
> +/**
> + * struct cpu_operations - Callback operations for hotplugging CPUs.
> + *
> + * @name:              Name of the boot protocol.
> + * @cpu_prepare:       Early one-time preparation step for a cpu. If there
> + *                     is a mechanism for doing so, tests whether it is
> + *                     possible to boot the given HART.
> + * @cpu_start:         Boots a cpu into the kernel.
> + */
> +struct cpu_operations {
> +       const char      *name;
> +       int             (*cpu_prepare)(unsigned int cpu);
> +       int             (*cpu_start)(unsigned int cpu,
> +                                    struct task_struct *tidle);
> +};
> +
> +extern const struct cpu_operations *cpu_ops[NR_CPUS];

Add following here:
extern void *__cpu_up_stack_pointer[NR_CPUS];
extern void *__cpu_up_task_pointer[NR_CPUS];

> +int __init cpu_set_ops(int cpu);
> +
> +#endif /* ifndef __ASM_CPU_OPS_H */
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index f40205cb9a22..d77def5b4e87 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -32,6 +32,7 @@ obj-$(CONFIG_RISCV_M_MODE)    += clint.o
>  obj-$(CONFIG_FPU)              += fpu.o
>  obj-$(CONFIG_SMP)              += smpboot.o
>  obj-$(CONFIG_SMP)              += smp.o
> +obj-$(CONFIG_SMP)              += cpu_ops.o
>  obj-$(CONFIG_MODULES)          += module.o
>  obj-$(CONFIG_MODULE_SECTIONS)  += module-sections.o
>
> diff --git a/arch/riscv/kernel/cpu_ops.c b/arch/riscv/kernel/cpu_ops.c
> new file mode 100644
> index 000000000000..099dbb6ff9f0
> --- /dev/null
> +++ b/arch/riscv/kernel/cpu_ops.c
> @@ -0,0 +1,61 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2019 Western Digital Corporation or its affiliates.
> + *
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/mm.h>
> +#include <linux/of.h>
> +#include <linux/string.h>
> +#include <linux/sched/task_stack.h>
> +#include <asm/cpu_ops.h>
> +#include <asm/sbi.h>
> +#include <asm/smp.h>
> +
> +const struct cpu_operations *cpu_ops[NR_CPUS] __ro_after_init;
> +
> +void *__cpu_up_stack_pointer[NR_CPUS];
> +void *__cpu_up_task_pointer[NR_CPUS];
> +
> +const struct cpu_operations cpu_spinwait_ops;
> +
> +static int spinwait_cpu_prepare(unsigned int cpuid)
> +{
> +       if (!cpu_spinwait_ops.cpu_start) {
> +               pr_err("cpu start method not defined for CPU [%d]\n", cpuid);
> +               return -ENODEV;
> +       }
> +       return 0;
> +}
> +
> +static int spinwait_cpu_start(unsigned int cpuid, struct task_struct *tidle)
> +{
> +       int hartid = cpuid_to_hartid_map(cpuid);
> +
> +       /*
> +        * In this protocol, all cpus boot on their own accord.  _start
> +        * selects the first cpu to boot the kernel and causes the remainder
> +        * of the cpus to spin in a loop waiting for their stack pointer to be
> +        * setup by that main cpu.  Writing __cpu_up_stack_pointer signals to
> +        * the spinning cpus that they can continue the boot process.
> +        */
> +       smp_mb();
> +       WRITE_ONCE(__cpu_up_stack_pointer[hartid],
> +                 task_stack_page(tidle) + THREAD_SIZE);
> +       WRITE_ONCE(__cpu_up_task_pointer[hartid], tidle);
> +
> +       return 0;
> +}
> +
> +const struct cpu_operations cpu_spinwait_ops = {
> +       .name           = "spinwait",
> +       .cpu_prepare    = spinwait_cpu_prepare,
> +       .cpu_start      = spinwait_cpu_start,
> +};

Move cpu_spinwait_ops, spinwait_cpu_start, and spinwait_cpu_prepare
to arch/riscv/kernel/cpu_ops_spinwait.c

Have "extern const struct cpu_operations cpu_spinwait_ops;" here.

> +
> +int __init cpu_set_ops(int cpuid)
> +{
> +       cpu_ops[cpuid] = &cpu_spinwait_ops;
> +       return 0;
> +}
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index de3e65dae83a..8208d1109ddb 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -16,12 +16,13 @@
>  #include <linux/of_platform.h>
>  #include <linux/sched/task.h>
>  #include <linux/swiotlb.h>
> +#include <linux/smp.h>
>
>  #include <asm/clint.h>
> +#include <asm/cpu_ops.h>
>  #include <asm/setup.h>
>  #include <asm/sections.h>
>  #include <asm/pgtable.h>
> -#include <asm/smp.h>
>  #include <asm/sbi.h>
>  #include <asm/tlbflush.h>
>  #include <asm/thread_info.h>
> @@ -79,6 +80,7 @@ void __init setup_arch(char **cmdline_p)
>                 sbi_init();
>
>  #ifdef CONFIG_SMP
> +       cpu_set_ops(0);
>         setup_smp();
>  #endif
>
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index 8bc01f0ca73b..f2cf541bc895 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -25,6 +25,7 @@
>  #include <linux/sched/task_stack.h>
>  #include <linux/sched/mm.h>
>  #include <asm/clint.h>
> +#include <asm/cpu_ops.h>
>  #include <asm/irq.h>
>  #include <asm/mmu_context.h>
>  #include <asm/tlbflush.h>
> @@ -34,8 +35,6 @@
>
>  #include "head.h"
>
> -void *__cpu_up_stack_pointer[NR_CPUS];
> -void *__cpu_up_task_pointer[NR_CPUS];
>  static DECLARE_COMPLETION(cpu_running);
>
>  void __init smp_prepare_boot_cpu(void)
> @@ -46,6 +45,7 @@ void __init smp_prepare_boot_cpu(void)
>  void __init smp_prepare_cpus(unsigned int max_cpus)
>  {
>         int cpuid;
> +       int ret;
>
>         /* This covers non-smp usecase mandated by "nosmp" option */
>         if (max_cpus == 0)
> @@ -54,6 +54,11 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>         for_each_possible_cpu(cpuid) {
>                 if (cpuid == smp_processor_id())
>                         continue;
> +               if (cpu_ops[cpuid]->cpu_prepare) {
> +                       ret = cpu_ops[cpuid]->cpu_prepare(cpuid);
> +                       if (ret)
> +                               continue;
> +               }
>                 set_cpu_present(cpuid, true);
>         }
>  }
> @@ -92,36 +97,41 @@ void __init setup_smp(void)
>                         cpuid, nr_cpu_ids);
>
>         for (cpuid = 1; cpuid < nr_cpu_ids; cpuid++) {
> -               if (cpuid_to_hartid_map(cpuid) != INVALID_HARTID)
> +               if (cpuid_to_hartid_map(cpuid) != INVALID_HARTID) {
> +                       if (cpu_set_ops(cpuid)) {
> +                               cpuid_to_hartid_map(cpuid) = INVALID_HARTID;
> +                               continue;
> +                       }
>                         set_cpu_possible(cpuid, true);
> +               }
>         }
>  }
>
> +int start_secondary_cpu(int cpu, struct task_struct *tidle)
> +{
> +       if (cpu_ops[cpu]->cpu_start)
> +               return cpu_ops[cpu]->cpu_start(cpu, tidle);
> +
> +       return -EOPNOTSUPP;
> +}
> +
>  int __cpu_up(unsigned int cpu, struct task_struct *tidle)
>  {
>         int ret = 0;
> -       int hartid = cpuid_to_hartid_map(cpu);
>         tidle->thread_info.cpu = cpu;
>
> -       /*
> -        * On RISC-V systems, all harts boot on their own accord.  Our _start
> -        * selects the first hart to boot the kernel and causes the remainder
> -        * of the harts to spin in a loop waiting for their stack pointer to be
> -        * setup by that main hart.  Writing __cpu_up_stack_pointer signals to
> -        * the spinning harts that they can continue the boot process.
> -        */
> -       smp_mb();
> -       WRITE_ONCE(__cpu_up_stack_pointer[hartid],
> -                 task_stack_page(tidle) + THREAD_SIZE);
> -       WRITE_ONCE(__cpu_up_task_pointer[hartid], tidle);
> -
> -       lockdep_assert_held(&cpu_running);
> -       wait_for_completion_timeout(&cpu_running,
> +       ret = start_secondary_cpu(cpu, tidle);
> +       if (!ret) {
> +               lockdep_assert_held(&cpu_running);
> +               wait_for_completion_timeout(&cpu_running,
>                                             msecs_to_jiffies(1000));
>
> -       if (!cpu_online(cpu)) {
> -               pr_crit("CPU%u: failed to come online\n", cpu);
> -               ret = -EIO;
> +               if (!cpu_online(cpu)) {
> +                       pr_crit("CPU%u: failed to come online\n", cpu);
> +                       ret = -EIO;
> +               }
> +       } else {
> +               pr_crit("CPU%u: failed to start\n", cpu);
>         }
>
>         return ret;
> --
> 2.24.0
>

Regards,
Anup
