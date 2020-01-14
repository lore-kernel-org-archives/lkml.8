Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DCBC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E985924670
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WOQmQox9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbgANJp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 04:45:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27789 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725820AbgANJp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 04:45:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578995126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dpdYnh3ehC1xBR9FQRKRWQQKkfsBd2paFMi0gxw65vs=;
        b=WOQmQox9RbJIdze3wS/av0+Gq14ziA3JxLjGjHkDavdJZmTG3h+LOFkFvooaweioJHCafZ
        hqsOVFDxeGYRty4zfrabvZfPdJjHBr5JUSLQOF8MH3DqL6Rj3oQhlQyriImtKI7CV+hpKG
        hL+SaijwNbP45ZAwp9bdRZVoSIseonQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-R0RBuLB0MmK4CbSvq05_tw-1; Tue, 14 Jan 2020 04:45:25 -0500
X-MC-Unique: R0RBuLB0MmK4CbSvq05_tw-1
Received: by mail-wm1-f72.google.com with SMTP id q206so1465939wme.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 01:45:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=dpdYnh3ehC1xBR9FQRKRWQQKkfsBd2paFMi0gxw65vs=;
        b=P/yrqy84qwfaewRiLmO+SmUJyu4H5X4ZQx3jvTRt5eVcNxFM5n0aR/oCPRBdTv0eMp
         ihndbOFw1daHTuLigCw5nl8uvSkqAZoc2ZHGW0V6SwvlSjPZ4TKXS0oUrTiQfNppSY/g
         ChkgLYn7r7HA85hgYMfbT9sBQh57TYq9Crkw4YM3WDt9apM9Jz+2q9hKyc3vGAOZ4O+P
         t36ig/7IzKbdLYW8cifgFS+/oXaZ3139jaYU67I94T9eUqJcpWeID5+SXcmUOJtL+3nr
         zpgglj51BN3tFUqr11CmHcvFQBO/SxibKs+iJJPLaAPAujSoFemWfwu8j1ZSvInAYqgo
         2/tA==
X-Gm-Message-State: APjAAAW3CO9yPv86YSNWTcbnsZobKOeUACNQ0BrBw6IF2UkQXwJUtN7/
        OjlpWBjLcX+5anMunHY0e4tqZDNfGZ/L0lM2e6kO6jpGOj9alKM1SiyoMR/fD2ASPW92uKRHvDq
        M3TFzSbbccAqEloEiqF4zxIO2
X-Received: by 2002:a7b:c317:: with SMTP id k23mr26120659wmj.75.1578995123858;
        Tue, 14 Jan 2020 01:45:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqzWketTabLO18BRJzvrJ5eNbu6rPO92g7wSOnQvOojjIfx9HfkACN3XnXW0CHLj23dctowTeA==
X-Received: by 2002:a7b:c317:: with SMTP id k23mr26120630wmj.75.1578995123493;
        Tue, 14 Jan 2020 01:45:23 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id c2sm18771259wrp.46.2020.01.14.01.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 01:45:22 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4] reboot: support hotplug CPUs before reboot
In-Reply-To: <20200114063056.98368-1-hsinyi@chromium.org>
References: <20200114063056.98368-1-hsinyi@chromium.org>
Date:   Tue, 14 Jan 2020 10:45:22 +0100
Message-ID: <878smape19.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hsin-Yi Wang <hsinyi@chromium.org> writes:

> Currently system reboots uses architecture specific codes (smp_send_stop)
> to offline non reboot CPUs. Most architecture's implementation is looping
> through all non reboot online CPUs and call ipi function to each of them. Some
> architecture like arm64, arm, and x86... would set offline masks to cpu without
> really offline them. This causes some race condition and kernel warning comes
> out sometimes when system reboots.
>
> This patch adds a config ARCH_OFFLINE_CPUS_ON_REBOOT, which would hotplug cpus in
> migrate_to_reboot_cpu(). If non reboot cpus are all offlined here, the loop for
> checking online cpus would be an empty loop. If architecture don't enable this
> config, or some cpus somehow fails to offline, it would fallback to ipi
> function.
>
> Opt in this config for architectures that support CONFIG_HOTPLUG_CPU.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> Change from v3:
> * Opt in config for architectures that support CONFIG_HOTPLUG_CPU
> * Merge function offline_secondary_cpus() and freeze_secondary_cpus()
>   with an additional flag.

