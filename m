Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13573C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 04:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBB8C2073C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 04:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="y0xLYqyh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgBLE2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 23:28:40 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46702 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727904AbgBLE2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 23:28:39 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so457840wrl.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 20:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zpvQzt0G7nK1UhrxjyRbKFvhpJ/9qLsWzisYQqD9vVc=;
        b=y0xLYqyhHL5ZtMnaKkWtviV3QYoHHgsBKb6apqm2R90q4SV0ohcLbTRQz+mnlQsuGw
         QzrwDV4zMesr0MZ8RVQIx+vPy1DmiQfA1uvyRmq+tZUHTihRlwtu7XRm8nZXqKpMuGhZ
         fZxFvdnQkbRh0wDZ3uO3MpwNFV8X/TgmvkY3dtgWQB74BMPGOfHkaVn5AOJ5Qm5mwF7/
         XRneYPmVqgJkk3ZWGq9GOr2yvmCOHzFbAK5EME0x+2fCtcf8ksYo3RazGSzmDEf6IRS8
         fztn7yq9DhP+ftKygr/TQZ6GTXDUEUCRttD+ApFwNi9T8LvfoPy0zZEQqn21JnMJpss6
         LWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zpvQzt0G7nK1UhrxjyRbKFvhpJ/9qLsWzisYQqD9vVc=;
        b=LbRK+/CLXf8YeH1txQrb7Ss2j1A+/xxO4iitBzfEbMNAP3Wa4eSWshcYBMctnTrhi+
         U4GYkMpSvCS9YQV4RwYGWUuuJzn99Pnd9TeodxGNGteDgn84XAgjLmxZfp9F5QygdhMq
         9HZpX7L0/N6ObOz21ARVuZDO2AoB5WXyzsDxljEY7vObq2EyG/uWsulEO/AdTQhxc223
         VEb0tFo1vvHikgQhae8KLQwqzXc/ltjPrLZlTktc1lElzQbHx2F6qyaNw7H359csb07T
         +cmv9HATXHF7fXD+mbBTghWzYmxqH2i2wzxeV3AbI9nq2NtJ+XNEnHxTrPuMh9PggDec
         Cqtg==
X-Gm-Message-State: APjAAAXelCwaTakvompG9IUcKYoiVGkBTF/eQVCYb5Vao9n/He/BBq3X
        RIWJ38v0D2q65b9yz6pYKP4PtMPgNGiQYBI9Bz+L/Q==
X-Google-Smtp-Source: APXvYqzfV248s2Q0oR2x/I1/y2ryjxfZvXf11A+pGQon6zmy7Q2xGWNdTklL0rMevXvtZQ8oPovi5TR+y/Ie6tI0vTc=
X-Received: by 2002:adf:f28f:: with SMTP id k15mr12420066wro.230.1581481714584;
 Tue, 11 Feb 2020 20:28:34 -0800 (PST)
MIME-Version: 1.0
References: <20200212014822.28684-1-atish.patra@wdc.com> <20200212014822.28684-8-atish.patra@wdc.com>
In-Reply-To: <20200212014822.28684-8-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 12 Feb 2020 09:58:23 +0530
Message-ID: <CAAhSdy3RVpbum-O_ercZJkiEjDYPT-zrEHvYvMUQqE8+P82ihA@mail.gmail.com>
Subject: Re: [PATCH v8 07/11] RISC-V: Add cpu_ops and modify default booting method
To:     Atish Patra <atish.patra@wdc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Allison Randal <allison@lohutok.net>,
        Borislav Petkov <bp@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Mao Han <han_mao@c-sky.com>, Marc Zyngier <maz@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <vincent.chen@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 7:21 AM Atish Patra <atish.patra@wdc.com> wrote:
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
>  arch/riscv/include/asm/cpu_ops.h     | 34 ++++++++++++++++++
>  arch/riscv/kernel/Makefile           |  2 ++
>  arch/riscv/kernel/cpu_ops.c          | 40 +++++++++++++++++++++
>  arch/riscv/kernel/cpu_ops_spinwait.c | 42 ++++++++++++++++++++++
>  arch/riscv/kernel/smpboot.c          | 54 +++++++++++++++++-----------
>  5 files changed, 151 insertions(+), 21 deletions(-)
>  create mode 100644 arch/riscv/include/asm/cpu_ops.h
>  create mode 100644 arch/riscv/kernel/cpu_ops.c
>  create mode 100644 arch/riscv/kernel/cpu_ops_spinwait.c
>
> diff --git a/arch/riscv/include/asm/cpu_ops.h b/arch/riscv/include/asm/cpu_ops.h
> new file mode 100644
> index 000000000000..7db276284009
> --- /dev/null
> +++ b/arch/riscv/include/asm/cpu_ops.h
> @@ -0,0 +1,34 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2019 Western Digital Corporation or its affiliates.
> + * Based on arch/arm64/include/asm/cpu_ops.h
> + */
> +#ifndef __ASM_CPU_OPS_H
> +#define __ASM_CPU_OPS_H
> +
> +#include <linux/init.h>
> +#include <linux/sched.h>
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
> +int __init cpu_set_ops(int cpu);

