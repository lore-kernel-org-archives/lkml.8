Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB08AC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 18:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DBB420784
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 18:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="yfvcJOGv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgCaSf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 14:35:27 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:53253 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbgCaSf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 14:35:26 -0400
Received: by mail-pj1-f66.google.com with SMTP id l36so1437371pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 11:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=yKm3QuElovNuOAdB1AlqOjnBdq3ajrD+IliidLbQDiQ=;
        b=yfvcJOGv4I3AN0el/GOAB9eZVeGPuHwun5KOy0+dJTs1nImQdIxA1O1ltudQHl6iN9
         fnv9+C/APbO0OenYMSaTP1GhKxMptNvaIARh4TP1/hauK7hpRYbP/702H+j4Etx4EswH
         FuexHwZkosSCnYbxLm/aJwX36oI04bk2brNBKK5C1QxEOITJYlfJa/HXXZeii/vOzwKU
         HBo7bPMN3zX8EZ449+Fn4Pa3gKyvRJZNZ5HRnOTZRJUzA3/iwK5Suijaxirru7fdJUqG
         HkEvBARBXAKmHuTP22CIXj07pRLJThIOX4ZteHIhe84y351WLbIcZYfUlNqrOmZyCq/b
         SS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=yKm3QuElovNuOAdB1AlqOjnBdq3ajrD+IliidLbQDiQ=;
        b=cSExivmMnnD+soGUTPwxOBgNh2uiguI8GON/9/MWEh1NoIJLZoIfwcKEsINRNA4szX
         s47jtdE/PM/IFlF0pQG9+tCy3/oUwKHzV0vjdVb2maU3JWg3IGm0R2g46r7iTRsp+c6o
         4q9+AQXxMAcPVhN+u4HndWh/zED1Eitko4Ct0dnplH8Yng31hy8omBwzGnZ7LJ8n5CGc
         6Cn5t84IX6qHFgLQ2LKByhn3V4gh7dzUAuoNYYsK2QnvG5hlRedxQZbf/rbTht9YhoJk
         ANeStsugtGQVdV7umnXZuKl1J+47pTJ4FG5Kewmxz+4AOaze1ylvrqYlflzTIEnyU6pl
         eKiQ==
X-Gm-Message-State: AGi0Pua5H6WqZGiRlbf8z8U1FDIvPCy3Kk1UelSlGcGMGgxhHmdSXQZE
        EZytcTnDBLQY6UsidjxaqtetnHf+wQA=
X-Google-Smtp-Source: APiQypJWty9jeuC6J0m7sudEE4XkeJrYCfEuWlWrRYKsX+wj9d7FuYQU0iArrIURv806y+GzF6ufZw==
X-Received: by 2002:a17:90b:24c:: with SMTP id fz12mr223055pjb.85.1585679724172;
        Tue, 31 Mar 2020 11:35:24 -0700 (PDT)
Received: from localhost (c-67-161-15-180.hsd1.ca.comcast.net. [67.161.15.180])
        by smtp.gmail.com with ESMTPSA id y131sm12888666pfg.25.2020.03.31.11.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 11:35:23 -0700 (PDT)
Date:   Tue, 31 Mar 2020 11:35:23 -0700 (PDT)
X-Google-Original-Date: Tue, 31 Mar 2020 11:33:02 PDT (-0700)
Subject:     Re: [PATCH v11 11/11] RISC-V: Support cpu hotplug
In-Reply-To: <20200318011144.91532-12-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        anup@brainfault.org, aou@eecs.berkeley.edu, gary@garyguo.net,
        greentime.hu@sifive.com, linux-riscv@lists.infradead.org,
        han_mao@c-sky.com, rppt@linux.ibm.com, nickhu@andestech.com,
        Paul Walmsley <paul.walmsley@sifive.com>, tglx@linutronix.de,
        vincent.chen@sifive.com, zong.li@sifive.com, bmeng.cn@gmail.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-ee543c6f-129c-4ce0-9c1f-ae456b7443be@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Mar 2020 18:11:44 PDT (-0700), Atish Patra wrote:
> This patch enable support for cpu hotplug in RISC-V. It uses SBI HSM
> extension to online/offline any hart. As a result, the harts are
> returned to firmware once they are offline. If the harts are brought
> online afterwards, they re-enter Linux kernel as if a secondary hart
> booted for the first time. All booting requirements are honored during
> this process.
>
> Tested both on QEMU and HighFive Unleashed board with. Test result follows.

