Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB26C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E052207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CmAmDvuh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730923AbgANKTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:19:35 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:33566 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729683AbgANKTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:19:33 -0500
Received: by mail-io1-f67.google.com with SMTP id z8so13240943ioh.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 02:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yz4qhUBcEuZb98FBPlFhYlzry/Y1dsG9uLaKtAruT8k=;
        b=CmAmDvuhRFD48/YYr4dTYsGU1mEaMsuop7lnZorbeKjveS6g8SP2m4Nd7jrdjQRfaP
         sreYjlw/g+f52J7UXRHlUCVZy4VSSOyVw7CxBS2uWL3PY53+LDKYZer3DDvk1w4UqK2g
         0MDntnjIpSj57HqnzqdlUwzSypqJL6tMD2O3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yz4qhUBcEuZb98FBPlFhYlzry/Y1dsG9uLaKtAruT8k=;
        b=kBXZPRV5JXGepuUN2+gxG7kcLZ0A0iKaHvU2ovd4tnleRJGOFiJSjRVEGVs9IhaXPG
         YyocMTxtbfBNG2UUClcTQWkauhvmZZaWdKRFOeDhd32xjxqbP7+FRMo+I+jmrnBJNkqH
         rYrLimt7puId8EKIwc2myjneBEJD7bw/V/rHtYVdlKHGgMs3Kf++KIDmx/TmpjGhOiJ5
         +mL6CETtkMr1Db71VMzqRR2sZkfQNRO1Hi2h+WM6+fYj064c4Do3sh6/W+QDpgDPLrxa
         kD2iXQ1qi9pwAXgdS0aOM1FipO1ye4RhiVNGVShv9qw7id938r13TiAwCFxuDpfZ2/Xg
         IBHA==
X-Gm-Message-State: APjAAAUrMRe8aARoO7sJ4+xqEJDIDe0uiw8QNbnzDu5aRs7jUOJL3mm1
        vtyobHNiYuUj8Nbf04Q+ilgRLAgKY+dUajwbJg+5Nw==
X-Google-Smtp-Source: APXvYqzmwZZXgq4P8YcU3w7NuHkFD+4qEMdDlntpWHeyIywCU8U4uclRFMs+Gv2qMvzsxMsWORTTVC8RxPxKF7lJbmY=
X-Received: by 2002:a5d:8cd6:: with SMTP id k22mr15628141iot.283.1578997172153;
 Tue, 14 Jan 2020 02:19:32 -0800 (PST)
MIME-Version: 1.0
References: <20200114063056.98368-1-hsinyi@chromium.org> <878smape19.fsf@vitty.brq.redhat.com>
In-Reply-To: <878smape19.fsf@vitty.brq.redhat.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 14 Jan 2020 18:19:06 +0800
Message-ID: <CAJMQK-hmn=fG2CBgwZtQ2CwwkW69SZ5aVHnVExnkiFvqUszS0A@mail.gmail.com>
Subject: Re: [PATCH v4] reboot: support hotplug CPUs before reboot
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 5:45 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> Hsin-Yi Wang <hsinyi@chromium.org> writes:
>
> > Currently system reboots uses architecture specific codes (smp_send_stop)
> > to offline non reboot CPUs. Most architecture's implementation is looping
> > through all non reboot online CPUs and call ipi function to each of them. Some
> > architecture like arm64, arm, and x86... would set offline masks to cpu without
> > really offline them. This causes some race condition and kernel warning comes
> > out sometimes when system reboots.
> >
> > This patch adds a config ARCH_OFFLINE_CPUS_ON_REBOOT, which would hotplug cpus in
> > migrate_to_reboot_cpu(). If non reboot cpus are all offlined here, the loop for
> > checking online cpus would be an empty loop. If architecture don't enable this
> > config, or some cpus somehow fails to offline, it would fallback to ipi
> > function.
> >
> > Opt in this config for architectures that support CONFIG_HOTPLUG_CPU.
> >
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > ---
> > Change from v3:
> > * Opt in config for architectures that support CONFIG_HOTPLUG_CPU
> > * Merge function offline_secondary_cpus() and freeze_secondary_cpus()
> >   with an additional flag.
>
> I haven't commented on the idea itself, actually (I'm not sure I'm the
> right person though but as I'm already looking at the code...)
>
> On x86, the custom IPI/NMI solution we have now is more 'lightweight'
> and here you suggest we switch to the full-blown CPUHP machinery
> instead. We seem to be already using it for suspend/hibernation,
> however, I would expect it to be way less tested: on servers, for
> example, less people do suspend/resume than reboot :-)
>
> The existing IPI/NMI code stays in place so nothing (in theory) should
> break -- unles some cpuhp_ hook does something really weird. But your
> change will definitely contribute to improving these hooks' quality in
> the long run :-)
>
> I have nothing to say on other arches and I don't see anyone from
> e.g. ARM on the CC: list, not good.
>
I'll resend to CC ARM as well, thanks.

