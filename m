Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C97AC10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 10:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 498F32073C
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 10:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgCGKQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 05:16:12 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:17209 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgCGKQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 05:16:11 -0500
X-Originating-IP: 79.86.19.127
Received: from [192.168.0.12] (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 0B741240003;
        Sat,  7 Mar 2020 10:16:07 +0000 (UTC)
Subject: Re: [PATCH RESEND v2] riscv: Introduce CONFIG_RELOCATABLE
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, zong.li@sifive.com,
        anup@brainfault.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <mhng-346cdebc-e24d-49db-bb2e-0d4fa8d57030@palmerdabbelt-glaptop1>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <64d78857-0c12-2cbb-ea14-b0363f65297e@ghiti.fr>
Date:   Sat, 7 Mar 2020 05:16:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <mhng-346cdebc-e24d-49db-bb2e-0d4fa8d57030@palmerdabbelt-glaptop1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

On 3/6/20 12:58 PM, Palmer Dabbelt wrote:
> On Mon, 02 Mar 2020 21:44:37 PST (-0800), alex@ghiti.fr wrote:
>> This config allows to compile the kernel as PIE and to relocate it at any
>> virtual address at runtime: this paves the way to KASLR and to 4-level
>> page table folding at runtime. Runtime relocation is possible since
>> relocation metadata are embedded into the kernel.
>>
>> Note that relocating at runtime introduces an overhead even if the kernel
>> is loaded at the same address it was linked at and that the compiler
>> options are those used in arm64 which uses the same RELA relocation 
>> format.
>>
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>> Reviewed-by: Zong Li <zong.li@sifive.com>
>> Reviewed-by: Anup Patel <anup@brainfault.org>
>> Tested-by: Zong Li <zong.li@sifive.com>
>> ---
>> Changes in v2:
>> - Make RELOCATABLE depend on MMU as suggested by Anup
>> - Rename kernel_load_addr into kernel_virt_addr as suggested by Anup
>> - Use __pa_symbol instead of __pa, as suggested by Zong
>> - Rebased on top of v5.6-rc3
>> - Tested with sv48 patchset
>> - Add Reviewed/Tested-by from Zong and Anup
>>
>>  arch/riscv/Kconfig              | 12 +++++
>>  arch/riscv/Makefile             |  5 +-
>>  arch/riscv/boot/loader.lds.S    |  2 +-
>>  arch/riscv/include/asm/page.h   |  5 +-
>>  arch/riscv/kernel/head.S        |  3 +-
>>  arch/riscv/kernel/vmlinux.lds.S | 10 ++--
>>  arch/riscv/mm/Makefile          |  4 ++
>>  arch/riscv/mm/init.c            | 92 ++++++++++++++++++++++++++++-----
>>  8 files changed, 111 insertions(+), 22 deletions(-)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 73f029eae0cc..f5f3d474504d 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -163,6 +163,18 @@ config PGTABLE_LEVELS
>>      default 3 if 64BIT
>>      default 2
>>
>> +config RELOCATABLE
>> +    bool
>> +    depends on MMU
>> +    help
>> +          This builds a kernel as a Position Independent Executable 
>> (PIE),
>> +          which retains all relocation metadata required to relocate the
>> +          kernel binary at runtime to a different virtual address 
>> than the
>> +          address it was linked at.
>> +          Since RISCV uses the RELA relocation format, this requires a
>> +          relocation pass at runtime even if the kernel is loaded at the
>> +          same address it was linked at.
>> +
>>  source "arch/riscv/Kconfig.socs"
>>
>>  menu "Platform type"
>> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
>> index b9009a2fbaf5..5a115cf6a9c1 100644
>> --- a/arch/riscv/Makefile
>> +++ b/arch/riscv/Makefile
>> @@ -9,7 +9,10 @@
>>  #
>>
>>  OBJCOPYFLAGS    := -O binary
>> -LDFLAGS_vmlinux :=
>> +ifeq ($(CONFIG_RELOCATABLE),y)
>> +LDFLAGS_vmlinux := -shared -Bsymbolic -z notext -z norelro
>> +KBUILD_CFLAGS += -fPIE
>> +endif
>>  ifeq ($(CONFIG_DYNAMIC_FTRACE),y)
>>      LDFLAGS_vmlinux := --no-relax
>>  endif
>> diff --git a/arch/riscv/boot/loader.lds.S b/arch/riscv/boot/loader.lds.S
>> index 47a5003c2e28..a9ed218171aa 100644
>> --- a/arch/riscv/boot/loader.lds.S
>> +++ b/arch/riscv/boot/loader.lds.S
>> @@ -7,7 +7,7 @@ ENTRY(_start)
>>
>>  SECTIONS
>>  {
>> -    . = PAGE_OFFSET;
>> +    . = CONFIG_PAGE_OFFSET;
>>
>>      .payload : {
>>          *(.payload)
>> diff --git a/arch/riscv/include/asm/page.h 
>> b/arch/riscv/include/asm/page.h
>> index 8ca1930caa44..af5810f9aebd 100644
>> --- a/arch/riscv/include/asm/page.h
>> +++ b/arch/riscv/include/asm/page.h
>> @@ -31,9 +31,9 @@
>>   * When not using MMU this corresponds to the first free page in
>>   * physical memory (aligned on a page boundary).
>>   */
>> -#define PAGE_OFFSET        _AC(CONFIG_PAGE_OFFSET, UL)
>> +#define PAGE_OFFSET        kernel_virt_addr
> 
> I assume we want to keep PAGE_OFFSET a constant for the non-relocatable
> systems.  As it currently stands this is imposing a performance hit even 
> when

Ok I can do that, thanks.

>> -#define KERN_VIRT_SIZE (-PAGE_OFFSET)
>> +#define KERN_VIRT_SIZE        (-_AC(CONFIG_PAGE_OFFSET, UL))
> 
> This seems like it would cause issues if the kernel is relocated to high 
> enough
> addresses that "kernel_virt_addr+KERN_VIRT_SIZE" overflows.

KERN_VIRT_SIZE is only used to define the size of VMALLOC zone and 
VMALLOC zone must aligned on 2MB (size of PMD page): so I simply used 
CONFIG_PAGE_OFFSET that guarantees that (since aligned on 1GB).

But I should define KERN_VIRT_SIZE by using kernel_virt_addr and make 
sure that VMALLOC zone is aligned on 2MB.

Ok I'll fix that in v3, thanks.

> 
>>  #ifndef __ASSEMBLY__
>>
>> @@ -97,6 +97,7 @@ extern unsigned long pfn_base;
>>  #define ARCH_PFN_OFFSET        (PAGE_OFFSET >> PAGE_SHIFT)
>>  #endif /* CONFIG_MMU */
>>
>> +extern unsigned long kernel_virt_addr;
>>  extern unsigned long max_low_pfn;
>>  extern unsigned long min_low_pfn;
>>
>> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
>> index 271860fc2c3f..d792912c2da3 100644
>> --- a/arch/riscv/kernel/head.S
>> +++ b/arch/riscv/kernel/head.S
>> @@ -131,7 +131,8 @@ clear_bss_done:
>>  #ifdef CONFIG_MMU
>>  relocate:
>>      /* Relocate return address */
>> -    li a1, PAGE_OFFSET
>> +    la a1, kernel_virt_addr
>> +    REG_L a1, 0(a1)
>>      la a2, _start
>>      sub a1, a1, a2
>>      add ra, ra, a1
>> diff --git a/arch/riscv/kernel/vmlinux.lds.S 
>> b/arch/riscv/kernel/vmlinux.lds.S
>> index 1e0193ded420..5bf69e9b91e6 100644
>> --- a/arch/riscv/kernel/vmlinux.lds.S
>> +++ b/arch/riscv/kernel/vmlinux.lds.S
>> @@ -4,7 +4,7 @@
>>   * Copyright (C) 2017 SiFive
>>   */
>>
>> -#define LOAD_OFFSET PAGE_OFFSET
>> +#define LOAD_OFFSET CONFIG_PAGE_OFFSET
>>  #include <asm/vmlinux.lds.h>
>>  #include <asm/page.h>
>>  #include <asm/cache.h>
>> @@ -71,9 +71,11 @@ SECTIONS
>>
>>      EXCEPTION_TABLE(0x10)
>>
>> -    .rel.dyn : {
>> -        *(.rel.dyn*)
>> -    }
>> +        .rela.dyn : ALIGN(8) {
>> +        __rela_dyn_start = .;
>> +                *(.rela .rela*)
>> +        __rela_dyn_end = .;
>> +        }
> 
> It looks like the indentation is screwed up here: I see a mix of 
> tabs/spaces
> that doesn't match the rest of the file.
> 

Thanks, I'll fix it.

>>
>>      _end = .;
>>
>> diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
>> index 50b7af58c566..27593d362248 100644
>> --- a/arch/riscv/mm/Makefile
>> +++ b/arch/riscv/mm/Makefile
>> @@ -1,6 +1,10 @@
>>  # SPDX-License-Identifier: GPL-2.0-only
>>
>>  CFLAGS_init.o := -mcmodel=medany
>> +ifdef CONFIG_RELOCATABLE
>> +CFLAGS_init.o += -fno-pie
>> +endif
>> +
>>  ifdef CONFIG_FTRACE
>>  CFLAGS_REMOVE_init.o = -pg
>>  endif
>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> index 965a8cf4829c..428aee2669aa 100644
>> --- a/arch/riscv/mm/init.c
>> +++ b/arch/riscv/mm/init.c
>> @@ -12,6 +12,9 @@
>>  #include <linux/sizes.h>
>>  #include <linux/of_fdt.h>
>>  #include <linux/libfdt.h>
>> +#ifdef CONFIG_RELOCATABLE
>> +#include <linux/elf.h>
>> +#endif
>>
>>  #include <asm/fixmap.h>
>>  #include <asm/tlbflush.h>
>> @@ -28,6 +31,9 @@ EXPORT_SYMBOL(empty_zero_page);
>>  extern char _start[];
>>  void *dtb_early_va;
>>
>> +unsigned long kernel_virt_addr = _AC(CONFIG_PAGE_OFFSET, UL);
>> +EXPORT_SYMBOL(kernel_virt_addr);
>> +
>>  static void __init zone_sizes_init(void)
>>  {
>>      unsigned long max_zone_pfns[MAX_NR_ZONES] = { 0, };
>> @@ -132,7 +138,8 @@ void __init setup_bootmem(void)
>>          phys_addr_t end = reg->base + reg->size;
>>
>>          if (reg->base <= vmlinux_end && vmlinux_end <= end) {
>> -            mem_size = min(reg->size, (phys_addr_t)-PAGE_OFFSET);
>> +            mem_size = min(reg->size,
>> +                       (phys_addr_t)-kernel_virt_addr);
> 
> PAGE_OFFSET is kernel_virt_addr, so I don't see any reason to change 
> these --
> they account for a significant fraction of the diff.

You are totally right, those are leftovers from a previous version. 
Thanks for catching that, that greatly simplifies this patch.

> 
>>              /*
>>               * Remove memblock from the end of usable area to the
>> @@ -269,7 +276,7 @@ static phys_addr_t __init alloc_pmd(uintptr_t va)
>>      if (mmu_enabled)
>>          return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
>>
>> -    pmd_num = (va - PAGE_OFFSET) >> PGDIR_SHIFT;
>> +    pmd_num = (va - kernel_virt_addr) >> PGDIR_SHIFT;
>>      BUG_ON(pmd_num >= NUM_EARLY_PMDS);
>>      return (uintptr_t)&early_pmd[pmd_num * PTRS_PER_PMD];
>>  }
>> @@ -370,6 +377,54 @@ static uintptr_t __init best_map_size(phys_addr_t 
>> base, phys_addr_t size)
>>  #error "setup_vm() is called from head.S before relocate so it should 
>> not use absolute addressing."
>>  #endif
>>
>> +#ifdef CONFIG_RELOCATABLE
>> +extern unsigned long __rela_dyn_start, __rela_dyn_end;
>> +
>> +#ifdef CONFIG_64BIT
>> +#define Elf_Rela Elf64_Rela
>> +#define Elf_Addr Elf64_Addr
>> +#else
>> +#define Elf_Rela Elf32_Rela
>> +#define Elf_Addr Elf32_Addr
>> +#endif
>> +
>> +void __init relocate_kernel(uintptr_t load_pa)
>> +{
>> +    Elf_Rela *rela = (Elf_Rela *)&__rela_dyn_start;
>> +    uintptr_t link_addr = _AC(CONFIG_PAGE_OFFSET, UL);
>> +    /*
>> +     * This holds the offset between the linked virtual address and the
>> +     * relocated virtual address.
>> +     */
>> +    uintptr_t reloc_offset = kernel_virt_addr - link_addr;
>> +    /*
>> +     * This holds the offset between linked virtual address and physical
>> +     * address whereas va_pa_offset holds the offset between relocated
>> +     * virtual address and physical address.
>> +     */
>> +    uintptr_t va_link_pa_offset = link_addr - load_pa;
>> +
>> +    for ( ; rela < (Elf_Rela *)&__rela_dyn_end; rela++) {
>> +        Elf_Addr addr = (rela->r_offset - va_link_pa_offset);
>> +        Elf_Addr relocated_addr = rela->r_addend;
>> +
>> +        if (rela->r_info != R_RISCV_RELATIVE)
>> +            continue;
> 
> This should at least provide a warning when it encounters an unresolvable
> relocation.  Is it currently stands this just ignores all other runtime
> relocations, and while I can buy the argument there shouldn't be any 
> (though
> I'd expect R_RISCV_{32,64} to show up?) we certainly shouldn't just 
> silently
> skip them.
> 

It's hard to warn that early in the boot process: what about we do like 
powerpc and warns at compile time ? In addition, it would be better that 
way since we can eliminate false-positive like in 43e76cd368fb (because 
the only R_RISCV_64 relocations are indeed false-positive).

>> +
>> +        /*
>> +         * Make sure to not relocate vdso symbols like rt_sigreturn
>> +         * which are linked from the address 0 in vmlinux since
>> +         * vdso symbol addresses are actually used as an offset from
>> +         * mm->context.vdso in VDSO_OFFSET macro.
>> +         */
>> +        if (relocated_addr >= link_addr)
>> +            relocated_addr += reloc_offset;
>> +
>> +        *(Elf_Addr *)addr = relocated_addr;
>> +    }
>> +}
>> +#endif
>> +
>>  asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>>  {
>>      uintptr_t va, end_va;
>> @@ -377,9 +432,20 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>>      uintptr_t load_sz = (uintptr_t)(&_end) - load_pa;
>>      uintptr_t map_size = best_map_size(load_pa, MAX_EARLY_MAPPING_SIZE);
>>
>> -    va_pa_offset = PAGE_OFFSET - load_pa;
>> +    va_pa_offset = kernel_virt_addr - load_pa;
>>      pfn_base = PFN_DOWN(load_pa);
>>
>> +#ifdef CONFIG_RELOCATABLE
>> +    /*
>> +     * Early page table uses only one PGDIR, which makes it possible
>> +     * to map 1GB aligned on 1GB: if the relocation offset makes the 
>> kernel
>> +     * cross over a 1G boundary, raise a bug since a part of the kernel
>> +     * would not get mapped.
>> +     */
>> +    BUG_ON(SZ_1G - (kernel_virt_addr & (SZ_1G - 1)) < load_sz);
>> +    relocate_kernel(load_pa);
>> +#endif
>> +
>>      /*
>>       * Enforce boot alignment requirements of RV32 and
>>       * RV64 by only allowing PMD or PGD mappings.
>> @@ -387,7 +453,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>>      BUG_ON(map_size == PAGE_SIZE);
>>
>>      /* Sanity check alignment and size */
>> -    BUG_ON((PAGE_OFFSET % PGDIR_SIZE) != 0);
>> +    BUILD_BUG_ON((_AC(CONFIG_PAGE_OFFSET, UL) % PGDIR_SIZE) != 0);
>>      BUG_ON((load_pa % map_size) != 0);
>>      BUG_ON(load_sz > MAX_EARLY_MAPPING_SIZE);
>>
>> @@ -400,13 +466,13 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>>      create_pmd_mapping(fixmap_pmd, FIXADDR_START,
>>                 (uintptr_t)fixmap_pte, PMD_SIZE, PAGE_TABLE);
>>      /* Setup trampoline PGD and PMD */
>> -    create_pgd_mapping(trampoline_pg_dir, PAGE_OFFSET,
>> +    create_pgd_mapping(trampoline_pg_dir, kernel_virt_addr,
>>                 (uintptr_t)trampoline_pmd, PGDIR_SIZE, PAGE_TABLE);
>> -    create_pmd_mapping(trampoline_pmd, PAGE_OFFSET,
>> +    create_pmd_mapping(trampoline_pmd, kernel_virt_addr,
>>                 load_pa, PMD_SIZE, PAGE_KERNEL_EXEC);
>>  #else
>>      /* Setup trampoline PGD */
>> -    create_pgd_mapping(trampoline_pg_dir, PAGE_OFFSET,
>> +    create_pgd_mapping(trampoline_pg_dir, kernel_virt_addr,
>>                 load_pa, PGDIR_SIZE, PAGE_KERNEL_EXEC);
>>  #endif
>>
>> @@ -415,10 +481,10 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>>       * us to reach paging_init(). We map all memory banks later
>>       * in setup_vm_final() below.
>>       */
>> -    end_va = PAGE_OFFSET + load_sz;
>> -    for (va = PAGE_OFFSET; va < end_va; va += map_size)
>> +    end_va = kernel_virt_addr + load_sz;
>> +    for (va = kernel_virt_addr; va < end_va; va += map_size)
>>          create_pgd_mapping(early_pg_dir, va,
>> -                   load_pa + (va - PAGE_OFFSET),
>> +                   load_pa + (va - kernel_virt_addr),
>>                     map_size, PAGE_KERNEL_EXEC);
>>
>>      /* Create fixed mapping for early FDT parsing */
>> @@ -457,9 +523,9 @@ static void __init setup_vm_final(void)
>>              break;
>>          if (memblock_is_nomap(reg))
>>              continue;
>> -        if (start <= __pa(PAGE_OFFSET) &&
>> -            __pa(PAGE_OFFSET) < end)
>> -            start = __pa(PAGE_OFFSET);
>> +        if (start <= __pa_symbol(kernel_virt_addr) &&
>> +            __pa(kernel_virt_addr) < end)
>> +            start = __pa_symbol(kernel_virt_addr);
>>
>>          map_size = best_map_size(start, end - start);
>>          for (pa = start; pa < end; pa += map_size) {

Thanks Palmer,

Alex