I had to jump through some hoops to apply this one on for-next.  It should be
f1e58583b9c7 ("RISC-V: Support cpu hotplug") now, LMK if something went wrong.

>
> ---------------------------------------------------
> Offline cpu 2
> ---------------------------------------------------
> $ echo 0 > /sys/devices/system/cpu/cpu2/online
> [   32.828684] CPU2: off
> $ cat /proc/cpuinfo
> processor       : 0
> hart            : 0
> isa             : rv64imafdcsu
> mmu             : sv48
>
> processor       : 1
> hart            : 1
> isa             : rv64imafdcsu
> mmu             : sv48
>
> processor       : 3
> hart            : 3
> isa             : rv64imafdcsu
> mmu             : sv48
>
> processor       : 4
> hart            : 4
> isa             : rv64imafdcsu
> mmu             : sv48
>
> processor       : 5
> hart            : 5
> isa             : rv64imafdcsu
> mmu             : sv48
>
> processor       : 6
> hart            : 6
> isa             : rv64imafdcsu
> mmu             : sv48
>
> processor       : 7
> hart            : 7
> isa             : rv64imafdcsu
> mmu             : sv48
>
> ---------------------------------------------------
> online cpu 2
> ---------------------------------------------------
> $ echo 1 > /sys/devices/system/cpu/cpu2/online
> $ cat /proc/cpuinfo
> processor       : 0
> hart            : 0
> isa             : rv64imafdcsu
> mmu             : sv48
>
> processor       : 1
> hart            : 1
> isa             : rv64imafdcsu
> mmu             : sv48
>
> processor       : 2
> hart            : 2
> isa             : rv64imafdcsu
> mmu             : sv48
>
> processor       : 3
> hart            : 3
> isa             : rv64imafdcsu
> mmu             : sv48
>
> processor       : 4
> hart            : 4
> isa             : rv64imafdcsu
> mmu             : sv48
>
> processor       : 5
> hart            : 5
> isa             : rv64imafdcsu
> mmu             : sv48
>
> processor       : 6
> hart            : 6
> isa             : rv64imafdcsu
> mmu             : sv48
>
> processor       : 7
> hart            : 7
> isa             : rv64imafdcsu
> mmu             : sv48
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> ---
>  arch/riscv/Kconfig               | 12 ++++-
>  arch/riscv/include/asm/cpu_ops.h | 12 +++++
>  arch/riscv/include/asm/smp.h     | 17 +++++++
>  arch/riscv/kernel/Makefile       |  1 +
>  arch/riscv/kernel/cpu-hotplug.c  | 87 ++++++++++++++++++++++++++++++++
>  arch/riscv/kernel/cpu_ops_sbi.c  | 34 +++++++++++++
>  arch/riscv/kernel/setup.c        | 19 ++++++-
>  7 files changed, 180 insertions(+), 2 deletions(-)
>  create mode 100644 arch/riscv/kernel/cpu-hotplug.c
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 20c6191399ea..b3daadd116ec 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -20,7 +20,6 @@ config RISCV
>  	select CLONE_BACKWARDS
>  	select COMMON_CLK
>  	select GENERIC_CLOCKEVENTS
> -	select GENERIC_CPU_DEVICES
>  	select GENERIC_IRQ_SHOW
>  	select GENERIC_PCI_IOMAP
>  	select GENERIC_SCHED_CLOCK
> @@ -248,6 +247,17 @@ config NR_CPUS
>  	depends on SMP
>  	default "8"
>
> +config HOTPLUG_CPU
> +	bool "Support for hot-pluggable CPUs"
> +	depends on SMP
> +	select GENERIC_IRQ_MIGRATION
> +	help
> +
> +	  Say Y here to experiment with turning CPUs off and on.  CPUs
> +	  can be controlled through /sys/devices/system/cpu.
> +
> +	  Say N if you want to disable CPU hotplug.
> +
>  choice
>  	prompt "CPU Tuning"
>  	default TUNE_GENERIC
> diff --git a/arch/riscv/include/asm/cpu_ops.h b/arch/riscv/include/asm/cpu_ops.h
> index 5ce81a28e1d9..a8ec3c5c1bd2 100644
> --- a/arch/riscv/include/asm/cpu_ops.h
> +++ b/arch/riscv/include/asm/cpu_ops.h
> @@ -18,12 +18,24 @@
>   *			is a mechanism for doing so, tests whether it is
>   *			possible to boot the given HART.
>   * @cpu_start:		Boots a cpu into the kernel.
> + * @cpu_disable:	Prepares a cpu to die. May fail for some
> + *			mechanism-specific reason, which will cause the hot
> + *			unplug to be aborted. Called from the cpu to be killed.
> + * @cpu_stop:		Makes a cpu leave the kernel. Must not fail. Called from
> + *			the cpu being stopped.
> + * @cpu_is_stopped:	Ensures a cpu has left the kernel. Called from another
> + *			cpu.
>   */
>  struct cpu_operations {
>  	const char	*name;
>  	int		(*cpu_prepare)(unsigned int cpu);
>  	int		(*cpu_start)(unsigned int cpu,
>  				     struct task_struct *tidle);
> +#ifdef CONFIG_HOTPLUG_CPU
> +	int		(*cpu_disable)(unsigned int cpu);
> +	void		(*cpu_stop)(void);
> +	int		(*cpu_is_stopped)(unsigned int cpu);
> +#endif
>  };
>
>  extern const struct cpu_operations *cpu_ops[NR_CPUS];
> diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
> index 023f74fb8b3b..f4c7cfda6b7f 100644
> --- a/arch/riscv/include/asm/smp.h
> +++ b/arch/riscv/include/asm/smp.h
> @@ -43,6 +43,13 @@ void riscv_cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask *out);
>   */
>  #define raw_smp_processor_id() (current_thread_info()->cpu)
>
> +#if defined CONFIG_HOTPLUG_CPU
> +int __cpu_disable(void);
> +void __cpu_die(unsigned int cpu);
> +void cpu_stop(void);
> +#else
> +#endif /* CONFIG_HOTPLUG_CPU */
> +
>  #else
>
>  static inline void show_ipi_stats(struct seq_file *p, int prec)
> @@ -69,4 +76,14 @@ static inline void riscv_cpuid_to_hartid_mask(const struct cpumask *in,
>  }
>
>  #endif /* CONFIG_SMP */
> +
> +#if defined(CONFIG_HOTPLUG_CPU) && (CONFIG_SMP)
> +bool cpu_has_hotplug(unsigned int cpu);
> +#else
> +static inline bool cpu_has_hotplug(unsigned int cpu)
> +{
> +	return false;
> +}
> +#endif
> +
>  #endif /* _ASM_RISCV_SMP_H */
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index a0be34b96846..9601ac907f70 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -47,5 +47,6 @@ obj-$(CONFIG_RISCV_SBI)		+= sbi.o
>  ifeq ($(CONFIG_RISCV_SBI), y)
>  obj-$(CONFIG_SMP) += cpu_ops_sbi.o
>  endif
> +obj-$(CONFIG_HOTPLUG_CPU)	+= cpu-hotplug.o
>
>  clean:
> diff --git a/arch/riscv/kernel/cpu-hotplug.c b/arch/riscv/kernel/cpu-hotplug.c
> new file mode 100644
> index 000000000000..df84e0c13db1
> --- /dev/null
> +++ b/arch/riscv/kernel/cpu-hotplug.c
> @@ -0,0 +1,87 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020 Western Digital Corporation or its affiliates.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/mm.h>
> +#include <linux/sched.h>
> +#include <linux/err.h>
> +#include <linux/irq.h>
> +#include <linux/cpu.h>
> +#include <linux/sched/hotplug.h>
> +#include <asm/irq.h>
> +#include <asm/cpu_ops.h>
> +#include <asm/sbi.h>
> +
> +void cpu_stop(void);
> +void arch_cpu_idle_dead(void)
> +{
> +	cpu_stop();
> +}
> +
> +bool cpu_has_hotplug(unsigned int cpu)
> +{
> +	if (cpu_ops[cpu]->cpu_stop)
> +		return true;
> +
> +	return false;
> +}
> +
> +/*
> + * __cpu_disable runs on the processor to be shutdown.
> + */
> +int __cpu_disable(void)
> +{
> +	int ret = 0;
> +	unsigned int cpu = smp_processor_id();
> +
> +	if (!cpu_ops[cpu] || !cpu_ops[cpu]->cpu_stop)
> +		return -EOPNOTSUPP;
> +
> +	if (cpu_ops[cpu]->cpu_disable)
> +		ret = cpu_ops[cpu]->cpu_disable(cpu);
> +
> +	if (ret)
> +		return ret;
> +
> +	remove_cpu_topology(cpu);
> +	set_cpu_online(cpu, false);
> +	irq_migrate_all_off_this_cpu();
> +
> +	return ret;
> +}
> +
> +/*
> + * Called on the thread which is asking for a CPU to be shutdown.
> + */
> +void __cpu_die(unsigned int cpu)
> +{
> +	int ret = 0;
> +
> +	if (!cpu_wait_death(cpu, 5)) {
> +		pr_err("CPU %u: didn't die\n", cpu);
> +		return;
> +	}
> +	pr_notice("CPU%u: off\n", cpu);
> +
> +	/* Verify from the firmware if the cpu is really stopped*/
> +	if (cpu_ops[cpu]->cpu_is_stopped)
> +		ret = cpu_ops[cpu]->cpu_is_stopped(cpu);
> +	if (ret)
> +		pr_warn("CPU%d may not have stopped: %d\n", cpu, ret);
> +}
> +
> +/*
> + * Called from the idle thread for the CPU which has been shutdown.
> + */
> +void cpu_stop(void)
> +{
> +	idle_task_exit();
> +
> +	(void)cpu_report_death();
> +
> +	cpu_ops[smp_processor_id()]->cpu_stop();
> +	/* It should never reach here */
> +	BUG();
> +}
> diff --git a/arch/riscv/kernel/cpu_ops_sbi.c b/arch/riscv/kernel/cpu_ops_sbi.c
> index 66f3cded91f5..685fae72b7f5 100644
> --- a/arch/riscv/kernel/cpu_ops_sbi.c
> +++ b/arch/riscv/kernel/cpu_ops_sbi.c
> @@ -74,8 +74,42 @@ static int sbi_cpu_prepare(unsigned int cpuid)
>  	return 0;
>  }
>
> +#ifdef CONFIG_HOTPLUG_CPU
> +static int sbi_cpu_disable(unsigned int cpuid)
> +{
> +	if (!cpu_ops_sbi.cpu_stop)
> +		return -EOPNOTSUPP;
> +	return 0;
> +}
> +
> +static void sbi_cpu_stop(void)
> +{
> +	int ret;
> +
> +	ret = sbi_hsm_hart_stop();
> +	pr_crit("Unable to stop the cpu %u (%d)\n", smp_processor_id(), ret);
> +}
> +
> +static int sbi_cpu_is_stopped(unsigned int cpuid)
> +{
> +	int rc;
> +	int hartid = cpuid_to_hartid_map(cpuid);
> +
> +	rc = sbi_hsm_hart_get_status(hartid);
> +
> +	if (rc == SBI_HSM_HART_STATUS_STOPPED)
> +		return 0;
> +	return rc;
> +}
> +#endif
> +
>  const struct cpu_operations cpu_ops_sbi = {
>  	.name		= "sbi",
>  	.cpu_prepare	= sbi_cpu_prepare,
>  	.cpu_start	= sbi_cpu_start,
> +#ifdef CONFIG_HOTPLUG_CPU
> +	.cpu_disable	= sbi_cpu_disable,
> +	.cpu_stop	= sbi_cpu_stop,
> +	.cpu_is_stopped	= sbi_cpu_is_stopped,
> +#endif
>  };
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 44ac4ddf60ab..1d2f66579b94 100644
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
> @@ -43,6 +44,7 @@ struct screen_info screen_info = {
>  /* The lucky hart to first increment this variable will boot the other cores */
>  atomic_t hart_lottery;
>  unsigned long boot_cpu_hartid;
> +static DEFINE_PER_CPU(struct cpu, cpu_devices);
>
>  void __init parse_dtb(void)
>  {
> @@ -90,3 +92,18 @@ void __init setup_arch(char **cmdline_p)
>
>  	riscv_fill_hwcap();
>  }
> +
> +static int __init topology_init(void)
> +{
> +	int i;
> +
> +	for_each_possible_cpu(i) {
> +		struct cpu *cpu = &per_cpu(cpu_devices, i);
> +
> +		cpu->hotpluggable = cpu_has_hotplug(i);
> +		register_cpu(cpu, i);
> +	}
> +
> +	return 0;
> +}
> +subsys_initcall(topology_init);
