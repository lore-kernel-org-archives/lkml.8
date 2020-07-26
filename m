Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC4AC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 05:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA8762065F
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 05:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="FkjW7Pa1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgGZFQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 01:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbgGZFQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 01:16:10 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB38C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 22:16:09 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k20so3953060wmi.5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 22:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TTiPFatKfylQY8cdbtemRuZicZujuMNYtojwAlUi1pk=;
        b=FkjW7Pa1p0K982ECr0evrdO+zraCCFRPpDin8aINenqted2EcW9Demg6ZudVQYPRcF
         BSyIAUX50SA1Q9/F7v5H9J31/WbxUsTQ91+INt+NVJzT4SonPs5N/UklWgcEymG7DH/P
         82dJZjLzg0ZVzImgZiiehoPDzO8bPJVrR3K6IFJ9MXZqkpXvxCJDrtKuomXM7+pE22ef
         gfJR1BV3xV9R4rf09Gt0IuRVcfcYp/tg+nbXazluQn10RJDr0vX6laY3fkrbHYQv0AT5
         A/ggYuRaZ6vj+LJg7G0cGjjLHMOgxG4T3kkh/t4vtjbWJTMwUOPsOOqqMVtB5QLrjvsf
         RmLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TTiPFatKfylQY8cdbtemRuZicZujuMNYtojwAlUi1pk=;
        b=NOjWb97GhLd6zoDJyveY7ggHjYZNC3Cc+31mSK2I0/dkWVpNCUuBMiKuBoRyTt19l6
         1LVaeuFEBFz2BedeFVH5wNIpgiNfstk03f7GfrDdmxLwDaUGaa8mFt79JLHbGMgL/Qqt
         nO/RLcRXBPT6zofNsQqPQplt5RtWHygc56mSi7fHnm1iCTtXmhzJWf+80piY6NaS+R9T
         kDcLswnIaoZP19KN64wre+b7jIdY/08X8/pq4sAcS6LSOcmA3xy3UBEbV3heOlmgvA51
         ycpI6W33Ofgj6f58BI4mVoX38aE51wzXzsm9ROEi9TUyzU36ZzxQVV+0JU2LKB1+N1VJ
         rbqA==
X-Gm-Message-State: AOAM5321CqNA65ZDgkUVONWNUJybBqKJtjItWs3Tnrszw8xrcgy7eSXU
        C8Rm3o43+ke2WRzQ2E/x8PAjxaae8P9duc503l5QIRZh
X-Google-Smtp-Source: ABdhPJwDkv/vtL5HgI6dkSNCDOG0iMwDHSrWY5KTbrAHOAwo5fEI3tE/qKWa2rYjP+1HPLA0kz/YCe9cMJ6fSJFU/Rw=
X-Received: by 2002:a7b:c4d5:: with SMTP id g21mr5042252wmk.185.1595740567490;
 Sat, 25 Jul 2020 22:16:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200724071822.126758-1-anup.patel@wdc.com> <20200724071822.126758-4-anup.patel@wdc.com>
 <CAOnJCULOcbSWdgfWsG3ruATCP4TRLAGyXEQxirV69gOpZF0b2w@mail.gmail.com>
In-Reply-To: <CAOnJCULOcbSWdgfWsG3ruATCP4TRLAGyXEQxirV69gOpZF0b2w@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Sun, 26 Jul 2020 10:45:38 +0530
Message-ID: <CAAhSdy2wJ9v5f3UGo-fZo=SS7SUVgwwY=6EW25Dnck5=mBS7FA@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] RISC-V: Remove CLINT related code from timer and arch
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>,
        Emil Renner Berhing <kernel@esmil.dk>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 25, 2020 at 10:46 AM Atish Patra <atishp@atishpatra.org> wrote:
>
> On Fri, Jul 24, 2020 at 12:19 AM Anup Patel <anup.patel@wdc.com> wrote:
> >
> > Right now the RISC-V timer driver is convoluted to support:
> > 1. Linux RISC-V S-mode (with MMU) where it will use TIME CSR for
> >    clocksource and SBI timer calls for clockevent device.
> > 2. Linux RISC-V M-mode (without MMU) where it will use CLINT MMIO
> >    counter register for clocksource and CLINT MMIO compare register
> >    for clockevent device.
> >
> > We now have a separate CLINT timer driver which also provide CLINT
> > based IPI operations so let's remove CLINT MMIO related code from
> > arch/riscv directory and RISC-V timer driver.
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > Tested-by: Emil Renner Berhing <kernel@esmil.dk>
> > Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > ---
> >  arch/riscv/Kconfig                      |  2 +-
> >  arch/riscv/Kconfig.socs                 |  2 +
> >  arch/riscv/configs/nommu_virt_defconfig |  7 +--
> >  arch/riscv/include/asm/clint.h          | 14 ------
> >  arch/riscv/include/asm/timex.h          | 28 +++--------
> >  arch/riscv/kernel/Makefile              |  2 +-
> >  arch/riscv/kernel/clint.c               | 63 -------------------------
> >  arch/riscv/kernel/setup.c               |  2 -
> >  arch/riscv/kernel/smp.c                 |  1 -
> >  arch/riscv/kernel/smpboot.c             |  1 -
> >  drivers/clocksource/Kconfig             |  3 +-
> >  drivers/clocksource/timer-riscv.c       | 17 +------
> >  12 files changed, 16 insertions(+), 126 deletions(-)
> >  delete mode 100644 arch/riscv/include/asm/clint.h
> >  delete mode 100644 arch/riscv/kernel/clint.c
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index fedb4a72b29a..57a72ae23d10 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -74,7 +74,7 @@ config RISCV
> >         select PCI_DOMAINS_GENERIC if PCI
> >         select PCI_MSI if PCI
> >         select RISCV_INTC
> > -       select RISCV_TIMER
> > +       select RISCV_TIMER if RISCV_SBI
> >         select SPARSEMEM_STATIC if 32BIT
> >         select SPARSE_IRQ
> >         select SYSCTL_EXCEPTION_TRACE
> > diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> > index 6c88148f1b9b..8a55f6156661 100644
> > --- a/arch/riscv/Kconfig.socs
> > +++ b/arch/riscv/Kconfig.socs
> > @@ -12,6 +12,7 @@ config SOC_SIFIVE
> >
> >  config SOC_VIRT
> >         bool "QEMU Virt Machine"
> > +       select CLINT_TIMER if RISCV_M_MODE
> >         select POWER_RESET
> >         select POWER_RESET_SYSCON
> >         select POWER_RESET_SYSCON_POWEROFF
> > @@ -24,6 +25,7 @@ config SOC_VIRT
> >  config SOC_KENDRYTE
> >         bool "Kendryte K210 SoC"
> >         depends on !MMU
> > +       select CLINT_TIMER if RISCV_M_MODE
> >         select SERIAL_SIFIVE if TTY
> >         select SERIAL_SIFIVE_CONSOLE if TTY
> >         select SIFIVE_PLIC
> > diff --git a/arch/riscv/configs/nommu_virt_defconfig b/arch/riscv/configs/nommu_virt_defconfig
> > index cf74e179bf90..cf9388184aa3 100644
> > --- a/arch/riscv/configs/nommu_virt_defconfig
> > +++ b/arch/riscv/configs/nommu_virt_defconfig
> > @@ -26,6 +26,7 @@ CONFIG_EXPERT=y
> >  CONFIG_SLOB=y
> >  # CONFIG_SLAB_MERGE_DEFAULT is not set
> >  # CONFIG_MMU is not set
> > +CONFIG_SOC_VIRT=y
> >  CONFIG_MAXPHYSMEM_2GB=y
> >  CONFIG_SMP=y
> >  CONFIG_CMDLINE="root=/dev/vda rw earlycon=uart8250,mmio,0x10000000,115200n8 console=ttyS0"
> > @@ -48,7 +49,6 @@ CONFIG_VIRTIO_BLK=y
> >  # CONFIG_SERIO is not set
> >  # CONFIG_LEGACY_PTYS is not set
> >  # CONFIG_LDISC_AUTOLOAD is not set
> > -# CONFIG_DEVMEM is not set
> >  CONFIG_SERIAL_8250=y
> >  # CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
> >  CONFIG_SERIAL_8250_CONSOLE=y
> > @@ -56,16 +56,13 @@ CONFIG_SERIAL_8250_NR_UARTS=1
> >  CONFIG_SERIAL_8250_RUNTIME_UARTS=1
> >  CONFIG_SERIAL_OF_PLATFORM=y
> >  # CONFIG_HW_RANDOM is not set
> > +# CONFIG_DEVMEM is not set
> >  # CONFIG_HWMON is not set
> > -# CONFIG_LCD_CLASS_DEVICE is not set
> > -# CONFIG_BACKLIGHT_CLASS_DEVICE is not set
>
> Why these changes are in the diff ?