This function is more like probing for appropriate cpu_ops. Also,
I think we don't need to return anything from cpu_set_ops().

Maybe rename it to "void cpu_probe_ops(int cpu)" ?

> +void cpu_update_secondary_bootdata(unsigned int cpuid,
> +                                  struct task_struct *tidle);
> +
> +#endif /* ifndef __ASM_CPU_OPS_H */
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index f40205cb9a22..f81a6ff88005 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -32,6 +32,8 @@ obj-$(CONFIG_RISCV_M_MODE)    += clint.o
>  obj-$(CONFIG_FPU)              += fpu.o
>  obj-$(CONFIG_SMP)              += smpboot.o
>  obj-$(CONFIG_SMP)              += smp.o
> +obj-$(CONFIG_SMP)              += cpu_ops.o
> +obj-$(CONFIG_SMP)              += cpu_ops_spinwait.o
>  obj-$(CONFIG_MODULES)          += module.o
>  obj-$(CONFIG_MODULE_SECTIONS)  += module-sections.o
>
> diff --git a/arch/riscv/kernel/cpu_ops.c b/arch/riscv/kernel/cpu_ops.c
> new file mode 100644
> index 000000000000..1085def3735a
> --- /dev/null
> +++ b/arch/riscv/kernel/cpu_ops.c
> @@ -0,0 +1,40 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2020 Western Digital Corporation or its affiliates.
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/mm.h>
> +#include <linux/of.h>
> +#include <linux/string.h>
> +#include <linux/sched.h>
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
> +extern const struct cpu_operations cpu_ops_spinwait;
> +
> +void cpu_update_secondary_bootdata(unsigned int cpuid,
> +                                  struct task_struct *tidle)
> +{
> +       int hartid = cpuid_to_hartid_map(cpuid);
> +
> +       /* Make sure tidle is updated */
> +       smp_mb();
> +       WRITE_ONCE(__cpu_up_stack_pointer[hartid],
> +                 task_stack_page(tidle) + THREAD_SIZE);
> +       WRITE_ONCE(__cpu_up_task_pointer[hartid], tidle);
> +}
> +
> +int __init cpu_set_ops(int cpuid)

Maybe rename it to "void cpu_probe_ops(int cpu)" ?

> +{
> +       cpu_ops[cpuid] = &cpu_ops_spinwait;
> +
> +       return 0;
> +}
> diff --git a/arch/riscv/kernel/cpu_ops_spinwait.c b/arch/riscv/kernel/cpu_ops_spinwait.c
> new file mode 100644
> index 000000000000..f828e660294e
> --- /dev/null
> +++ b/arch/riscv/kernel/cpu_ops_spinwait.c
> @@ -0,0 +1,42 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2020 Western Digital Corporation or its affiliates.
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/of.h>
> +#include <linux/string.h>
> +#include <asm/cpu_ops.h>
> +#include <asm/sbi.h>
> +#include <asm/smp.h>
> +
> +const struct cpu_operations cpu_ops_spinwait;
> +
> +static int spinwait_cpu_prepare(unsigned int cpuid)
> +{
> +       if (!cpu_ops_spinwait.cpu_start) {
> +               pr_err("cpu start method not defined for CPU [%d]\n", cpuid);
> +               return -ENODEV;
> +       }
> +       return 0;
> +}
> +
> +static int spinwait_cpu_start(unsigned int cpuid, struct task_struct *tidle)
> +{
> +       /*
> +        * In this protocol, all cpus boot on their own accord.  _start
> +        * selects the first cpu to boot the kernel and causes the remainder
> +        * of the cpus to spin in a loop waiting for their stack pointer to be
> +        * setup by that main cpu.  Writing to bootdata (i.e __cpu_up_stack_pointer) signals to
> +        * the spinning cpus that they can continue the boot process.
> +        */
> +       cpu_update_secondary_bootdata(cpuid, tidle);
> +
> +       return 0;
> +}
> +
> +const struct cpu_operations cpu_ops_spinwait = {
> +       .name           = "spinwait",
> +       .cpu_prepare    = spinwait_cpu_prepare,
> +       .cpu_start      = spinwait_cpu_start,
> +};
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index 8bc01f0ca73b..2ee41c779a16 100644
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
> @@ -65,6 +70,8 @@ void __init setup_smp(void)
>         bool found_boot_cpu = false;
>         int cpuid = 1;
>
> +       cpu_set_ops(0);
> +
>         for_each_of_cpu_node(dn) {
>                 hart = riscv_of_processor_hartid(dn);
>                 if (hart < 0)
> @@ -92,36 +99,41 @@ void __init setup_smp(void)
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

Make this function static.

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

Apart from minor comments above, looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
