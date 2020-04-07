Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3422DC2BA16
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 05:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03CB32072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 05:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgDGFKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 01:10:35 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:38069 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbgDGFKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 01:10:35 -0400
X-Originating-IP: 2.7.45.25
Received: from [192.168.1.101] (lfbn-lyo-1-453-25.w2-7.abo.wanadoo.fr [2.7.45.25])
        (Authenticated sender: alex@ghiti.fr)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id D131C20002;
        Tue,  7 Apr 2020 05:10:31 +0000 (UTC)
Subject: Re: [PATCH RFC 3/8] riscv/kaslr: support KASLR infrastructure
To:     Zong Li <zong.li@sifive.com>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <cover.1584352425.git.zong.li@sifive.com>
 <fe97f88c69a9f752a96623afa398c4125aab930f.1584352425.git.zong.li@sifive.com>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <7e490410-9f2c-62dc-e3ab-8018cc3ee534@ghiti.fr>
Date:   Tue, 7 Apr 2020 01:10:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <fe97f88c69a9f752a96623afa398c4125aab930f.1584352425.git.zong.li@sifive.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/24/20 3:30 AM, Zong Li wrote:
> This patch support KASLR implementation. It copies kernel image to a
> proper and random place, and make all harts go to the new destination.
> 
> After KASLR initialization, secondary harts go to the new destination
> to wait their stack pointer to be setup by main hart, main hart goes to
> re-create the early page table and doing relocation by going back to
> setup_vm again.
> 
> We separate the randomization process from this patch, so the kernel
> offset was not randomized yet, it just hardcode a meanless number here.
> 
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>   arch/riscv/Kconfig         | 15 +++++++++++
>   arch/riscv/kernel/Makefile |  2 ++
>   arch/riscv/kernel/head.S   | 39 +++++++++++++++++++++++++++
>   arch/riscv/kernel/kaslr.c  | 55 ++++++++++++++++++++++++++++++++++++++
>   arch/riscv/mm/init.c       | 53 +++++++++++++++++++++++++++++++++++-
>   5 files changed, 163 insertions(+), 1 deletion(-)
>   create mode 100644 arch/riscv/kernel/kaslr.c
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index aea03ac470c8..8f566b40ea1e 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -183,6 +183,21 @@ config RELOCATABLE
>             relocation pass at runtime even if the kernel is loaded at the
>             same address it was linked at.
>   
> +config RANDOMIZE_BASE
> +	bool "Randomize the address of the kernel image"
> +	depends on MMU
> +	select MODULE_SECTIONS if MODULES
> +	select RELOCATABLE
> +	help
> +	  Randomizes the virtual address at which the kernel image is
> +	  loaded, as a security feature that deters exploit attempts
> +	  relying on knowledge of the location of kernel internals.
> +
> +	  It is the job of previous stage to provide entropy, by passing a
> +	  random u64 value in /chosen/kaslr-seed at kernel entry.
> +
> +	  If unsure, say N.
> +
>   source "arch/riscv/Kconfig.socs"
>   
>   menu "Platform type"
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index d189bd3d8501..8f62732b1135 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -45,4 +45,6 @@ obj-$(CONFIG_PERF_EVENTS)	+= perf_callchain.o
>   obj-$(CONFIG_HAVE_PERF_REGS)	+= perf_regs.o
>   obj-$(CONFIG_RISCV_SBI)		+= sbi.o
>   
> +obj-$(CONFIG_RANDOMIZE_BASE)	+= kaslr.o
> +
>   clean:
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index cb4a6e2d3793..5191e528d813 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -113,9 +113,12 @@ clear_bss_done:
>   	la a2, boot_cpu_hartid
>   	REG_S a0, (a2)
>   
> +.align 2

Why do you need this new alignment constraint ?

> +early_page_table:
>   	/* Initialize page tables and relocate to virtual addresses */
>   	la sp, init_thread_union + THREAD_SIZE
>   	mv a0, s1
> +

Newline ?