I haven't commented on the idea itself, actually (I'm not sure I'm the
right person though but as I'm already looking at the code...)

On x86, the custom IPI/NMI solution we have now is more 'lightweight'
and here you suggest we switch to the full-blown CPUHP machinery
instead. We seem to be already using it for suspend/hibernation,
however, I would expect it to be way less tested: on servers, for
example, less people do suspend/resume than reboot :-)

The existing IPI/NMI code stays in place so nothing (in theory) should
break -- unles some cpuhp_ hook does something really weird. But your
change will definitely contribute to improving these hooks' quality in
the long run :-)

I have nothing to say on other arches and I don't see anyone from
e.g. ARM on the CC: list, not good.

>
> Change from v2:
> * Add another config instead of configed by CONFIG_HOTPLUG_CPU
> ---
>  arch/Kconfig                          |  5 +++++
>  arch/arm/Kconfig                      |  1 +
>  arch/arm64/Kconfig                    |  1 +
>  arch/arm64/kernel/hibernate.c         |  2 +-
>  arch/csky/Kconfig                     |  1 +
>  arch/ia64/Kconfig                     |  1 +
>  arch/mips/Kconfig                     |  1 +
>  arch/parisc/Kconfig                   |  1 +
>  arch/powerpc/Kconfig                  |  1 +
>  arch/s390/Kconfig                     |  1 +
>  arch/sh/Kconfig                       |  1 +
>  arch/sparc/Kconfig                    |  1 +
>  arch/x86/Kconfig                      |  1 +
>  arch/xtensa/Kconfig                   |  1 +
>  drivers/power/reset/sc27xx-poweroff.c |  2 +-
>  include/linux/cpu.h                   |  9 ++++++---
>  kernel/cpu.c                          | 17 +++++++++++------
>  kernel/reboot.c                       |  8 ++++++++
>  18 files changed, 44 insertions(+), 11 deletions(-)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 48b5e103bdb0..2ba3d62c98c5 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -255,6 +255,11 @@ config ARCH_HAS_UNCACHED_SEGMENT
>  	select ARCH_HAS_DMA_PREP_COHERENT
>  	bool
>  
> +# Select to do a full hotplug on secondary CPUs before reboot.
> +config ARCH_OFFLINE_CPUS_ON_REBOOT
> +	bool "Support for hotplug CPUs before reboot"
> +	depends on HOTPLUG_CPU
> +

Nit: what we're actually doing is not 'hotplug', it's either 'hotunplug' or
'offlining'.