The patch idea came from there are some warnings during reboot seen on
x86 and arm, arm64.
(x86) https://lore.kernel.org/lkml/20190727164450.GA11726@roeck-us.net/
(arm64) https://lkml.org/lkml/2012/8/22/3, resend version
https://lore.kernel.org/patchwork/patch/1117201/

> >
> > Change from v2:
> > * Add another config instead of configed by CONFIG_HOTPLUG_CPU
> > ---
> >  arch/Kconfig                          |  5 +++++
> >  arch/arm/Kconfig                      |  1 +
> >  arch/arm64/Kconfig                    |  1 +
> >  arch/arm64/kernel/hibernate.c         |  2 +-
> >  arch/csky/Kconfig                     |  1 +
> >  arch/ia64/Kconfig                     |  1 +
> >  arch/mips/Kconfig                     |  1 +
> >  arch/parisc/Kconfig                   |  1 +
> >  arch/powerpc/Kconfig                  |  1 +
> >  arch/s390/Kconfig                     |  1 +
> >  arch/sh/Kconfig                       |  1 +
> >  arch/sparc/Kconfig                    |  1 +
> >  arch/x86/Kconfig                      |  1 +
> >  arch/xtensa/Kconfig                   |  1 +
> >  drivers/power/reset/sc27xx-poweroff.c |  2 +-
> >  include/linux/cpu.h                   |  9 ++++++---
> >  kernel/cpu.c                          | 17 +++++++++++------
> >  kernel/reboot.c                       |  8 ++++++++
> >  18 files changed, 44 insertions(+), 11 deletions(-)
> >
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index 48b5e103bdb0..2ba3d62c98c5 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -255,6 +255,11 @@ config ARCH_HAS_UNCACHED_SEGMENT
> >       select ARCH_HAS_DMA_PREP_COHERENT
> >       bool
> >
> > +# Select to do a full hotplug on secondary CPUs before reboot.
> > +config ARCH_OFFLINE_CPUS_ON_REBOOT
> > +     bool "Support for hotplug CPUs before reboot"
> > +     depends on HOTPLUG_CPU
> > +
>
> Nit: what we're actually doing is not 'hotplug', it's either 'hotunplug' or
> 'offlining'.
>
> >  # Select if arch init_task must go in the __init_task_data section
> >  config ARCH_TASK_STRUCT_ON_STACK
> >       bool
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 69950fb5be64..d53cc8cb47e3 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -28,6 +28,7 @@ config ARM
> >       select ARCH_KEEP_MEMBLOCK if HAVE_ARCH_PFN_VALID || KEXEC
> >       select ARCH_MIGHT_HAVE_PC_PARPORT
> >       select ARCH_NO_SG_CHAIN if !ARM_HAS_SG_CHAIN
> > +     select ARCH_OFFLINE_CPUS_ON_REBOOT if HOTPLUG_CPU
> >       select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
> >       select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT if CPU_V7
> >       select ARCH_SUPPORTS_ATOMIC_RMW
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 9af26ac75d19..9f913bc5c1f6 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -61,6 +61,7 @@ config ARM64
> >       select ARCH_INLINE_SPIN_UNLOCK_IRQ if !PREEMPTION
> >       select ARCH_INLINE_SPIN_UNLOCK_IRQRESTORE if !PREEMPTION
> >       select ARCH_KEEP_MEMBLOCK
> > +     select ARCH_OFFLINE_CPUS_ON_REBOOT if HOTPLUG_CPU
> >       select ARCH_USE_CMPXCHG_LOCKREF
> >       select ARCH_USE_QUEUED_RWLOCKS
> >       select ARCH_USE_QUEUED_SPINLOCKS
> > diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
> > index 590963c9c609..f7245dfa09d9 100644
> > --- a/arch/arm64/kernel/hibernate.c
> > +++ b/arch/arm64/kernel/hibernate.c
> > @@ -581,5 +581,5 @@ int hibernate_resume_nonboot_cpu_disable(void)
> >               return -ENODEV;
> >       }
> >
> > -     return freeze_secondary_cpus(sleep_cpu);
> > +     return freeze_secondary_cpus(sleep_cpu, false);
> >  }
> > diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> > index 4acef4088de7..0f03e5c3f2fc 100644
> > --- a/arch/csky/Kconfig
> > +++ b/arch/csky/Kconfig
> > @@ -5,6 +5,7 @@ config CSKY
> >       select ARCH_HAS_DMA_PREP_COHERENT
> >       select ARCH_HAS_SYNC_DMA_FOR_CPU
> >       select ARCH_HAS_SYNC_DMA_FOR_DEVICE
> > +     select ARCH_OFFLINE_CPUS_ON_REBOOT if HOTPLUG_CPU
> >       select ARCH_USE_BUILTIN_BSWAP
> >       select ARCH_USE_QUEUED_RWLOCKS if NR_CPUS>2
> >       select COMMON_CLK
> > diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
> > index bab7cd878464..f12b4b11ee98 100644
> > --- a/arch/ia64/Kconfig
> > +++ b/arch/ia64/Kconfig
> > @@ -10,6 +10,7 @@ config IA64
> >       bool
> >       select ARCH_MIGHT_HAVE_PC_PARPORT
> >       select ARCH_MIGHT_HAVE_PC_SERIO
> > +     select ARCH_OFFLINE_CPUS_ON_REBOOT if HOTPLUG_CPU
> >       select ACPI
> >       select ACPI_NUMA if NUMA
> >       select ARCH_SUPPORTS_ACPI
> > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> > index b6b5f83af169..9bb2556d21fc 100644
> > --- a/arch/mips/Kconfig
> > +++ b/arch/mips/Kconfig
> > @@ -8,6 +8,7 @@ config MIPS
> >       select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
> >       select ARCH_HAS_UBSAN_SANITIZE_ALL
> >       select ARCH_HAS_FORTIFY_SOURCE
> > +     select ARCH_OFFLINE_CPUS_ON_REBOOT if HOTPLUG_CPU
> >       select ARCH_SUPPORTS_UPROBES
> >       select ARCH_USE_BUILTIN_BSWAP
> >       select ARCH_USE_CMPXCHG_LOCKREF if 64BIT
> > diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
> > index 71034b54d74e..41609f00b057 100644
> > --- a/arch/parisc/Kconfig
> > +++ b/arch/parisc/Kconfig
> > @@ -13,6 +13,7 @@ config PARISC
> >       select ARCH_HAS_STRICT_KERNEL_RWX
> >       select ARCH_HAS_UBSAN_SANITIZE_ALL
> >       select ARCH_NO_SG_CHAIN
> > +     select ARCH_OFFLINE_CPUS_ON_REBOOT if HOTPLUG_CPU
> >       select ARCH_SUPPORTS_MEMORY_FAILURE
> >       select RTC_CLASS
> >       select RTC_DRV_GENERIC
> > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > index 658e0324d256..a6b76dd82a2d 100644
> > --- a/arch/powerpc/Kconfig
> > +++ b/arch/powerpc/Kconfig
> > @@ -142,6 +142,7 @@ config PPC
> >       select ARCH_KEEP_MEMBLOCK
> >       select ARCH_MIGHT_HAVE_PC_PARPORT
> >       select ARCH_MIGHT_HAVE_PC_SERIO
> > +     select ARCH_OFFLINE_CPUS_ON_REBOOT      if HOTPLUG_CPU
> >       select ARCH_OPTIONAL_KERNEL_RWX         if ARCH_HAS_STRICT_KERNEL_RWX
> >       select ARCH_SUPPORTS_ATOMIC_RMW
> >       select ARCH_USE_BUILTIN_BSWAP
> > diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> > index 287714d51b47..19eec37b1682 100644
> > --- a/arch/s390/Kconfig
> > +++ b/arch/s390/Kconfig
> > @@ -102,6 +102,7 @@ config S390
> >       select ARCH_INLINE_WRITE_UNLOCK_IRQ
> >       select ARCH_INLINE_WRITE_UNLOCK_IRQRESTORE
> >       select ARCH_KEEP_MEMBLOCK
> > +     select ARCH_OFFLINE_CPUS_ON_REBOOT if HOTPLUG_CPU
> >       select ARCH_SAVE_PAGE_KEYS if HIBERNATION
> >       select ARCH_STACKWALK
> >       select ARCH_SUPPORTS_ATOMIC_RMW
> > diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> > index 9ece111b0254..4ed1e0ca83a2 100644
> > --- a/arch/sh/Kconfig
> > +++ b/arch/sh/Kconfig
> > @@ -18,6 +18,7 @@ config SUPERH
> >       select ARCH_HAVE_CUSTOM_GPIO_H
> >       select ARCH_HAVE_NMI_SAFE_CMPXCHG if (GUSA_RB || CPU_SH4A)
> >       select ARCH_HAS_GCOV_PROFILE_ALL
> > +     select ARCH_OFFLINE_CPUS_ON_REBOOT if HOTPLUG_CPU
> >       select PERF_USE_VMALLOC
> >       select HAVE_DEBUG_KMEMLEAK
> >       select HAVE_KERNEL_GZIP
> > diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
> > index e8c3ea01c12f..f31700309621 100644
> > --- a/arch/sparc/Kconfig
> > +++ b/arch/sparc/Kconfig
> > @@ -30,6 +30,7 @@ config SPARC
> >       select RTC_SYSTOHC
> >       select HAVE_ARCH_JUMP_LABEL if SPARC64
> >       select GENERIC_IRQ_SHOW
> > +     select ARCH_OFFLINE_CPUS_ON_REBOOT if HOTPLUG_CPU
> >       select ARCH_WANT_IPC_PARSE_VERSION
> >       select GENERIC_PCI_IOMAP
> >       select HAVE_NMI_WATCHDOG if SPARC64
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index b595ecb21a0f..e8edab974f67 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -85,6 +85,7 @@ config X86
> >       select ARCH_MIGHT_HAVE_ACPI_PDC         if ACPI
> >       select ARCH_MIGHT_HAVE_PC_PARPORT
> >       select ARCH_MIGHT_HAVE_PC_SERIO
> > +     select ARCH_OFFLINE_CPUS_ON_REBOOT      if HOTPLUG_CPU
> >       select ARCH_STACKWALK
> >       select ARCH_SUPPORTS_ACPI
> >       select ARCH_SUPPORTS_ATOMIC_RMW
> > diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
> > index 1c645172b4b5..c862dfa69ed9 100644
> > --- a/arch/xtensa/Kconfig
> > +++ b/arch/xtensa/Kconfig
> > @@ -7,6 +7,7 @@ config XTENSA
> >       select ARCH_HAS_SYNC_DMA_FOR_CPU if MMU
> >       select ARCH_HAS_SYNC_DMA_FOR_DEVICE if MMU
> >       select ARCH_HAS_UNCACHED_SEGMENT if MMU
> > +     select ARCH_OFFLINE_CPUS_ON_REBOOT if HOTPLUG_CPU
> >       select ARCH_USE_QUEUED_RWLOCKS
> >       select ARCH_USE_QUEUED_SPINLOCKS
> >       select ARCH_WANT_FRAME_POINTERS
> > diff --git a/drivers/power/reset/sc27xx-poweroff.c b/drivers/power/reset/sc27xx-poweroff.c
> > index 29fb08b8faa0..d6cdf837235c 100644
> > --- a/drivers/power/reset/sc27xx-poweroff.c
> > +++ b/drivers/power/reset/sc27xx-poweroff.c
> > @@ -30,7 +30,7 @@ static void sc27xx_poweroff_shutdown(void)
> >  #ifdef CONFIG_PM_SLEEP_SMP
> >       int cpu = smp_processor_id();
> >
> > -     freeze_secondary_cpus(cpu);
> > +     freeze_secondary_cpus(cpu, false);
> >  #endif
> >  }
> >
> > diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> > index 1ca2baf817ed..9c62274a4db9 100644
> > --- a/include/linux/cpu.h
> > +++ b/include/linux/cpu.h
> > @@ -137,11 +137,14 @@ static inline void cpu_hotplug_done(void) { cpus_write_unlock(); }
> >  static inline void get_online_cpus(void) { cpus_read_lock(); }
> >  static inline void put_online_cpus(void) { cpus_read_unlock(); }
> >
> > +#if defined(CONFIG_PM_SLEEP_SMP) || defined(CONFIG_ARCH_OFFLINE_CPUS_ON_REBOOT)
> > +extern int freeze_secondary_cpus(int primary, bool reboot);
> > +#endif
> > +
> >  #ifdef CONFIG_PM_SLEEP_SMP
> > -extern int freeze_secondary_cpus(int primary);
> >  static inline int disable_nonboot_cpus(void)
> >  {
> > -     return freeze_secondary_cpus(0);
> > +     return freeze_secondary_cpus(0, false);
> >  }
> >  extern void enable_nonboot_cpus(void);
> >
> > @@ -152,7 +155,7 @@ static inline int suspend_disable_secondary_cpus(void)
> >       if (IS_ENABLED(CONFIG_PM_SLEEP_SMP_NONZERO_CPU))
> >               cpu = -1;
> >
> > -     return freeze_secondary_cpus(cpu);
> > +     return freeze_secondary_cpus(cpu, false);
> >  }
> >  static inline void suspend_enable_secondary_cpus(void)
> >  {
> > diff --git a/kernel/cpu.c b/kernel/cpu.c
> > index 9c706af713fb..87d2c6f5ce4c 100644
> > --- a/kernel/cpu.c
> > +++ b/kernel/cpu.c
> > @@ -1209,10 +1209,10 @@ int cpu_up(unsigned int cpu)
> >  }
> >  EXPORT_SYMBOL_GPL(cpu_up);
> >
> > -#ifdef CONFIG_PM_SLEEP_SMP
> > +#if defined(CONFIG_PM_SLEEP_SMP) || defined(CONFIG_ARCH_OFFLINE_CPUS_ON_REBOOT)
> >  static cpumask_var_t frozen_cpus;
> >
> > -int freeze_secondary_cpus(int primary)
> > +int freeze_secondary_cpus(int primary, bool reboot)
> >  {
> >       int cpu, error = 0;
> >
> > @@ -1237,20 +1237,25 @@ int freeze_secondary_cpus(int primary)
> >               if (cpu == primary)
> >                       continue;
> >
> > -             if (pm_wakeup_pending()) {
> > +#ifdef CONFIG_PM_SLEEP
> > +             if (!reboot && pm_wakeup_pending()) {
>
> I would've moveed pm_wakeup_pending() check to callers
> (disable_nonboot_cpus()/suspend_disable_secondary_cpus()) now.
>
pm_wakeup_pending() is in for_each_online_cpu() loop. Quoting from
commit message of a66d955e910:
"CPU hotplug is a slow operation, so it makes sense to check for wakeup
pending in the freezer loop before bringing down the next CPU. This
improves the system suspend abort latency significantly."

In reboot case don't have to check for wakeup pending condition. But
for suspend it should check between bringing down CPUs.
> >                       pr_info("Wakeup pending. Abort CPU freeze\n");
> >                       error = -EBUSY;
> >                       break;
> >               }
> > +#endif
> >
> > -             trace_suspend_resume(TPS("CPU_OFF"), cpu, true);
> > +             if (!reboot)
> > +                     trace_suspend_resume(TPS("CPU_OFF"), cpu, true);
> >               error = _cpu_down(cpu, 1, CPUHP_OFFLINE);
> > -             trace_suspend_resume(TPS("CPU_OFF"), cpu, false);
> > +             if (!reboot)
> > +                     trace_suspend_resume(TPS("CPU_OFF"), cpu, false);
>
> Does it actually hurt if we keep this for reboot case?
>
Okay I'll keep them with reboot case.

> >               if (!error)
> >                       cpumask_set_cpu(cpu, frozen_cpus);
> >               else {
> >                       pr_err("Error taking CPU%d down: %d\n", cpu, error);
> > -                     break;
> > +                     if (!reboot)
> > +                             break;
>
> I would've added a comment like "When rebooting, try to offline as many
> CPUs as possible".
>
>
> >               }
> >       }
> >
> > diff --git a/kernel/reboot.c b/kernel/reboot.c
> > index c4d472b7f1b4..e3bf515dc2bc 100644
> > --- a/kernel/reboot.c
> > +++ b/kernel/reboot.c
> > @@ -7,6 +7,7 @@
> >
> >  #define pr_fmt(fmt)  "reboot: " fmt
> >
> > +#include <linux/cpu.h>
> >  #include <linux/ctype.h>
> >  #include <linux/export.h>
> >  #include <linux/kexec.h>
> > @@ -220,7 +221,9 @@ void migrate_to_reboot_cpu(void)
> >       /* The boot cpu is always logical cpu 0 */
> >       int cpu = reboot_cpu;
> >
> > +#if !IS_ENABLED(CONFIG_ARCH_OFFLINE_CPUS_ON_REBOOT)
> >       cpu_hotplug_disable();
> > +#endif
> >
> >       /* Make certain the cpu I'm about to reboot on is online */
> >       if (!cpu_online(cpu))
> > @@ -231,6 +234,11 @@ void migrate_to_reboot_cpu(void)
> >
> >       /* Make certain I only run on the appropriate processor */
> >       set_cpus_allowed_ptr(current, cpumask_of(cpu));
> > +
> > +#if IS_ENABLED(CONFIG_ARCH_OFFLINE_CPUS_ON_REBOOT)
> > +     /* Hotplug other cpus if possible */
> > +     freeze_secondary_cpus(cpu, true);
> > +#endif
> >  }
> >
> >  /**
>
> --
> Vitaly
>