These are generated by "make savedefconfig".

To preserve bisectability, I have enabled CONFIG_SOC_VIRT
in nommu_virt_defconfig and I have used "make savedefconfig"
to update nommu_virt_defconfig.

>
> >  # CONFIG_VGA_CONSOLE is not set
> >  # CONFIG_HID is not set
> >  # CONFIG_USB_SUPPORT is not set
> >  CONFIG_VIRTIO_MMIO=y
> >  CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y
> > -CONFIG_SIFIVE_PLIC=y
> > -# CONFIG_VALIDATE_FS_PARSER is not set
> >  CONFIG_EXT2_FS=y
> >  # CONFIG_DNOTIFY is not set
> >  # CONFIG_INOTIFY_USER is not set
> > diff --git a/arch/riscv/include/asm/clint.h b/arch/riscv/include/asm/clint.h
> > deleted file mode 100644
> > index adaba98a7d6c..000000000000
> > --- a/arch/riscv/include/asm/clint.h
> > +++ /dev/null
> > @@ -1,14 +0,0 @@
> > -/* SPDX-License-Identifier: GPL-2.0 */
> > -#ifndef _ASM_RISCV_CLINT_H
> > -#define _ASM_RISCV_CLINT_H 1
> > -
> > -#include <linux/io.h>
> > -#include <linux/smp.h>
> > -
> > -#ifdef CONFIG_RISCV_M_MODE
> > -void clint_init_boot_cpu(void);
> > -#else /* CONFIG_RISCV_M_MODE */
> > -#define clint_init_boot_cpu()  do { } while (0)
> > -#endif /* CONFIG_RISCV_M_MODE */
> > -
> > -#endif /* _ASM_RISCV_CLINT_H */
> > diff --git a/arch/riscv/include/asm/timex.h b/arch/riscv/include/asm/timex.h
> > index bad2a7c2cda5..a3fb85d505d4 100644
> > --- a/arch/riscv/include/asm/timex.h
> > +++ b/arch/riscv/include/asm/timex.h
> > @@ -7,41 +7,27 @@
> >  #define _ASM_RISCV_TIMEX_H
> >
> >  #include <asm/csr.h>
> > -#include <asm/mmio.h>
> >
> >  typedef unsigned long cycles_t;
> >
> > -extern u64 __iomem *riscv_time_val;
> > -extern u64 __iomem *riscv_time_cmp;
> > -
> > -#ifdef CONFIG_64BIT
> > -#define mmio_get_cycles()      readq_relaxed(riscv_time_val)
> > -#else
> > -#define mmio_get_cycles()      readl_relaxed(riscv_time_val)
> > -#define mmio_get_cycles_hi()   readl_relaxed(((u32 *)riscv_time_val) + 1)
> > -#endif
> > -
> >  static inline cycles_t get_cycles(void)
> >  {
> > -       if (IS_ENABLED(CONFIG_RISCV_SBI))
> > -               return csr_read(CSR_TIME);
> > -       return mmio_get_cycles();
> > +       return csr_read(CSR_TIME);
> >  }
> >  #define get_cycles get_cycles
> >
> > +static inline u32 get_cycles_hi(void)
> > +{
> > +       return csr_read(CSR_TIMEH);
> > +}
> > +#define get_cycles_hi get_cycles_hi
> > +
> >  #ifdef CONFIG_64BIT
> >  static inline u64 get_cycles64(void)
> >  {
> >         return get_cycles();
> >  }
> >  #else /* CONFIG_64BIT */
> > -static inline u32 get_cycles_hi(void)
> > -{
> > -       if (IS_ENABLED(CONFIG_RISCV_SBI))
> > -               return csr_read(CSR_TIMEH);
> > -       return mmio_get_cycles_hi();
> > -}
> > -
> >  static inline u64 get_cycles64(void)
> >  {
> >         u32 hi, lo;
> > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > index b355cf485671..7edf15643146 100644
> > --- a/arch/riscv/kernel/Makefile
> > +++ b/arch/riscv/kernel/Makefile
> > @@ -31,7 +31,7 @@ obj-y += cacheinfo.o
> >  obj-y  += patch.o
> >  obj-$(CONFIG_MMU) += vdso.o vdso/
> >
> > -obj-$(CONFIG_RISCV_M_MODE)     += clint.o traps_misaligned.o
> > +obj-$(CONFIG_RISCV_M_MODE)     += traps_misaligned.o
> >  obj-$(CONFIG_FPU)              += fpu.o
> >  obj-$(CONFIG_SMP)              += smpboot.o
> >  obj-$(CONFIG_SMP)              += smp.o
> > diff --git a/arch/riscv/kernel/clint.c b/arch/riscv/kernel/clint.c
> > deleted file mode 100644
> > index a9845ee023e2..000000000000
> > --- a/arch/riscv/kernel/clint.c
> > +++ /dev/null
> > @@ -1,63 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > -/*
> > - * Copyright (c) 2019 Christoph Hellwig.
> > - */
> > -
> > -#include <linux/io.h>
> > -#include <linux/of_address.h>
> > -#include <linux/smp.h>
> > -#include <linux/types.h>
> > -#include <asm/clint.h>
> > -#include <asm/csr.h>
> > -#include <asm/timex.h>
> > -
> > -/*
> > - * This is the layout used by the SiFive clint, which is also shared by the qemu
> > - * virt platform, and the Kendryte KD210 at least.
> > - */
> > -#define CLINT_IPI_OFF          0
> > -#define CLINT_TIME_CMP_OFF     0x4000
> > -#define CLINT_TIME_VAL_OFF     0xbff8
> > -
> > -u32 __iomem *clint_ipi_base;
> > -
> > -static void clint_send_ipi(const struct cpumask *target)
> > -{
> > -       unsigned int cpu;
> > -
> > -       for_each_cpu(cpu, target)
> > -               writel(1, clint_ipi_base + cpuid_to_hartid_map(cpu));
> > -}
> > -
> > -static void clint_clear_ipi(void)
> > -{
> > -       writel(0, clint_ipi_base + cpuid_to_hartid_map(smp_processor_id()));
> > -}
> > -
> > -static struct riscv_ipi_ops clint_ipi_ops = {
> > -       .ipi_inject = clint_send_ipi,
> > -       .ipi_clear = clint_clear_ipi,
> > -};
> > -
> > -void clint_init_boot_cpu(void)
> > -{
> > -       struct device_node *np;
> > -       void __iomem *base;
> > -
> > -       np = of_find_compatible_node(NULL, NULL, "riscv,clint0");
> > -       if (!np) {
> > -               panic("clint not found");
> > -               return;
> > -       }
> > -
> > -       base = of_iomap(np, 0);
> > -       if (!base)
> > -               panic("could not map CLINT");
> > -
> > -       clint_ipi_base = base + CLINT_IPI_OFF;
> > -       riscv_time_cmp = base + CLINT_TIME_CMP_OFF;
> > -       riscv_time_val = base + CLINT_TIME_VAL_OFF;
> > -
> > -       clint_clear_ipi();
> > -       riscv_set_ipi_ops(&clint_ipi_ops);
> > -}
> > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > index f04373be54a6..2c6dd329312b 100644
> > --- a/arch/riscv/kernel/setup.c
> > +++ b/arch/riscv/kernel/setup.c
> > @@ -18,7 +18,6 @@
> >  #include <linux/swiotlb.h>
> >  #include <linux/smp.h>
> >
> > -#include <asm/clint.h>
> >  #include <asm/cpu_ops.h>
> >  #include <asm/setup.h>
> >  #include <asm/sections.h>
> > @@ -79,7 +78,6 @@ void __init setup_arch(char **cmdline_p)
> >  #else
> >         unflatten_device_tree();
> >  #endif
> > -       clint_init_boot_cpu();
> >
> >  #ifdef CONFIG_SWIOTLB
> >         swiotlb_init(1);
> > diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> > index 8b85683ce203..07626be78c23 100644
> > --- a/arch/riscv/kernel/smp.c
> > +++ b/arch/riscv/kernel/smp.c
> > @@ -17,7 +17,6 @@
> >  #include <linux/seq_file.h>
> >  #include <linux/delay.h>
> >
> > -#include <asm/clint.h>
> >  #include <asm/sbi.h>
> >  #include <asm/tlbflush.h>
> >  #include <asm/cacheflush.h>
> > diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> > index 5fe849791bf0..a6cfa9842d4b 100644
> > --- a/arch/riscv/kernel/smpboot.c
> > +++ b/arch/riscv/kernel/smpboot.c
> > @@ -24,7 +24,6 @@
> >  #include <linux/of.h>
> >  #include <linux/sched/task_stack.h>
> >  #include <linux/sched/mm.h>
> > -#include <asm/clint.h>
> >  #include <asm/cpu_ops.h>
> >  #include <asm/irq.h>
> >  #include <asm/mmu_context.h>
> > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> > index 41f1c147c178..b24449da3022 100644
> > --- a/drivers/clocksource/Kconfig
> > +++ b/drivers/clocksource/Kconfig
> > @@ -648,9 +648,8 @@ config ATCPIT100_TIMER
> >           This option enables support for the Andestech ATCPIT100 timers.
> >
> >  config RISCV_TIMER
> > -       bool "Timer for the RISC-V platform"
> > +       bool "Timer for the RISC-V platform" if COMPILE_TEST
> >         depends on GENERIC_SCHED_CLOCK && RISCV
> > -       default y
> >         select TIMER_PROBE
> >         select TIMER_OF
> >         help
> > diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
> > index 9de1dabfb126..c51c5ed15aa7 100644
> > --- a/drivers/clocksource/timer-riscv.c
> > +++ b/drivers/clocksource/timer-riscv.c
> > @@ -19,26 +19,13 @@
> >  #include <linux/of_irq.h>
> >  #include <asm/smp.h>
> >  #include <asm/sbi.h>
> > -
> > -u64 __iomem *riscv_time_cmp;
> > -u64 __iomem *riscv_time_val;
> > -
> > -static inline void mmio_set_timer(u64 val)
> > -{
> > -       void __iomem *r;
> > -
> > -       r = riscv_time_cmp + cpuid_to_hartid_map(smp_processor_id());
> > -       writeq_relaxed(val, r);
> > -}
> > +#include <asm/timex.h>
> >
> >  static int riscv_clock_next_event(unsigned long delta,
> >                 struct clock_event_device *ce)
> >  {
> >         csr_set(CSR_IE, IE_TIE);
> > -       if (IS_ENABLED(CONFIG_RISCV_SBI))
> > -               sbi_set_timer(get_cycles64() + delta);
> > -       else
> > -               mmio_set_timer(get_cycles64() + delta);
> > +       sbi_set_timer(get_cycles64() + delta);
> >         return 0;
> >  }
> >
> > --
> > 2.25.1
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>
> Otherwise, looks good.
>
> Reviewed-by: Atish Patra <atish.patra@wdc.com>
>
> --
> Regards,
> Atish

Regards,
Anup