>   	call setup_vm
>   #ifdef CONFIG_MMU
>   	la a0, early_pg_dir
> @@ -127,6 +130,29 @@ clear_bss_done:
>   	sw zero, TASK_TI_CPU(tp)
>   	la sp, init_thread_union + THREAD_SIZE
>   
> +#ifdef CONFIG_RANDOMIZE_BASE
> +	/* KASRL initialization. Try to get a random kernel offset. */
> +	call kaslr_early_init
> +
> +	/* If return value equals to zero, we don't need to randomize kernel */
> +	beqz a0, 1f
> +
> +	la a1, early_page_table
> +	add a1, a1, a0
> +	la a0, va_pa_offset
> +	REG_L a0, 0(a0)
> +	sub a1, a1, a0
> +	mv a0, s1
> +
> +	/*
> +	 * Go to new kernel image destination, and disable MMU to re-create
> +	 * early page table and do relocation.
> +	 */
> +	csrw CSR_TVEC, a1
> +	csrw CSR_SATP, x0
> +1:
> +#endif
> +
>   #ifdef CONFIG_KASAN
>   	call kasan_early_init
>   #endif
> @@ -194,6 +220,19 @@ relocate:
>   	la a3, .Lsecondary_park
>   	csrw CSR_TVEC, a3
>   
> +#ifdef CONFIG_RANDOMIZE_BASE
> +	/*
> +	 * Wait winning hart to tell secondary harts where is the new
> +	 * destination to go.
> +	 */
> +.Lwait_for_next_target:
> +	la a3, secondary_next_target
> +	REG_L a3, 0(a3)
> +	beqz a3, .Lwait_for_next_target
> +	jr a3
> +.global secondary_random_target
> +secondary_random_target:
> +#endif
>   	slli a3, a0, LGREG
>   	la a1, __cpu_up_stack_pointer
>   	la a2, __cpu_up_task_pointer
> diff --git a/arch/riscv/kernel/kaslr.c b/arch/riscv/kernel/kaslr.c
> new file mode 100644
> index 000000000000..281b5fcca5c8
> --- /dev/null
> +++ b/arch/riscv/kernel/kaslr.c
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2020 SiFive
> + * Copyright (C) 2020 Zong Li <zong.li@sifive.com>
> + */
> +
> +#include <linux/libfdt.h>
> +#include <linux/timex.h>
> +#include <linux/random.h>
> +#include <linux/set_memory.h>
> +#include <asm/cacheflush.h>
> +
> +extern char _start[], _end[];
> +extern void secondary_random_target(void);
> +extern void kaslr_create_page_table(uintptr_t start, uintptr_t end);
> +
> +uintptr_t secondary_next_target __initdata;
> +static uintptr_t kaslr_offset __initdata;
> +
> +uintptr_t __init kaslr_early_init(void)
> +{
> +	uintptr_t dest_start, dest_end;
> +	uintptr_t kernel_size = (uintptr_t) _end - (uintptr_t) _start;
> +
> +	/* Get zero value at second time to avoid doing randomization again. */
> +	if (kaslr_offset)
> +		return 0;
> +
> +	/* Get the random number for kaslr offset. */
> +	kaslr_offset = 0x10000000;

For clarity, you could use a macro or something like that for this constant.

> +
> +	/* Update kernel_virt_addr for get_kaslr_offset. */
> +	kernel_virt_addr += kaslr_offset;

This could be done after you test if kaslr_offset is null below.

> +
> +	if (kaslr_offset) {
> +		dest_start = (uintptr_t) (PAGE_OFFSET + kaslr_offset);
> +		dest_end = dest_start + kernel_size;

dest_end = dest_start + kernel_size - 1;

> +
> +		/* Create the new destination mapping for kernel image. */
> +		kaslr_create_page_table(dest_start, dest_end);
> +
> +		/* Copy kernel image from orignial location. */
> +		memcpy((void *)dest_start, (void *)_start, kernel_size);
> +		flush_icache_range(dest_start, dest_end); > +
> +		/* Make secondary harts jump to new kernel image destination. */
> +		WRITE_ONCE(secondary_next_target,
> +			   __pa_symbol(secondary_random_target) + kaslr_offset);

Don't you need to sync secondary harts icache with main hart dcache here ?

> +	} else {
> +		WRITE_ONCE(secondary_next_target,
> +			   __pa_symbol(secondary_random_target));
> +	}
> +
> +	return kaslr_offset;
> +}
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 51e263c04fa2..2f5b25f02b6c 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -413,6 +413,41 @@ static void __init clear_pgd(pgd_t *pgdp)
>   			}
>   		}
>   }
> +
> +static void __init clear_page_tables(void)
> +{
> +	clear_pgd(early_pg_dir);
> +	clear_pgd(trampoline_pg_dir);
> +}