>  # Select if arch init_task must go in the __init_task_data section
>  config ARCH_TASK_STRUCT_ON_STACK
>  	bool
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 69950fb5be64..d53cc8cb47e3 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -28,6 +28,7 @@ config ARM
>  	select ARCH_KEEP_MEMBLOCK if HAVE_ARCH_PFN_VALID || KEXEC
>  	select ARCH_MIGHT_HAVE_PC_PARPORT
>  	select ARCH_NO_SG_CHAIN if !ARM_HAS_SG_CHAIN
> +	select ARCH_OFFLINE_CPUS_ON_REBOOT if HOTPLUG_CPU
>  	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
>  	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT if CPU_V7
>  	select ARCH_SUPPORTS_ATOMIC_RMW
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 9af26ac75d19..9f913bc5c1f6 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -61,6 +61,7 @@ config ARM64
>  	select ARCH_INLINE_SPIN_UNLOCK_IRQ if !PREEMPTION
>  	select ARCH_INLINE_SPIN_UNLOCK_IRQRESTORE if !PREEMPTION
>  	select ARCH_KEEP_MEMBLOCK
> +	select ARCH_OFFLINE_CPUS_ON_REBOOT if HOTPLUG_CPU
>  	select ARCH_USE_CMPXCHG_LOCKREF
>  	select ARCH_USE_QUEUED_RWLOCKS
>  	select ARCH_USE_QUEUED_SPINLOCKS
> diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
> index 590963c9c609..f7245dfa09d9 100644
> --- a/arch/arm64/kernel/hibernate.c
> +++ b/arch/arm64/kernel/hibernate.c
> @@ -581,5 +581,5 @@ int hibernate_resume_nonboot_cpu_disable(void)
>  		return -ENODEV;
>  	}
>  
> -	return freeze_secondary_cpus(sleep_cpu);
> +	return freeze_secondary_cpus(sleep_cpu, false);
>  }
> diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> index 4acef4088de7..0f03e5c3f2fc 100644
> --- a/arch/csky/Kconfig
> +++ b/arch/csky/Kconfig
> @@ -5,6 +5,7 @@ config CSKY
>  	select ARCH_HAS_DMA_PREP_COHERENT
>  	select ARCH_HAS_SYNC_DMA_FOR_CPU
>  	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
> +	select ARCH_OFFLINE_CPUS_ON_REBOOT if HOTPLUG_CPU
>  	select ARCH_USE_BUILTIN_BSWAP
>  	select ARCH_USE_QUEUED_RWLOCKS if NR_CPUS>2
>  	select COMMON_CLK
> diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
> index bab7cd878464..f12b4b11ee98 100644
> --- a/arch/ia64/Kconfig
> +++ b/arch/ia64/Kconfig
> @@ -10,6 +10,7 @@ config IA64
>  	bool
>  	select ARCH_MIGHT_HAVE_PC_PARPORT
>  	select ARCH_MIGHT_HAVE_PC_SERIO
> +	select ARCH_OFFLINE_CPUS_ON_REBOOT if HOTPLUG_CPU
>  	select ACPI
>  	select ACPI_NUMA if NUMA
>  	select ARCH_SUPPORTS_ACPI
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index b6b5f83af169..9bb2556d21fc 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -8,6 +8,7 @@ config MIPS
>  	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>  	select ARCH_HAS_UBSAN_SANITIZE_ALL
>  	select ARCH_HAS_FORTIFY_SOURCE
> +	select ARCH_OFFLINE_CPUS_ON_REBOOT if HOTPLUG_CPU
>  	select ARCH_SUPPORTS_UPROBES
>  	select ARCH_USE_BUILTIN_BSWAP
>  	select ARCH_USE_CMPXCHG_LOCKREF if 64BIT
> diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
> index 71034b54d74e..41609f00b057 100644
> --- a/arch/parisc/Kconfig
> +++ b/arch/parisc/Kconfig
> @@ -13,6 +13,7 @@ config PARISC
>  	select ARCH_HAS_STRICT_KERNEL_RWX
>  	select ARCH_HAS_UBSAN_SANITIZE_ALL
>  	select ARCH_NO_SG_CHAIN
> +	select ARCH_OFFLINE_CPUS_ON_REBOOT if HOTPLUG_CPU
>  	select ARCH_SUPPORTS_MEMORY_FAILURE
>  	select RTC_CLASS
>  	select RTC_DRV_GENERIC
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 658e0324d256..a6b76dd82a2d 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -142,6 +142,7 @@ config PPC
>  	select ARCH_KEEP_MEMBLOCK
>  	select ARCH_MIGHT_HAVE_PC_PARPORT
>  	select ARCH_MIGHT_HAVE_PC_SERIO
> +	select ARCH_OFFLINE_CPUS_ON_REBOOT	if HOTPLUG_CPU
>  	select ARCH_OPTIONAL_KERNEL_RWX		if ARCH_HAS_STRICT_KERNEL_RWX
>  	select ARCH_SUPPORTS_ATOMIC_RMW
>  	select ARCH_USE_BUILTIN_BSWAP
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 287714d51b47..19eec37b1682 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -102,6 +102,7 @@ config S390
>  	select ARCH_INLINE_WRITE_UNLOCK_IRQ
>  	select ARCH_INLINE_WRITE_UNLOCK_IRQRESTORE
>  	select ARCH_KEEP_MEMBLOCK
> +	select ARCH_OFFLINE_CPUS_ON_REBOOT if HOTPLUG_CPU
>  	select ARCH_SAVE_PAGE_KEYS if HIBERNATION
>  	select ARCH_STACKWALK
>  	select ARCH_SUPPORTS_ATOMIC_RMW
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index 9ece111b0254..4ed1e0ca83a2 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -18,6 +18,7 @@ config SUPERH
>  	select ARCH_HAVE_CUSTOM_GPIO_H
>  	select ARCH_HAVE_NMI_SAFE_CMPXCHG if (GUSA_RB || CPU_SH4A)
>  	select ARCH_HAS_GCOV_PROFILE_ALL
> +	select ARCH_OFFLINE_CPUS_ON_REBOOT if HOTPLUG_CPU
>  	select PERF_USE_VMALLOC
>  	select HAVE_DEBUG_KMEMLEAK
>  	select HAVE_KERNEL_GZIP
> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
> index e8c3ea01c12f..f31700309621 100644
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -30,6 +30,7 @@ config SPARC
>  	select RTC_SYSTOHC
>  	select HAVE_ARCH_JUMP_LABEL if SPARC64
>  	select GENERIC_IRQ_SHOW
> +	select ARCH_OFFLINE_CPUS_ON_REBOOT if HOTPLUG_CPU
>  	select ARCH_WANT_IPC_PARSE_VERSION
>  	select GENERIC_PCI_IOMAP
>  	select HAVE_NMI_WATCHDOG if SPARC64
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index b595ecb21a0f..e8edab974f67 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -85,6 +85,7 @@ config X86
>  	select ARCH_MIGHT_HAVE_ACPI_PDC		if ACPI
>  	select ARCH_MIGHT_HAVE_PC_PARPORT
>  	select ARCH_MIGHT_HAVE_PC_SERIO
> +	select ARCH_OFFLINE_CPUS_ON_REBOOT	if HOTPLUG_CPU
>  	select ARCH_STACKWALK
>  	select ARCH_SUPPORTS_ACPI
>  	select ARCH_SUPPORTS_ATOMIC_RMW
> diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
> index 1c645172b4b5..c862dfa69ed9 100644
> --- a/arch/xtensa/Kconfig
> +++ b/arch/xtensa/Kconfig
> @@ -7,6 +7,7 @@ config XTENSA
>  	select ARCH_HAS_SYNC_DMA_FOR_CPU if MMU
>  	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if MMU
>  	select ARCH_HAS_UNCACHED_SEGMENT if MMU
> +	select ARCH_OFFLINE_CPUS_ON_REBOOT if HOTPLUG_CPU
>  	select ARCH_USE_QUEUED_RWLOCKS
>  	select ARCH_USE_QUEUED_SPINLOCKS
>  	select ARCH_WANT_FRAME_POINTERS
> diff --git a/drivers/power/reset/sc27xx-poweroff.c b/drivers/power/reset/sc27xx-poweroff.c
> index 29fb08b8faa0..d6cdf837235c 100644
> --- a/drivers/power/reset/sc27xx-poweroff.c
> +++ b/drivers/power/reset/sc27xx-poweroff.c
> @@ -30,7 +30,7 @@ static void sc27xx_poweroff_shutdown(void)
>  #ifdef CONFIG_PM_SLEEP_SMP
>  	int cpu = smp_processor_id();
>  
> -	freeze_secondary_cpus(cpu);
> +	freeze_secondary_cpus(cpu, false);
>  #endif
>  }
>  
> diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> index 1ca2baf817ed..9c62274a4db9 100644
> --- a/include/linux/cpu.h
> +++ b/include/linux/cpu.h
> @@ -137,11 +137,14 @@ static inline void cpu_hotplug_done(void) { cpus_write_unlock(); }
>  static inline void get_online_cpus(void) { cpus_read_lock(); }
>  static inline void put_online_cpus(void) { cpus_read_unlock(); }
>  
> +#if defined(CONFIG_PM_SLEEP_SMP) || defined(CONFIG_ARCH_OFFLINE_CPUS_ON_REBOOT)
> +extern int freeze_secondary_cpus(int primary, bool reboot);
> +#endif
> +
>  #ifdef CONFIG_PM_SLEEP_SMP
> -extern int freeze_secondary_cpus(int primary);
>  static inline int disable_nonboot_cpus(void)
>  {
> -	return freeze_secondary_cpus(0);
> +	return freeze_secondary_cpus(0, false);
>  }
>  extern void enable_nonboot_cpus(void);
>  
> @@ -152,7 +155,7 @@ static inline int suspend_disable_secondary_cpus(void)
>  	if (IS_ENABLED(CONFIG_PM_SLEEP_SMP_NONZERO_CPU))
>  		cpu = -1;
>  
> -	return freeze_secondary_cpus(cpu);
> +	return freeze_secondary_cpus(cpu, false);
>  }
>  static inline void suspend_enable_secondary_cpus(void)
>  {
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 9c706af713fb..87d2c6f5ce4c 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1209,10 +1209,10 @@ int cpu_up(unsigned int cpu)
>  }
>  EXPORT_SYMBOL_GPL(cpu_up);
>  
> -#ifdef CONFIG_PM_SLEEP_SMP
> +#if defined(CONFIG_PM_SLEEP_SMP) || defined(CONFIG_ARCH_OFFLINE_CPUS_ON_REBOOT)
>  static cpumask_var_t frozen_cpus;
>  
> -int freeze_secondary_cpus(int primary)
> +int freeze_secondary_cpus(int primary, bool reboot)
>  {
>  	int cpu, error = 0;
>  
> @@ -1237,20 +1237,25 @@ int freeze_secondary_cpus(int primary)
>  		if (cpu == primary)
>  			continue;
>  
> -		if (pm_wakeup_pending()) {
> +#ifdef CONFIG_PM_SLEEP
> +		if (!reboot && pm_wakeup_pending()) {

I would've moveed pm_wakeup_pending() check to callers
(disable_nonboot_cpus()/suspend_disable_secondary_cpus()) now.

>  			pr_info("Wakeup pending. Abort CPU freeze\n");
>  			error = -EBUSY;
>  			break;
>  		}
> +#endif
>  
> -		trace_suspend_resume(TPS("CPU_OFF"), cpu, true);
> +		if (!reboot)
> +			trace_suspend_resume(TPS("CPU_OFF"), cpu, true);
>  		error = _cpu_down(cpu, 1, CPUHP_OFFLINE);
> -		trace_suspend_resume(TPS("CPU_OFF"), cpu, false);
> +		if (!reboot)
> +			trace_suspend_resume(TPS("CPU_OFF"), cpu, false);

Does it actually hurt if we keep this for reboot case?

>  		if (!error)
>  			cpumask_set_cpu(cpu, frozen_cpus);
>  		else {
>  			pr_err("Error taking CPU%d down: %d\n", cpu, error);
> -			break;
> +			if (!reboot)
> +				break;

I would've added a comment like "When rebooting, try to offline as many
CPUs as possible".


>  		}
>  	}
>  
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index c4d472b7f1b4..e3bf515dc2bc 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -7,6 +7,7 @@
>  
>  #define pr_fmt(fmt)	"reboot: " fmt
>  
> +#include <linux/cpu.h>
>  #include <linux/ctype.h>
>  #include <linux/export.h>
>  #include <linux/kexec.h>
> @@ -220,7 +221,9 @@ void migrate_to_reboot_cpu(void)
>  	/* The boot cpu is always logical cpu 0 */
>  	int cpu = reboot_cpu;
>  
> +#if !IS_ENABLED(CONFIG_ARCH_OFFLINE_CPUS_ON_REBOOT)
>  	cpu_hotplug_disable();
> +#endif
>  
>  	/* Make certain the cpu I'm about to reboot on is online */
>  	if (!cpu_online(cpu))
> @@ -231,6 +234,11 @@ void migrate_to_reboot_cpu(void)
>  
>  	/* Make certain I only run on the appropriate processor */
>  	set_cpus_allowed_ptr(current, cpumask_of(cpu));
> +
> +#if IS_ENABLED(CONFIG_ARCH_OFFLINE_CPUS_ON_REBOOT)
> +	/* Hotplug other cpus if possible */
> +	freeze_secondary_cpus(cpu, true);
> +#endif
>  }
>  
>  /**

-- 
Vitaly