early page table and trampoline page table consist in one page per 
level, I confirm that a memset to 0 is easier here.

> +
> +void __init kaslr_create_page_table(uintptr_t start, uintptr_t end)
> +{
> +	pgd_next_t *nextp;
> +	phys_addr_t next_phys;
> +	uintptr_t pgd_index, va;
> +	phys_addr_t pa = __pa(PAGE_OFFSET) + get_kaslr_offset();
> +	uintptr_t map_size =
> +		best_map_size(__pa(PAGE_OFFSET), MAX_EARLY_MAPPING_SIZE);
> +
> +	/* Expolit early_pg_dir and early_pmd during using early page table. */
> +	for (va = start; va < end; va += map_size, pa += map_size) {
> +		pgd_index = pgd_index(va);
> +
> +		if (pgd_val(early_pg_dir[pgd_index]) == 0) {
> +			next_phys = alloc_pgd_next(va);
> +			early_pg_dir[pgd_index] =
> +				pfn_pgd(PFN_DOWN(next_phys), PAGE_TABLE);
> +			nextp = (pgd_next_t *)(__va(next_phys));
> +			memset(nextp, 0, PAGE_SIZE);
> +		} else {
> +			next_phys = PFN_PHYS(_pgd_pfn(early_pg_dir[pgd_index]));
> +			nextp = (pgd_next_t *)(__va(next_phys));
> +		}
> +
> +		create_pgd_next_mapping(nextp, va, pa, map_size,
> +					PAGE_KERNEL_EXEC);
> +	}
> +}
>   #endif

I may be missing something here: I don't see where the mappings for the 
new kernel you create here are used between here and setup_vm ?

If I read correctly, if kaslr_early_init returns a random offset, you 
disable mmu and then call setup_vm which will recreate early page tables 
anyway.

>   
>   /*
> @@ -489,7 +524,13 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>   	uintptr_t map_size = best_map_size(load_pa, MAX_EARLY_MAPPING_SIZE);
>   
>   	va_pa_offset = kernel_virt_addr - load_pa;
> -	pfn_base = PFN_DOWN(load_pa);
> +
> +	/*
> +	 * Update pfn_base only if pfn_base is empty. It's avoid to mess up it
> +	 * when re-enter this function by KASLR.
> +	 */
> +	if (!pfn_base)
> +		pfn_base = PFN_DOWN(load_pa);
>   
>   #ifdef CONFIG_RELOCATABLE
>   	/*
> @@ -513,6 +554,16 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>   	BUG_ON((load_pa % map_size) != 0);
>   	BUG_ON(load_sz > MAX_EARLY_MAPPING_SIZE);
>   
> +#ifdef CONFIG_RANDOMIZE_BASE
> +	/*
> +	 * Enter setup_vm twice if there is a legal random destination in KASLR,
> +	 * Reach here at second time, Clear page table because PTE entris allow
> +	 * writing when it's empty.
> +	 */
> +	if (get_kaslr_offset())
> +		clear_page_tables();
> +#endif
> +
>   	/* Setup early PGD for fixmap */
>   	create_pgd_mapping(early_pg_dir, FIXADDR_START,
>   			   (uintptr_t)fixmap_pgd_next, PGDIR_SIZE, PAGE_TABLE);
>

Just an idea, maybe worthless, but couldn't we benefit from kexec here ? 
That's quite the same: copy a new kernel from the current kernel in some 
new memory locations and then jump to it. We could pass the computed 
random offset as a very early kernel parameter so that setup_vm would 
only be called once (per kernel).

Alex
